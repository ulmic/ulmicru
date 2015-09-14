class LetterForm < ApplicationForm
  attributes :subdivision_code,
             :number,
             :send_date,
             :receiver,
             :title,
             :list_number,
             :annex,
             :stamp_of_receipt,
             :note,
             :state,
             :executor_name,
             required: true
  attributes :executor_id
end
