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
        hash[:patronymic] = row[1].split(' ')[2] if row[1]
        hash[:ticket] = row[7].to_i
        hash[:email] = row[10].match /[a-zA-Z0-9]+*@[a-zA-Z0-9]+*\.[a-zA-Z0-9]+*/ if row[10]
        hash[:join_date] = row[6].to_date if row[6] && row[6] != '' && row[6] != '?'
        hash[:state] = :unavailable
        member = Member.find_by_ticket hash[:ticket]
        Member.create(hash) unless member
      end
    end
    hash = {}
    parents_count = 0
    exists_parents_count = 0
    exceptions = []
    csv.each_with_index do |row, index|
      if index >= 5
        names = row[13].split(' ') if row[13] && row[13] != '' && row[13] != ' '
        if names
          parents_count += 1
          change = exists_parents_count
          if names.count == 2
            Member.all.each do |member|
              name = "#{member.first_name} #{member.last_name}"
              reverse_name = "#{member.last_name} #{member.first_name}"
              if name == row[13] || reverse_name == row[13]
                child = Member.find_by_ticket row[7]
                child.update parent_id: member.id if child
                exists_parents_count += 1
                break
              end
            end
          elsif names.count == 3
            Member.all.each do |member|
              name = "#{member.first_name} #{member.patronymic} #{member.last_name}"
              reverse_name = "#{member.last_name} #{member.first_name} #{member.patronymic}"
              if name == row[13] || reverse_name == row[13]
                child = Member.find_by_ticket row[7]
                child.update parent_id: member.id
                exists_parents_count += 1
                break
              end
            end
          end
          if exists_parents_count == change
            exceptions << row[13]
          end
        end
      end
    end
    [parents_count, exists_parents_count, exceptions]
  end

  def update_emails(filepath)
    csv_text = File.read filepath
    csv = CSV.parse csv_text
    csv.each_with_index do |row, index|
      if index >= 5
        ticket = row[7].to_i
        email = row[10].match /[a-zA-Z0-9]+*@[a-zA-Z0-9]+*\.[a-zA-Z0-9]+*/ if row[10]
        m = Member.find_by_ticket ticket
        if m.present?
          m.email = email
          m.save
        end
      end
    end
  end
end
