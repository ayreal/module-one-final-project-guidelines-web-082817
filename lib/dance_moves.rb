class DanceMove < ActiveRecord::Base
  belongs_to :turns
  has_many :dancers, through: :turns
end
