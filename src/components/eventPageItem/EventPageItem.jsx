import React, { useContext } from 'react'
import './eventPageItem.css'
import { YMaps, Map, Placemark } from '@pbe/react-yandex-maps';
import MainInfo from '../mainInfo/MainInfo';
import { Context } from '../../context/Context'
import { Link } from 'react-router-dom';

import parse from 'html-react-parser';
import ProfileImage from '../profileImage/ProfileImage';

//функция для изменения фопмата даты
function formatExactLocation(dateTimeString) {
    const [dateString, timeString] = dateTimeString.split(' ');
    const [year, month, day] = dateString.split('-');
    const [hours, minutes] = timeString.split(':');

    const daysOfWeek = ['Воскресенье', 'Понедельник', 'Вторник', 'Среда', 'Четверг', 'Пятница', 'Суббота'];
    const months = ['января', 'февраля', 'марта', 'апреля', 'мая', 'июня', 'июля', 'августа', 'сентября', 'октября', 'ноября', 'декабря'];

    const date = new Date(parseInt(year), parseInt(month) - 1, parseInt(day));
    const dayOfWeek = daysOfWeek[date.getDay()];
    const monthIndex = parseInt(month) - 1;
    const formattedMonth = months[monthIndex];

    return `${dayOfWeek}, ${parseInt(day)} ${formattedMonth} ${year} ${hours}:${minutes}`;
}

export const EventPageItem = (props) => {
    const { event } = props
    const { button, user, users, fetchAllEvent, setChoseUser, vhod } = useContext(Context)

    //Обработчик нажатия для перемещения на нужного участника
    const handleUsers = (user) => {
        setChoseUser(user)
        localStorage.setItem('choseUser', JSON.stringify(user));
    };

    //функция для нахожденя цвета участников
    const findColor = (userId) => {
        let colorrrr = users.find((e) => e.id === Number(userId))

        return colorrrr !== undefined ? colorrrr.color : '#ffffff'
    };

    //функция для нахожденя имени участников
    const findName = (userId) => {
        let name = users.find((e) => e.id === Number(userId))

        return name !== undefined ? name.name : '?'
    };

    //функция для проверки нахождения пользователя в списке участников
    const findUser = () => {
        let usersss = false;
        if (event.participants !== null) usersss = event.participants.some(item => item.id_user === user.id)

        return usersss
    };

    //функция для удаления пользователя в список участников
    const deleteParticipants = () => {
        if (!event.participants || !Array.isArray(event.participants) || event.participants.length === 0) {
            return [];
        }

        return event.participants.filter(participant => participant.id_user !== user.id);
    }

    //функция для добавления пользователя из списка участников
    function addParticipants() {
        const currentParticipants = event.participants || [];
        const newParticipant = {
            id: currentParticipants.length > 0 ? currentParticipants[currentParticipants.length - 1].id + 1 : 1,
            id_user: user.id
        };

        return [...currentParticipants, newParticipant];
    }

    function updateEvent() {
        fetch(`http://localhost:4000/data_event/${event.id}`, {
            method: 'PUT',
            headers: {
                'Content-Type': 'application/json',
            },
            body: JSON.stringify({
                participants: findUser() ?
                    deleteParticipants()
                    : addParticipants()
            }),
        })
            .then(response => {
                return response.text();
            })
            .then(data => {
                alert(data);
                fetchAllEvent()
            });
    }

    const reg = () => {
        if (vhod) updateEvent()
        else alert('Для участия в аккаунт необходимо войти в аккаунт')
    };

    return (
        <div className='event__page'>

            <div className='event__headerImg' style={{ backgroundImage: `url(${event.link_img})` }}>
                <div className='event__headerText'>
                    <h2 className="event__headerDate">
                        {formatExactLocation(event.datetimeassetc)}
                    </h2>
                    <h1 className="event__headerTitle">
                        {event.title}
                    </h1>
                    <h3 className="event__headerPlace">
                        {event.adress}
                        <div>{event.name}</div>
                    </h3>
                </div>

            </div>
            <div className='map__mainInfo'>
                {event.latitude ?
                    <>
                        <div id="maps__conteiner">
                            <YMaps width={'100%'} height={'100%'}>
                                <Map defaultState={{ center: [event.latitude, event.longitude], zoom: 16 }} width={'100%'} height={'100%'}>
                                    <Placemark geometry={[event.latitude, event.longitude]} />
                                </Map>
                            </YMaps>
                        </div>
                        <div className="mainInfo">
                            <MainInfo key={event.id} participants={event.participants ? event.participants.length : ''} paparticipantsBoolean={true} exactLocation={formatExactLocation(event.datetimeassetc)} adress={event.adress} name={event.name} organizator={event.organizer} tags={event.tags} />
                            <div className='line'>
                                <button className={findUser() && vhod ? 'line__button__reg' : 'line__button'} onClick={reg}>
                                    {button(event.datetimeassetc, findUser())}
                                </button>
                                <p className='line__disclaimer'>
                                    Используется сторонняя регистрация. После клика вы будете перенаправлены на другой сайт, не пугайтесь.
                                </p>
                            </div>
                        </div>
                    </>
                    :
                    <div className="mainInfo" style={{ width: '41.5%', padding: 0, marginBottom: -20 }}>
                        <MainInfo key={event.id} participants={event.participants ? event.participants.length : ''} paparticipantsBoolean={true} exactLocation={formatExactLocation(event.datetimeassetc)} adress={event.adress} name={event.name} organizator={event.organizer} tags={event.tags} />
                        <div className='line'>
                            <button className={findUser() && vhod ? 'line__button__reg' : 'line__button'} onClick={reg}>
                                {button(event.datetimeassetc, findUser())}
                            </button>
                            <p className='line__disclaimer'>
                                Используется сторонняя регистрация. После клика вы будете перенаправлены на другой сайт, не пугайтесь.
                            </p>
                        </div>
                    </div>}
            </div>
            <hr />
            <div className="pading">
                <div className="about">
                    {parse(event.contentt)}
                </div>
                <div className="participants">
                    <div className='participants__header'>
                        <h4>Участники<small>{event.participants === null ? 0 : event.participants.length}</small></h4>
                    </div>
                    <div className="participants__body">
                        <div className="user__conteiner">
                            {event.participants && event.participants.map((item) => {
                                return <Link key={item.id} className='link__profile' to={`/user/${item.nik}`} onClick={() => handleUsers(item.id_user)}>
                                    {console.log()}
                                    <ProfileImage
                                        color={findColor(item.id_user)}
                                        name={findName(item.id_user)}
                                        size={50}
                                        forma={"circle"}
                                        fontSize={24} />
                                </Link>
                            })}
                        </div>
                    </div>
                    <div className="participants__footer">
                        <div className='line'>
                            <button className={findUser() && vhod ? 'line__button__reg' : 'line__button'} onClick={reg}>
                                {button(event.datetimeassetc, findUser())}
                            </button>
                            <p className='line__disclaimer'>
                                Используется сторонняя регистрация. После клика вы будете перенаправлены на другой сайт, не пугайтесь.
                            </p>
                        </div>
                    </div>
                </div >
            </div>
        </div>
    )
}
