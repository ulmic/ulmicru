module Concerns
  module RegistrationWithLogs
    def get_registrations_with_logs(registrations)
      @registrations = {}
      registrations.each do |registration|
        @registrations[registration] = ''
        registration.event.logged_actions.each do |logged_action|
          if logged_action.parsed_params.present?
            logged_action.parsed_params.each do |param|
              if added_nested_attribute?(param, :registrations) && added_nested_attribute_id(param) == registration.id
                @registrations[registration] = logged_action
                break
              end
            end
          end
        end
      end
    end
  end
end
