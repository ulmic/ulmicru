require 'xls_exporter'

class Xls::ActivityLines::Lider::YaLider::ParticipantsController < ApplicationController
  before_filter :authenticate_permitted_user!

  def index
    participants = if params[:contest_id].present?
                     ActivityLines::Lider::YaLider.find(params[:contest_id]).participants 
                   else
                     ::ActivityLines::Lider::YaLider::Participant.all
                   end.page(params[:page]).decorate
    ::XlsExport.export do
      filename "participants-#{DateTime.now.strftime('%d.%m.%Y')}.xls"

      add_sheet 'participants'
      fields = [ :reason, :what_is_win_for_you, :quality, :if_i_have_one_million, :one_dream, :hobby, :life_plans ]
      values = fields.map { |f| { f: -> { request_field(f).value } } }
      export_models participants, :id, :first_name, :patronymic, :last_name, :email, :birth_date, :municipality,
        :locality, :school, :mobile_phone, { avatar: -> { small_avatar.url } }, :esse,
        *values
    end
  end
end
