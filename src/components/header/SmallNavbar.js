import React, { useContext } from 'react';
import { NavLink } from 'react-router-dom'
import { Context } from '../../context/Context'

import { RiCalendar2Fill } from "react-icons/ri";
import { IoMdPeople, IoMdExit } from "react-icons/io";
import { HiQuestionMarkCircle } from "react-icons/hi2";
import { FaHeart, FaPowerOff } from "react-icons/fa";
import { LiaPlusSolid } from "react-icons/lia";
import android from '../../assetc/android.png'
import ios from '../../assetc/ios.svg'
import ProfileImage from '../profileImage/ProfileImage';

const SmallNavbar = ({ navClass, linkClassName }) => {
    const { setTranslate, ColorHeader, color, vhod, setVhod, user } = useContext(Context);

    const Color = (event) => {
        ColorHeader(event.target.innerText)
        setTranslate(true)
    };

    const ColorExit = () => {
        ColorHeader("СОБЫТИЯ")
        setVhod(false)
        localStorage.setItem('vhod', JSON.stringify(false));
        localStorage.setItem('user', JSON.stringify({}));
        setTranslate(true)
    };

    return (
        <>
            {vhod ?
                <div className='name__email'>
                    <h3>{user.name} {user.sername}</h3>
                    <h6>{user.email}</h6>
                </div> :
                ''}
            <div className={navClass} >

                <NavLink className='icoLink' to={vhod ? '/events/new' : '/login'} onClick={Color} style={{ background: color === "ДОБАВИТЬ СОБЫТИЕ" ? '#111111' : '' }}>
                    <div className='icoLind__conteiner'>
                        <LiaPlusSolid className='ico' size={24} />
                    </div>
                    <div className={linkClassName} >Добавить событие</div>
                </NavLink>
                <hr />
                <NavLink className='icoLink' to='/' onClick={Color} style={{ background: color === "СОБЫТИЯ" ? '#111111' : '' }}>
                    <div className='icoLind__conteiner'>
                        <RiCalendar2Fill className='ico' size={24} />
                    </div>
                    <div className={linkClassName}>События</div>
                </NavLink>
                <NavLink className='icoLink' to='/communities' onClick={Color} style={{ background: color === "СООБЩЕСТВА" ? '#111111' : '' }}>
                    <div className='icoLind__conteiner'>
                        <IoMdPeople className='ico' size={24} />
                    </div>
                    <div className={linkClassName} >Сообщества</div>
                </NavLink>
                <NavLink className='icoLink' to='/startups' onClick={Color} style={{ background: color === "СТАРТАПЫ" ? '#111111' : '' }}>
                    <div className='icoLind__conteiner'>
                        <RiCalendar2Fill className='ico' size={24} />
                    </div>
                    <div className={linkClassName} >Стартапы</div>
                </NavLink>
                <NavLink className='icoLink' to='/about' onClick={Color} style={{ background: color === "О НАС" ? '#111111' : '' }}>
                    <div className='icoLind__conteiner'>
                        <HiQuestionMarkCircle className='ico' size={24} />
                    </div>
                    <div className={linkClassName}>О нас</div>
                </NavLink>
                <NavLink className='icoLink' to='/help' onClick={Color} style={{ background: color === "ПОМОЧЬ!" ? '#111111' : '' }}>
                    <div className='icoLind__conteiner'>
                        <FaHeart className='ico' size={22} />
                    </div>
                    <div className={linkClassName} >Помочь!</div>
                </NavLink>
                {vhod ?
                    <>
                        <hr />
                        <NavLink className='icoLink' to='/profile' onClick={Color} style={{ background: color === "ПРОФИЛЬ" ? '#111111' : '' }}>
                            <ProfileImage color={user.color} name={user.name} size={24} forma={"square"} fontSize={14} />
                            <div className={linkClassName} >Профиль</div>
                        </NavLink>
                    </> :
                    ''}
                <hr />
                {vhod ?
                    <NavLink className='icoLink' to={'/'} onClick={ColorExit}>
                        <div className='icoLind__conteiner'>
                            <FaPowerOff className='ico' size={22} />
                        </div>
                        <div className={linkClassName} >Выйти</div>
                    </NavLink> :
                    <NavLink className='icoLink' to='/login' onClick={Color} style={{ background: color === "ВОЙТИ" ? '#111111' : '' }}>
                        <div className='icoLind__conteiner'>
                            <IoMdExit className='ico' size={24} />
                        </div>
                        <div className={linkClassName} >Войти</div>
                    </NavLink>}
            </div >
            <div className='aside__footer'>
                <p><a className='instll__nav' href='https://play.google.com/store/apps/details?id=io.github.defolters.it52&utm_source=it52' style={{ backgroundImage: `url(${ios})`, width: 158, backgroundSize: 'contain' }}> </a></p>
                <p><a className='instll__nav' href='https://apps.apple.com/ru/app/it52/id1239876838' style={{ backgroundImage: `url(${android})`, width: 158, backgroundSize: 'cover' }}> </a></p>
            </div>
        </>
    )
}
export default SmallNavbar;