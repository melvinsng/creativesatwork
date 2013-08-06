class JobCategory
  include Mongoid::Document
  has_many :freelancers
  has_many :projects
  field :name
end