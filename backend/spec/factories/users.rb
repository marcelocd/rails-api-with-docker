FactoryBot.define do
  factory :user do
    username { Faker::Internet.username(specifier: User::MIN_USERNAME_LENGTH..User::MAX_USERNAME_LENGTH) }
    email    { Faker::Internet.email }
    password { Faker::Internet.password(min_length: User::MIN_PASSWORD_LENGTH, max_length: User::MAX_PASSWORD_LENGTH) }
  end
end
