#= require react-motion

@ConfessionYear = React.createClass
  render: ->
    year = this.props.year
    id = "year_#{year}"
    href = "#confession_#{year}"
    `<div className='year' id={id} href={href}>
      {year}
    </div>`
