import React from 'react'
import PlaceForm from '../places/form'

class PlaceField extends React.Component {
  constructor(props) {
    super(props)
    this.state = {
      formDisplay: 'none'
    }
    this.showForm = this.showForm.bind(this)
  }
  showForm() {
    this.setState({ formDisplay: 'block' })
  }
  render() {
    return <div>
      <a className='btn btn-success' onClick={this.showForm}>{I18n.t('web.admin.events.form.add_place')}</a>
      <PlaceForm display={this.state.formDisplay}/>
    </div>
  }
}

export default PlaceField
