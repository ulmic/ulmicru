class LoggedAction < ActiveRecord::Base
  belongs_to :user
  belongs_to :record, polymorphic: true

  extend Enumerize
  enumerize :action_type, in: [ :create, :update, :destroy, :sign_in, :sign_out, :restore, :delete ]

  include PgSearch
  pg_search_scope :search_everywhere, against: [:action_type, :record_type, :record_id, :user_id],
    associated_against: {
      user: [ :first_name, :patronymic, :last_name, :ticket ]
    }

  def parsed_params
    # FIXME with PG >9.4 and jsonb
    params.present? ? eval(params).with_indifferent_access : {}
  end
end
