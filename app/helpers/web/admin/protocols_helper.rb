module Web::Admin::ProtocolsHelper
  def protocol_color(protocol)
    if protocol.document_id.present? && protocol.scan.present? && protocol.attenders.count > 0 && protocol.absents.count > 0
      :success
    else
      :danger
    end
  end
end
