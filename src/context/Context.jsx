import React, { useState, useEffect, createContext } from 'react'
export const Context = createContext(null);

//Поучения массива необходимой длины для хранения данных о событиях
const getDefaultCart = (event) => {
  let cart = [];
  for (let index = 0; index < event.length; index++) {
    cart[index] = event[index];
  }

  return cart;
}

const ContextProvider = ({ children }) => {


  const [baze, setBaze] = useState([]);
  const [loadinevents, setLoadinevents] = useState(false);

  //импорт пользователей
  const [user, setUser] = useState({});
  const [users, setUsers] = useState([]);
  const [loadinguser, setLoadinguser] = useState(false);
  const [loadingusers, setLoadingusers] = useState(false);


  const [choseUser, setChoseUser] = useState();

  useEffect(() => {
    const localchoseUser = localStorage.getItem('choseUser');
    if (localchoseUser !== null) {
      setChoseUser(JSON.parse(localchoseUser));
    }
  }, []);


  //импорт всех пользователей
  useEffect(() => {
    fetchAllUsers();
  }, []);

  function fetchAllUsers() {
    fetch('http://localhost:4000/login')
      .then(response => {
        return response.json();
      })
      .then(data => {
        setUsers(data);
        setLoadingusers(true)
      });
  }

  //Определения входа в аккаунт
  const [vhod, setVhod] = useState(false);

  useEffect(() => {
    const localVhod = localStorage.getItem('vhod');
    if (localVhod !== null) {
      setVhod(JSON.parse(localVhod));
    }
  }, []);

  //импорт пользователя который вошел в систему
  useEffect(() => {
    fetchUser();
  }, []);

  function fetchUser() {
    const iduser = localStorage.getItem('user_id');

    fetch(`http://localhost:4000/user/${iduser}`)
      .then(response => {
        return response.json();
      })
      .then(data => {
        setUser(data[0]);
        setLoadinguser(true)
      });
  }

  const [translate, setTranslate] = useState(true);

  //импорт событий
  useEffect(() => {
    fetchAllEvent();
  }, []);

  function fetchAllEvent() {
    fetch('http://localhost:4000')
      .then(response => {
        return response.json();
      })
      .then(data => {
        setBaze(data);
        setLoadinevents(true)
      });
  }

  //Смена цвета активных кнопок
  const [color, setColor] = useState("СОБЫТИЯ");


  const ColorHeader = (dateEvent) => {
    setColor(dateEvent.toUpperCase())
    return color
  }


  //Определение категории собтий
  const getEventBaze = (nameBaze) => {
    let choseEv = [];

    if (nameBaze === "Все события") {
      choseEv = baze;
    }
    else if (nameBaze === "Митапы") {
      for (let index = 0; index < baze.length; index++) {
        if (baze[index].event === 1) {
          choseEv[index] = baze[index];
        }
      }

      let filtered = choseEv.filter(function (el) {
        return el != null;
      });

      choseEv = filtered;
    }
    else {
      for (let index = 0; index < baze.length; index++) {
        if (baze[index].event === 2) {
          choseEv[index] = baze[index];
        }
      }

      let filtered = choseEv.filter(function (el) {
        return el != null;
      });

      choseEv = filtered;
    }

    return choseEv
  }

  //фильтруем события по дате
  const [nameBaze, setNameBaze] = useState("Все события");
  const [willWas, setwillWas] = useState("БУДУТ");
  const current = new Date();
  const date = `${current.getFullYear()}-${current.getMonth() + 1}-${current.getDate()}`;
  const nowDate = new Date(date)

  const chooseEvent = () => {

    let chose = getDefaultCart(getEventBaze(nameBaze))

    var index = chose.length

    if (willWas === "БУДУТ") {
      while (index--) {
        let bazeDate = new Date(chose[index].datetimeassetc);

        if (bazeDate <= nowDate) {
          chose.splice(index, 1);
        }
      }
    }
    else {
      while (index--) {
        let bazeDate = new Date(chose[index].datetimeassetc);

        if (bazeDate > nowDate) {
          chose.splice(index, 1);
        }
      }
    }

    return chose;
  }


  //Кнопка регистрации
  const button = (dateEvent, reg) => {
    let result = '';

    let bazeDate = new Date(dateEvent);
    if (bazeDate - nowDate > 0) {
      if (reg && vhod) result = 'Отказаться от участия'
      else result = 'Зарегистрироваться'

    }
    else {
      if (reg && vhod) result = 'Меня не было на мероприятии'
      else result = 'я участвовал'
    }

    return result
  }

  const [ww, setWw] = useState(localStorage.getItem('ww') || "БУДУТ");

  const contextValue = {
    chooseEvent,
    setNameBaze,
    setwillWas,
    baze,
    button,
    translate,
    setTranslate,
    ColorHeader,
    color,
    vhod,
    setVhod,
    users,
    user,
    setUser,
    fetchAllEvent,
    fetchUser,
    fetchAllUsers,
    choseUser,
    setChoseUser,
    loadingusers,
    loadinevents,
    ww,
    setWw,
    loadinguser
  }

  return (
    <Context.Provider value={contextValue}>
      {children}
    </Context.Provider>
  )
}

export default ContextProvider