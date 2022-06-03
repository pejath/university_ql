class Lecturer < ApplicationRecord
  belongs_to :department
  has_many :lectures
  has_many :lecturers_subjects
  has_many :subjects, through: :lecturers_subjects
  has_many :marks, dependent: :nullify
  has_many :groups, through: :lectures
  has_one  :curatorial_group, class_name: 'Group', foreign_key: :curator_id, dependent: :nullify

  validates :name, presence: true
  validates :academic_degree, numericality: {only_integer: true, greater_than: 0, less_than:6}, allow_blank: true

  scope :free_curators, -> (group) { Lecturer.where.missing(:curatorial_group).or(Lecturer.where(curatorial_group:group))}

end
