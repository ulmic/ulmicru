import React from 'react'

class TagToolbar extends React.Component {
  render() {
    return(<div className='btn-toolbar'>
      <div className='btn-group tag-buttons'>
        <a className="btn btn-xs btn-success" onClick={this.props.toolbarButtonOnClick.bind(null, 'string', 'none')}>
          <span className='glyphicon glyphicon-font'></span>
        </a>
        <a className="btn btn-xs btn-success" onClick={this.props.toolbarButtonOnClick.bind(null, 'link', 'member')}>
          <span className='glyphicon glyphicon-user'></span>
        </a>
        <a className="btn btn-xs btn-success" onClick={this.props.toolbarButtonOnClick.bind(null, 'link', 'event')}>
          <span className='glyphicon glyphicon-calendar'></span>
        </a>
        <a className="btn btn-xs btn-success" onClick={this.props.toolbarButtonOnClick.bind(null, 'link', 'activity_line')}>
          <span className='glyphicon glyphicon-flag'></span>
        </a>
          <a className="btn btn-xs btn-success" onClick={this.props.toolbarButtonOnClick.bind(null, 'link', 'team')}>
            <span className='glyphicon glyphicon-bullhorn'></span>
          </a>
        </div>
    </div>)
  }
}

export default TagToolbar;
