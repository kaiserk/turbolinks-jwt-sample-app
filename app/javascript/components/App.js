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
import { BrowserRouter as Router, Switch, Route } from "react-router-dom";
import ProductsList from "./ProductsList";
import Preferencess from "./Preferencess";
import Nav from "./Navigation";
import "./styles.css";
import Help from "./Help";
import HelpCollection from "./HelpCollection";
import ContactUs from "./ContactUs";


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
                <link
                    rel="stylesheet"
                    href="https://unpkg.com/@shopify/polaris@7.0.0/build/esm/styles.css"
                />
                <div className="main">
                    <Nav />
                    <div className={'content_wrapper'}>
                        <Router>
                            <Switch>
                                <Route path="/dashboard" exact component={ProductsList} />
                                <Route path="/productslist" exact component={ProductsList} />
                                <Route path="/preferencess" component={Preferencess} />
                                <Route path="/help-collection-page" component={Help} />
                                <Route path="/help-manual-uninstall" component={HelpCollection} />
                                <Route path="/contactus" exact component={ContactUs} />
                            </Switch>
                        </Router>
                    </div>
                </div>

                {/*<Page>*/}
                {/*    <Nav/>*/}
                {/*    <ProductsList/>*/}
                {/*</Page>*/}
            </ApolloProvider>
        </AppProvider>
    );
}

export default App;