import React from 'react';

class Form extends React.Component {
  first_nameRef = React.createRef();
  last_nameRef = React.createRef();
  emailRef = React.createRef();
  phone_numberRef = React.createRef();

  handleForm = (event) => {
    event.preventDefault();
    const contact = {
      first_name: this.first_nameRef.current.value,
      last_name: this.last_nameRef.current.value,
      email: this.emailRef.current.value,
      phone_number: this.phone_numberRef.current.value,
    }
    // if comes from new then create, if not then update
    if (this.props.addContact) {
      this.props.addContact(contact)
    } else {
      this.props.updateContact(contact)
    }
  }

  render () {
    return (
      <form className="form" onSubmit={this.handleForm}>
        <input defaultValue={this.props.first_name} name="first_name" ref={this.first_nameRef} type="text" placeholder="first name" required/>
        <input defaultValue={this.props.last_name} name="last_name" ref={this.last_nameRef} type="text" placeholder="last name" required/>
        <input defaultValue={this.props.email} name="email" ref={this.emailRef} type="text" placeholder="email" required/>
        <input defaultValue={this.props.phone_number} name="phone_number" ref={this.phone_numberRef} type="text" placeholder="phone number" required/>
        <input type="submit" value={this.props.value}/>
      </form>
    )
  }
}

export default Form
