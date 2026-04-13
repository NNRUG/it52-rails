import React, { useContext } from 'react'
import './userPageItem.css'
import ProfileImage from '../profileImage/ProfileImage'
import { Context } from '../../context/Context'
import { Link } from 'react-router-dom';

function formatDateTime(dateTimeString) {
    const date = new Date(dateTimeString);
    const monthNames = ["января", "февраля", "марта", "апреля", "мая", "июня",
        "июля", "августа", "сентября", "октября", "ноября", "декабря"
    ];

    const day = date.getDate();
    const monthIndex = date.getMonth();
    const month = monthNames[monthIndex];

    return `${day} ${month}`;
};

export const UserPageItem = () => {

    const { choseUser, users, loadingusers } = useContext(Context)

    const findUserIndexById = () => {
        const userIndex = users.findIndex(user => user.id === choseUser);
        return userIndex;
    }

    return (
        <div className='block__conteinerr'>
            <div className='img__block'>
                <ProfileImage color={loadingusers ? users[findUserIndexById()].color : '#ffffff'} name={loadingusers ? users[findUserIndexById()].name : '#ffffff'}
                    size={200} forma={"circle"} fontSize={120} />
                <h1 style={{ display: 'flex', fontSize: 28, marginTop: '10px', fontWeight: 500, letterSpacing: '-2px', alignItems: 'center' }}>{loadingusers ? users[findUserIndexById()].name : ''} {loadingusers ? users[findUserIndexById()].sername : ''}</h1>
            </div>
            <div className='events__block'>
                <h2>Участник мероприятий</h2>
                {loadingusers ?
                    <div className='list__events'>
                        <h3>2024</h3>
                        <ul>
                            {
                                users[findUserIndexById()].events && users[findUserIndexById()].events.map((item) => {
                                    return <li key={item.id}>{formatDateTime(item.datetimeassetc)}  <Link to={`/event/${item.eventid}`} className='link__event'>{item.title}</Link></li>
                                })}
                        </ul>
                    </div>
                    :
                    ''
                }
            </div>
        </div >
    )
}
