import React from 'react';
import ContactCard from './ContactCard'
import Button from './Button'
import Header from './Header'

class App extends React.Component {

  state = {
    contacts: []
  }

  componentDidMount(){
    fetch('/api/v1/contacts.json')
      .then((response) => {return response.json()})
      .then((data) => {this.setState({ contacts: data }) });
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
      <div className="main">
        <Header title={"contacts"} />
        <div className="contacts">
          {contacts}
        </div>
        <Button history={this.props.history} />
      </div>
    )
  }
}

export default App
