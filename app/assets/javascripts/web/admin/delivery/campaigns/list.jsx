import React from 'react'

class AudiencesList extends React.Component {
  render() {
    let rows = []
    for (let i = 0; i < this.props.audiences.length; i++) {
      rows.push(
        <tr key={`audience-${i}`}>
          <td>
            {I18n.t(`enumerize.delivery/audience.audience_type.${this.audience_type}`)}
          </td>
          <td>
            {this.audience_id}} 
          </td>
        </tr>
      )
    }
    return(
      <table className='table'>
        <tbody>
          {rows}
        </tbody>
      </table>
    )
  }
}

export default AudiencesList
