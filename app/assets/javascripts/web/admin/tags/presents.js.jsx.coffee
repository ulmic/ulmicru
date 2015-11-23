@TagsPresents = React.createClass
  render: ->
    presents_tags = []
    tags = this.props.tags
    component = this
    $(tags).each ->
      presents_tags.push `<li className='list-group-item'>
          <a className="badge tag_destroy" data-remote="true" rel="nofollow" data-method="delete" href={Routes.api_admin_tag_path(this.id)}>X
          </a>
          {this.text}
        </li>`
    `<ul className='list-group'>
      {presents_tags}
    </ul>`
