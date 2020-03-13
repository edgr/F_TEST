FactoryBot.define do

  factory :contact do
    first_name { 'John' }
    last_name  { 'Doe' }
    email { 'john.doe@gmail.com' }
    phone_number { '123456789' }
  end

  factory :second_contact, parent: :contact do
    first_name { 'Bobby' }
    last_name  { 'Bobson' }
    email { 'bobby.bobson@yahoo.com' }
    phone_number { '123456789' }
  end

  factory :other_contact, parent: :contact do
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
    email { Faker::Internet.email }
    phone_number { Faker::PhoneNumber.phone_number }
  end

end
