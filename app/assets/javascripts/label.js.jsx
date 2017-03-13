import React from 'react'

class Label extends React.Component {
  constructor(props) {
    super(props)
    this.state = {
      checked: false
    }
    this.request = this.request.bind(this)
  }
  request(e) {
    e.preventDefault() 
    $.ajax({
      url: this.props.url,
      data: this.props.data,
      dataType: 'JSON',
      success: (function () {
        this.setState({ checked: true }) 
      })
    })
  }
  render() {
    let labelColor = ``
    if (this.state.checked) {
      labelColor = `label label-${this.props.color}`
    } else {
      labelColor = `label label-default`
    }
    <span className={labelColor} onClick={this.request}>{this.props.text}</span>
  }
}
