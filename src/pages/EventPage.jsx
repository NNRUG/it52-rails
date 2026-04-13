import React, { useContext, useEffect } from 'react'
import { EventPageItem } from '../components/eventPageItem/EventPageItem'
import { useParams } from 'react-router-dom'
import { Context } from '../context/Context'

export const EventPage = () => {

    useEffect(() => {
        window.scrollTo(0, 0);
    }, []);

    const { baze, loadinevents } = useContext(Context);

    const { eventId } = useParams();
    let event = baze.find((e) => e.id === Number(eventId))

    return (
        <div className='Main'>
            <div className='conteiner__eventPage'>
                {loadinevents ?
                    <EventPageItem event={event} />
                    :
                    ''}
            </div>
        </div>
    )
}
