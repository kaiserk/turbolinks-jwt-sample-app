import React, {useCallback, useState} from 'react';
import {Banner, Card, FormLayout, Layout, TextField} from '@shopify/polaris';
import {gql, useQuery, useMutation} from "@apollo/client";
import EasyEdit from "react-easy-edit";

// const PREFERENCES_QUERY = gql`
//     query GetPreferences($shopId: Int!) {
//         preferences(shopId: $shopId) {
//           id
//           currency
//           labelText
//           collectionLabelText
//         }
//     }
// `;
//
// const UPDATE_CURRENCY = gql`
//     mutation UpdateCurrency($id: ID!, $currency: String, $labelText: String, $collectionLabelText: String) {
//     updateCurrency(input: { id: $id, currency: $currency, labelText: $labelText, collectionLabelText: $collectionLabelText }) {
//           errors
//         }
//     }
// `;

const Help = () => {
    return (
        <div class="show-collection-page">
            <div>
                <h1>How to Remove Unit Prices from Shopify Collections Pages</h1>
                <p>Here is a quick guide to setup this feature.</p>
            </div>
            <div>
                <h2>1. Open your theme's code</h2>
                <p>From your admin dashboard, in the menu on the left side, click Online Store then from the 'Actions' dropdown select the 'Edit code' option.</p>
                {/*<%= image_tag "step1.png" %>*/}
                <br/>
            </div>
            <div>
                <h2>2. Open the file called "product-card-grid.liquid" in "Snippets" folder on the left side.</h2>
                {/*<p><strong>Note:</strong> if you don't see the "product-card-grid.liquid" file, or the {{ product.price | money }} code, don't worry! just email us at <a class="blue-link" href="mailto:info@appsbysimple.com">info@appsbysimple.com</a> and we'll take care of it for you.</p>*/}
                {/*<%= image_tag "step2.png" %>*/}
                <br/>
            </div>
            <div>
                <h2>3. Remove the snippet of code</h2>
                <p>
                    <span>On the right side of the screen, find and remove this line of code:</span><br/>
                    <br/>
                        {/*<code><%= '<div class="insert-unit-pricing" data-product="{{ product.id }}"></div>' %></code><br>*/}
                <br/>
                </p>
                {/*<%= image_tag "step3_2.png" %>*/}
                <br/>
            </div>
        </div>
        );


}

export default Help;




// <FormLayout>
//     <FormLayout.Group condensed>
//
//         <TextField
//             label="Currency"
//             value="XYZ"
//             onChange={handleChange}
//             autoComplete="off"
//         />
//         <TextField
//             label="Label Text"
//             value="XYZ"
//             onChange={handleChange2}
//             autoComplete="off"
//         />
//         <TextField
//             label="Currency"
//             value="XYZ"
//             onChange={handleChange3}
//             autoComplete="off"
//         />
//     </FormLayout.Group>
// </FormLayout>