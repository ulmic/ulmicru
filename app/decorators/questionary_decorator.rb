class QuestionaryDecorator < MemberDecorator
  delegate_all

  def profile_avatar
    object.on_the_trial? ? avatar.profile : default_avatar
  end

  def real_attributes
    [:email, :motto, :mobile_phone, :birth_date, :municipality, :locality, :school, :want_to_do, :experience]
  end

  def sites_attributes
    [:id, :request_date, :member_state, :state, { sign_in_count: -> { logged_actions_with(action_type: :sign_in).count } }]
  end

  def self.collections
    [ :on_the_trial, :unviewed, :declined, :member_trial_passed ]
  end
end
