class Student < ApplicationRecord
  belongs_to :group
  has_many :marks, dependent: :destroy
  has_many :subjects, through: :marks

  accepts_nested_attributes_for :marks, allow_destroy: true

  validates :name, presence: true

  scope :red_diplomas, -> { Student.joins(:marks, :group).group(:id).having('AVG(marks.mark) >= 4.5').where('groups.course = 5')}

  def average_mark
    Mark.where('student_id = ?', id).average('mark').to_f.round(2)
  end
end