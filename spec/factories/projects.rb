FactoryBot.define do
  factory :project do
    name { FFaker::Name.name }
    init { Date.today } 
    add_attribute(:end) { Date.today.end_of_year} 
  end
end
