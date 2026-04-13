import React, { useContext } from 'react';
import './Item.css'
import { Link } from 'react-router-dom';
import MainInfo from '../../mainInfo/MainInfo';
import { Context } from '../../../context/Context'

import parse from 'html-react-parser';
import ProfileImage from '../../profileImage/ProfileImage';

import { ToastContainer, toast } from 'react-toastify';
import 'react-toastify/dist/ReactToastify.css';

//смена формата даты
function formatDateTime(dateString) {
    const dateTime = new Date(dateString);
    const now = new Date();
    const diffInDays = Math.floor((dateTime - now) / (1000 * 60 * 60 * 24));

    let formattedDateTime;
    if (diffInDays === 0) {
        formattedDateTime = `Сегодня ${dateTime.getHours()}:${dateTime.getMinutes().toString().padStart(2, '0')}`;
    } else if (diffInDays === 1) {
        formattedDateTime = `Завтра ${dateTime.getHours()}:${dateTime.getMinutes().toString().padStart(2, '0')}`;
    } else {
        const months = ['января', 'февраля', 'марта', 'апреля', 'мая', 'июня', 'июля', 'августа', 'сентября', 'октября', 'ноября', 'декабря'];
        const month = months[dateTime.getMonth()];
        formattedDateTime = `${dateTime.getDate()} ${month} ${dateTime.getHours()}:${dateTime.getMinutes().toString().padStart(2, '0')}`;
    }

    return formattedDateTime;
}

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

const Item = (props) => {
    const { user, users, button, fetchAllEvent, setChoseUser, fetchAllUsers, fetchUser, vhod } = useContext(Context)

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
        if (props.participants !== null) usersss = props.participants.some(item => item.id_user === user.id)

        return usersss
    };

    //функция для проверки нахождения события в списке участия пользователя
    const findEvent = () => {
        let eventtt = false;
        if (user.events !== null) eventtt = user.events.some(item => item.title === props.title)

        return eventtt
    };

    function addParticipants() {
        const currentParticipants = props.participants || [];
        const newParticipant = {
            id: currentParticipants.length > 0 ? currentParticipants[currentParticipants.length - 1].id + 1 : 1,
            id_user: user.id, // предполагается, что есть переменная 'userId' с идентификатором нового пользователя
            nik: user.nik
        };

        return [...currentParticipants, newParticipant];
    }

    //функция для удаления пользователя из списка участников
    const deleteParticipants = () => {
        if (!props.participants || !Array.isArray(props.participants) || props.participants.length === 0) {
            return [];
        }

        return props.participants.filter(participant => participant.id_user !== user.id);
    }

    //функция для добавления пользователя в список участников
    function addEventsUsers() {
        const currentEvents = user.events || [];
        const newEvents = {
            id: currentEvents.length > 0 ? currentEvents[currentEvents.length - 1].id + 1 : 1,
            title: props.title, // предполагается, что есть переменная 'userId' с идентификатором нового пользователя
            datetimeassetc: props.datetimeassetc,
            eventid: props.id
        };

        return [...currentEvents, newEvents];
    }

    //функция для удаления события в списке пользователя
    const deleteEventUsers = () => {
        if (!user.events || !Array.isArray(user.events) || user.events.length === 0) {
            return [];
        }

        return user.events.filter(events => events.title !== props.title);
    }
    const errorMesenge = (er) => {
        toast(er, {
            position: "top-center",
            autoClose: 5000,
            hideProgressBar: true,
            closeOnClick: true,
            pauseOnHover: true,
            draggable: true,
            progress: undefined,
            theme: "dark"
        });
    };

    function updateEvent() {

        fetch(`http://localhost:4000/data_event/${props.id}`, {
            method: 'PUT',
            headers: {
                'Content-Type': 'application/json',
            },
            body: JSON.stringify({ participants: findUser() ? deleteParticipants() : addParticipants() }),
        })
            .then(response => {
                return response.text();
            })
            .then(data => {
                if (data === "Вы участник события") {
                    alert(data);
                    fetchAllEvent()
                }
                else {
                    alert('Вы не учавствуете в событии');
                    fetchAllEvent()
                }
            });

        fetch(`http://localhost:4000/user/events/${user.id}`, {
            method: 'PUT',
            headers: {
                'Content-Type': 'application/json',
            },
            body: JSON.stringify({ events: findEvent() ? deleteEventUsers() : addEventsUsers() }),
        })
            .then(response => {
                return response.text();
            })
            .then(data => {
                fetchAllUsers()
                fetchUser()
            });
    }


    const reg = () => {
        if (vhod) updateEvent()
        else errorMesenge('Для регистрации, необходимо войти в аккаунт')
    };

    return (
        <div className='block'>
            <ToastContainer style={{ top: 50 }} />
            <div className='panel'>
                <div className='panel__header'>
                    <h2 className='header__title'><Link className='title__link' to={`/event/${props.id}`}>{props.title}</Link></h2>
                    <h4 className='header__datePlace'>
                        <a className='dateTime__link' href='/'>{formatDateTime(props.datetimeassetc)}</a>
                        <a className='place__link' href='/'>{props.adress}{props.name ? `, ${props.name}` : ''}</a>
                    </h4>
                </div>
                <hr />
                <div className="main">
                    <div className="col1">
                        <Link to={`/event/${props.id}`}>
                            <div className='image__conteiner'>
                                <img src={props.image} alt=''></img>
                            </div>
                        </Link>
                        <div className='line'>
                            <a href={!findUser() && vhod ? props.linkreg : '/'} target={!findUser() && vhod ? "_blank" : ''} rel="noreferrer">
                                <button className={findUser() && vhod ? 'line__button__reg' : 'line__button'} onClick={reg} >
                                    {button(props.datetimeassetc, findUser())}
                                </button>
                            </a>
                            <p className='line__disclaimer'>
                                Используется сторонняя регистрация. После клика вы будете перенаправлены на другой сайт, не пугайтесь.
                            </p>
                        </div>
                        <hr />
                        <MainInfo key={props.id}
                            exactLocation={formatExactLocation(props.datetimeassetc)}
                            adress={props.adress}
                            name={props.name} o
                            organizator={props.organizer}
                            tags={props.tags} />
                    </div>
                    <div className="col2">
                        {props.contentt !== '' ?
                            parse(props.contentt)
                            :
                            ''}
                    </div>
                </div>
            </div>
            <div className='panel__footer'>
                <h4>Участники<small>{props.participants === null ? 0 : props.participants.length}</small></h4>
                <div className="user__conteiner">
                    {props.participants && props.participants.map((item) => {
                        return <Link key={item.id}
                            className='link__profile'
                            to={`/user/${item.nik}`}
                            onClick={() => handleUsers(item.id_user)}>
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
        </div>
    )
}

export default Item;