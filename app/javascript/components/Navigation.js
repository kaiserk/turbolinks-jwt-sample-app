import React, {useState, useRef} from 'react';

import {Navigation} from '@shopify/polaris';

export default function Nav() {
    return (
        <Navigation location="/">
            <Navigation.Section
                items={[
                    {
                        url: '/productslist',
                        label: 'Products',
                        // icon: HomeMajor,
                    },
                    {
                        url: '/preferencess',
                        label: 'Preferencess',
                        // icon: OrdersMajor,
                        // badge: '15',
                    },
                    {
                        url: 'mailto:info@appsbysimple.com',
                        label: 'Help',
                        // icon: ProductsMajor,
                    },
                ]}
            />
        </Navigation>
    );
}