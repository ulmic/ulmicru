class LoggedAction < ActiveRecord::Base
  belongs_to :user
  belongs_to :record, polymorphic: true

  extend Enumerize
  enumerize :action_type, in: [ :create, :update, :destroy, :sign_in, :sign_out, :restore, :delete ]

  def parsed_params
    # FIXME with PG 9.4 and jsonb
    eval params
  end
end
