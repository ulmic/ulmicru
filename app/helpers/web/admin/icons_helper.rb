module Web::Admin::IconsHelper
  ICONS = {
    removed: :remove,
    closed: :lock,
    unviewed: :inbox,
    active: :asterisk,
    future: 'arrow-circle-o-right',
    past: 'arrow-circle-o-left',
    current: 'dot-circle-o',
    declined: :ban,
    main: :fire,
    confirmed: :asterisk,
    unavailable: 'user-times',
    member_on_the_trial: 'clock-o',
    member_trial_passed: 'thumbs-up',
    sended: 'paper-plane',
    on_vote: 'hand-paper-o',
    inactive: 'eye-slash',
    actual: 'calendar-check-o'
  }
  
  def fa_icon_by_state(state)
    fa_icon ICONS[state]
  end
end
