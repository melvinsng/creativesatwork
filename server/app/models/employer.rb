class Employer < User
  has_many :projects

  field :company_name
  field :company_url
  field :company_description
  field :company_location

  validates :email, presence: true, uniqueness: true,
            format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i}

  def as_json_options(options={})
    preset_options = {methods: [:projects]}
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
