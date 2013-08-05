class Freelancer < User
  belongs_to :job_category

  field :job_title
  field :years_of_experience
  field :professional_history
  field :education_and_certificates
  field :other_information
  field :accolades_and_awards
  field :portfolio
  field :day_rate

  validates :email, presence: true, uniqueness: true,
            format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i}

  include Mongoid::TaggableWithContext
  include Mongoid::TaggableWithContext::AggregationStrategy::RealTime
  # include Mongoid::TaggableWithContext::AggregationStrategy::MapReduce
  taggable :skills, separator: ','

  def profile_incomplete
    job_title.blank? || years_of_experience.blank? || professional_history.blank? || day_rate.blank?
  end

  def as_json_options(options={})
    # val must be array!
    preset_options = {methods: [:skills, :job_category, :profile_incomplete]}
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
    options = as_json_options(options)
    super options
  end
end
