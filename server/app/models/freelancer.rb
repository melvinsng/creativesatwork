class Freelancer < User
  belongs_to :job_category

  has_many :projects

  has_and_belongs_to_many :bidding_projects, class_name: 'Project', inverse_of: :bidders
  has_and_belongs_to_many :offered_projects, class_name: 'Project', inverse_of: :offers

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

  include Mongoid::Search
  search_in :first_name, :last_name, :job_title, :skills_string

  def profile_incomplete
    job_title.blank? || years_of_experience.blank? || professional_history.blank? ||
        day_rate.blank? || education_and_certificates.blank? || location.blank? ||
        other_information.blank? || skills.blank?
  end

  def as_json_options(options={})
    # val must be array!
    preset_options = {methods: [:skills, :job_category, :profile_incomplete, :bidding_projects, :offered_projects]}
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
