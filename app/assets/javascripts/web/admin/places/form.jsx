import React from 'react'

class PlaceForm extends React.Component {
  constructor(props) {
    super(props)
  }
  render() {
    let display = this.props.display
    return <div className='modal fade' id='placeForm' tabindex='-1' role='dialog' aria-labelledby='placeFormLabel'>
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
                <form noValidate="noValidate" className="simple_form new_place" id="new_place" action="/api/admin/places" acceptCharset="UTF-8" data-remote="true" method="post"><input name="utf8" type="hidden" value="&#x2713;" />  
                  <div className="input text optional place_title">
                    <textarea className="text optional" placeholder="locale" name="place[title]" id="place_title">
                    </textarea>
                  </div>
                  <div className="input text optional place_description">
                    <textarea className="text optional" placeholder="locale" name="place[description]" id="place_description">
                    </textarea>
                  </div>
                  <div className="input text optional place_latitude">
                    <label className="text optional" htmlFor="place_latitude">
                      Latitude
                    </label>
                    <textarea className="text optional" name="place[latitude]" id="place_latitude">
                    </textarea>
                  </div>
                  <div className="input text optional place_longitude">
                    <label className="text optional" htmlFor="place_longitude">
                      Longitude
                    </label>
                    <textarea className="text optional" name="place[longitude]" id="place_longitude">
                    </textarea>
                  </div>
                  <div className="input text optional place_url">
                    <label className="text optional" htmlFor="place_url">
                      Url
                    </label>
                    <textarea className="text optional" name="place[url]" id="place_url">
                    </textarea>
                  </div>
                  <input type="submit" name="commit" value="Добавить место" className="button" />
                  <a className="btn btn-default see_coordinates" href="#">Найти координаты</a>
                </form>
              </div>
            </div>
            <div className='modal-footer'>
              <button type='button' className='btn btn-default' data-dismiss='modal'>
                {I18n.t('helpers.links.close')}
              </button>
              <button type='button' className='btn btn-success'>
                {I18n.t('helpers.links.save')}
              </button>
            </div>
          </div>
        </div>
      </div>
  }
}

export default PlaceForm
