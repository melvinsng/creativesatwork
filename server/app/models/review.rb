class Review
  include Mongoid::Document
  include Mongoid::Timestamps

  field :content
  field :rating
  field :rating_1
  field :rating_2
  field :rating_3
  field :is_approved, type: Boolean, default: true
  field :flagged, type: Boolean, default: false

  belongs_to :freelancer
  belongs_to :reviewer, class_name: 'Employer', inverse_of: :reviews
  #has_and_belongs_to_many :flaggers, class_name: 'Member', inverse_of: nil

  before_save :average_rating
  after_save :update_provider_rating
  after_create :notify_admin

  def average_rating
    combined_score = self.rating_1 + self.rating_2 + self.rating_3
    self.rating = combined_score.to_f / 3
  end

  def update_provider_rating
    if freelancer.reviews.blank?
      freelancer.overall_rating = nil
    else
      freelancer.overall_rating = freelancer.reviews.where(is_approved: true).avg(:rating)
    end
    freelancer.save!
  end


  def after_trashed
    update_provider_rating
  end

  def notify_admin
    #ProjectMailer.delay.notify_admin_upon_review_created self.id
    #ProjectMailer.delay.notify_vendor_upon_review_created self.id
  end

  def freelancer_name
    [freelancer.first_name, freelancer.last_name].join(' ')
  end

  def reviewer_name
    [reviewer.first_name, reviewer.last_name].join(' ')
  end

  def as_json_options(options={})
    # val must be array!
    preset_options = {include: [],
                      methods: [:freelancer_name, :reviewer_name]}
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