class NakkitypeInfo < ActiveRecord::Base
  validates :title, :presence => true, :length => {
              :minimum => 2,
              :maximum => 50,
              :too_short => "2 characters is minimum allowed",
              :too_long => "50 characters is maximum allowed"
            }
  validates_uniqueness_of :title
end
