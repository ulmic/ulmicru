require 'csv'

module Data::ImportMembers
  def upload_members(filepath)
    csv_text = File.read filepath
    csv = CSV.parse csv_text
    hash = {}
    csv.each_with_index do |row, index|
      if index >= 5
        hash[:first_name] = row[1].split(' ')[1] if row[1]
        hash[:last_name] = row[1].split(' ')[0] if row[1]
        hash[:ticket] = row[7].to_i
        hash[:join_date] = row[6].to_date if row[6] && row[6] != '' && row[6] != '?'
        hash[:state] = :unavailable
        member = Member.find_by_ticket hash[:ticket]
        Member.create(hash) unless member
      end
    end
    hash = {}
    parents = []
    csv.each_with_index do |row, index|
      if index >= 5
        names = row[13].split(' ') if row[13] && row[13] != ''
        if names
          if names.count == 2
            names.each_with_index do |name, index|
              members = Member.where(first_name: name)
              if members.any?
                members.each do |m|
                  if m.last_name == names[index * (-1) - 1]
                    parents << names
                    m = Member.find_by_ticket row[7].to_i
                    m.update parent_id: m.id
                  end
                end
              end
            end
          end
        end
      end
    end
    parents
  end
end
