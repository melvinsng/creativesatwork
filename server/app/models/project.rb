=begin

{
  "organizer_id": "51f407f3a5410fc80400004a",
  "project_leaders": [
    {
      "name": "123",
      "contact_number": "2132"
    },
    {
      "name": "13",
      "contact_number": "123"
    }
  ],
  "project_photos": [
    {
      "url": "http://sgattractions.com:3003/uploads/picture/data/70/content_IMG_0022.JPG"
    }
  ],
  "name": "name of pro",
  "contact_person": "conta",
  "contact_person_number": "asd",
  "contact_person_email": "asdasd",
  "first_objective": "To achieve happiness",
  "second_objective": "To build a democratic society",
  "third_objective": "BaseModeld on Justice and Equality",
  "objective_summary": "12312",
  "inspiration_behind": "1231",
  "why_meet_objectives": "12312",
  "target_audience": "easd",
  "how_to_accomplish": "asdas",
  "when_accomplish": "ads",
  "why_support": "qqeqw",
  "how_to_support": "qwew",
  "people_behind": "qweq",
  "announcement": "qweqwe",
  "video_url": "asad",
  "facebook_page": "asdasd"
}


=end

class Project
  include Mongoid::Document
  include Mongoid::Timestamps
  belongs_to :organizer, class_name: 'CommonUser', inverse_of: :organized_projects
  has_and_belongs_to_many :supporters, class_name: 'CommonUser', inverse_of: :supporting_projects
  has_and_belongs_to_many :volunteers, class_name: 'CommonUser', inverse_of: :volunteering_projects
  embeds_many :project_leaders
  embeds_many :project_photos
  field :name
  field :contact_person
  field :contact_person_number
  field :contact_person_email
  field :first_objective
  field :second_objective
  field :third_objective
  field :objective_summary
  field :inspiration_behind
  field :why_meet_objective
  field :target_audience
  field :how_to_accomplish
  field :when_accomplish
  field :why_support
  field :how_to_support
  field :people_behind
  field :announcement
  field :video_url
  field :youtube_vid
  field :facebook_page

  accepts_nested_attributes_for :project_leaders, reject_if: :all_blank, allow_destroy: true
  accepts_nested_attributes_for :project_photos, reject_if: :all_blank, allow_destroy: true

  validates_presence_of :name, :target_audience, :contact_person, :contact_person_number,
                        :contact_person_email, :first_objective, :objective_summary, :video_url

  before_save :extract_youtube_identifier

  def no_of_supporters; supporters.size end
  def no_of_volunteers; volunteers.size end
  def as_json_options(options={})
    preset_options = {include: [:project_leaders, :project_photos], methods: [:supporters, :volunteers, :no_of_supporters, :no_of_volunteers]}
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

  def extract_youtube_identifier
    link = video_url || ''
    max_hash = link.split(/[\:\/\?\.\=]/).group_by(&:size).max
    self.youtube_vid = max_hash.last.last unless max_hash.nil? || max_hash.last.nil?
  end
end