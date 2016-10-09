module Web::Admin::IconsHelper
  ICONS = {
    removed: :remove,
    closed: :lock,
    unviewed: 'info-circle',
    active: :fire
  }
  
  def fa_icon_by_state(state)
    fa_icon ICONS[state]
  end
end
