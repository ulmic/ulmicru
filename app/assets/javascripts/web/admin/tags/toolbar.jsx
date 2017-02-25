import React from 'react'

class TagToolbar extends React.Component {
  render() {
    return(<div className='btn-toolbar'>
      <div className='btn-group tag-buttons'>
        <a className="btn btn-xs btn-success" onClick={this.props.toolbarButtonOnClick.bind(null, 'string', 'none')}>
          <i className='fa fa-tag fa-2x'></i>
        </a>
        <a className="btn btn-xs btn-success" onClick={this.props.toolbarButtonOnClick.bind(null, 'link', 'member')}>
          <i className='fa fa-user fa-2x'></i>
        </a>
        <a className="btn btn-xs btn-success" onClick={this.props.toolbarButtonOnClick.bind(null, 'link', 'event')}>
          <i className='fa fa-calendar fa-2x'></i>
        </a>
        <a className="btn btn-xs btn-success" onClick={this.props.toolbarButtonOnClick.bind(null, 'link', 'activity_line')}>
          <i className='fa fa-flag fa-2x'></i>
        </a>
          <a className="btn btn-xs btn-success" onClick={this.props.toolbarButtonOnClick.bind(null, 'link', 'team')}>
            <i className='fa fa-bullhorn fa-2x'></i>
          </a>
        </div>
    </div>)
  }
}

export default TagToolbar;
