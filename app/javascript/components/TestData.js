import { gql, useQuery, useMutation } from '@apollo/client';
import React, {useRef, useState} from 'react';
import EasyEdit from 'react-easy-edit';
import Editable from "./Editable";
import {Card, DataTable, Link, Page} from '@shopify/polaris';



const PRODUCTS_QUERY = gql`
  query GetProducts($shopId: Int!) {
    products(shopId: $shopId) {
      id
      title
      shopifyId
      productPrice
      unitPrice
      units
      variants {
        id
        title
        variantPrice
        units
        unitPrice
      }
    }
  }
`;

const UPDATE_QUERY = gql`
    mutation UpdateVariant($id: ID, $units: Float) {
        updateVariant(input: { id: $id, units: $units }) {
          errors
        }
  }
`;

export default function TestData() {
    let input;

    const { loading, error, data } = useQuery(PRODUCTS_QUERY, {
        variables: { shopId: 0 }
    });

    const inputRef = useRef();
    const [task, setTask] = useState("");

    const [updateVariant, { loading2, error2, data2 }] = useMutation(UPDATE_QUERY);

    const save = (id, value) => {
        const fValue = parseFloat(value);
        console.log(id);
        updateVariant({ variables: { id: id, units: fValue }});

        if(loading2) {
            console.log('loading')
        } else if (error2) {
            console.log('Mutation error: ' + error)
        } else {
            console.log('Nothing show anymore: ' + data);
        }
    };

    // const getProductPrice = (productId) => {
    //
    //     return { data } = useQuery(VARIANTS_QUERY, {
    //         variables: { productId: productId }
    //     });
    //
    //     // if (loading) {
    //     //     return (
    //     //         <div>Loading</div>
    //     //     );
    //     // } else if (error) {
    //     //     return (
    //     //         <div>Something went wrong! {error}</div>
    //     //     );
    //     // } else {
    //     // return data.variantPrice[0];
    //     // }
    // };

    const cancel = () => {};


    if (loading) {
        return (
            <div>Loading</div>
        );
    } else if (error) {
        return (
            <div>Something went wrong! {error}</div>
        );
    } else {
        const rows_array = []
        const rows = data.products.map(product => (
            product.variants.map(variant => (
                rows_array.push([
                    product.title,
                    variant.title,
                    variant.variantPrice,
                    <EasyEdit
                        type="number"
                        value={variant.units}
                        onSave={(value) => { save(variant.id, value) }}
                        onCancel={cancel}
                        saveButtonLabel="Save"
                        cancelButtonLabel="Cancel"
                        attributes={{ name: "awesome-input", id: 1}}
                        // instructions="Instruction!"
                    />,
                    variant.unitPrice
                ])
            ))
        ));

        return (
            <Page title="Products & Variants">
                <Card>
                    <DataTable
                        columnContentTypes={[
                        'text',
                        'text',
                        'numeric',
                        'numeric',
                        'numeric',
                    ]}
                    headings={['Product Title', 'Variant Name', 'Price', 'Units', 'Unit Price']}
                    rows={rows_array}
                    />
                </Card>
            </Page>
        );
    }
}