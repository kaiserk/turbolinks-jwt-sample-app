import { gql, useQuery, useMutation } from '@apollo/client';
import React, {useEffect, useRef, useState} from 'react';
import EasyEdit from 'react-easy-edit';
import Editable from "./Editable";
import {Card, DataTable, Link, Page, Pagination} from '@shopify/polaris';


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

export default function ProductsList() {
    let input;

    const { loading, error, data } = useQuery(PRODUCTS_QUERY, {
        variables: { shopId: 0 }
    });

    const [table_rows, set_table_Rows] = useState([]);
    const [products, setProducts] = useState([]);
    const rowsPerPage = 1;
    const [pos, setPos] = useState(1);
    const [pagination, setPagination] = useState(1);

    const inputRef = useRef();

    // const [updateVariant, ret] = useMutation(UPDATE_QUERY);

    // Refetches two queries after mutation completes
    const [updateVariant, ret] = useMutation(UPDATE_QUERY, {
        refetchQueries: [
            PRODUCTS_QUERY, // DocumentNode object parsed with gql
            'GetProducts' // Query name
        ],
    });

    const save = (id, value) => {
        const fValue = parseFloat(value);

        updateVariant({ variables: { id: id, units: fValue }});

        if(ret.loading) {
            console.log('loading...')
        } else if (ret.error) {
            console.log('Mutation error: ' + ret.error)
        } else {
            console.log('Nothing to show anymore: ' + ret.data);
        }

//        const tmpData = [...products];
        // just a min.
        //tmpData[0].units = 1;
        console.log(products);

        if(data && data.products.length > 0) {
            initialData(data.products, id, value)
        }
    };

    useEffect((() => {
        if(data && data.products.length > 0) {
            setProducts(data.products);
            initialData(data.products, -1, 0);
        }

    }), [data])

    const initialData = (products, id, value) => {
        const rows_array = []
        const rows = products.map(product => (
            product.variants.map(variant => {
                let unitiprice = 0;
                if(id === variant.id){
                    unitiprice = variant.variantPrice / value;
                } else {
                    unitiprice = variant.variantPrice / variant.units; // variant.units is storing the old value here, when user updates this, data.produ// ct.variants.units is not being updated

                    console.log('variant price: ' + variant.variantPrice + ' divided by units: ' + variant.units);
                }
                unitiprice = unitiprice.toFixed(2);

                let vTitle = variant.title
                if (vTitle === 'Default Title') {
                    vTitle = 'N/A (Product without variant)';
                }

                let vUnits = String(variant.units);
                return rows_array.push([
                    product.title,
                    vTitle,
                    variant.variantPrice,
                    <EasyEdit
                        type="number"
                        value={vUnits}
                        onSave={(value) => { save(variant.id, value) }}
                        onCancel={cancel}
                        saveButtonLabel="Save"
                        cancelButtonLabel="Cancel"
                        attributes={{ name: "awesome-input", id: 1}}
                        // instructions="Instruction!"
                    />,
                    unitiprice,
                ])
            })
        ));
        console.log('------>', table_rows, rows_array);
        set_table_Rows(rows_array);
    }

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
    useEffect(()=>{
        setPagination(Math.round(table_rows.length / rowsPerPage));
    }, [table_rows]);


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
            <Page title="Products & Variants">
                 <Card>
                    <DataTable
                        columnContentTypes={[
                        'text',
                        'text',
                        'numeric',
                        'numeric',
                        'numeric',
                    ]}
                    headings={['Product Title', 'Variant Name', 'Price', 'Units', 'Unit Price']}
                    rows={table_rows.slice(rowsPerPage * (pos - 1), rowsPerPage * pos)}
                    />
                </Card>
                <Pagination
                    label={`Page ${pos} of ${pagination}`} //show 2 per page
                    hasPrevious={pos > 1? true: false}
                    onPrevious={() => {
                        setPos(pos - 1)
                    }}
                    hasNext={pos < pagination? true: false}
                    onNext={() => {
                        setPos(pos + 1);
                    }}
                />
            </Page>
        );
    }
};