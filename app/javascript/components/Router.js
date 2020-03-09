import React from 'react'
import { BrowserRouter, Route, Switch } from 'react-router-dom'
import App from './App'
import NewContactForm from './NewContactForm'

const Router = () => (
  <BrowserRouter>
    <Switch>
      <Route exact path='/' component={App} />
      <Route exact path='/new-contact' component={NewContactForm} />
    </Switch>
  </BrowserRouter>
)

export default Router
