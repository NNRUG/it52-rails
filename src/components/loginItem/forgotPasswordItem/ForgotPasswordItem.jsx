import React from 'react'
import './forgotPasswordItem.css'
import { Link } from 'react-router-dom';

const ForgotPasswordItem = () => {
    return (
        <div className='reg__Item'>
            <h1>Забыли пароль?</h1>
            <div className='form__conteiner'>
                <form>
                    <div className='mail__password'>
                        <label className='label__top'>
                            Email
                        </label>
                        <input className='form__control' type="email" placeholder="cool@hacker.io" autoFocus="autofocus"></input>
                    </div>
                    <input type="submit" name="commit" value="Восстановить" data-disable-with="Восстановить" className='input__voiti'></input>
                </form>
                <hr />
                <Link to='/login'>Войти</Link>
                <br />
                <Link to='/signup'>Зарегистрироваться</Link>
                <br />
                <Link to='/confirmation'>Я не получил ссылку для активации</Link>
            </div>
        </div>
    )
}

export default ForgotPasswordItem