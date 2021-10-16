import React, {useState, useRef} from 'react';

import {Navigation} from '@shopify/polaris';

export default function Nav() {
    return (
        <Navigation location="/productslist">
            <Navigation.Section
                items={[
                    {
                        url: '/productslist',
                        label: 'Products',
                        // icon: HomeMajor,
                    },
                    {
                        url: '/preferencess',
                        label: 'Preferences',
                        // icon: OrdersMajor,
                        // badge: '15',
                    },
                    {
                        url: '/help',
                        label: 'Help',
                        selected: true,
                        subNavigationItems: [
                            {
                                url: '/admin/products',
                                disabled: false,
                                selected: true,
                                label: 'All products',
                            },
                            {
                                url: '/admin/products/inventory',
                                disabled: false,
                                label: 'Inventory',
                            },
                        ],
                    },
                ]}
            />
        </Navigation>
    );
}