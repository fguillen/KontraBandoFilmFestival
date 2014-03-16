class AddDataOfBirthToShortFilmUser < ActiveRecord::Migration
  def change
    add_column :short_film_users, :producer_date_of_birth, :date
  end
end
