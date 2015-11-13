@TagsPresents = React.createClass
  render: ->
    presents_tags = []
    tags = this.props.tags
    $(tags).each ->
      text = this.text
      switch this.target_type
        when 'member'
          text = this.text

      if this.tag_type == 'string'
        presents_tags.push `<li className='list-group-item'>
            <a className="badge tag_destroy" data-remote="true" rel="nofollow" data-method="delete" href={Routes.api_admin_tag_path(this.id)}>X
            </a>
            {this.text}
          </li>`
    `<ul className='list-group'>
      {presents_tags}
    </ul>`
