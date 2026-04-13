import React from 'react'
import './profileItem.css'

import ContentLoader from 'react-content-loader'


const ProfileItemSceleton = () => {


    return (
        <>
            <div className='image__block'>
                <div style={{ position: 'relative' }}>
                    <ContentLoader
                        speed={2}
                        width={230}
                        height={230}
                        viewBox="0 0 230 230"
                        backgroundColor="#e6e6e6"
                        foregroundColor="#ecebeb"
                    >
                        <circle cx="115" cy="115" r="115" />
                    </ContentLoader>
                </div>
                <ContentLoader
                    speed={2}
                    width={150}
                    height={40}
                    viewBox="0 0 150 40"
                    backgroundColor="#e6e6e6"
                    foregroundColor="#ecebeb"
                >
                    <rect x="0" y="0" rx="10" ry="10" width="150" height="40" />
                </ContentLoader>
            </div>
            <div className='information__block'>
                <div className="profile-tabs">
                    <ContentLoader
                        speed={2}
                        width={560}
                        height={22}
                        viewBox="0 0 560 22"
                        backgroundColor="#e6e6e6"
                        foregroundColor="#ecebeb"
                    >
                        <rect x="0" y="0" rx="6" ry="6" width="560" height="22" />
                    </ContentLoader>

                </div>
                <div className='form'>
                    <div className="input__block">
                        <ContentLoader
                            speed={2}
                            width={702}
                            height={56}
                            viewBox="0 0 702 56"
                            backgroundColor="#e6e6e6"
                            foregroundColor="#ecebeb"
                        >
                            <rect x="0" y="0" rx="5" ry="5" width="702" height="56" />
                        </ContentLoader>
                        <ContentLoader
                            speed={2}
                            width={702}
                            height={56}
                            viewBox="0 0 702 56"
                            backgroundColor="#e6e6e6"
                            foregroundColor="#ecebeb"
                        >
                            <rect x="0" y="0" rx="5" ry="5" width="702" height="56" />
                        </ContentLoader>
                        <ContentLoader
                            speed={2}
                            width={702}
                            height={56}
                            viewBox="0 0 702 56"
                            backgroundColor="#e6e6e6"
                            foregroundColor="#ecebeb"
                        >
                            <rect x="0" y="0" rx="5" ry="5" width="702" height="56" />
                        </ContentLoader>
                        <ContentLoader
                            speed={2}
                            width={702}
                            height={56}
                            viewBox="0 0 702 56"
                            backgroundColor="#e6e6e6"
                            foregroundColor="#ecebeb"
                        >
                            <rect x="0" y="0" rx="5" ry="5" width="702" height="56" />
                        </ContentLoader>
                        <ContentLoader
                            speed={2}
                            width={702}
                            height={56}
                            viewBox="0 0 702 56"
                            backgroundColor="#e6e6e6"
                            foregroundColor="#ecebeb"
                        >
                            <rect x="0" y="0" rx="5" ry="5" width="702" height="56" />
                        </ContentLoader>
                        <ContentLoader
                            speed={2}
                            width={702}
                            height={240}
                            viewBox="0 0 702 240"
                            backgroundColor="#e6e6e6"
                            foregroundColor="#ecebeb"
                        >
                            <rect x="0" y="24" rx="5" ry="5" width="702" height="240" />
                        </ContentLoader>
                    </div>
                    <ContentLoader
                        speed={2}
                        width={220}
                        height={52}
                        viewBox="0 0 220 52"
                        backgroundColor="#e6e6e6"
                        foregroundColor="#ecebeb"
                    >
                        <rect x="0" y="15" rx="5" ry="5" width="220" height="37" />
                    </ContentLoader>
                </div>
            </div>
        </>
    )
}

export default ProfileItemSceleton