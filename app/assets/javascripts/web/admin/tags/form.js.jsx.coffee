@TagsForm = React.createClass
  getInitialState: ->
    {
      tagType: 'none'
      targetType: 'none'
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
  render: ->
    `<div className='tags-form'>
      <TagToolbar toolbarButtonOnClick={this.openTagForm} />
      <TagsPresents tags={this.props.tags} />
      <TagOptionForm tagType={this.state.tagType}
                     record={this.props.record}
                     recordType={this.props.record_type} />
    </div>`
