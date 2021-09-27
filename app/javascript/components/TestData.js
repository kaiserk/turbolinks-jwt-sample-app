import { gql, useQuery, useMutation } from '@apollo/client';
import React, {useRef, useState} from 'react';
import EasyEdit from 'react-easy-edit';
import Editable from "./Editable";


const PRODUCTS_QUERY = gql`
  query GetProducts {
    products {
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

    const { loading, error, data } = useQuery(PRODUCTS_QUERY);

    const inputRef = useRef();
    const [task, setTask] = useState("");

    const [updateProduct, { }] = useMutation(UPDATE_QUERY);

    const save = (value) => {
        const fValue = parseFloat(value);
        updateProduct({ variables: { id: 1, units: fValue }});
    };

    const cancel = () => {alert("Cancelled")};

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
                                    <input readOnly type="text" value={product.title}/>
                                </td>
                                <td>
                                    <input readOnly type="text" value={product.productPrice}/>
                                </td>
                                <td>
                                    <EasyEdit
                                        type="text"
                                        value={product.units}
                                        onSave={save}
                                        onCancel={cancel}
                                        saveButtonLabel="Save Me"
                                        cancelButtonLabel="Cancel Me"
                                        attributes={{ name: "awesome-input", id: 1}}
                                        instructions="Star this repo!"
                                    />
                                </td>
                                <td>
                                    <input readOnly type="text" value={product.unitPrice}/>
                                </td>
                            </tr>
                            </tbody>
                ))}
                </table>
            </div>
        );
    }
}