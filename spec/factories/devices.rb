FactoryBot.define do
  factory :device do
    name {Faker::Company.name}
    status {false}
    description {"Device Description"}
    address {Faker::Internet.ip_v4_address}
  end
end
