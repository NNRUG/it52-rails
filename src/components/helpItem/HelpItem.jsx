import React from "react";
import './helpItem.css'
import donate from '../../assetc/btn_donate.gif'
import Table from './table/Table';

const HelpItem = () => {

    return (
        <div className='help__item'>
            <h1>На it52</h1>
            <p>Мы некоммерческое сообщество, <strike>а сил для игр и роста требуестя ой как много</strike> и тратим на подготовку мероприятий своё личное время. Если вам понравилась какая-то из наших конференций, митапов или других тус, или вы просто хороший человек (и программист), то вы можете выразить материальную благодарность в этой формочке.</p>
            <hr />
            <p className='paypal'><strong>Предпочитаете PayPal или Patreon?</strong></p>
            <p className='donate'>
                <a className='donate__img' href='https://www.paypal.com/donate?token=TdgFZYERX8B-sGvrw0FCQ9hQLXAGKsIv49Z1pTkMexwD0hE_G3be_329IUZ3pYURW-1oG6BCDg8I9lEK'>
                    <img src={donate} alt="donate" />
                </a>
                <a className="help__item__a" href='/'>Поддержать на Патреоне</a>
            </p>
            <hr />
            <p><strong>Или криптовалюты?</strong></p>
            <ul>
                <li>BTC: 1Gtxx7iyjZgKcberm7nsVQTAQxqPauPdQ9</li>
                <li>ETH: 0xb4E4eB51Ddf445Db4F625fDa925951bd1A1b3fBf</li>
                <li>LTC: LhwVEdvvVRNxLssjBSj7jYLpg7xsn4gY5L</li>
                <li>DASH: XefxK98D86iUAtoU1GexQ5FmFqHjJEq9qh</li>
            </ul>
            <hr />
            <h4 className='where__money'>Куда пойдут деньги?</h4>
            <Table />
            <a className="help__item__a" href='/'>Отчёт по уже собранным средствам</a>
        </div >
    )
}

export default HelpItem