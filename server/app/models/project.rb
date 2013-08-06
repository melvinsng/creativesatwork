class Project
  include Mongoid::Document
  include Mongoid::Timestamps

  PENDING = 'project_pending'
  ACTIVE = 'project_active'
  COMPLETED = 'project_completed'

  belongs_to :employer
  belongs_to :job_category

  field :title
  field :project_description
  field :project_timeline
  field :additional_info
  field :budget_range
  field :project_status, default: PENDING

  include Mongoid::TaggableWithContext
  include Mongoid::TaggableWithContext::AggregationStrategy::RealTime
  # include Mongoid::TaggableWithContext::AggregationStrategy::MapReduce
  taggable :tags, separator: ','

  include Mongoid::Search
  search_in :title, :project_description, :tags_string

  delegate :company_location, to: :employer

  def as_json_options(options={})
    # val must be array!
    preset_options = {methods: [:employer, :job_category, :tags, :company_location]}
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