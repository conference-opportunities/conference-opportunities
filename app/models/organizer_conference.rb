class OrganizerConference < ActiveRecord::Base
  belongs_to :organizer
  belongs_to :conference
end
