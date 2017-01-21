import React from 'react'

var input = function(attribute) {
   return <div className={`input string required place_${attribute} form-group`}>
     <label className="string required" htmlFor={`place_${attribute}`}>
       <abbr title="required">
         *
       </abbr>
       {I18n.t(`activerecord.attributes.place.${attribute}`)}
     </label>
     <input type="text" className="string required form-control" placeholder={I18n.t(`activerecord.attributes.place.${attribute}`)} name={`place[${attribute}]`} id={`place_${attribute}`}/>
   </div>
}

class PlaceForm extends React.Component {
  constructor(props) {
    super(props)
  }
  render() {
    let display = this.props.display
    return <div className='modal fade' id='placeForm' tabIndex='-1' role='dialog' aria-labelledby='placeFormLabel'>
        <div className='modal-dialog' role='document'>
          <div className='modal-content'>
            <div className='modal-header'>
              <button type='button' className='close' data-dismiss='modal' aria-label='Close'>
                <span aria-hidden='true'>
                  &times;
                </span>
              </button>
              <h4 className='modal-title' id='placeFormLabel'>
                {I18n.t('web.admin.events.form.add_place')}
              </h4>
            </div>
            <div className='modal-body'>
              <div className='form'>
                <form noValidate="noValidate" className="simple_form new_place" id="new_place" action="/api/admin/places" acceptCharset="UTF-8" data-remote="true" method="post">
                  <input name="utf8" type="hidden" value="&#x2713;" />  
                  <div className="alert alert-dismissible alert-info">
                    <i className="fa fa-info-circle"></i>
                    {I18n.t('hints.admin.places.form.url')}
                  </div>
                  {input("title")}
                  {input("description")}
                  {input("url")}
                  <input type="submit" name="commit" value="Добавить место" className="btn btn-success" />
                </form>
                <a href="https://maps.google.com" className='btn btn-info' target='_blank'>
                  <i className='fa fa-google'></i>
                </a>
                <a href="https://maps.yandex.ru" className='btn btn-info' target='_blank'>
                  <b>
                    Я
                  </b>
                </a>
                <a href="https://foursquare.com" className='btn btn-info' target='_blank'>
                  <i className='fa fa-foursquare'></i>
                </a>
              </div>
            </div>
            <div className='modal-footer'>
              <button type='button' className='btn btn-default' data-dismiss='modal'>
                {I18n.t('helpers.links.close')}
              </button>
            </div>
          </div>
        </div>
      </div>
  }
}

export default PlaceForm
