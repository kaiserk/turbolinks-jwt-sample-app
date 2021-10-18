import React, {useCallback, useState} from 'react';
import {CalloutCard, Banner, Card, FormLayout, Layout, TextField, MediaCard, Heading, TextStyle, TextContainer} from '@shopify/polaris';
import step1 from '../../assets/images/step1.png';
import step2 from '../../assets/images/step2.png';
import HelpCollection from "./Help";


const ContactUs = () => {    return (
        <div>
            <p>If you need technical assistance or have product feedback, please  <a href="mailto:info@appsbysimple.com?subject=Need help with Unit Pricer" target="_blank"><b>email us</b></a>.</p><br/>
        </div>
        );
}

export default ContactUs;

