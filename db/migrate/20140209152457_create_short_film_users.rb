class CreateShortFilmUsers < ActiveRecord::Migration
  def change
    create_table :short_film_users do |t|
      t.string :title, :null => false
      t.integer :length_minutes, :null => false
      t.integer :length_seconds, :null => false
      t.string :language, :null => false
      t.text :script_embed
      t.string :subtitles_language
      t.string :genre, :null => false
      t.string :credits_direction, :null => false
      t.string :credits_script
      t.string :credits_camera
      t.string :credits_art_direction
      t.string :credits_editing
      t.string :credits_music
      t.string :credits_other
      t.string :credits_actors
      t.text :synopsis, :null => false
      t.string :producer_name, :null => false
      t.string :producer_dni, :null => false
      t.string :producer_year_of_birth, :null => false
      t.string :producer_phone, :null => false
      t.string :producer_email, :null => false
      t.string :school_name

      # authlogic
      t.string :crypted_password
      t.string :password_salt
      t.string :persistence_token
      t.string :perishable_token

      # paperclip
      t.attachment :thumbnail

      t.timestamps
    end
  end
end
