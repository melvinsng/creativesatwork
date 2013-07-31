class JobCategory
  include Mongoid::Document
  has_many :freelancers
  field :name
end