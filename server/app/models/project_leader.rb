class ProjectLeader
  include Mongoid::Document
  include Mongoid::Timestamps
  embedded_in :project
  field :name
  field :contact_number
  validates_presence_of :name
end