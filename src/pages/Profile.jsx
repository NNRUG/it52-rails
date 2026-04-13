import React, { useContext, useEffect } from 'react'
import ProfileItem from '../components/profileItem/ProfileItem'
import ProfileItemSceleton from '../components/profileItem/ProfileItemSceleton'
import { Context } from '../context/Context'


const Profile = () => {

    const { loadinguser } = useContext(Context)

    useEffect(() => {
        window.scrollTo(0, 0);
    }, []);


    return (
        <div className='Main'>
            <div className='conteiner__eventPage'>
                <div className='block__conteiner'>
                    {loadinguser ?
                        (<ProfileItem />)
                        :
                        (<ProfileItemSceleton />)}
                </div>
            </div>
        </div>
    )
}

export default Profile