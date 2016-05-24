import React from 'react'
import TagToolbar from './toolbar'
import TagsPresents from './presents'
import TagOptionForm from './option_form'

var getTags = function(component) {
  $.ajax({
    url: Routes.api_admin_tags_path(),
    data: {
      record_id: component.props.record.id,
      record_type: component.props.record_type
    },
    dataType: 'JSON',
    success: function(data) {
      component.setState({ tags: data })
    }
  })
}

class TagsForm extends React.Component {
  constructor(props) {
    super(props)
    this.state = {
      tagType: 'none',
      targetType: 'none',
      tags: this.props.tags
    }
  }
  openTagForm(type, targetType = 'none') {
    if ((this.state.tagType == type) && (this.state.targetType == targetType)) {
      this.setState({
        tagType: 'none',
        targetType: 'none'
      })
    } else {
      this.setState({
        tagType: type,
        targetType: targetType
      })
    }
  }
  onTagSubmit() {
    getTags(this)
  }
  reloadTags() {
    getTags(this)
  }
  render() {
    return(<div className='tags-form'>
      <TagToolbar toolbarButtonOnClick={this.openTagForm.bind(this)} />
      <TagsPresents tags={this.state.tags}
                    reloadTags={this.reloadTags.bind(this)} />
      <TagOptionForm tagType={this.state.tagType}
                     targetType={this.state.targetType}
                     record={this.props.record}
                     recordType={this.props.record_type}
                     onTagSubmit={this.onTagSubmit.bind(this)}/>
    </div>)
  }
}

export default TagsForm
