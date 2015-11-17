getTags = (component, record_type, record_id) ->
  $.ajax {
    url: Routes.api_admin_tags_path()
    data: {
      record_id: record_id
      record_type: record_type
    }
    dataType: 'JSON'
    success: (data) ->
      component.setState { tags: JSON.parse(data.list) }
  }

@TagsForm = React.createClass
  getInitialState: ->
    {
      tagType: 'none'
      targetType: 'none'
      tags: this.props.tags
    }
  openTagForm: (type, targetType = 'none') ->
    if this.state.tagType == type && this.state.targetType == targetType
      this.setState {
        tagType: 'none'
        targetType: 'none'
      }
    else
      this.setState {
                      tagType: type
                      targetType: targetType
                    }
  onTagSubmit: ->
    getTags(this, this.props.record_type, this.props.record.id)
  reloadTags: ->
    getTags(this, this.props.record_type, this.props.record.id)
  render: ->
    `<div className='tags-form'>
      <TagToolbar toolbarButtonOnClick={this.openTagForm} />
      <TagsPresents tags={this.state.tags}
                    reloadTags={this.reloadTags}/>
      <TagOptionForm tagType={this.state.tagType}
                     record={this.props.record}
                     recordType={this.props.record_type} />
    </div>`
