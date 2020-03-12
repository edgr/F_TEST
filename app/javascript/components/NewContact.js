import React from 'react';
import Form from './Form';


class NewContact extends React.Component {

  url = `/api/v1/contacts.json`

  addContact = (contact) => {
    const body = JSON.stringify({
      first_name: contact.first_name,
      last_name: contact.last_name,
      email: contact.email,
      phone_number: contact.phone_number
    })
    fetch(this.url, {
      method: 'POST',
      headers: { 'Content-Type': 'application/json' },
      body: body
    }).then((response) => {return response.json()});
    this.props.history.push(`/`);
  }

  render () {
    return (
      <Form addContact={this.addContact} title="Add a new contact" value="Add Contact" />
    )
  }
}

export default NewContact
