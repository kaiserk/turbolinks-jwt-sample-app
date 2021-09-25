import { gql, useQuery, useMutation } from '@apollo/client';
import React, {useRef, useState} from 'react';
import Editable from "./Editable";


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

    const inputRef = useRef();
    const [task, setTask] = useState("");

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
                    <Editable
                        text={task}
                        placeholder={product.title}
                        childRef={inputRef}
                        type="input"
                    >
                        <input
                            ref={inputRef}
                            type="text"
                            name="task"
                            placeholder={product.title}
                            value={task}
                            onChange={e => setTask(e.target.value)}
                        />
                    </Editable>
                ))}
            </div>
        );
    }
}