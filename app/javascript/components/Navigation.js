import React, {useState, useRef} from 'react';

import {Navigation} from '@shopify/polaris';

export default function Nav() {
    return (
        <Navigation location="/">
            <Navigation.Section
                items={[
                    {
                        url: '/productslist',
                        label: 'Setup Pricing',
                        // icon: HomeMajor,
                    },
                    {
                        url: '/preferencess',
                        label: 'Preferences',
                        // icon: OrdersMajor,
                        // badge: '15',
                    },
                    {
                        url: '/help-collection-page',
                        label: 'Collection Page Setup',
                    },
                    {
                        url: '/help-manual-uninstall',
                        label: 'Manual Uninstall',
                    },{
                        url: '/contactus',
                        label: 'Contact Us',
                    },
                ]}
            />
        </Navigation>
    );
}