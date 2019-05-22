FactoryBot.define do
  factory :notification do
    device_id {nil}
    message {"MyString"}
    status {false}
    read {false}
  end
end
