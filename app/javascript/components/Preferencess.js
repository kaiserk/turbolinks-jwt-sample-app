import React, {useCallback, useState} from 'react';
import {Banner, Card, FormLayout, Layout, TextField} from '@shopify/polaris';
import {gql, useQuery, useMutation} from "@apollo/client";
import EasyEdit from "react-easy-edit";

const PREFERENCES_QUERY = gql`
    query GetPreferences($shopId: Int!) {
        preferences(shopId: $shopId) {
          currency
          labelText
          collectionLabelText
        }
    }
`;

const UPDATE_PREFERENCE = gql`
    mutation UpdateVariant($id: ID, $units: Float) {
        updateVariant(input: { id: $id, units: $units }) {
          errors
        }
      }
`;

const Preferencess = () => {
    const cancel = () => {};

    const { loading, error, data } = useQuery(PREFERENCES_QUERY, {
        variables: { shopId: 0 }
    });

    const [value, setValue] = useState('Jaded Pixel');

    const handleChange = useCallback((newValue) => setValue(newValue), []);
    const handleChange2 = useCallback((newValue) => setValue(newValue), []);
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
            <Layout.Section>
            <Banner title="Order archived" onDismiss={() => {}}>
                <p>This order was archived on March 7, 2017 at 3:12pm EDT.</p>
            </Banner>
            </Layout.Section>
            <Layout.AnnotatedSection
            id="storeDetails"
            title="Store details"
            description="Shopify and your customers will use this information to contact you."
            >
            <Card sectioned>
                <FormLayout>
                    <TextField label="Currency" value={preferences.currency} onChange={() => {}} autoComplete="off" />
                    <TextField label="Label" value={preferences.labelText} onChange={() => {}} autoComplete="off" />
                    <TextField label="Collection label" value={preferences.collectionLabelText} onChange={() => {}} autoComplete="off" />
                    <EasyEdit
                        type="text"
                        value={preferences.collectionLabelText}
                        // onSave={(value) => { save(variant.id, value) }}
                        onCancel={cancel}
                        saveButtonLabel="Save"
                        cancelButtonLabel="Cancel"
                        attributes={{ name: "awesome-input", id: 1}}
                        // instructions="Instruction!"
                    />,
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