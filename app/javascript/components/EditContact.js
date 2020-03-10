import React from 'react';
import Form from './Form';

class EditContact extends React.Component {
  state = {
    contact: []
  }

  url = `/api/v1/contacts/${this.props.match.params.id}.json`

  componentDidMount(){
    fetch(this.url)
      .then((response) => {return response.json()})
      .then((data) => {this.setState({ contact: data }) });
  }

  updateContact = (contact) => {
    const body = JSON.stringify({
      first_name: contact.first_name,
      last_name: contact.last_name,
      email: contact.email,
      phone_number: contact.phone_number
    });
    fetch(this.url, {
      method: 'PATCH',
      headers: { 'Content-Type': 'application/json' },
      body: body
    });
    this.props.history.push(`/`);
  }

  render () {
    const { first_name, last_name, email, phone_number} = this.state.contact
    return (
      <Form
        first_name={first_name}
        last_name={last_name}
        email={email}
        phone_number={phone_number}
        updateContact={this.updateContact}
        value="Update Contact"
      />
    )
  }
}

export default EditContact
