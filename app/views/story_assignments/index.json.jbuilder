# frozen_string_literal: true

json.array!(@story_assignments, partial: 'story_assignments/story_assignment',
                                as: :story_assignment)
