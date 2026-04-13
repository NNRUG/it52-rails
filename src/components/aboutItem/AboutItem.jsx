import React from 'react'
import './aboutItem.css'
import { Link } from 'react-router-dom'

import android from '../../assetc/android.png'
import ios from '../../assetc/ios.svg'

const AboutItem = () => {
    return (
        <div className='aboutItem'>
            <h1>Нижегородское IT-сообщество</h1>
            <p>it52 — это некоммерческое сообщество энтузиастов, которые думают, что могут сделать жизнь нижегородского айтишника немного лучше. Мы помогаем организовывать профильные мероприятия, ведём афишу событий, курируем несколько чатиков в телеграме и групп в соцсетях, и кажется, что у нас получается.</p>
            <Link to='/manifest' className='aboutItem__a'>Пожалуйста ознакомьтесь с нашим манифестом</Link>
            <h2>Я тоже хочу!</h2>
            <p>Пожалуйста. Мы всегда рады хорошим людям. Помочь вы можете разными способами.</p>
            <p>
                <strong>— Я нашёл ошибку</strong>
                <br />
                <em>— Отлично! Напишите нам об этом, </em>
                <em>
                    <a href='https://github.com/NNRUG/it52-rails/issues/new' className='aboutItem__a'>оставив багрепорт</a>
                    .
                </em>
            </p>
            <hr />
            <p>
                <strong>— Я придумал новую фичу</strong>
                <br />
                <em>— Ещё лучше! </em>
                <em>
                    <a href='https://github.com/NNRUG/it52-rails/issues/new' className='aboutItem__a'>Опишите</a>
                    , чего вам не хватает, или что можно реализовать лучше. Обсудим и сделаем.
                </em>
            </p>
            <hr />
            <p>
                <strong>— Я гуру (начинающий/хочу изучить) Ruby on Rails или что-нибудь во фронтенде, и у меня есть немного времени.</strong>
                <br />
                <em>— Круто! Присылайте pull request. Только про тесты не забудьте.</em>
            </p>
            <hr />
            <p>
                <strong>— Я не умею программировать, но умею в дизайн.</strong>
                <br />
                <em>— Хороший дизайнер всегда пригодится. Мы будем безмерно благодарны за переработку UI страниц. Если найдёте время причесать дизайн, то совсем хорошо.</em>
            </p>
            <hr />
            <p>
                <strong>— Я хочу помочь материально.</strong>
                <br />
                <em>— Да, мы некоммерческое сообщество и </em>
                <em>
                    <Link to='/help' className='aboutItem__a'>принимаем пожертвования</Link>
                    . Спасибо.
                </em>
            </p>
            <hr />
            <h2 style={{ marginTop: 0 }}>Наши отважные разработчики</h2>
            <p>Коллеги из Ростова с <a href='https://github.com/IT61/it61-rails' className='aboutItem__a'>it61-rails</a>, ставшего базой для нашего ресурса.</p>
            <br />
            <p><a href='https://github.com/NNRUG/it52-rails/graphs/contributors' className='aboutItem__a'>И ещё есть</a>.</p>
            <h2>Отдельный респект</h2>
            <p>@defolter за <a href='https://play.google.com/store/apps/details?id=io.github.defolters.it52' className='aboutItem__a'>приложение под android</a>.</p>
            <p><a className='install' href='https://play.google.com/store/apps/details?id=io.github.defolters.it52&utm_source=it52' style={{ backgroundImage: `url(${android})`, width: 158, backgroundSize: 'cover' }}> </a></p>
            <p>@overmind за <a href='https://apps.apple.com/ru/app/it52/id1239876838' className='aboutItem__a'>приложение под iOS</a>.</p>
            <p><a className='install' href='https://apps.apple.com/ru/app/it52/id1239876838' style={{ backgroundImage: `url(${ios})`, width: 158, backgroundSize: 'contain' }}> </a></p>
        </div>
    )
}

export default AboutItem