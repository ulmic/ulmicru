#= require react
#= require react_ujs

@TagsForm = React.createClass
  getInitialState: ->
    { tagTypeOpen: 'none' }
  render: ->
    `<div className='tags-form'>
      <div className='btn-toolbar'>
        <div className='btn-group tag-buttons'>
          <a className="btn btn-xs btn-success" data-tag-type="string" href="#">
            <span className='glyphicon glyphicon-font'></span>
          </a>
          <a className="btn btn-xs btn-success" data-tag-type="link" data-target-type="Member" href="#">
            <span className='glyphicon glyphicon-user'></span>
          </a>
          <a className="btn btn-xs btn-success" data-tag-type="link" data-target-type="Event" href="#">
            <span className='glyphicon glyphicon-calendar'></span>
          </a>
          <a className="btn btn-xs btn-success" data-tag-type="link" data-target-type="ActivityLine" href="#">
            <span className='glyphicon glyphicon-flag'></span>
          </a>
            <a className="btn btn-xs btn-success" data-tag-type="link" data-target-type="Team" href="#">
              <span className='glyphicon glyphicon-bullhorn'></span>
          </a>
        </div>
      </div>
    </div>`
