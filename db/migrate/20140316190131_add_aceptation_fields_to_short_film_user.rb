class AddAceptationFieldsToShortFilmUser < ActiveRecord::Migration
  def change
    add_column :short_film_users, :accept_authenticity, :boolean
    add_column :short_film_users, :accept_authorization, :boolean
    add_column :short_film_users, :accept_responsability, :boolean
  end
end
