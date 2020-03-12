import React from 'react';
import BackHome from './BackHome';

class Contact extends React.Component {
  state = {
    contact: []
  }

  url = `/api/v1/contacts/${this.props.match.params.id}.json`

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
    const answer = confirm('Are you sure?')
    if (answer) {
      fetch(this.url, {
        method: 'DELETE',
      });
      this.props.history.push('/')
    }
  }

  render () {
    const { first_name, last_name, email, phone_number} = this.state.contact
    return (
      <div className="contact">
        <h2>{first_name} {last_name}</h2>
        <p>{email}</p>
        <p>{phone_number}</p>
        <div className="buttons">
          <a className="button" onClick={this.editContact}>Edit</a>
          <a className="button button-reverse" onClick={this.deleteContact}>Delete</a>
        </div>
        <BackHome />
      </div>
    )
  }
}

export default Contact
