ActivityLines::Lider::YaLider.where(contest_number: 15).first.participants.each do |p|
  Token.create! content: SecureHelper.generate_token, record_type: 'ActivityLines::Lider::YaLider::Participant', record_id: p.id
end
