import { gql, useQuery, useMutation } from '@apollo/client';

import React from 'react';

const TEST_QUERY = gql`query { testField }`;

// const UPDATE_QUERY = gql`
//     mutation UpdateProduct($id: ID!, $title: String!) {
//         updateProduct(input: { id: $id, title: $title }) {
//           product {
//             title
//           }
//           errors
//         }
//   }
// `;

const UPDATE_QUERY = gql`
    mutation UpdateProduct($id: ID!, $title: String!) {
        updateProduct(input: { id: $id, title: $title }) {
          errors
        }
  }
`;

export default function TestData() {
    let input;
    const [updateProduct, { data, loading, error }] = useMutation(UPDATE_QUERY);

    if (loading) {
        return (
            <div>Loading</div>
        );
    } else if (error) {
        return (
            <div>Something went wrong!</div>
        );
    } else {
        return (
            <div>
                <form
                    onSubmit={e => {
                        e.preventDefault();
                        updateProduct({ variables: { id: 1, title: input.value } });
                        input.value = '';
                    }}
                >
                    <input
                        ref={node => {
                            input = node;
                        }}
                    />
                    <button type="submit">Update Title</button>
                </form>
            </div>
        );
    }
}