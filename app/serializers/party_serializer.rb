class PartySerializer < ActiveModel::Serializer
  attributes :id, :title, :date, :info_date, :description, :aux_jobs_enabled
end
