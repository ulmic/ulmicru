class Web::Admin::ApplicationController < Web::ApplicationController
  before_filter :authenticate_permitted_user!
  before_filter :check_declared_scopes, only: :index
  before_filter :collections_counts, only: :index
  before_action :save_object, only: [ :update, :destroy ]
  after_action :log_action, only: [ :create, :update, :destroy, :restore ]

  layout 'web/admin/application'

  include ModelsConcern
  include Concerns::DecoratorsConcern
  include Concerns::LoggedActions

  RECORDS_PER_PAGE = 25

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

  def collection_page(record, current_collection)
    index = record.class.send(current_collection).map(&:id).index(record.id)
    if index && index > 25
      index % RECORDS_PER_PAGE == 0 ? index / RECORDS_PER_PAGE : index / RECORDS_PER_PAGE + 1
    else
      1
    end
  end

  def pre_build_record(record)
    params[model_name.underscore]&.each do |attr, value|
      record.send "#{attr}=", value
    end
    record
  end
end
