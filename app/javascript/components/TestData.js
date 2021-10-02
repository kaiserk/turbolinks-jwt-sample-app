import { gql, useQuery, useMutation } from '@apollo/client';
import React, {useRef, useState} from 'react';
import EasyEdit from 'react-easy-edit';
import Editable from "./Editable";


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
        return (
            <div>
                <table className="">
                    <thead>
                    <tr>
                        <th>
                            Title
                        </th>
                        <th>
                            Variant Name
                        </th>
                        <th>
                            Price
                        </th>
                        <th>
                            Units
                        </th>
                        <th>
                            Unit Price
                        </th>
                    </tr>
                    </thead>
                    {data.products.map(product => (
                    <tbody>
                        {product.variants.map(variant => (
                            <tr>
                                <td>
                                    <label className="e-float-text e-label-top">{product.title}</label>
                                </td>
                                <td>
                                    <label className="e-float-text e-label-top">{variant.title}</label>
                                </td>
                                <td>
                                    <label className="e-float-text e-label-top">{variant.variantPrice}</label>
                                </td>
                                <td>
                                    <EasyEdit
                                    type="text"
                                    value={variant.units}
                                    onSave={(value) => { save(variant.id, value) }}
                                    onCancel={cancel}
                                    saveButtonLabel="Save"
                                    cancelButtonLabel="Cancel"
                                    attributes={{ name: "awesome-input", id: 1}}
                                    // instructions="Instruction!"
                                    />
                                </td>
                                <td>
                                    <label className="e-float-text e-label-top">{variant.unitPrice}</label>
                                </td>
                            </tr>
                        ))}
                    </tbody>
                    ))}
                </table>
            </div>
        );
    }
}