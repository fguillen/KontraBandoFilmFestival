class ShortFilmUser < ActiveRecord::Base
  acts_as_authentic do |c|
    c.email_field = :producer_email
    c.validate_email_field = false
  end

  GENRES = [
    :action,
    :adventure,
    :comedy,
    :crime,
    :erotica,
    :faction,
    :fantasy,
    :historical,
    :horror,
    :mystery,
    :paranoid,
    :philosophical,
    :political,
    :romance,
    :saga,
    :satire,
    :science_fiction,
    :slice_of_life,
    :specultative,
    :thriller,
    :urban
  ]

  LANGUAGES = [
    :english,
    :spanish,
    :catalonian
  ]

  strip_attributes
  log_book

  attr_protected nil

  validates :title, :presence => true
  validates :length_minutes, :presence => true
  # validates :length_seconds, :presence => true
  validates :language, :presence => true
  validates :genre, :presence => true
  validates :credits_direction, :presence => true

  validates :synopsis, :presence => true
  validates :producer_name, :presence => true
  validates :producer_dni, :presence => true
  validates :producer_year_of_birth, :presence => true
  validates :producer_phone, :presence => true
  validates :producer_email, :presence => true
  validates :producer_email, :uniqueness => true, :format => { :with => RubyRegex::Email }

  validates :thumbnail, :attachment_presence => true

  ATTACH_STYLES = {
    :front => "205x126#",
    :front_medium => "287x177#",
    :front_big => "600x",
    :admin => "303x203#"
  }

  # TODO: ugly! the point is that in test we don't use S3 so it needs another config
  if APP_CONFIG[:s3_credentials]
    has_attached_file(
      :thumbnail,
      :styles => ATTACH_STYLES,
      :storage => :s3,
      :s3_credentials => APP_CONFIG[:s3_credentials],
      :path => "/assets/uploads/:rails_env/:id/:style.:extension",
    )
  else
    has_attached_file(
      :thumbnail,
      :styles => ATTACH_STYLES,
      :url => "/assets/uploads/:rails_env/:id/:style.:extension",
      :path => ":rails_root/public:url"
    )
  end

  def to_param
    "#{id}-#{title.to_url}"
  end

  def duration
    "%02d:%02d" % [length_minutes, length_seconds]
  end

  # Yep!, I know this can be optimized :)
  def previous
    short_film_users = ShortFilmUser.all
    index = short_film_users.find_index(self)
    index > 0 ? short_film_users[index - 1] : nil
  end

  def next
    short_film_users = ShortFilmUser.all
    index = short_film_users.find_index(self)
    index < (short_film_users.length - 1) ? short_film_users[index + 1] : nil
  end

end
