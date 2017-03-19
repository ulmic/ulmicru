import React from 'react'

class Label extends React.Component {
  constructor(props) {
    super(props)
    let checked = false
    if (this.props.checked != undefined) {
      checked = this.props.checked 
    }
    this.state = {
      checked: checked
    }
    this.request = this.request.bind(this)
  }
  request(e) {
    e.preventDefault() 
    let component = this
    $.ajax({
      url: this.props.url,
      data: this.props.data,
      method: this.props.method,
      dataType: 'JSON',
      //FIXME I can't understand why! Error works, but success not working
      success: function (data) {
        component.setState({ checked: true }) 
      },
      error: function(data) {
        component.setState({ checked: true }) 
      }
    })
  }
  render() {
    let labelColor = ``
    if (this.state.checked) {
      labelColor = `label label-${this.props.color} reactLabel`
    } else {
      labelColor = `label label-default reactLabel`
    }
    return(<span className={labelColor} onClick={this.request}>{this.props.text}</span>)
  }
}

export default Label
