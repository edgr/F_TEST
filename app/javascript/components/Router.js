import React from 'react';
import { BrowserRouter, Route, Switch } from 'react-router-dom';
import App from './App';
import NewContact from './NewContact';
import Contact from './Contact';
import NotFound from './NotFound';
import EditContact from './EditContact';

const Router = () => (
  <BrowserRouter>
    <Switch>
      <Route exact path='/' component={App} />
      <Route exact path='/new-contact' component={NewContact} />
      <Route exact path='/contacts/:id' component={Contact} />
      <Route exact path='/contacts/:id/edit' component={EditContact} />
      <Route component={NotFound} />
    </Switch>
  </BrowserRouter>
)

export default Router
