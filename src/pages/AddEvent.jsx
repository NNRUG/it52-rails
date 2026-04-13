import React, { useEffect } from 'react'
import AddEventItem from '../components/addEventItem/AddEventItem'

const AddEvent = () => {

    useEffect(() => {
        window.scrollTo(0, 0);
    }, []);

    return (
        <div className='Main'>
            <div className='conteiner'>
                <AddEventItem />
            </div>
        </div>
    )
}

export default AddEvent