import React from 'react'

var initial_nomination = function(component) {
  if (component.props.nomination == undefined) {
    return component.props.nomination
  } else {
    return 'debut'
  }
}

var checkedValue = function(component, nomination) {
  if (component.state.nomination == nomination) {
    return 'checked'
  }
}

var init_select2 = function(component) {
  $(".select2-petition#activity_lines_corporative_confession_member_id").select2({
    ajax: {
      //FIXME don't get from admin namespace
      url: Routes.api_admin_members_path(),
      data: function(term, page) {
        return({
          condition: `without_${component.state.nomination}`,
          q: term
        })
      },
      dataType: 'json',
      processResults: function(data) {
        var members = []
        $(data).each(function() {
          members.push({
            id: this.id,
            text: `${this.ticket} | ${this.first_name} ${this.last_name}`
          })})
        return({ results: members })
      }
    },
    minimumInputLength: 2
  })
}

class PetitionInputs extends React.Component {
  constructor(props) {
    super(props)
    this.state = { nomination: initial_nomination(this) }
  }
  componentDidMount() {
    init_select2(this)
  }
  componentDidUpdate() {
    init_select2(this)
  }
  changeNomination(nomination) {
    this.setState({ nomination: nomination })
  }
  render() {
    return(<div>
             <div className="form-group radio_buttons required activity_lines_corporative_confession_nomination">
               <label className="radio_buttons required control-label">
                 <abbr title="required">*</abbr> Номинация
               </label>
               <div className="radio inline">
                 <label htmlFor="activity_lines_corporative_confession_nomination_debut">
                   <input className="radio_buttons required" type="radio" value="debut"
                          name="activity_lines_corporative_confession[nomination]"
                          id="activity_lines_corporative_confession_nomination_debut"
                          checked={checkedValue(this, 'debut')}
                          onClick={this.changeNomination.bind(null, 'debut')} />
                     Дебют года
                 </label>
               </div>
               <div className="radio inline">
                 <label htmlFor="activity_lines_corporative_confession_nomination_number_one">
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
               <label className="select required" htmlFor="activity_lines_corporative_confession_member_id">
                 <abbr title="required">*</abbr> Член МИЦ
               </label>
               <select className="select required select2-petition"
                       name="activity_lines_corporative_confession[member_id]"
                       id="activity_lines_corporative_confession_member_id">
               </select>
             </div>
           </div>)
  }
}

export default PetitionInputs
