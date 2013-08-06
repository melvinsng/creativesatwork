class Employer < User
  has_many :projects
  field :company_name
  field :company_url
  field :company_description
  field :company_location

  validates :email, presence: true, uniqueness: true,
            format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i}

  def profile_incomplete
    company_name.blank? || company_description.blank? || company_location.blank?
  end

  def as_json_options(options={})
    # val must be array!
    preset_options = {methods: [:projects, :profile_incomplete]}
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
