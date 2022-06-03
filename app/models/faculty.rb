class Faculty < ApplicationRecord
  has_many :departments
  has_many :lecturers, through: :departments

  validates :name, presence: true, uniqueness: true
  validates_format_of :formation_date, presence: true, with: /\A\d{0,4}.\d{0,2}.\d{0,2}\z/
end
