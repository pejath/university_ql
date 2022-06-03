class Mark < ApplicationRecord
  belongs_to :student
  belongs_to :subject
  belongs_to :lecturer, optional: true

  validates :mark, numericality: {only_integer: true, greater_than: 0, less_than:6}, presence: true


end
