class Portfolio
  include Mongoid::Document
  include Mongoid::Timestamps
  embedded_in :freelancer

  # only url for now
  field :url
  field :name
  field :video
  field :description
end