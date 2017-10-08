class Group < ApplicationRecord
    acts_as_followable
    has_many :comments, dependent: :destroy
    serialize :scores, Array
end
