import React, { useContext } from 'react';
import './header.css'
import { NavLink } from 'react-router-dom'
import Navbar from './Navbar.js';
import SmallNavbar from './SmallNavbar.js';
import { AiOutlineMenu, AiOutlineClose } from 'react-icons/ai'
import { IoMdExit } from "react-icons/io";
import { useWindowWidthAndHeight } from './CustomHooks';
import { Context } from '../../context/Context'

import { BiPlus } from "react-icons/bi";
import ProfileImage from '../profileImage/ProfileImage.jsx';

const Header = () => {
    const { translate, setTranslate, ColorHeader, user, vhod } = useContext(Context);

    const ColorEvent = () => {
        ColorHeader("События")
    };
    const ColorLogin = () => {
        ColorHeader("Войти")
    };
    const ColorProfile = () => {
        ColorHeader("Профиль")
    };
    const ColorAddEvent = () => {
        ColorHeader("Добавить событие")
    };

    const width = useWindowWidthAndHeight();

    return (
        <header>
            <div className="conteiner__header">
                <div className="header__inner">
                    <div className="header__inner-logoNav">
                        <NavLink to="/"
                            id="logo__link"
                            onClick={ColorEvent}>
                            <h1 className={vhod ? 'vhod' : 'logo'}>
                                it52
                            </h1>
                        </NavLink>
                        {width > 770 ?
                            <Navbar navClass="nav"
                                linkClassName="nav__link" />
                            :
                            <Navbar navClass="nav_mobile"
                                linkClassName="nav__link" />
                        }
                    </div>
                    <div id="sidebar__list" className={`${translate ? "addTransiton" : "removeTransition"}`}>
                        <SmallNavbar navClass="navSmall"
                            linkClassName="navSmall__link"
                            onClick={() => setTranslate(false)} />
                    </div>
                    {!translate ?
                        <div className='mdc__drawer__scrim'
                            onClick={() => setTranslate(true)} ></div>
                        :
                        ''}
                    <div className='header__inner-btnLoginMenu'>
                        {vhod ?
                            <>
                                <NavLink to='/events/new' onClick={ColorAddEvent}>
                                    <div className='plus'><BiPlus size={24} /></div>
                                </NavLink>
                                <NavLink to='/profile' onClick={ColorProfile}>
                                    <div className='avatar__profile'>
                                        <ProfileImage color={user.color} name={user.name} size={24} forma={"square"} fontSize={14} />
                                    </div>
                                </NavLink>
                            </>
                            :
                            <NavLink to='/login' className="logo__link">
                                <button className='login_button'
                                    onClick={ColorLogin}>
                                    <div className="ico__login">
                                        <IoMdExit size={18} />
                                    </div>
                                    <span className='text__login'>Войти</span>
                                </button>
                            </NavLink>}
                        <button className="menu__button"
                            onClick={() => setTranslate(!translate)}>
                            {translate ? <AiOutlineMenu size={25} /> : <AiOutlineClose size={25} />}
                        </button>
                    </div>
                </div>
            </div>
        </header >
    )
}

export default Header;