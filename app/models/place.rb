class Place < ApplicationRecord
  belongs_to :user
  has_many :comments

  geocoded_by :address
  after_validation :geocode

  validates :name, presence: true, length: { maximum: 50, minimum: 3 }
  validates :address, presence: true, length: { maximum: 140 }
  validates :description, presence: true, length: { maximum: 280 }

  # will_paginate gem
  self.per_page = 10
end
