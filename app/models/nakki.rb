class Nakki < ActiveRecord::Base
  belongs_to :user
  belongs_to :nakkitype

  validates :slot, :presence => true, :numericality => {
    :only_integer => true,
    :greater_than_or_equal_to => 0
  }
  validates :nakkitype_id, :presence => true
end
