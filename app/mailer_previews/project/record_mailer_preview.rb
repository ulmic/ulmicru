class Project::RecordMailerPreview
  def create
    user = OpenStruct.new email: (@email || 'example@ulmic.ru'), 
      first_name: (@first_name || 'Leopold'), 
      last_name: (@last_name || 'Botov')
    record = Project::Record.new properties: { last_name: 'Botov', first_name: 'Leopold', email: 'example@email.com', phone: '+79603727201' }
    Project::RecordMailer.create record, user
  end

  def confirm
    record = Project::Record.new properties: { last_name: 'Botov', first_name: 'Leopold', email: 'example@email.com', phone: '+79603727201' }
    Project::RecordMailer.confirm record, record
  end
end
