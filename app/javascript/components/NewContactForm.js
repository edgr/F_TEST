import React from 'react'

class NewContactForm extends React.Component {
  state = {
    contacts: {}
  }

  first_nameRef = React.createRef();
  last_nameRef = React.createRef();
  emailRef = React.createRef();
  phone_numberRef = React.createRef();

  createContact = (event) => {
    {/* preventing default behavior */}
    event.preventDefault();
    {/* create new contact */}
    const contact = {
      first_name: this.first_nameRef.current.value,
      last_name: this.last_nameRef.current.value,
      email: this.emailRef.current.value,
      phone_number: this.phone_numberRef.current.value,
    }
    // copy of state
    const contacts = {...this.state.contacts}
    // adding the contact with unique ID
    contacts[`contact${Date.now()}`] = contact
    // update state
    this.setState({ contacts })
    {/* redirecting to home */}
  }
  render () {
    return (
      <form action="" className="new-contact-form" onSubmit={this.createContact}>
        <h2>Add a new contact</h2>
        <input name="first_name" ref={this.first_nameRef} type="text" placeholder="first name" required/>
        <input name="last_name" ref={this.last_nameRef} type="text" placeholder="last name" required/>
        <input name="email" ref={this.emailRef} type="text" placeholder="email" required/>
        <input name="phone_number" ref={this.phone_numberRef} type="text" placeholder="phone number" required/>
        <input type="submit" value="Create Contact"/>
      </form>
    )
  }
}

export default NewContactForm
