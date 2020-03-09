import React from 'react';

class App extends React.Component {
  render () {
    const newContact = (event) => {
      event.preventDefault();
      this.props.history.push(`/new-contact`)
    }
    return (
      <div>
        <h1>Your contacts!</h1>
        <input type="submit" onClick={newContact} />
      </div>
    )
  }
}

export default App
