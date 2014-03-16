class AddTutorFieldsToShortFilmUser < ActiveRecord::Migration
  def change
    add_column :short_film_users, :tutor_kind, :string
    add_column :short_film_users, :tutor_name, :string
    add_column :short_film_users, :tutor_dni, :string
    add_column :short_film_users, :tutor_phone, :string
    add_column :short_film_users, :tutor_email, :string
  end
end
