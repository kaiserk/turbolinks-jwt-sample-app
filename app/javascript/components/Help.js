import React, {useCallback, useState} from 'react';
import {Banner, Card, FormLayout, Layout, TextField, MediaCard, Heading, TextStyle, TextContainer} from '@shopify/polaris';
import step1 from '../../assets/images/step1.png';
import step2 from '../../assets/images/step2.png';


const HelpCollection = () => {
    return (
        <Layout>
            <Layout.Section>
                <Card sectioned>
                    <Heading element="h2">How to Display Unit Prices on Shopify Collections Pages</Heading>
                    <MediaCard
                        title="1. Open your theme's code"
                        description="From your admin dashboard, in the menu on the left side, click Online Store then from the 'Actions' dropdown select the 'Edit code' option."
                        // popoverActions={[{content: 'Dismiss', onAction: () => {}}]}
                    >
                        <img
                            alt=""
                            width="100%"
                            height="100%"
                            style={{
                                objectFit: 'cover',
                                objectPosition: 'center',
                            }}
                            src={step1}
                        />
                    </MediaCard>
                </Card>
                <Card sectioned>
                    <MediaCard
                        title="2. Open the file called 'product-card-grid.liquid' in 'Snippets' folder on the left side."
                        description=""
                        // popoverActions={[{content: 'Dismiss', onAction: () => {}}]}
                    >
                        <img
                            alt=""
                            width="30%"
                            height="30%"
                            style={{
                                objectFit: 'cover',
                                objectPosition: 'center',
                            }}
                            src={step2}
                        />
                    </MediaCard>
                </Card>
                <TextContainer>
                    <Heading>3. Plant a snippet of code</Heading>
                    <p>
                        <Heading element="h4">On the right side of the screen, find this line of code:</Heading>
                        <p>
                            {`
                                {% include 'product-price-listing', product: product, show_vendor: show_vendor %}
                            `}
                        </p>
                    </p>
                    <p>
                        <Heading element="h4">In old stores the line may look like:</Heading>
                        <p>
                            {`
                                {% include 'product-price', variant: product %}
                            `}
                        </p>
                    </p>
                </TextContainer>
                <TextContainer>
                    <Heading>4. Then, directly after that line of code, paste this:</Heading>
                    <p>
                        <Heading element="h4">Then, directly after that line of code, paste this:</Heading>
                        <p>
                            {`
                                <%= '<div class="insert-unit-pricing" data-product="{{ product.id }}"></div>' %>
                            `}
                        </p>
                    </p>
                </TextContainer>
            </Layout.Section>
        </Layout>
    );
}

export default HelpCollection;
