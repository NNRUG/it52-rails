import React, { useState, useContext } from 'react'
import './loginItem.css'
// import { IoLogoGithub } from "react-icons/io5";
// import { FaGooglePlus, FaFacebook, FaTwitter } from "react-icons/fa";
// import { SlSocialVkontakte } from "react-icons/sl";
// import { Link } from 'react-router-dom';
import { Context } from '../../context/Context';

import { styled } from '@mui/material/styles';
import { useNavigate } from 'react-router-dom';
import { InputBase, Button, Box, Typography, Checkbox, FormControlLabel, IconButton } from '@mui/material';
import { Visibility, VisibilityOff } from '@mui/icons-material';
import { ToastContainer, toast } from 'react-toastify';
import 'react-toastify/dist/ReactToastify.css';
import CryptoJS from 'crypto-js';


const StyledTypography = styled(Typography)(({ theme }) => ({
    fontWeight: 'normal',
    fontSize: '24px',
    marginBottom: theme.spacing(2),
    color: '#333333',
}));

const StyledInputBase = styled(InputBase)(({ theme }) => ({
    minWidth: '350px',
    border: '1px solid #ccc',
    borderRadius: '4px',
    '& .MuiInputBase-input': {
        padding: theme.spacing(1.2),
        transition: theme.transitions.create(['border-color', 'background-color'], {
            duration: theme.transitions.duration.short,
        }),
    },
    '&:hover': {
        borderColor: '#999',
    },
    '&.Mui-focused': {
        borderColor: '#000000',
        boxShadow: '0 0 3px 0 rgba(0, 0, 0, 0.5)',
    },
}));

const StyledButton = styled(Button)(({ theme }) => ({
    backgroundColor: '#000000', // Устанавливаем черный цвет фона
    color: '#ffffff', // Устанавливаем белый цвет текста
    '&:hover': {
        backgroundColor: '#222222', // Устанавливаем более темный цвет фона при наведении
    },
}));

const StyledRegisterButton = styled(Button)(({ theme }) => ({
    backgroundColor: '#f0f0f0', // 浅灰色背景
    color: '#333333', // 深灰色文字
    '&:hover': {
        backgroundColor: '#e0e0e0', // 更深的灰色背景
    },
}));

