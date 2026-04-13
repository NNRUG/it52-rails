import React, { useEffect } from 'react'
import AboutItem from '../../components/aboutItem/AboutItem'

const About = () => {

  useEffect(() => {
    window.scrollTo(0, 0);
  }, []);

  return (
    <div className='Main'>
      <div className='conteiner'>
        <AboutItem />
      </div>
    </div>
  )
}

export default About