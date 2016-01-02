# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user do
    password 'password'
    password_confirmation 'password'
    role "user"

    sequence :name do |n| 
      "user#{n}"
    end
    
    sequence :nick do |n| 
      "user#{n}"
    end
    
    sequence :email do |n| 
      "user#{n}@example.com"
    end

    number "040123456"
  end

  factory :admin, class: User do
    password 'password'
    password_confirmation 'password'
    role "admin"

    sequence :name do |n| 
      "user#{n}"
    end
    
    sequence :nick do |n| 
      "user#{n}"
    end
    
    sequence :email do |n| 
      "user#{n}@example.com"
    end

    number "040123456"
  end
end
