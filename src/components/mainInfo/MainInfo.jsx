import React, { useContext } from 'react'
import { Link } from 'react-router-dom';

import { FaCalendar, FaShareAlt, FaTelegram, FaTag, FaEye } from "react-icons/fa";
import { FaLocationPin, FaSquareXTwitter, FaUserLarge, FaPeopleGroup } from "react-icons/fa6";
import { SlSocialVkontakte } from "react-icons/sl";
import './mainInfo.css'
import { Context } from '../../context/Context';

const MainInfo = (props) => {
    const { setChoseUser } = useContext(Context)

    //Обработчик нажатия для перемещения на нужного участника
    const handleUsers = (user) => {
        setChoseUser(user)
        localStorage.setItem('choseUser', JSON.stringify(user));
    };

    return (
        <div className='main__info'>
            <div className="info__data">
                <div className="ico__conteiner">
                    <FaCalendar size={14} />
                </div>
                <a href='/'>{props.exactLocation}</a>
            </div>
            <div className="info__dataAdress">
                <div className="ico__conteinerAdress">
                    <FaLocationPin size={14} />
                </div>
                <a href='/'>{props.adress}{props.name ? `, ${props.name}` : ''}</a>
            </div>
            <div className="info__dataOrganizer">
                <div className="ico__conteinerOrganizer">
                    <FaUserLarge size={14} />
                </div>
                <div className='organaizer__name'>Организатор</div>
                <Link to={`/user/${props.organizator.nik}`} onClick={() => handleUsers(props.organizator.id)}>{props.organizator ? props.organizator.organizer : ''}</Link>
            </div>

            {props.paparticipantsBoolean ?
                <div className="info__dataParticipants">
                    <div className="ico__conteinerParticipants">
                        <FaPeopleGroup size={14} />
                    </div>
                    <div className='organaizer__name'>Участники</div>
                    {props.participants ?
                        <div>{props.participants}</div> : '0'}
                </div> : ''}

            <div className="info__dataShare">
                <div className="ico__conteinerShare">
                    <FaShareAlt size={14} />
                </div>
                <div className='organaizer__share'>Поделиться в</div>
                <div className="share__ico">
                    <a href='/'><FaTelegram size={24} /></a>
                    <a href='/'><SlSocialVkontakte size={24} /></a>
                    <a href='/'><FaSquareXTwitter size={24} /></a>
                </div>
            </div>
            {props.tags ?
                <div className="info__dataTags">
                    <div className="ico__conteinerTags">
                        <FaTag size={14} />
                    </div>
                    {props.tags && props.tags.map((item) => {
                        return <a key={item.id} href='/'>{item.tag}</a>
                    })}

                </div>
                :
                ''}
            <div className="info__data">
                <div className="ico__conteiner">
                    <FaEye size={14} />
                </div>
                0
            </div>
        </div>
    )
}

export default MainInfo