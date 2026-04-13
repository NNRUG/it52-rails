import React, { useEffect } from 'react'
import HelpItem from '../components/helpItem/HelpItem'

const Help = () => {

  useEffect(() => {
    window.scrollTo(0, 0);
  }, []);

  return (
    <div className='Main'>
      <div className='conteiner'>
        <HelpItem />
      </div>
    </div>
  )
}

export default Help