import React, { useEffect } from 'react'
import CommItem from '../components/commItem/CommItem'

const Communities = () => {

  useEffect(() => {
    window.scrollTo(0, 0);
  }, []);

  return (
    <div className='Main'>
      <div className='conteiner'>
        <CommItem />
      </div>
    </div>
  )
}

export default Communities