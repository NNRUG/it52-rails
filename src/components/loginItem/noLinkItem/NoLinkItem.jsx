import React from 'react'
import './noLinkItem.css'
import { Link } from 'react-router-dom';

const NoLinkItem = () => {
    return (
        <div className='reg__Item'>
            <h1>Активация аккаунта</h1>
            <div className='form__conteiner'>
                <form>
                    <div className='mail__password'>
                        <label className='label__top'>
                            Email
                        </label>
                        <input className='form__control' type="email" placeholder="cool@hacker.io" autoFocus="autofocus"></input>
                    </div>
                    <input type="submit" name="commit" value="Выслать повторно" data-disable-with="Выслать повторно" className='input__voiti'></input>
                </form>
                <hr />
                <Link to='/login'>Войти</Link>
                <br />
                <Link to='/signup'>Зарегистрироваться</Link>
                <br />
                <Link to='/password'>Кажется, я забыл пароль</Link>
            </div>
        </div>
    )
}

export default NoLinkItem