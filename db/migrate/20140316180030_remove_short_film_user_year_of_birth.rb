class RemoveShortFilmUserYearOfBirth < ActiveRecord::Migration
  def change
    remove_column :short_film_users, :producer_year_of_birth, :integer
  end
end
