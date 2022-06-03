class LectureTime < ApplicationRecord
  has_many :lectures

  validates :beginning, presence: true, uniqueness: true
  validates_format_of :beginning, with: /([0-1]?[0-9]|2[0-3]):[0-5][0-9]/

  def formatted_time
    beginning.strftime("%H:%M")
  end
end
