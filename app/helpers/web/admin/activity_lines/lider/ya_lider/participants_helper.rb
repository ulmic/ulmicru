module Web::Admin::ActivityLines::Lider::YaLider::ParticipantsHelper
  def stage_tab_class(participation, index)
    if (params[:stage].nil? && index == 0) || params[:stage].to_i == participation.stage.number
      :active
    end
  end
end
