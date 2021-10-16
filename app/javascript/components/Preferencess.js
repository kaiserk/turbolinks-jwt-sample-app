import React, {useCallback, useState} from 'react';
import {Banner, Card, FormLayout, Layout, TextField} from '@shopify/polaris';
import {gql, useQuery, useMutation} from "@apollo/client";
import EasyEdit from "react-easy-edit";

const PREFERENCES_QUERY = gql`
    query GetPreferences($shopId: Int!) {
        preferences(shopId: $shopId) {
          id
          currency
          labelText
          collectionLabelText
        }
    }
`;

const UPDATE_CURRENCY = gql`
    mutation UpdateCurrency($id: ID!, $currency: String, $labelText: String, $collectionLabelText: String) {
    updateCurrency(input: { id: $id, currency: $currency, labelText: $labelText, collectionLabelText: $collectionLabelText }) {
          errors
        }
    }
`;

const Preferencess = () => {
    const cancel = () => {};

    // Refetches two queries after mutation completes
    const [updateCurrency, ret] = useMutation(UPDATE_CURRENCY, {
        refetchQueries: [
            PREFERENCES_QUERY, // DocumentNode object parsed with gql
            'GetPreferences' // Query name
        ],
    });

    const { loading, error, data } = useQuery(PREFERENCES_QUERY, {
        variables: { shopId: 0 }
    });

    const [value, setValue] = useState('Jaded Pixel');

    const save = (id, value) => {

        if(value.currency) {
            updateCurrency({ variables: { id: id, currency: value.currency }});
        } else if (value.labelText) {
            updateCurrency({ variables: { id: id, labelText: value.labelText }});
        } else {
            updateCurrency({ variables: { id: id, collectionLabelText: value.collectionLabelText }});
        }

        if(ret.loading) {
            console.log('loading...')
        } else if (ret.error) {
            console.log('Mutation error: ' + ret.error)
        } else {
            console.log('Nothing to show anymore: ' + ret.data);
        }

        // if(data && data.products.length > 0) {
        //     initialData(data.products, id, value)
        // }
    };

    if (loading) {
        return (
            <div>Loading</div>
        );
    } else if (error) {
        return (
            <div>Something went wrong! {error}</div>
        );
    } else {
        console.log(data);
        console.log("I'm here!");
        const preferences = data.preferences[0];
        return (
            <Layout>
            {/*<Layout.Section>*/}
            {/*<Banner title="Order archived" onDismiss={() => {}}>*/}
            {/*    <p>This order was archived on March 7, 2017 at 3:12pm EDT.</p>*/}
            {/*</Banner>*/}
            {/*</Layout.Section>*/}
            <Layout.AnnotatedSection
            id="settings"
            title="Settings"
            description="Unit Pricer will use this information to show products unit price"
            >
            <Card sectioned>
                <FormLayout>
                    <Card title="Enter your currency:" sectioned>
                        <EasyEdit
                            type="text"
                            value={preferences.currency}
                            onSave={(value) => { save(preferences.id, { currency: value }) }}
                            onCancel={cancel}
                            saveButtonLabel="Save"
                            cancelButtonLabel="Cancel"
                            attributes={{ name: "awesome-input", id: 1}}
                            instructions="Curreny Symbol: (e.g. $, £, ₽, zł, ¥, etc. )"
                        />
                    </Card>

                    <Card title="Product Label (beside price on product details page):" sectioned>
                        <EasyEdit
                            type="text"
                            value={preferences.labelText}
                            onSave={(value) => { save(preferences.id, { labelText: value }) }}
                            onCancel={cancel}
                            saveButtonLabel="Save"
                            cancelButtonLabel="Cancel"
                            attributes={{ name: "awesome-input", id: 1}}
                        />
                    </Card>

                    <Card title="Collection Label for multiple variant products (instead of price on Collections grid):" sectioned>
                        <EasyEdit
                            type="text"
                            value={preferences.collectionLabelText}
                            onSave={(value) => { save(preferences.id, { collectionLabelText: value }) }}
                            onCancel={cancel}
                            saveButtonLabel="Save"
                            cancelButtonLabel="Cancel"
                            attributes={{ name: "awesome-input", id: 1}}
                        />
                    </Card>
                </FormLayout>
            </Card>
            </Layout.AnnotatedSection>
            </Layout>
        );
    }
};

export default Preferencess;




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