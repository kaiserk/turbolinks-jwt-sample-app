import { gql, useQuery, useMutation } from '@apollo/client';
import React from 'react';

const PRODUCTS_QUERY = gql`
  query GetProducts {
    products {
      id
      title
    }
  }
`;

export default function TestData() {
    let input;

    const { loading, error, data } = useQuery(PRODUCTS_QUERY);

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
                {data.products.map(product => (
                    <div key={product.id}>
                        <b>{product .title}</b>
                    </div>
                ))}
            </div>
        );
    }
}