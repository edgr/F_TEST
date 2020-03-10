import React from 'react';
import ContactCard from './ContactCard'

class App extends React.Component {

  state = {
    contacts: []
  }

  componentDidMount(){
    fetch('/api/v1/contacts.json')
      .then((response) => {return response.json()})
      .then((data) => {this.setState({ contacts: data }) });
  }

  newContact = (event) => {
    event.preventDefault();
    this.props.history.push(`/new-contact`)
  }

  render () {
    const contacts = this.state.contacts.map((contact) => {
      return (
        <ContactCard
          key={contact.id}
          id={contact.id}
          first_name={contact.first_name}
          last_name={contact.last_name}
          email={contact.email}
          phone_number={contact.phone_number}
          history ={this.props.history }
        />
      )
    })
    return (
      <div>
        <h1>Your contacts!</h1>
        <div className="contacts">
          {contacts}
        </div>
        <a onClick={this.newContact}>Add new contact</a>
      </div>
    )
  }
}

export default App
