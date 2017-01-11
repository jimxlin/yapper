class Place < ApplicationRecord
  belongs_to :user

  # will_paginate gem
  self.per_page = 10
end
