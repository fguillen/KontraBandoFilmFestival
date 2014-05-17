class ChangeShortFilmUserColumnProducerToDirector < ActiveRecord::Migration
  def change
    rename_column :short_film_users, :producer_name, :director_name
    rename_column :short_film_users, :producer_dni, :director_dni
    rename_column :short_film_users, :producer_phone, :director_phone
    rename_column :short_film_users, :producer_email, :director_email
    rename_column :short_film_users, :producer_date_of_birth, :director_date_of_birth
  end
end
