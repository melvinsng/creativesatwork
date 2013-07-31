class Project
  include Mongoid::Document
  include Mongoid::Timestamps
  belongs_to :employer

  field :title
  field :description
  field :budget_range

  def as_json_options(options={})
    # val must be array!
    preset_options = {methods: [:employer]}
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