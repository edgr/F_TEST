import React from 'react';

class Contact extends React.Component {
  state = {
    contact: []
  }

  url = `/api/v1/contacts/${this.props.match.params.contactId}.json`

  componentDidMount(){
    fetch(this.url)
      .then((response) => {return response.json()})
      .then((data) => {this.setState({ contact: data }) });
  }

  editContact = (event) => {
    event.preventDefault();
    this.props.history.push(`/contacts/${this.state.contact.id}/edit`)
  }

  deleteContact = (event) => {
    event.preventDefault();
    fetch(this.url, {
      method: 'DELETE',
    });
    this.props.history.push('/')
  }

  render () {
    const { first_name, last_name, email, phone_number} = this.state.contact
    return (
      <div className="contact">
        <h2>{first_name} {last_name}</h2>
        <p>{email}</p>
        <p>{phone_number}</p>
        <a onClick={this.editContact}>Edit</a>
        <a onClick={this.deleteContact}>Delete</a>
      </div>
    )
  }
}

export default Contact
