class Message
  include Mongoid::Document
  include Mongoid::Timestamps

  field :content

  belongs_to :recipient, class_name: 'User', inverse_of: :received_messages
  belongs_to :sender, class_name: 'User', inverse_of: :sent_messages

  after_create :notify_parties

  def notify_parties
    #ProjectMailer.delay.notify_admin_upon_review_created self.id
    #ProjectMailer.delay.notify_vendor_upon_review_created self.id
  end

  def recipient_name
    [recipient.first_name, recipient.last_name].join(' ')
  end

  def sender_name
    [sender.first_name, sender.last_name].join(' ')
  end

  def recipient_photo
    recipient.photo_url
  end

  def sender_photo
    sender.photo_url
  end

  def as_json_options(options={})
    # val must be array!
    preset_options = {include: [],
                      methods: [:recipient_name, :sender_name, :recipient_photo, :sender_photo]}
    if defined?(super)
      super(preset_options).each do |key,val|
        if options.has_key?(key)
          options[key] = (val.to_set.merge options[key]).to_a
        else
          options[key] = val
        end
      end
    else
      preset_options.each do |key,val|
        if options.has_key?(key)
          options[key] = (val.to_set.merge options[key]).to_a
        else
          options[key] = val
        end
      end
    end
    options
  end
  def as_json(options={})
    super as_json_options(options)
  end
end