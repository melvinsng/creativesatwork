class Employer < User
  has_many :projects
  field :company_name
  field :company_url
  field :company_description
  field :company_location
  field :profile_incomplete, type: Boolean

  validates :email, presence: true, uniqueness: true,
            format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i}

  before_save :persist_profile_incomplete

  def active_projects; projects.where(project_status: Project::ACTIVE) end
  def pending_projects; projects.where(project_status: Project::PENDING) end
  def completed_projects; projects.where(project_status: Project::COMPLETED) end
  def _profile_incomplete; company_location.blank? end
  def _deny_fields; %W{pending_projects active_projects completed_projects} end

  def persist_profile_incomplete
    self.profile_incomplete = _profile_incomplete
  end

  def as_json_options(options={})
    # val must be array!
    exposed = [:active_projects, :pending_projects, :completed_projects, :_deny_fields]
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
