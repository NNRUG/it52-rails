import React, { useContext } from 'react'
import './addEventItem.css'
import TextField from "@mui/material/TextField";
import { ThemeProvider, createTheme } from "@mui/material";
import { Select, MenuItem, InputLabel, FormControl, Checkbox, FormControlLabel, Box } from "@mui/material";
import { useState } from "react";
import { Editor } from '@tinymce/tinymce-react';
import { Context } from '../../context/Context';

import { ToastContainer, toast } from 'react-toastify';
import 'react-toastify/dist/ReactToastify.css';

const theme = createTheme({

    //стили для инпутов
    components: {
        MuiTextField: {
            styleOverrides: {
                root: {
                    // Standard
                    "& .MuiInput-root": {
                        color: "#000",
                        fontFamily: "fira mono",
                        fontWeight: "normal",
                        "&:before": {

                            borderWidth: "1px",
                        },
                        "&:after": {

                            borderWidth: "2px",
                        },
                        ":hover:not(.Mui-focused)": {
                            "&:before": {

                                borderWidth: "2px",
                            },
                        },
                    },
                },
            },
        },
    },
});

const AddEventItem = () => {

    const { user, fetchAllEvent } = useContext(Context);


    const [title, setTitle] = useState('');
    const [selectedImage, setSelectedImage] = useState('');
    const [event, setEvent] = useState('');
    const [date, setDate] = useState('');
    const [tags, setTags] = useState('');
    const [adress, setAdress] = useState('');
    const [name, setName] = useState('');
    const [showInput, setShowInput] = useState(false);
    const [contentt, setContentt] = useState('');
    const [linkreg, setLinkreg] = useState('');

    //обработчики инпутов
    const handleChangeTitle = (event) => {
        setTitle(event.target.value)
    };

    const handleImageChange = (event) => {
        setSelectedImage(event.target.value);
    };

    const handleChangeEvent = (event) => {
        setEvent(event.target.value);
    };

    const handleChangeDate = (event) => {
        setDate(event.target.value);
    };

    const handleChangeTags = (event) => {
        setTags(event.target.value);
    };

    const handleChangeAdres = (event) => {
        setAdress(event.target.value);
    };

    const handleChangeName = (event) => {
        setName(event.target.value);
    };
    const handleLinkreg = (event) => {
        setLinkreg(event.target.value);
    };

    const handleCheckboxChange = (event) => {
        setShowInput(event.target.checked);
    };

    function addSlashAfterWord(str, word) {
        const regex = new RegExp(`(${word})`, 'g');

        return str.replace(regex, '$1/');
    }

    const handleUpdate = (value, editor) => {
        const length = editor.getContent();
        setContentt(length);
    };

    //форматирование input тегов
    function formatTags(tagString) {
        const tagsss = tagString.split(',').map(tag => tag.trim());
        if (tagString === '') return null
        else {
            return tagsss.map((tag, index) => ({
                id: String(index + 1),
                tag
            }));
        }
    }

    //форматирование input тегов
    function formatOganaizer() {
        const organizer = {
            id: user.id,
            organizer: user.name + ' ' + user.sername,
            nik: user.nik
        };
        return organizer
    }

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

    //запрос в бд на создание нового события
    function createMerchant() {
        fetch('http://localhost:4000/data_event', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json',
            },
            body: JSON.stringify({
                title,
                adress,
                name,
                date,
                event,
                selectedImage,
                contentt: addSlashAfterWord(contentt),
                tags: formatTags(tags),
                organizer: formatOganaizer(),
                linkreg: linkreg === '' ? null : linkreg
            }),
        })
            .then(response => {
                return response.text();
            })
            .then(data => {
                errorMesenge(data);
                fetchAllEvent()
            });
    }

    const logg = () => {
        createMerchant()
    };

    return (
        <div className='addeventItem'>
            <ToastContainer style={{ top: 50 }} />
            <h1>Новое мероприятие</h1>
            <Box component="form" sx={{ display: 'flex', flexWrap: 'wrap', marginTop: 1 }}>
                <ThemeProvider theme={theme}>
                    <TextField
                        position="start"
                        label="Название"
                        variant="standard"
                        value={title}
                        onChange={handleChangeTitle}
                        sx={{ width: '100%' }} />
                    <div className='mui'>
                        <div className='mui__left'>
                            <FormControl variant="standard">
                                <InputLabel id="demo-simple-select-standard-label">Тип</InputLabel>
                                <Select
                                    labelId="demo-simple-select-standard-label"
                                    id="demo-simple-select-standard"
                                    value={event}
                                    onChange={handleChangeEvent}
                                    label="Тип"
                                >
                                    <MenuItem value={1}>Событие</MenuItem>
                                    <MenuItem value={2}>Обучение</MenuItem>
                                </Select>
                            </FormControl>
                            <TextField
                                label="Дата начала"
                                variant="standard"
                                value={date}
                                onChange={handleChangeDate}

                            />
                            <TextField
                                label="Ссылка на фото"
                                variant="standard"
                                value={selectedImage}
                                onChange={handleImageChange}
                            />
                            <TextField
                                label="Теги"
                                variant="standard"
                                helperText="В качестве разделителя используйте пробелы или запятые"
                                value={tags}
                                onChange={handleChangeTags}
                            />
                        </div>
                        <div className='mui__right'>
                            <TextField
                                variant="standard"
                                label="Адрес"
                                helperText="Просто адрес: город, улица и дом"
                                value={adress}
                                onChange={handleChangeAdres}
                            />
                            <TextField
                                variant="standard"
                                id="filled-multiline-static"
                                label="Место проведения"
                                multiline
                                rows={2}
                                helperText="Офис компании, бизнес-центр, гостиница, кафе"
                                value={name}
                                onChange={handleChangeName}
                            />
                            <FormControl variant="standard">
                                <FormControlLabel
                                    control={
                                        <Checkbox
                                            checked={showInput}
                                            onChange={handleCheckboxChange}
                                            size="small" />}
                                    label="Сторонняя регистрация"
                                />
                                {showInput && (
                                    <TextField
                                        sx={{ position: "absolute", mt: 5, width: "100%" }}
                                        variant="standard"
                                        label="Ссылка на стороннюю регистрацию"
                                        value={linkreg}
                                        onChange={handleLinkreg}
                                    />
                                )}
                            </FormControl>
                        </div>
                    </div>
                </ThemeProvider>
            </Box>
            <div className='tiny'>
                <label className='tyni__about'>Описание</label>
                <Editor
                    value={contentt}
                    onEditorChange={handleUpdate}
                    apiKey='ks5g6d018fc744k84qgkfmqiw6ijt1ejd596gy3i4a6o9xek'
                    init={{
                        menubar: false,
                        height: 350,
                        min_height: 350,
                        content_style: 'body { font-family:Helvetica,Arial,sans-serif; font-size:14px }'
                    }} />
                <button className='button__form__event' onClick={logg}>Добавить мероприятие</button>
            </div>
        </div >
    )
}

export default AddEventItem