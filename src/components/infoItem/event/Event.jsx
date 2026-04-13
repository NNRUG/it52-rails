import React, { useContext } from 'react';
import './Event.css'
import Item from '../item/Item'
import { Context } from '../../../context/Context'


const Event = () => {

    const { chooseEvent } = useContext(Context);

    return (
        <div className='event'>
            {chooseEvent() && chooseEvent().map((item, i) => {
                return <Item key={i}
                    id={item.id}
                    title={item.title}
                    datetimeassetc={item.datetimeassetc}
                    adress={item.adress}
                    name={item.name}
                    image={item.link_img}
                    organizer={item.organizer}
                    tags={item.tags}
                    contentt={item.contentt}
                    participants={item.participants}
                    linkreg={item.linkreg} />
            })}
        </div>
    )
}

export default Event;