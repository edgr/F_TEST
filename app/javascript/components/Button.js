import React from 'react';

class Button extends React.Component {

  newContact = (event) => {
    event.preventDefault();
    this.props.history.push(`/new-contact`)
  }

  render () {
    return (
      <a className="button" onClick={this.newContact}>
        add new contact
      </a>
    )
  }
}

export default Button
