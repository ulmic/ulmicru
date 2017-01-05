FactoryGirl.define do
  factory 'test_paper/question', class: 'TestPaper::Question' do
    text { generate :string }
    test_paper_id { TestPaper.last ? TestPaper.last.id : create(:test_paper).id }
    question_type { TestPaper.question_type.values.sample }
  end
end
