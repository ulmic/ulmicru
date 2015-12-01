@TagsPresents = React.createClass
  removeTag: (tag_id) ->
    component = this
    $.ajax {
      url: Routes.api_admin_tag_path(tag_id)
      type: 'DELETE'
      success: ->
        component.props.reloadTags()
      # FIXME несмотря на ответ сервера success, здесь исполняется всё равно error
      error: ->
        component.props.reloadTags()
    }
  render: ->
    presents_tags = []
    tags = this.props.tags
    component = this
    $(tags).each ->
      presents_tags.push `<li className='list-group-item'>
          <a onClick={component.removeTag.bind(null, this.id)} className="badge tag_destroy" rel="nofollow">
            X
          </a>
          {this.text}
        </li>`
    `<ul className='list-group'>
      {presents_tags}
    </ul>`
