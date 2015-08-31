class Page < ActiveRecord::Base
  extend FriendlyId
  friendly_id :title, use: [:slugged, :history]
  validates :title, presence: true, length: { minimum: 3, maximum: 50 }
  validates :content, presence: true, length: { minimum: 42 }

  def normalize_friendly_id(text)
    text.to_slug.normalize(transliterations: :bulgarian).to_s
  end
end
