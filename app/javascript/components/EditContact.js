import React from 'react';

class EditContact extends React.Component {
  state = {
    contact: []
  }

  url = `/api/v1/contacts/${this.props.match.params.contactId}.json`

  componentDidMount(){
    fetch(this.url)
      .then((response) => {return response.json()})
      .then((data) => {this.setState({ contact: data }) });
  }

  render () {
    return (
      <p>Test</p>
    )
  }
}

export default EditContact
