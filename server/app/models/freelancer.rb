class Freelancer < User
  belongs_to :job_category

  has_many :projects, inverse_of: :freelancer
  embeds_many :portfolios
  embeds_many :portfolio_images

  has_and_belongs_to_many :bidding_projects, class_name: 'Project', inverse_of: :bidders
  has_and_belongs_to_many :offered_projects, class_name: 'Project', inverse_of: :offers

  field :job_title
  field :years_of_experience
  field :professional_history
  field :education_and_certificates
  field :other_information
  field :accolades_and_awards
  field :day_rate
  field :profile_incomplete, type: Boolean

  accepts_nested_attributes_for :portfolios, reject_if: :all_blank, allow_destroy: true
  accepts_nested_attributes_for :portfolio_images, reject_if: :all_blank, allow_destroy: true

  validates :email, presence: true, uniqueness: true,
            format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i}

  include Mongoid::TaggableWithContext
  include Mongoid::TaggableWithContext::AggregationStrategy::RealTime
  # include Mongoid::TaggableWithContext::AggregationStrategy::MapReduce
  taggable :skills, separator: ','

  include Mongoid::Search
  search_in :first_name, :last_name, :job_title, :skills_string

  before_save :persist_profile_incomplete

  def active_projects; projects.where(project_status: Project::ACTIVE) end
  def completed_projects; projects.where(project_status: Project::COMPLETED) end
  def _profile_incomplete; job_title.blank? || years_of_experience.blank? || day_rate.blank? || location.blank? end
  def _deny_fields; %W{pending_projects active_projects completed_projects} end

  def persist_profile_incomplete
    self.profile_incomplete = _profile_incomplete
    true
  end

  def as_json_options(options={})
    # val must be array!
    exposed = [:skills, :job_category, :portfolios, :portfolio_images,
               :bidding_projects, :offered_projects, :active_projects, :completed_projects, :_deny_fields]
    preset_options = {methods: exposed}
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
