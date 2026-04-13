import React, { useEffect } from 'react'
import Dropdown from '../components/infoItem/dropdown/Dropdown.jsx'
import WasWillBe from '../components/infoItem/wasWillBe/WasWillBe.jsx'
import Event from '../components/infoItem/event/Event.jsx'

const Info = () => {

  useEffect(() => {
    window.scrollTo(0, 0);
  }, []);

  return (

    <div className='Main'>
      <div className='conteiner'>
        <Dropdown />
        <WasWillBe />
        <Event />
      </div>
    </div>

  )
}

export default Info