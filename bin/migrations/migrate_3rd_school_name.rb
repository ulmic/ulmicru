User.where(school: 'МОУ Мариинская гимназия').each do |u|
  u.update_attributes! school: 'МБОУ Мариинская гимназия'
end
