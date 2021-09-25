// Editable.js
import React, { useState, useEffect } from "react";

import { gql, useQuery, useMutation } from '@apollo/client';

const UPDATE_QUERY = gql`
    mutation UpdateProduct($id: ID!, $title: String!) {
        updateProduct(input: { id: $id, title: $title }) {
          errors
        }
  }
`;


// Component accept text, placeholder values and also pass what type of Input - input, textarea so that we can use it for styling accordingly
const Editable = ({
                      childRef,
                      text,
                      type,
                      placeholder,
                      children,
                      ...props
                  }) => {
    // Manage the state whether to show the label or the input box. By default, label will be shown.
    // Exercise: It can be made dynamic by accepting initial state as props outside the component
    const [isEditing, setEditing] = useState(false)

    /*
        using use effect, when isEditing state is changing, check whether it is set to true, if true, then focus on the reference element
    */
    useEffect(() => {
        if (childRef && childRef.current && isEditing === true) {
            childRef.current.focus();
        }
    }, [isEditing, childRef]);

    const [updateProduct, { data, loading, error }] = useMutation(UPDATE_QUERY);

    // Event handler while pressing any key while editing
    const handleKeyDown = (event, type) => {
        // Handle when key is pressed
        // updateProduct({ variables: { id: 1, title: text } });
    };

    /*
    - It will display a label is `isEditing` is false
    - It will display the children (input or textarea) if `isEditing` is true
    - when input `onBlur`, we will set the default non edit mode
    Note: For simplicity purpose, I removed all the classnames, you can check the repo for CSS styles
    */

    return (
        <section {...props}>
            {isEditing ? (
                <div
                    onBlur={() => {
                            setEditing(false);
                            updateProduct({ variables: { id: 1, title: text }});
                        }
                    }
                    onKeyDown={e => handleKeyDown(e, type)}
                >
                    {children}
                </div>
            ) : (
                <div
                    onClick={() => setEditing(true)}
                >
                  <span>
                    {text || placeholder || "Editable content"}
                  </span>
                </div>
            )}
        </section>
        );
};

export default Editable;
