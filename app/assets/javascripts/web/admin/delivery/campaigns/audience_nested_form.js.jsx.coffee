newForms = (component) ->
  forms = []
  for i in [0...component.state.newFieldsCount]
    forms.push `<AudienceForm index={i + component.props.audiences.length}
                              campaign_id={component.props.campaign_id}
                              audience_types={component.props.audience_types} />`
  forms

forms = (component) ->
  forms = []
  for i in component.props.audiences
    forms.push `<AudienceForm audience={this}
                              index={i + component.props.audiences.length}
                              campaign_id={component.props.campaign_id}
                              audience_types={component.props.audience_types} />`
  forms

@AudienceNestedForm = React.createClass
  getInitialState: ->
    {
      newFieldsCount: 0
      audiences: this.props.audiences
    }
  addFields: ->
    this.setState { newFieldsCount: this.state.newFieldsCount + 1 }
  render: ->
    `<div>
      {forms(this)}
      {newForms(this)}
    </div>`
