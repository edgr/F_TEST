import React from 'react';
import { BrowserRouter, Route, Switch } from 'react-router-dom';
import App from './App';
import NewContactForm from './NewContactForm';
import Contact from './Contact';
import NotFound from './NotFound';

const Router = () => (
  <BrowserRouter>
    <Switch>
      <Route exact path='/' component={App} />
      <Route exact path='/new-contact' component={NewContactForm} />
      <Route exact path='/contact/:contactId' component={Contact} />
      <Route component={NotFound}/>
    </Switch>
  </BrowserRouter>
)

export default Router
