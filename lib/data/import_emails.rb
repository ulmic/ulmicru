require 'csv'

module Data::ImportEmails
  def upload_emails(filepath)
    csv_text = File.read filepath
    csv = CSV.parse csv_text
    csv.each_with_index do |row, index|
      contact_email = Delivery::ContactEmail.new email: row[0], first_name: row[1].gsub(' ', ''), last_name: row[2].gsub(' ', '')
      contact_email.save
      #raise [row, contact_email.errors].inspect unless contact_email.save
      print "#{index} of #{csv.count}\r"
    end
    puts 'Done!'
  end
end
