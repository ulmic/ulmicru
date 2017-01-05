class TestPaper::Question < ActiveRecord::Base
  belongs_to :test_paper

  extend Enumerize
  enumerize :question_type, in: [ :text, :some_variants, :one_variant, :date, :member, :number, :position ]
end
