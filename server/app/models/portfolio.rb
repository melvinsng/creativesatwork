class Portfolio
  include Mongoid::Document
  include Mongoid::Timestamps

  # only url for now
  field :url
  field :name
  field :video
  field :description
end