class Notification < ApplicationRecord
  belongs_to :device, optional: true
  validates_presence_of :message
  validates_inclusion_of :status, in: [true, false]
  validates_inclusion_of :read, in: [true, false]

end
