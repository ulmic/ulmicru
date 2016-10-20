module ModelsConcern
  #хорошие имена функций, правда!)) Цените!!
  def trash_models
    [ :user, :member, :questionary, :news, :category, :article,
      :activity_line, :banner, :document, :team ]
  end

  def trash_modules
    [ :activity_lines, :corporative, :confession ]
  end

  def model_name
    namespaces = ['web/admin/', 'web/members/']
    namespaces.reduce(controller_path) do |name, namespace|
      name = name.sub namespace, ''
    end.classify
  end

  def model_class
    if take_member_action?
      Member
    else
      case model_name
      when 'Corporative::Petition'
        ActivityLines::Corporative::Confession
      else
        model_name.constantize
      end
    end
  end

  def not_logged_controllers
    [Web::Admin::Delivery::SessionsController]
  end

  def not_logged_attributes
    [:horizontal, :vertical, :avatar, :file, :photo, :main_photo, :image, :created_at, :updated_at, :google_calendar_event_id, :_destroy].map &:to_s
  end

  # Принять в организацию
  def take_member_action?
    model_name == 'Questionary' && params[:questionary] == {"member_state"=>"confirmed"}
  end
end
