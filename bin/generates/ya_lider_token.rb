current_ya_lider = ActivityLines::Lider::YaLider.where(state: :active,
                                                       contest_year: (DateTime.now.month > 8 ? DateTime.now.year + 1 : DateTime.now.year)).first
if current_ya_lider.tokens.any?
  raise "You have already generated token".inspect
else
  Token.create! record_id: current_ya_lider.id, record_type: 'ActivityLines::Lider::YaLider', 
    content: SecureHelper.generate_token
end
