import React, { useContext, useEffect } from 'react';
import './wasWillBe.css'

import { MdEventNote, } from "react-icons/md";
import { BiRss } from "react-icons/bi";

import { Context } from '../../../context/Context'

function WasWillBe() {



    const { setwillWas, ww, setWw } = useContext(Context);



    useEffect(() => {
        localStorage.setItem('ww', ww);

        return () => {
            // Эта функция будет вызываться при размонтировании компонента
            // или при перезагрузке страницы
            localStorage.removeItem('ww');
        };
    }, [ww]);

    const dataColor = (event) => {
        setWw(event.target.innerText)
        localStorage.setItem('ww', JSON.stringify(event.target.innerText));
        setwillWas(event.target.innerText)
    };

    return (
        <div className='header__events'>
            <div className="pull__right">
                <a href="/" className="pull__right__icon">
                    <MdEventNote size={24} />
                </a>
                <a href="/" className="pull__right__icon">
                    <BiRss className='right__icon' size={24} />
                </a>
            </div>
            <div className="wasWillBe__buttons">
                <button
                    className="button"
                    onClick={dataColor}
                    style={{ border: ww === "БУДУТ" ? '1px solid #fff' : '1px solid #000' }}>
                    Будут
                </button>
                <button
                    className="button"
                    onClick={dataColor}
                    style={{ border: ww === "БЫЛИ" ? '1px solid #fff' : '1px solid #000' }}>
                    Были
                </button>
            </div>
        </div>
    )
}

export default WasWillBe;