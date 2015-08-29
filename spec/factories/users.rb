FactoryGirl.define do
  factory :user do
    name "Elijah the Tishbite"
    email "elijah@heaven.net"
    password "12345678"
    password_confirmation "12345678"
    active true
    confirmed_at Time.now
  end

end
