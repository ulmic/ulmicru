module Web::Admin::ProtocolsHelper
  def protocol_color(protocol)
    if protocol.document_id.present?
      :success
    else
      :danger
    end
  end
end
