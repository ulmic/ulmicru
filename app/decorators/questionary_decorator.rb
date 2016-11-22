class QuestionaryDecorator < MemberDecorator
  delegate_all

  def profile_avatar
    object.on_the_trial? ? avatar.profile : default_avatar
  end

  def real_attributes
    [:email, :corporate_email, :motto, :mobile_phone, :birth_date, :municipality, :locality, :school, :want_to_do, :experience]
  end

  def sites_attributes
    [:id, :request_date, :member_state, :state, { sign_in_count: -> { logged_actions_with(action_type: :sign_in).count } }]
  end

  def short_name_link
    short_name
  end

  def avatar_small_img
    h.content_tag :img, class: :avatar, src: object.avatar.small do
    end
  end

  def ticket_number
    h.content_tag :span, 'data-tooltip' => true, 'aria-haspopup' => true, class: 'has-tip', title: t('tooltip.questionary.ticket_number') do 
      fa_icon 'question-circle 2x'
    end
  end

  def self.collections
    [ :member_on_the_trial, :member_changes_expectation,  :unviewed, :declined, :member_trial_passed ]
  end
end
