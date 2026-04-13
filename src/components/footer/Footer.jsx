import React from 'react';
import './footer.css'

import { FaGooglePlay, FaApple, FaDocker, FaPatreon, FaFacebook, FaTelegramPlane } from "react-icons/fa";
import { IoLogoGithub } from "react-icons/io5";
import { SlSocialVkontakte } from "react-icons/sl";
import { IoMdMail } from "react-icons/io";

import footer from '../../assetc/footer.svg'

const Footer = () => {

    return (
        <footer>
            <div className='conteiner'>
                <div className="container__1">
                    <div className="footer__cell__1">
                        <a className='con__a' href='/'>2014 — 2024 © IT52.info</a>
                        <div className="sociall__icons">
                            <a className='social__iconsLink' href='https://play.google.com/store/apps/details?id=io.github.defolters.it52&utm_source=it52'>
                                <FaGooglePlay size={18} />
                            </a>
                            <a className='social__iconsLink' href='https://apps.apple.com/ru/app/it52/id1239876838  '>
                                <FaApple size={18} />
                            </a>
                            <a className='social__iconsLink' href='https://github.com/NNRUG/it52-rails'>
                                <IoLogoGithub size={18} />
                            </a>
                            <a className='social__iconsLink' href='https://hub.docker.com/r/it52/rails'>
                                <FaDocker size={18} />
                            </a>
                            <a className='social__iconsLink' href='https://www.patreon.com/it52'>
                                <FaPatreon size={18} />
                            </a>
                            <a className='social__iconsLink' href='https://www.facebook.com/it52info'>
                                <FaFacebook size={18} />
                            </a>
                            <a className='social__iconsLink' href='https://vk.com/it52info'>
                                <SlSocialVkontakte size={18} />
                            </a>
                            <a className='social__iconsLink' href='mailto:events@it52.info'>
                                <IoMdMail size={18} />
                            </a>
                            <a className='social__iconsLink' href='tg://resolve=it52info/'>
                                <FaTelegramPlane size={18} />
                            </a>
                        </div>
                    </div>
                    <div className="footer__cell__2">
                        <a className='mcs__logo' href='https://mcs.mail.ru/?utm_source=referral&utm_medium=partner&utm_campaign=partner_it52'>
                            <img alt='' src={footer} />
                            <small>на инфраструктуре MCS</small>
                        </a>
                    </div>
                </div>
                <div className="container__2">
                    <p className='copyrights'>
                        <small>Google Play и логотип Google Play являются товарными знаками корпорации Google LLC. Apple и логотип Apple являются товарными знаками Apple. Другие названия компаний и продуктов могут являться товарными знаками соответствующих владельцев.</small>
                    </p>
                </div>
            </div>
        </footer>
    )
}

export default Footer;