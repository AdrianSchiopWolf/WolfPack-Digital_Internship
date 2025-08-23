# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    username { Faker::Internet.unique.username }
    email { Faker::Internet.unique.email }
    password { 'Password1@#' }
  end

  trait :admin do
    role { 'admin' }
  end
end
