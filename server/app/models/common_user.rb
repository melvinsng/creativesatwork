class CommonUser < User
  has_many :organized_projects, class_name: 'Project', inverse_of: :organizer
  has_and_belongs_to_many :supporting_projects, class_name: 'Project', inverse_of: :supporters
  has_and_belongs_to_many :volunteering_projects, class_name: 'Project', inverse_of: :volunteers

  validates :email, presence: true, uniqueness: true,
            format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i}

  def as_json_options(options={})
    preset_options = {include: [:organized_projects, :supporting_projects, :volunteering_projects]}
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
