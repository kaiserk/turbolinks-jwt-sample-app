import {
    ApolloClient,
    ApolloProvider,
    HttpLink,
    InMemoryCache,
} from '@apollo/client';

import {AppProvider, EmptyState, Page} from '@shopify/polaris';
import {authenticatedFetch} from '@shopify/app-bridge-utils';
import enTranslations from '@shopify/polaris/locales/en.json';
import React, {useState, useRef} from 'react';
import TestData from "./TestData";
import Editable from "./Editable";

const client = new ApolloClient({

    link: new HttpLink({
        credentials: 'same-origin',
        fetch: authenticatedFetch(window.app), // created in shopify_app.js
        uri: '/graphql'
    }),

    cache: new InMemoryCache()

});

function App() {
    /*
      1. create a reference using use reference and add the ref={inputRef} to input element
      2. pass this reference to the Editable component, use different name than ref, I used `childRef`. Its basically a normal prop carrying the input element reference.
    */
    // const inputRef = useRef();
    // const [task, setTask] = useState("");

    /*
      Enclose the input element as the children to the Editable component to make it as inline editable.
    */
    return (

        <AppProvider i18n={enTranslations}>
            <ApolloProvider client={client}>
                <Page>
                    <EmptyState>
                        <TestData/>
                        {/*<Editable*/}
                        {/*    text={task}*/}
                        {/*    placeholder="Write a task name"*/}
                        {/*    childRef={inputRef}*/}
                        {/*    type="input"*/}
                        {/*>*/}
                        {/*    <input*/}
                        {/*        ref={inputRef}*/}
                        {/*        type="text"*/}
                        {/*        name="task"*/}
                        {/*        placeholder="Write a task name"*/}
                        {/*        value={task}*/}
                        {/*        onChange={e => setTask(e.target.value)}*/}
                        {/*    />*/}
                        {/*</Editable>*/}
                    </EmptyState>
                </Page>
            </ApolloProvider>
        </AppProvider>
    );
}

export default App;