class Nakkitype < ActiveRecord::Base
  belongs_to :party
  has_many :nakkis, :dependent => :delete_all
  belongs_to :nakkitype_info

  validates :party_id, :presence => true
  validates :nakkitype_info_id, :presence => true
end
