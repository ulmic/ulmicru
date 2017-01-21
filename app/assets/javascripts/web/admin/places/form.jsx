import React from 'react'

class PlaceForm extends React.Component {
  constructor(props) {
    super(props)
  }
  render() {
    return <div className='popup' id='place_form'>
        <div className='close'>
          <div className='btn'>
            X
          </div>
        </div>
        <div className='top'>
          <h2>
            Создать место на Foursquare
          </h2>
        </div>
        <div className='form'>
          <form noValidate="noValidate" className="simple_form new_place" id="new_place" action="/api/admin/places" acceptCharset="UTF-8" data-remote="true" method="post"><input name="utf8" type="hidden" value="&#x2713;" />  <div className="input text optional place_title"><textarea className="text optional" placeholder="locale" name="place[title]" id="place_title">
</textarea></div>
            <div className="input text optional place_description"><textarea className="text optional" placeholder="locale" name="place[description]" id="place_description">
</textarea></div>
            <div className="input select optional place_state"><select className="select optional select2" data-prompt="Субъект Российской Федерации" name="place[state]" id="place_state"><option value=""></option>
            <option value="Алтайский край">Алтайский край</option>
            <option value="Амурская область">Амурская область</option>
            <option value="Архангельская область">Архангельская область</option>
            <option value="Астраханская область">Астраханская область</option>
            <option value="Белгородская область">Белгородская область</option>
            <option value="Брянская область">Брянская область</option>
            <option value="Владимирская область">Владимирская область</option>
            <option value="Волгоградская область">Волгоградская область</option>
            <option value="Вологодская область">Вологодская область</option>
            <option value="Воронежская область">Воронежская область</option>
            <option value="Еврейская автономная область">Еврейская автономная область</option>
            <option value="Забайкальский край">Забайкальский край</option>
            <option value="Ивановская область">Ивановская область</option>
            <option value="Иркутская область">Иркутская область</option>
            <option value="Кабардино-балкарская республика">Кабардино-балкарская республика</option>
            <option value="Калининградская область">Калининградская область</option>
            <option value="Калужская область">Калужская область</option>
            <option value="Камчатский край">Камчатский край</option>
            <option value="Карачаево-черкесская республика">Карачаево-черкесская республика</option>
            <option value="Кемеровская область">Кемеровская область</option>
            <option value="Кировская область">Кировская область</option>
            <option value="Костромская область">Костромская область</option>
            <option value="Краснодарский край">Краснодарский край</option>
            <option value="Красноярский край">Красноярский край</option>
            <option value="Курганская область">Курганская область</option>
            <option value="Курская область">Курская область</option>
            <option value="Ленинградская область">Ленинградская область</option>
            <option value="Липецкая область">Липецкая область</option>
            <option value="Магаданская область">Магаданская область</option>
            <option value="Москва">Москва</option>
            <option value="Московская область">Московская область</option>
            <option value="Мурманская область">Мурманская область</option>
            <option value="Ненецкий автономный округ">Ненецкий автономный округ</option>
            <option value="Нижегородская область">Нижегородская область</option>
            <option value="Новгородская область">Новгородская область</option>
            <option value="Новосибирская область">Новосибирская область</option>
            <option value="Омская область">Омская область</option>
            <option value="Оренбургская область">Оренбургская область</option>
            <option value="Орловская область">Орловская область</option>
            <option value="Пензенская область">Пензенская область</option>
            <option value="Пермский край">Пермский край</option>
            <option value="Приморский край">Приморский край</option>
            <option value="Псковская область">Псковская область</option>
            <option value="Республика Адыгея">Республика Адыгея</option>
            <option value="Республика Алтай">Республика Алтай</option>
            <option value="Республика Башкортостан">Республика Башкортостан</option>
            <option value="Республика Бурятия">Республика Бурятия</option>
            <option value="Республика Дагестан">Республика Дагестан</option>
            <option value="Республика Ингушетия">Республика Ингушетия</option>
            <option value="Республика Калмыкия">Республика Калмыкия</option>
            <option value="Республика Карелия">Республика Карелия</option>
            <option value="Республика Коми">Республика Коми</option>
            <option value="Республика Крым">Республика Крым</option>
            <option value="Республика Марий Эл">Республика Марий Эл</option>
            <option value="Республика Мордовия">Республика Мордовия</option>
            <option value="Республика Саха (Якутия)">Республика Саха (Якутия)</option>
            <option value="Республика Северная Осетия — Алания">Республика Северная Осетия — Алания</option>
            <option value="Республика Татарстан">Республика Татарстан</option>
            <option value="Республика Тыва (Тува)">Республика Тыва (Тува)</option>
            <option value="Республика Хакасия">Республика Хакасия</option>
            <option value="Ростовская область">Ростовская область</option>
            <option value="Рязанская область">Рязанская область</option>
            <option value="Самарская область">Самарская область</option>
            <option value="Санкт-Петербург">Санкт-Петербург</option>
            <option value="Саратовская область">Саратовская область</option>
            <option value="Сахалинская область">Сахалинская область</option>
            <option value="Свердловская область">Свердловская область</option>
            <option value="Севастополь">Севастополь</option>
            <option value="Смоленская область">Смоленская область</option>
            <option value="Ставропольский край">Ставропольский край</option>
            <option value="Тамбовская область">Тамбовская область</option>
            <option value="Тверская область">Тверская область</option>
            <option value="Томская область">Томская область</option>
            <option value="Тульская область">Тульская область</option>
            <option value="Тюменская область">Тюменская область</option>
            <option value="Удмуртская республика">Удмуртская республика</option>
            <option value="Ульяновская область">Ульяновская область</option>
            <option value="Хабаровский край">Хабаровский край</option>
            <option value="Ханты-Мансийский автономный округ">Ханты-Мансийский автономный округ</option>
            <option value="Челябинская область">Челябинская область</option>
            <option value="Чеченская республика">Чеченская республика</option>
            <option value="Чувашская республика">Чувашская республика</option>
            <option value="Чукотский автономный округ">Чукотский автономный округ</option>
            <option value="Ямало-Ненецкий автономный округ">Ямало-Ненецкий автономный округ</option>
            <option value="Ярославская область">Ярославская область</option></select></div>
            <div className="input text optional place_latitude"><label className="text optional" htmlFor="place_latitude">Latitude</label><textarea className="text optional" name="place[latitude]" id="place_latitude">
</textarea></div>
            <div className="input text optional place_longitude"><label className="text optional" htmlFor="place_longitude">Longitude</label><textarea className="text optional" name="place[longitude]" id="place_longitude">
</textarea></div>
            <div className="input text optional place_url"><label className="text optional" htmlFor="place_url">Url</label><textarea className="text optional" name="place[url]" id="place_url">
</textarea></div>
            <input type="submit" name="commit" value="Добавить место" className="button" />
            <a className="btn btn-default see_coordinates" href="#">Найти координаты</a>
          </form>
        </div>
      </div>
  }
}

export default PlaceForm
