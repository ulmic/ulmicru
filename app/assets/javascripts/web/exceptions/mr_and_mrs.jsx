// #= require jquery
// set_background_color = (color) ->
//   $('body').css('background-color', color)
//   $('#content').css('background-color', color)
//   $('.container').css('background-color', color)

// get_view = (hash) ->
//   $(hash).show()
//   set_background_color colors[hash]
//   if hash == '#view_2013'
//     $('h3').css('color', '#f0eff4')
//     $('.text').removeClass('small-6').addClass('small-4')
//     $('.image').removeClass('small-6').addClass('small-8')
//   if hash == '#view_2015'
//     $('h3').css('color', 'white')
//   return

// $(document).ready ->
//   $('.mr_mrs').hide()
//   if window.location.hash != ''
//     get_view(window.location.hash)
//     return
//   else
//     i = Math.floor(Math.random() * 4) + 1
//     hash = "#view_#{i}"
//     get_view(hash)
//     return
import React from 'react'

class MrAndMrs extends React.Component {
  constructor(props) {
    super(props)
    this.state = {
      year: this.props.year,
      error_type: this.props.error_type
    }
  }
  getBackgroundStyle() {
    var colors =  {
      '2012': '#f0eff4',
      '2013': '#232323',
      '2014': '#edcfdb',
      '2015': '#496e9b'
    };
    return {backgroundColor: colors[this.state.year]};
  }
  render() {
    return(
      <div className="row mr_mrs" id={'view_' + this.state.year} style={this.getBackgroundStyle()}>
        <div className="small-6 columns text">
          <h3>
            {I18n.t("web.exceptions." + this.state.error_type + '.message')}
            <br/>
            <br/>
            {I18n.t("web.exceptions.shared.mr_and_mrs." + this.state.year)}
          </h3>
        </div>
        <div className="small-6 columns image">
          <img className={"img_" + this.state.year} src={"assets/exceptions/" + this.state.year + ".jpg"}/>
        </div>
      </div>
    )
  }
}

export default MrAndMrs
