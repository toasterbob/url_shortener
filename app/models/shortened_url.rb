class ShortenedUrl < ActiveRecord::Base
  validates :short_url, uniqueness: true
  validates :long_url, :user_id, :short_url, presence: true

  belongs_to :submitter,
    primary_key: :id,
    foreign_key: :user_id,
    class_name: :User

  has_many :visits,
    primary_key: :id,
    foreign_key: :short_url_id,
    class_name: :Visit

  has_many :visitors,
  Proc.new { distinct },
  #-> { distinct } #same thing
    through: :visits,
    source: :user

  def self.random_code
    s = SecureRandom.urlsafe_base64(16)
    s = SecureRandom.urlsafe_base64(16) while ShortenedUrl.exists?(short_url: s)
    s
  end

  def self.create_for_user_and_long_url!(user, long_url)
    ShortenedUrl.create!(:long_url => long_url, :short_url => ShortenedUrl.random_code, user_id: user.id)
  end

  def num_clicks
    self.visits.count
  end

  def num_uniques
    self.visitors.count 
    # self.visits.select(:user_id).uniq.count
  end

  def num_recent_uniques
    self.visits.where("created_at > ?", 10.minutes.ago).select(:user_id).uniq.count
  end
end
