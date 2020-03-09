import React from 'react';

class App extends React.Component {
  newContact = (event) => {
    event.preventDefault();
    this.props.history.push(`/new-contact`)
  }
  render () {
    return (
      <div>
        <h1>Your contacts!</h1>
        <input type="submit" onClick={this.newContact} />
      </div>
    )
  }
}

export default App
