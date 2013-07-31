class Project
  include Mongoid::Document
  include Mongoid::Timestamps
  belongs_to :employer

  field :title
  field :description
  field :budget_range

  def as_json_options(options={})
    preset_options = {methods: [:employer]}
    if defined?(super)
      super(preset_options).merge options
    else
      preset_options.merge options
    end
  end
  def as_json(options={})
    options = as_json_options(options)
    super options
  end
end