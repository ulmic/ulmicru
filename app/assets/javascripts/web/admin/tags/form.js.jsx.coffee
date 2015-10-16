@TagsForm = React.createClass
  render: ->
    `<div class='btn-toolbar'>
      <div class='btn-group tag-buttons'>
        <a class="btn btn-xs btn-success" data-tag-type="string" href="#">
         <span class='glyphicon glyphicon-font'></span>
        </a>
        <a class="btn btn-xs btn-success" data-tag-type="link" data-target-type="Member" href="#"><span class='glyphicon glyphicon-user'></span>
        </a>
        <a class="btn btn-xs btn-success" data-tag-type="link" data-target-type="Event" href="#"><span class='glyphicon glyphicon-calendar'></span>
        </a>
        <a class="btn btn-xs btn-success" data-tag-type="link" data-target-type="ActivityLine" href="#"><span class='glyphicon glyphicon-flag'></span>
        </a>
        <a class="btn btn-xs btn-success" data-tag-type="link" data-target-type="Team" href="#"><span class='glyphicon glyphicon-bullhorn'></span>
        </a>
      </div>
    </div>`
