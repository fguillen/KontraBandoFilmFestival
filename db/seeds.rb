# coding: utf-8

ActiveRecord::Base.transaction do
  4.times do |index|
    short_film_user =
      ShortFilmUser.create!(
        :title => Faker::Lorem.sentence,
        :synopsis => Faker::Lorem.paragraphs.join("\n"),
        :length_minutes => 10,
        :length_seconds => 30,
        :language => :spanish,
        :genre => :action,
        :credits_direction => Faker::Lorem.word,
        :producer_name => Faker::Lorem.word,
        :producer_dni => "111222333",
        :producer_fecha_of_birth => Date.parse("1990-01-02"),
        :producer_phone => "111222333",
        :producer_email => "producer_#{index}@email.com",
        :password => "pass",
        :password_confirmation => "pass",
        :thumbnail => File.open("#{Rails.root}/test/fixtures/pic.jpg")
      )

    puts "Created short_film_user [#{short_film_user.id}] – #{short_film_user.producer_email}"
  end

  email = "admin@email.com"
  password = "pass"
  admin_user =
    AdminUser.create!(
      :name => "Super Admin",
      :email => email,
      :password => password,
      :password_confirmation => password
    )

  puts "AdminUser created #{email}/#{password}"
end