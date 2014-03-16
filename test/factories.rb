FactoryGirl.define do
  factory :admin_user do
    sequence(:name) { |n| "AdminUser Name #{n}" }
    sequence(:email) { |n| "email#{n}@email.com" }
    password "pass"
    password_confirmation "pass"
  end

  factory :log_book_event, :class => LogBook::Event  do
    text "Wadus Event"
  end

  factory :short_film_user do
    title "Short Film Title"
    length_minutes 10
    length_seconds 20
    genre "action"
    language "spanish"
    credits_direction "Director Name"
    synopsis "The Synopsis"
    producer_name "The Producer Name"
    producer_dni "The Producer DNI"
    producer_date_of_birth "1990-01-01"
    producer_phone "9191919191"
    sequence(:producer_email) { |n| "producer_#{n}@email.com" }
    accept_authenticity true
    accept_authorization true
    accept_responsability true

    password "pass"
    password_confirmation "pass"

    thumbnail { File.new("#{Rails.root}/test/fixtures/pic.jpg") }
  end
end