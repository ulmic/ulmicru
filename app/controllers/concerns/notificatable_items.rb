module Concerns
  module NotificatableItems
    def self.items(current_user_id)
      types = [ :member, :questionary, :news, :event, :feedback, :comment, :article, :position, :team, 'activity_lines/corporative/confession' ]
      types.map do |type|
        type if Organization::Permissions.send(type.to_s.gsub('/', '_'))[:review].map(&:id).include?(current_user_id)
      end.compact
    end
  end
end
