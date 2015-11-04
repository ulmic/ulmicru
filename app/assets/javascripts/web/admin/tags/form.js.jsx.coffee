@TagsForm = React.createClass
  getInitialState: ->
    {
      tagType: 'none'
      targetType: 'none'
    }
  openTagForm: (type, targetType = 'none') ->
    this.setState {
                    tagType: type
                    targetType: targetType
                  }
  render: ->
    `<div className='tags-form'>
      <TagToolbar toolbarButtonOnClick={this.openTagForm} />
      <TagOptionForm tagType={this.state.tagType}
                     record={this.props.record}
                     recordType={this.props.record_type} />
    </div>`
