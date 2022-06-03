class Group < ApplicationRecord
  FORM_OF_EDUCATION = [%w[evening evening], %w[correspondence correspondence], ['full time', 'full_time']]

  enum form_of_education: { evening: 0, correspondence: 1, full_time: 2 }

  belongs_to :department
  belongs_to :curator, class_name: 'Lecturer', foreign_key: :curator_id, optional: true

  has_many :lectures, dependent: :destroy
  has_many :lecturers, through: :lectures
  has_many :subjects, through: :lectures


  validates :form_of_education, inclusion: { in: %w[evening correspondence full_time 0 1 2], message: 'is not valid form' }
  validates :specialization_code, :curator_id, presence: true, numericality: {only_integer: true }, uniqueness: true
  validates :course, presence: true, numericality: { only_integer: true, greater_than: 0, less_than:6}

  def form_of_education=(value)
    super
  rescue ArgumentError
    @attributes.write_cast_value('form_of_education', value)
  end
end
