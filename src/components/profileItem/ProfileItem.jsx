import React, { useContext, useState, useEffect } from 'react'
import './profileItem.css'
import TextField from '@mui/material/TextField'
import { Avatar, IconButton } from '@mui/material';
import { PhotoCamera } from '@mui/icons-material';

import { Context } from '../../context/Context'
import { Link } from 'react-router-dom';

function formatDateTime(dateTimeString) {
    const date = new Date(dateTimeString);
    const monthNames = ["января", "февраля", "марта", "апреля", "мая", "июня",
        "июля", "августа", "сентября", "октября", "ноября", "декабря"
    ];

    const day = date.getDate();
    const monthIndex = date.getMonth();
    const month = monthNames[monthIndex];

    return `${day} ${month}`;
};

const ProfileItem = () => {
    const { user, ColorHeader, setVhod } = useContext(Context)

    const [name, setName] = useState(user.name === undefined ? ' ' : user.name);
    const [sername, setSername] = useState(user.sername === undefined ? ' ' : user.sername);
    const [nik, setNik] = useState(user.nik === undefined ? ' ' : user.nik);
    const [placejob, setPlacejob] = useState(user.placejob === undefined ? ' ' : user.placejob);
    const [sait, setSait] = useState(user.sait === undefined ? ' ' : user.sait);
    const [about, setAbout] = useState(user.about === undefined ? ' ' : user.about);
    const [selectedFile, setSelectedFile] = useState('');


    useEffect(() => {
        fetchUser()
    }, []);


    function fetchUser() {
        const iduser = localStorage.getItem('user_id');

        fetch(`http://localhost:4000/user/${iduser}`)
            .then(response => {

                return response.json();
            })
            .then(data => {
                setName(data[0].name)
                setSername(data[0].sername)
                setNik(data[0].nik)
                setPlacejob(data[0].placejob)
                setSait(data[0].sait)
                setAbout(data[0].about)
            });
    }

    const handleFileChange = (event) => {
        const file = event.target.files[0];
        setSelectedFile(URL.createObjectURL(file));
    };

    const handleChangeName = (event) => {
        setName(event.target.value)
    };

    const handleChangeSername = (event) => {
        setSername(event.target.value)
    };

    const handleChangeNik = (event) => {
        setNik(event.target.value)
    };

    const handleChangePlacejob = (event) => {
        setPlacejob(event.target.value)
    };

    const handleChangeSait = (event) => {
        setSait(event.target.value)
    };

    const handleChangeAbout = (event) => {
        setAbout(event.target.value)
    };

    function updateUser() {
        fetch(`http://localhost:4000/user/${user.id}`, {
            method: 'PUT',
            headers: {
                'Content-Type': 'application/json',
            },
            body: JSON.stringify({ name, sername, nik, placejob, sait, about }),
        })
            .then(response => {
                return response.text();
            })
            .then(data => {
                alert(data);
                fetchUser();
            });
    }

    const ColorExit = () => {
        ColorHeader("СОБЫТИЯ")
        setVhod(false)
        localStorage.setItem('vhod', JSON.stringify(false));
        localStorage.setItem('user', JSON.stringify({}));
    };

    const log = () => {
        updateUser()
    };

    const [activeTab, setActiveTab] = useState(-1);

    const handleTabClick = (index) => {
        setActiveTab(index);
    };


    return (
        <>
            <div className='image__block'>
                <div style={{ position: 'relative' }}>
                    <Avatar src={selectedFile} sx={{ bgcolor: user.color, width: 230, height: 230, fontSize: 80 }}>{user.name ? user.name[0] : '?'}</Avatar>
                    <IconButton
                        component="label"
                        sx={{
                            width: 60,
                            height: 60,
                            border: 5,
                            borderColor: 'white',
                            position: 'absolute',
                            bottom: 0,
                            right: 10,
                            color: '#ffffff',
                            backgroundColor: '#428bca',
                            '&:hover': {
                                backgroundColor: '#3071a9',
                            },
                        }}>
                        <input
                            type="file"
                            accept="image/*"
                            onChange={handleFileChange}
                            style={{ display: 'none' }}
                        />
                        <PhotoCamera />
                    </IconButton>
                </div>
                <button className='profilexit'>
                    <Link onClick={ColorExit} to='/login'>
                        Выйти
                    </Link>
                </button>
            </div>
            <div className='information__block'>
                <div className="profile-tabs">
                    <div className="tabs">
                        <div
                            className={`tab ${activeTab === -1 ? 'active' : ''}`}
                            onClick={() => handleTabClick(-1)}>
                            Данные пользователя
                        </div>
                        <div
                            className={`tab ${activeTab === 1 ? 'active' : ''}`}
                            onClick={() => handleTabClick(1)}>
                            Список мероприятий
                        </div>
                    </div>
                    <div className="tab-indicator" style={{ transform: `translateX(${activeTab * 50}%)` }} />
                </div>
                {activeTab === -1 ? <div className='form'>
                    <div className="input__block">
                        <TextField
                            id="outlined-basic"
                            value={name}
                            onChange={handleChangeName}
                            label="Имя"
                            variant="outlined"
                        />
                        <TextField
                            id="outlined-basic"
                            value={sername}
                            onChange={handleChangeSername}
                            label="Фамилия"
                            variant="outlined"
                            style={{ minWidth: '100%' }} />
                        <TextField
                            id="outlined-basic"
                            value={nik}
                            onChange={handleChangeNik}
                            label="Ник"
                            variant="outlined"
                            style={{ minWidth: '100%' }} />
                        <TextField
                            id="outlined-basic"
                            value={placejob}
                            onChange={handleChangePlacejob}
                            label="Место работы"
                            variant="outlined"
                            style={{ minWidth: '100%' }} />
                        <TextField
                            id="outlined-basic"
                            value={sait}
                            onChange={handleChangeSait}
                            helperText='Укажите ваш сайт или оставьте поле пустым.'
                            label="Сайт"
                            variant="outlined"
                            sx={{ m: 0 }} />
                        <TextField
                            id="outlined-basic"
                            value={about}
                            onChange={handleChangeAbout}
                            label="О себе"
                            variant="outlined"
                            style={{ minWidth: '100%' }}
                            multiline
                            rows={8} />
                    </div>
                    <button className='btn__save' onClick={log}>Сохранить изменения</button>
                </div>
                    :
                    <div className='list__events'>
                        <h3>2024</h3>
                        <ul>
                            {user.events && user.events.map((item) => {
                                return <li key={item.id}>{formatDateTime(item.datetimeassetc)}
                                    <Link
                                        to={`/event/${item.eventid}`}
                                        className='link__event'>
                                        {item.title}
                                    </Link>
                                </li>
                            })}
                        </ul>
                    </div>
                }
            </div>
        </>
    )
}

export default ProfileItem