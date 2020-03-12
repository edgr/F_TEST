import React from 'react';

class ContactCard extends React.Component {

  showContact = (event) => {
    event.preventDefault();
    this.props.history.push(`/contacts/${this.props.id}`);
  }

  render () {
    return (
      <a onClick={this.showContact}>
        <h2 className="name">{this.props.first_name} {this.props.last_name}</h2>
        <p className="email">{this.props.email}</p>
      </a>
    )
  }
}

export default ContactCard
