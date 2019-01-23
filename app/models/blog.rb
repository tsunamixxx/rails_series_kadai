class Blog < ApplicationRecord
  validates :title, presence: true
  validates :content, length: { in: 1..140 }
  # バリデーションについて
  # https://client.diveintocode.jp/curriculums/557

  belongs_to :user

  has_many :favorites, dependent: :destroy
  has_many :favorite_users, through: :favorites, source: :user
end
