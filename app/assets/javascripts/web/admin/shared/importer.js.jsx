import React from 'react'

class Importer extends React.Component {
  constructor(props) {
    super(props)
  }
  uploadXLS(e) {
    e.preventDefault()
    $.ajax({
      url: this.props.url,
      method: this.props.method,
      data: {
        file: $('#importFile').val()
      },
      success: function() {
        alert('success')
      }
    })
  }
  render() {
    return(
      <div className="row-fluid">
        <div className="col-md-4">
          <button className="btn btn-success">
            <i className="fa fa-download"></i>
            <span> </span>
            {I18n.t('web.admin.shared.importer.import')}
          </button>
        </div>
        <div className="col-md-8">
          <div className="panel panel-info">
            <div className="panel-heading">
              <i className="fa fa-info"></i>
              <span> </span>
              {I18n.t('web.admin.shared.importer.you_should_use_xls')}
            </div>
            <div className="panel-body">
              <form className="form-inline" action={this.props.url} method={this.props.method} data-remote="true">
                <div className="form-group">
                  <input type="file" id="file" name="file"/>
                </div>
                <div className="form-group">
                  <input type="submit" className="btn btn-warning" commit={I18n.t('helpers.upload')}/>
                </div>
              </form>
            </div>
          </div>
        </div>
      </div>
    )
  }
}

export default Importer
