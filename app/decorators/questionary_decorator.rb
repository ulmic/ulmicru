class QuestionaryDecorator < MemberDecorator
  delegate_all

  def profile_avatar
    object.on_the_trial? ? avatar.profile : default_avatar
  end
end
