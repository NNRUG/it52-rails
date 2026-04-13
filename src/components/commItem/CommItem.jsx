import React from 'react'
import './commItem.css'
import importantThihg from '../../assetc/commItemData/importantThihg'
import jobOffers from '../../assetc/commItemData/jobOffers'
import programmingLanguages from '../../assetc/commItemData/programmingLanguages'
import byInterests from '../../assetc/commItemData/byInterests'

const CommItem = () => {
    return (
        <div className='commItem'>
            <h1>IT-сообщества Нижнего Новгорода</h1>
            <h3>Всё о самом главном</h3>
            <ul className='commItem__content'>
                {importantThihg && importantThihg.map((item, i) => {
                    return <li className='content__row' key={i}><a className='content__rowLink' href={item.link}>{item.title}</a>{item.content}</li>
                })}
            </ul>
            <h3>Предложения и поиск работы</h3>
            <ul className='commItem__content'>
                {jobOffers && jobOffers.map((item, i) => {
                    return <li className='content__row' key={i}><a className='content__rowLink' href={item.link}>{item.title}</a>{item.content}</li>
                })}
            </ul>
            <h3>По языкам программирования или платформам</h3>
            <ul className='commItem__content'>
                {programmingLanguages && programmingLanguages.map((item, i) => {
                    return <li className='content__row' key={i}><a className='content__rowLink' href={item.link}>{item.title}</a>{item.content}</li>
                })}
            </ul>
            <h3>По интересам</h3>
            <ul className='commItem__content'>
                {byInterests && byInterests.map((item, i) => {
                    return <li className='content__row' key={i}><a className='content__rowLink' href={item.link}>{item.title}</a>{item.content}</li>
                })}
            </ul>
        </div>
    )
}

export default CommItem