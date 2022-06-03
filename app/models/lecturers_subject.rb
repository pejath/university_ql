class LecturersSubject < ApplicationRecord
  belongs_to :lecturer
  belongs_to :subject

  validates :lecturer_id, numericality: {only_integer: true}, presence: true, uniqueness: { scope: :subject_id }

end