const LoginItem = () => {

    const { setUser, setVhod, users } = useContext(Context)


    const [email, setEmail] = useState('');
    const [password, setPassword] = useState('');
    const [showPassword, setShowPassword] = useState(false); // Новое состояние для отображения/скрытия пароля
    const [error, setError] = useState(false);

    //обработчики для параля и почты
    const handleChangeEmail = (event) => {
        setError(false)
        setEmail(event.target.value)
    };

    const handlePasswordVisibility = () => {
        setShowPassword(!showPassword);
    };


    const handleChangePassword = (event) => {
        setError(false)
        setPassword(event.target.value);
    };

    //проверка на совпадение введенных паролей с базой данных и сохранение данных об активном пользователе
    function Proverka(userr) {
        var index = userr.length
        while (index--) {
            if (userr[index].email === email && CryptoJS.AES.decrypt(userr[index].password, 'your-secret-key').toString(CryptoJS.enc.Utf8) === password) {
                setUser(userr[index])
                localStorage.setItem('user_id', JSON.stringify(userr[index].id));

                return true
            }
        }
        return false
    }

    //вход в систему
    const navigate = useNavigate();
    const logg = () => {
        if (Proverka(users)) {
            setVhod(true)
            localStorage.setItem('vhod', JSON.stringify(true));
            navigate('/');
        }
        else {
            setError(true)
            toast.warn('Пользователь не найден или данные введены неверно', {
                position: "top-center",
                autoClose: 5000,
                hideProgressBar: true,
                closeOnClick: true,
                pauseOnHover: true,
                draggable: true,
                progress: undefined,
                theme: "dark"
            });
        }
    };

    return (
        <div className='login__Item'>
            <ToastContainer style={{ top: 50 }} />
            <div style={{ display: 'flex', flexDirection: 'column', alignItems: 'center', justifyContent: 'center' }}>
                <Box style={{ display: 'flex', flexDirection: 'column', alignItems: 'center', padding: '32px', backgroundColor: '#fff', borderRadius: '11px', boxShadow: '0 2px 40px rgba(0, 0, 0, 0.1)' }}>
                    <StyledTypography variant="h5" >
                        Вход
                    </StyledTypography>
                    <StyledInputBase
                        placeholder="Email"
                        variant="outlined"
                        type='email'
                        fullWidth
                        value={email}
                        onChange={handleChangeEmail}
                        style={{ marginBottom: '16px' }}
                        sx={{
                            border: `1px solid ${error ? 'red' : '#ccc'}`,
                            '&:hover': {
                                border: `1px solid ${error ? 'red' : '#999'}`,
                            },
                            '&.Mui-focused': {
                                border: `1px solid ${error ? 'red' : '#000'}`,
                                boxShadow: `${error ? '0 0 3px 0 red' : '0 0 3px 0 rgba(0, 0, 0, 0.5)'}`,
                            },
                        }}
                    />
                    <Box sx={{ position: 'relative', width: '100%' }}>
                        <StyledInputBase
                            placeholder="Password"
                            type={showPassword ? 'text' : 'password'}
                            value={password}
                            onChange={handleChangePassword}
                            variant="outlined"
                            fullWidth
                            autoComplete="off"
                            style={{ marginBottom: '10px' }}
                            sx={{
                                border: `1px solid ${error ? 'red' : '#ccc'}`,
                                '&:hover': {
                                    border: `1px solid ${error ? 'red' : '#999'}`,
                                },
                                '&.Mui-focused': {
                                    border: `1px solid ${error ? 'red' : '#000'}`,
                                    boxShadow: `${error ? '0 0 3px 0 red' : '0 0 3px 0 rgba(0, 0, 0, 0.5)'}`,
                                },
                            }} />

                        <IconButton
                            onClick={handlePasswordVisibility}
                            sx={{
                                position: 'absolute',
                                top: '40%',
                                right: '5px',
                                transform: 'translateY(-50%)'
                            }}>
                            {showPassword ? <Visibility /> : <VisibilityOff />}
                        </IconButton>
                    </Box>
                    <Box style={{ display: 'flex', justifyContent: 'start', width: '100%', marginLeft: '5px', marginBottom: '25px' }}>
                        <FormControlLabel
                            control={<Checkbox color="primary" />}
                            label="Запомнить меня"
                        />

                    </Box>
                    <Box style={{ display: 'flex', gap: '20px', alignItems: 'center', justifyContent: 'center' }}>
                        <StyledButton variant="contained" color="primary" onClick={logg}>
                            Войти
                        </StyledButton>
                        <StyledRegisterButton href="/signup" variant="body2">
                            Регистрация
                        </StyledRegisterButton>
                    </Box>
                </Box>
            </div>
            {/* <h1>Добро пожаловать!</h1> */}
            {/* <div className="login__ItemRow"> */}
            {/* <div className='row__left'>
                    <h2>Войти через</h2>
                    <ul>
                        <li><a className='all__mes git_hub' href='/'>
                            <div className="ico_btnConteiner">
                                <IoLogoGithub size={15} />
                            </div>
                            GitHub
                        </a></li>
                        <li><a className='all__mes google' href='/'>
                            <div className="ico_btnConteiner">
                                <FaGooglePlus size={15} />
                            </div>
                            Google
                        </a></li>
                        <li><a className='all__mes facebook' href='/'>
                            <div className="ico_btnConteiner">
                                <FaFacebook size={15} />
                            </div>
                            Facebook
                        </a></li>
                        <li><a className='all__mes vk' href='/'>
                            <div className="ico_btnConteiner">
                                <SlSocialVkontakte size={15} />
                            </div>
                            Вконтакте
                        </a></li>
                        <li><a className='all__mes twitter' href='/'>
                            <div className="ico_btnConteiner">
                                <FaTwitter size={15} />
                            </div>
                            Twitter
                        </a></li>
                    </ul>
                </div> */}
            {/* <div className='row__right'>
                    <h2>Войти</h2>
                    <div>
                        <StyledInputBase
                            id="outlined-basic"
                            value={email}
                            onChange={handleChangeEmail}
                            label="Email"
                            variant="outlined"
                        />
                        <TextField
                            id="outlined-basic"
                            value={password}
                            onChange={handleChangePassword}
                            label="Пароль"
                            variant="outlined"
                        /> */}
            {/* <div className='mail__password'>
                            <label className='label__top'>
                                Email
                            </label>
                            <input className='form__control' type="email" placeholder="cool@hacker.io" autoFocus="autofocus"
                                value={email}
                                onChange={handleChangeEmail}></input>
                        </div> */}
            {/* <div className='mail__password'>
                            <label className='label__top'>
                                Пароль
                            </label>
                            <input className='form__control' type="password"
                                value={password}
                                onChange={handleChangePassword}></input>
                        </div> */}
            {/* <div className='saveMe'>
                            <input type="checkbox"></input>
                            <label>
                                Запомнить меня
                            </label>
                        </div>
                        <Link className='input__voiti' onClick={logg} to='/' style={{ textDecoration: 'none' }}>Войти</Link>
                    </div>
                    <hr />
                    <Link to='/signup'>Зарегистрироваться</Link>
                    <br />
                    <Link to='/password'>Кажется, я забыл пароль</Link>
                    <br />
                    <Link to='/confirmation'>Я не получил ссылку для активации</Link>
                </div> */}
            {/* </div> */}
        </div >
    )
}

export default LoginItem