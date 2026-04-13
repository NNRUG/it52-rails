import React from "react";
import Header from "./components/header/Header.jsx";
import Info from './pages/Info';
import Footer from "./components/footer/Footer.jsx";

import { BrowserRouter, Routes, Route } from 'react-router-dom';

import Communities from './pages/Communities';
import Startups from './pages/Startups';
import About from './pages/About/About.jsx';
import Help from './pages/Help';
import Login from './pages/Login/Login.jsx';

import { EventPage } from "./pages/EventPage.jsx";
import Manifest from "./pages/About/Manifest.jsx";
import Register from "./pages/Login/Register.jsx";
import Profile from "./pages/Profile.jsx";
import AddEvent from "./pages/AddEvent.jsx";
import { UserPage } from "./pages/UserPage.jsx";


function App() {

  return (
    <div className="wrapper">
      <BrowserRouter>
        <Header />
        <Routes>
          <Route path='/' element={<Info />} />
          <Route path='/event' element={<EventPage />}>
            <Route path=':eventId' element={<EventPage />} />
          </Route>
          <Route path='/user' element={<UserPage />}>
            <Route path=':userNik' element={<UserPage />} />
          </Route>
          <Route path='/communities' element={<Communities />} />
          <Route path='/startups' element={<Startups />} />
          <Route path='/about' element={<About />} />
          <Route path='/manifest' element={<Manifest />} />
          <Route path='/help' element={<Help />} />
          <Route path='/login' element={<Login />} />
          <Route path='/profile' element={<Profile />} />
          <Route path='/events/new' element={<AddEvent />} />
          <Route path='/signup' element={<Register />} />
        </Routes>
        <Footer />
      </BrowserRouter>
    </div>
  );
}

export default App;
