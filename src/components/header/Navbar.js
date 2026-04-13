import React, { useContext } from 'react';
import { NavLink } from 'react-router-dom'
import { Context } from '../../context/Context'

const Navbar = ({ navClass, linkClassName }) => (
  <NavComponent navClass={navClass}
    linkClassName={linkClassName}
  />
);

export const NavComponent = ({ navClass, linkClassName }) => {

  const { ColorHeader, color } = useContext(Context);
  const Color = (event) => {
    ColorHeader(event.target.innerText)
  };

  return (<nav className={navClass}>
    <NavLink className={linkClassName} to='/' onClick={Color} style={{ color: color === "СОБЫТИЯ" ? '#c1c1c1' : '' }}>События</NavLink>
    <NavLink className={linkClassName} to='/communities' onClick={Color} style={{ color: color === "СООБЩЕСТВА" ? '#c1c1c1' : '' }}>Сообщества</NavLink>
    <NavLink className={linkClassName} to='/startups' onClick={Color} style={{ color: color === "СТАРТАПЫ" ? '#c1c1c1' : '' }}>Стартапы</NavLink>
    <NavLink className={linkClassName} to='/about' onClick={Color} style={{ color: color === "О НАС" ? '#c1c1c1' : '' }}>О нас</NavLink>
    <NavLink className={linkClassName} to='/help' onClick={Color} style={{ color: color === "ПОМОЧЬ!" ? '#c1c1c1' : '' }}>Помочь!</NavLink>
  </nav>)
}

export default Navbar;