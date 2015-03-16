FactoryGirl.define do
  factory :article do
    title       { generate :string  }
    body        { generate :string  }
    view        nil
    category_id { Category.first.id } 
  end

end
