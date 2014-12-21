class MessageAttachment
  include Mongoid::Document
  include Mongoid::Timestamps

  # only url for now
  field :url
  field :filename
end