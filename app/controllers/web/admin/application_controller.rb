class Web::Admin::ApplicationController < Web::ApplicationController
  before_filter :authenticate_admin!
  before_filter :check_declared_scopes, only: :index
  before_filter :collections_counts, only: :index
  before_action :save_object
  after_action :log_action, only: [ :create, :update, :destroy ]

  layout 'web/admin/application'

  include ModelsConcern
  include Concerns::DecoratorsConcern
  include Concerns::ParamsComparingConcern

  protected

  def choose_users
    @users = User.presented.decorate
  end

  def check_declared_scopes
    if params[:scope].present?
      if !model_class.scopes.map(&:to_s).include?(params[:scope])
        redirect_to params.except(:scope)
      end
    else
      params[:scope] ||= decorator_class.collections.first
    end
  end

  def collections_counts
    @counts = {}
    decorator_class.collections.each do |collection|
      @counts[collection] = model_class.send(collection).count
    end
  end

  def save_object
    @prev_object = model_class.find params[:id]
  end

  def log_action
    LoggedAction.create! user_id: current_user.id,
			 record_type: model_class.name,
			 record_id: params[:id],
			 action_type: action_name,
			 params: attributes_diff(model_class.find(params[:id]).attributes, params[model_class.name.underscore], @prev_object.attributes)
  end
end
