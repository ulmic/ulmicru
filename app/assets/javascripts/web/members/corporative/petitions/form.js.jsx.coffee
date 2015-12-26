initial_nomination = (component) ->
  if component.props.nomination == undefined
    component.props.nomination
  else
    'debut'

checkedValue = (component, nomination) ->
  if component.state.nomination == nomination
    'checked'

init_select2 = (component) ->
  $(".select2-petition#activity_lines_corporative_confession_member_id").select2 {
    ajax: {
      url: Routes.api_admin_members_path()
      data: (term, page) ->
        {
          condition: "without_#{component.state.nomination}"
          q: term
        }
      dataType: 'json'
      processResults: (data) ->
        members = []
        $(data).each ->
          members.push {
            id: @.id
            text: "#{@.ticket} | #{@.first_name} #{@.last_name}"
          }
        {
          results: members
        }
    }
    minimumInputLength: 2
  }

@PetitionInputs = React.createClass
  getInitialState: ->
    {
      nomination: initial_nomination(this)
    }
  componentDidMount: ->
    init_select2 this
  componentDidUpdate: ->
    init_select2 this
  changeNomination: (nomination) ->
    this.setState { nomination: nomination }
  render: ->
    `<div>
      <div className="form-group radio_buttons required activity_lines_corporative_confession_nomination">
        <label className="radio_buttons required control-label">
          <abbr title="required">*</abbr> Номинация
        </label>
        <div className="radio inline">
          <label for="activity_lines_corporative_confession_nomination_debut">
            <input className="radio_buttons required" type="radio" value="debut"
                   name="activity_lines_corporative_confession[nomination]"
                   id="activity_lines_corporative_confession_nomination_debut"
                   checked={checkedValue(this, 'debut')}
                   onClick={this.changeNomination.bind(null, 'debut')} />
              Дебют года
          </label>
        </div>
        <div className="radio inline">
          <label for="activity_lines_corporative_confession_nomination_number_one">
            <input className="radio_buttons required" type="radio" value="number_one"
                   name="activity_lines_corporative_confession[nomination]"
                   id="activity_lines_corporative_confession_nomination_number_one"
                   checked={checkedValue(this, 'number_one')}
                   onClick={this.changeNomination.bind(null, 'number_one')} />
            Номер один
          </label>
        </div>
      </div>
      <div className="input select required activity_lines_corporative_confession_member_id">
        <label className="select required" for="activity_lines_corporative_confession_member_id">
          <abbr title="required">*</abbr> Член МИЦ
        </label>
        <select className="select required select2-petition"
                name="activity_lines_corporative_confession[member_id]"
                id="activity_lines_corporative_confession_member_id">
        </select>
      </div>
    </div>`
