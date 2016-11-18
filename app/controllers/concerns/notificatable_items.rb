module Concerns
  module NotificatableItems
    def self.items(current_user_id)
      types = [ :member, :questionary, :news, :event, :feedback, :comment, :article, :position, :team, :activity_lines_corporative_confession ]
      types.map do |type|
        type if Organization::Permissions.send(type)[:review].map(&:id).include?(current_user_id)
      end.compact
    end
  end
end
