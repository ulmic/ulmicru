class LetterForm < ApplicationForm
  attributes :subdivision_code,
             :number,
             :send_date,
             :receiver,
             :title,
             :list_number,
             :annex,
             :state,
             :executor_name,
             required: true
  attributes :executor_id,
             :stamp_of_receipt,
             :note
end
