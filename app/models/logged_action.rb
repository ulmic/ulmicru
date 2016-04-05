class LoggedAction < ActiveRecord::Base
  belongs_to :user
  belongs_to :record

  extend Enumerize
  enumerize :action_type, in: [ :create, :update, :destroy, :sign_in, :sign_out, :restore ]

  def parsed_params
    JSON.parse params
  end
end
