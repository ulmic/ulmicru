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
    controller_path.sub('web/admin/', '').classify
  end

  def model_class
    model_name.constantize
  end

  def not_logged_controllers
    [Web::Admin::Delivery::SessionsController]
  end

  def not_logged_attributes
    [:horizontal, :vertical, :avatar, :file, :photo, :main_photo, :image].map &:to_s
  end
end
