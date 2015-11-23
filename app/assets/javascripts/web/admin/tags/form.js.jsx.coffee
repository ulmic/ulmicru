getTags = (component) ->
  $.ajax {
    url: Routes.api_admin_tags_path()
    data: {
      record_id: component.props.record.id
      record_type: component.props.record_type
    }
    dataType: 'JSON'
    success: (data) ->
      component.setState { tags: data }
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
    getTags this
  render: ->
    `<div className='tags-form'>
      <TagToolbar toolbarButtonOnClick={this.openTagForm} />
      <TagsPresents tags={this.state.tags}
                    reloadTags={this.reloadTags}/>
      <TagOptionForm tagType={this.state.tagType}
                     record={this.props.record}
                     recordType={this.props.record_type}
                     onTagSubmit={this.onTagSubmit}/>
    </div>`
