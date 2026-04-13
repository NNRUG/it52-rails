import React, { useState, useRef, useEffect, useContext } from "react";
import './dropdown.css';
import { Context } from '../../../context/Context'

function Dropdown() {

    //Открытие и закрытие меню на кнопку/////////////
    const [open, setOpen] = useState(false);

    const handleOpen = () => {
        setOpen(!open)
    }
    /////////////////////////////////////////////////

    //Закрытие списка при клике в любое место кроме элементов поля
    const modalRef = useOnClickOutsideRef(() => setOpen(false))

    //Смена цвета и передача активной кнопки
    const { setNameBaze } = useContext(Context)
    const [menu, setMenu] = useState("Все события")

    const menuColor = (event) => {
        setMenu(event.target.innerText)
        setNameBaze(event.target.innerText)
    };

    //////////////////////////////////////////////////////////////

    //////////////////////////////////////////////////////////////

    return (
        <div className="dropdown">
            <button className="dropdown__button" onClick={handleOpen} id="modal" ref={modalRef}>
                {menu}
            </button>
            {(open &&
                <ul className="dropdown__menu">
                    <li className="dropdown__item" >
                        <button
                            onClick={menuColor}
                            style={{ backgroundColor: menu === "Все события" ? '#e0e0e0' : '' }}>Все события</button>
                    </li>
                    <li className="dropdown__item">
                        <button
                            onClick={menuColor}
                            style={{ backgroundColor: menu === "Митапы" ? '#e0e0e0' : '' }}>Митапы</button>
                    </li>
                    <li className="dropdown__item">
                        <button
                            onClick={menuColor}
                            style={{ backgroundColor: menu === "Обучение" ? '#e0e0e0' : '' }}>Обучение</button>
                    </li>
                </ul>
            )}
        </div>
    )

}
//Закрытие списка при клике в любое место кроме элементов поля
function useOnClickOutsideRef(callback = () => { }, initialValue = null) {
    const elementRef = useRef(initialValue)
    useEffect(() => {
        function handler(event) {
            if (!elementRef.current?.contains(event.target)) {
                callback()
            }
        }
        window.addEventListener('click', handler)
        return () => window.removeEventListener('click', handler)
    }, [callback])

    return elementRef
}
//////////////////////////////////////////////////////////////
export default Dropdown