# frozen_string_literal: true

module Types
  class LectureTime < Types::BaseObject
    implements Interfaces::Timestamps

    field :beginning, String, null: false

    # has_many
    field :lectures, [Lecture], null: true
    def lectures
      defer_load_has_many(::Lecture, :lecture_time, object)
    end
  end
end
