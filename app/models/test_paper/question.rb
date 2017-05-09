class TestPaper::Question < ActiveRecord::Base
  belongs_to :test_paper

  include StateMachine::Scopes
  extend Enumerize
  enumerize :question_type, in: [ :text, :some_variants, :one_variant, :date, :member, :number, :position ]

  state_machine :state, initial: :active do
    state :active
    state :removed
  end
end
