class ShortFilmUser < ActiveRecord::Base
  acts_as_authentic do |c|
    c.email_field = :producer_email
    c.validate_email_field = false
  end

  FORMATS = [
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
  validates :length_seconds, :presence => true
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
    :front => "215x",
    :front_big => "710x",
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

end
