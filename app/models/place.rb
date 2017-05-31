class Place < ApplicationRecord
  belongs_to :user
  has_many :comments, dependent: :destroy
  has_many :photos

  geocoded_by :address
  after_validation :geocode

  validates :name, presence: true, length: { maximum: 50, minimum: 3 }
  validates :address, presence: true, format: { with: /\A[\w\s\-\.]+, San Francisco, CA \d\d\d\d\d\s*\z/,
                                                message: 'Enter address as XXXXX, San Francisco, CA XXXXX'}
  validates :place_type, presence: true
  validates :description, presence: true, length: { maximum: 280 }
  validates :phone, allow_blank: true, format: { with: /\A\d\d\d\-\d\d\d-\d\d\d\d\z/,
                                       message: 'Enter number as XXX-XXX-XXXX'}
  validates :url, allow_blank: true, format: { with: /\A[A-Za-z]+\.[\w-]+\.[A-Za-z]+\z|\A[\w-]+\.[A-Za-z]+\z/,
                                     message: 'Not a valid URL'}

  # will_paginate gem
  self.per_page = 10
end
