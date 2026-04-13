import React, { useContext, useState } from 'react'
import './regItem.css'
// import { Link } from 'react-router-dom';

import { styled } from '@mui/material/styles';
import { useNavigate } from 'react-router-dom';
import { InputBase, Button, Box, Typography } from '@mui/material';
import { ToastContainer, toast } from 'react-toastify';
import 'react-toastify/dist/ReactToastify.css';
import { Context } from '../../../context/Context';
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
        boxShadow: '1px 1px 4px 1px rgba(0, 0, 0, 0.2)',
    },
}));

const StyledRegisterButton = styled(Button)(({ theme }) => ({
    backgroundColor: '#000000', // Устанавливаем черный цвет фона
    color: '#ffffff', // Устанавливаем белый цвет текста
    '&:hover': {
        backgroundColor: '#333333', // Устанавливаем более темный цвет фона при наведении
    },
}));

// const StyledButton = styled(Button)(({ theme }) => ({
//     backgroundColor: '#f0f0f0', // 浅灰色背景
//     color: '#333333', // 深灰色文字
//     '&:hover': {
//         backgroundColor: '#e0e0e0', // 更深的灰色背景
//     },
// }));

const RegItem = () => {

    const { fetchAllUsers } = useContext(Context)

    const [email, setEmail] = useState('');
    const [emailError, setEmailError] = useState(false);

    const [password, setPassword] = useState('');
    const [passwordError, setPasswordError] = useState(false);

    const [passwordTwo, setPasswordTwo] = useState('');

    //обработчики пароля с почтой
    const handleChangeEmail = (event) => {
        setEmail(event.target.value);
        setEmailError('')
    };

    const handleChangePassword = (event) => {
        setPassword(event.target.value);
        setPasswordError('')
    };
    const handleChangePasswordTwo = (event) => {
        setPasswordTwo(event.target.value);
        setPasswordError('')
    };



    //генератор рандомного цвета для аватара пользователя
    const generateRandomColor = () => {
        const letters = '0123456789ABCDEF';
        let color = '#';
        for (let i = 0; i < 8; i++) {
            color += letters[Math.floor(Math.random() * 16)];
        }

        return color;
    };

    const errorMesenge = (er) => {
        toast(er, {
            position: "top-center",
            autoClose: 5000,
            hideProgressBar: true,
            closeOnClick: true,
            pauseOnHover: true,
            draggable: true,
            progress: undefined,
            theme: "dark"
        });
    };


    const navigate = useNavigate();

    function createUser() {

        fetch('http://localhost:4000/user', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json',
            },
            body: JSON.stringify({ email, password: CryptoJS.AES.encrypt(password, 'your-secret-key').toString(), color: generateRandomColor() }),
        })
            .then(response => {
                return response.text();
            })
            .then(data => {
                if (data === "Пользователь с таким Email уже существует") {
                    setEmailError(true)
                    setPasswordError(true)
                    errorMesenge(`${data}`)
                }
                else {
                    fetchAllUsers()
                    errorMesenge(`${data}`)
                    setTimeout(() => {
                        navigate('/login');
                    }, 2000);
                }
            });
    }

    const validatePassword = () => {
        if (password !== passwordTwo) {
            errorMesenge('Пароли не совпадают');
            setPasswordError(true)
            return false;
        } else if (password.length < 8) {
            errorMesenge('Пароль должен содержать не менее 8 символов');
            setPasswordError(true)
            return false;
        } else {
            return true;
        }
    };

    const validateEmail = () => {
        const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
        if (!emailRegex.test(email)) {
            errorMesenge('Email введен некоректно');
            setEmailError(true)
            return false;
        } else {
            return true;
        }
    };

    const handleSubmit = (e) => {
        e.preventDefault();
        if (validateEmail() && validatePassword()) {
            createUser()
        }
    };

    return (
        <div className='login__Item'>
            <ToastContainer style={{ top: 50 }} />
            <div style={{ display: 'flex', flexDirection: 'column', alignItems: 'center', justifyContent: 'center' }}>
                <Box component="form"
                    onSubmit={handleSubmit}
                    style={{ display: 'flex', flexDirection: 'column', alignItems: 'center', padding: '32px', backgroundColor: '#fff', borderRadius: '11px', boxShadow: '0 2px 40px rgba(0, 0, 0, 0.1)' }}>
                    <StyledTypography variant="h5" >
                        Регистрация
                    </StyledTypography>
                    <StyledInputBase
                        placeholder="Email"
                        variant="outlined"
                        fullWidth
                        error={emailError}
                        value={email}
                        onChange={handleChangeEmail}
                        style={{ marginBottom: '16px' }}
                        sx={{
                            border: `1px solid ${emailError ? 'red' : '#ccc'}`,
                            '&:hover': {
                                border: `1px solid ${emailError ? 'red' : '#999'}`,
                            },
                            '&.Mui-focused': {
                                border: `1px solid ${emailError ? 'red' : '#000'}`,
                                boxShadow: `${emailError ? '0 0 3px 0 red' : '0 0 3px 0 rgba(0, 0, 0, 0.5)'}`,
                            },
                        }}
                    />
                    <StyledInputBase
                        placeholder="Password"
                        type="password"
                        value={password}
                        onChange={handleChangePassword}
                        variant="outlined"
                        fullWidth
                        style={{ marginBottom: '16px' }}
                        sx={{
                            border: `1px solid ${passwordError ? 'red' : '#ccc'}`,
                            '&:hover': {
                                border: `1px solid ${passwordError ? 'red' : '#999'}`,
                            },
                            '&.Mui-focused': {
                                border: `1px solid ${passwordError ? 'red' : '#000'}`,
                                boxShadow: `${passwordError ? '0 0 3px 0 red' : '0 0 3px 0 rgba(0, 0, 0, 0.5)'}`,
                            },
                        }}
                    />
                    <StyledInputBase
                        placeholder="Repeat password"
                        type="password"
                        value={passwordTwo}
                        onChange={handleChangePasswordTwo}
                        variant="outlined"
                        fullWidth
                        style={{ marginBottom: '25px' }}
                        sx={{
                            border: `1px solid ${passwordError ? 'red' : '#ccc'}`,
                            '&:hover': {
                                border: `1px solid ${passwordError ? 'red' : '#999'}`,
                            },
                            '&.Mui-focused': {
                                border: `1px solid ${passwordError ? 'red' : '#000'}`,
                                boxShadow: `${passwordError ? '0 0 3px 0 red' : '0 0 3px 0 rgba(0, 0, 0, 0.5)'}`,
                            },
                        }}
                    />

                    <StyledRegisterButton type="submit" variant="contained">
                        Регистрация
                    </StyledRegisterButton>
                </Box>
            </div>
        </div>
    )
}

export default RegItem