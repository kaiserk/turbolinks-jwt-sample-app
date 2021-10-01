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
    }
  }
`;

const UPDATE_QUERY = gql`
    mutation UpdateProduct($id: ID!, $units: Float!) {
        updateProduct(input: { id: $id, units: $units }) {
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

    const [updateProduct, { }] = useMutation(UPDATE_QUERY);

    const save = (id, value) => {
        const fValue = parseFloat(value);
        updateProduct({ variables: { id: id, units: fValue }});
    };

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
                            <tr>
                                <td>
                                    <label className="e-float-text e-label-top">{product.title}</label>
                                </td>
                                <td>
                                    <label className="e-float-text e-label-top">{product.productPrice}</label>
                                </td>
                                <td>
                                    <EasyEdit
                                        type="text"
                                        value={product.units}
                                        onSave={(value) => { save(product.id, value) }}
                                        onCancel={cancel}
                                        saveButtonLabel="Save"
                                        cancelButtonLabel="Cancel"
                                        attributes={{ name: "awesome-input", id: 1}}
                                        // instructions="Instruction!"
                                    />
                                </td>
                                <td>
                                    <label className="e-float-text e-label-top">{product.unitPrice}</label>
                                </td>
                            </tr>
                            </tbody>
                ))}
                </table>
            </div>
        );
    }
}