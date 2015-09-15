require 'csv'

module Data::ImportLetters
  def upload_letters(filepath)
    csv_text = File.read filepath
    csv = CSV.parse csv_text
    csv.drop(1).each_with_index do |row, index|
      letter_count = Letter.count
      letter = Letter.create subdivision_code: row[0],
                    number: row[1],
                    send_date: row[3],
                    receiver: receiver(row[4]),
                    title: title(row[5]),
                    list_number: row[6],
                    annex: row[7],
                    executor_id: executor_id(row[8]),
                    executor_name: row[8],
                    stamp_of_receipt: row[9],
                    note: row[10]
      raise [letter.errors.inspect, row].inspect if letter_count == Letter.count
    end
  end

  private

  def executor_id(row)
    if row
      last_name = row.split(' ')[0]
      first_name_initial = row.split('.')[0].split(' ')[1]
      second_initial = row.split('.')[1]
      patronymic_initial = second_initial.gsub(/\s+/, '') if second_initial
      members = Member.where last_name: last_name
      if patronymic_initial
        members.each do |member|
          return member.id if first_name_initial == member.first_name && patronymic_initial == member.patronymic
        end
      end
      nil
    end
  end

  def title(row)
    row.present? ? row : 'Пустая тема'
  end

  def receiver(row)
    row.present? ? row : 'Пустой получатель'
  end
end
