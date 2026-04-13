import React from 'react'
import './profileImage.css'
import Avatar from '@mui/material/Avatar';


const ProfileImage = (props) => {

    return (
        <Avatar sx={{ bgcolor: props.color, width: props.size, height: props.size, fontSize: props.fontSize }}
            variant={`${props.forma}`}
            src={props.avatar ?
                `file:///${encodeURI(`C:/Users/Даниил/Desktop/it52/src/assetc/${props.avatar}`)}` : ''}>
            {props.name ? props.name[0] : '?'}
        </Avatar>
    )
}

export default ProfileImage
