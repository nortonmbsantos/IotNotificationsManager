class Device < ApplicationRecord
    validates_presence_of :name
    validates_inclusion_of :status, in: [true, false]
    validates_presence_of :description
    validates_presence_of :address
end
