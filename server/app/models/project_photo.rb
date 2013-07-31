class ProjectPhoto
  include Mongoid::Document
  include Mongoid::Timestamps
  embedded_in :project
  field :url
  validates_presence_of :url
end