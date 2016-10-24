module Concerns
  module NotificatableItems
    def self.items(current_user_id)
      types = [ :member, :questionary, :news, :event, :feedback, :comment, :article, :position, :team ]
      types.map do |type|
        type if Organization::Permissions.send(type)[:need_to_review].include?(current_user_id)
      end.concat
    end
  end
end
