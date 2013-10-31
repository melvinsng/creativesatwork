categories = ["Writing", "Production", "Design", "Others"]
categories.each do |cat|
  JobCategory.create! name: cat
end


=begin
job_titles = {
    'Writing' => ['Scriptwriter','Writer','Copywriter','Journalist','Editor'],
    'Design' => ['Product Designer', 'Graphic Designer', 'Multimedia Designer', 'Motion Graphic Designer', 'Art Director', 'Creative Director', 'Set Designer', 'Wardrode Designer', 'Web Designer'],
    'Production' => ['2D & 3D Animator', 'Illustrator', 'Video Producer', 'Director', 'Soundman', 'Lightingman', 'Videographer', 'Cameraman', 'Grip & Gaffer', 'Production Manager', 'Location Manager', 'Director', 'Video Editor', '3D Artist', 'Photographer', 'DI Artist', 'Audio Producer', 'Project Manager'],
    'Others' => ['Voice-over Artist', 'Translator', 'Marketing', 'PR']
}


skill_list = %w{css html javascript python ruby photoshop copywriting actionscript flash}
100.times do |index|
  job_cat_num = rand(4)
  job_cat_id = JobCategory.all[job_cat_num].id
  job_cat_name = JobCategory.all[job_cat_num].name
  Freelancer.create!(
      password: 'asdfqwer',
      password_confirmation: 'asdfqwer',
      first_name: 'Freelancer',
      last_name: "#{index}",
      email: "freelancer-#{index}@gmail.com",
      account_status: 'active',
      job_category_id: job_cat_id,
      job_title: job_titles[job_cat_name][rand(job_titles[job_cat_name].length)],
      years_of_experience: 4,
      education_and_certificates: 'education and cert',
      other_information: 'about me......',
      accolades_and_awards: 'my accolades and awards.....',
      day_rate: '99',
      photo_url: 'https://si0.twimg.com/profile_images/1019961979/Formal_Avatar_Face_B_W_Sample.jpg',
      professional_history: "This is summary for freelancer-#{index}", 
      skills: skill_list.sample(rand(skill_list.size-1)+1).join(','),
      location: 'Malaysia'
  )
end


Employer.create!(
    password: 'asdfqwer',
    password_confirmation: 'asdfqwer',
    first_name: 'Employer',
    last_name: "ONe",
    email: "employer1@gmail.com",
    account_status: 'active',
    location: 'Malaysia',
    company_name: 'Shell',
    company_url: 'http://shell.com',
    company_description: 'richest company',
    company_location: 'Arab'
)

empl = Employer.first
budget_list = ['$0 - $500','$500 - $1000','$1000 - $2000','$2000 - $3000','$3000 - $5000','$5000 - $10000']

100.times do |index|
  Project.create!(
      title: "A web design project - #{index}",
      project_description: 'Design a nice website',
      project_timeline: 'May 2014 till Feb 2015',
      additional_info: "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.",
      budget_range: budget_list[rand(budget_list.length)],
      tags: skill_list.sample(rand(skill_list.size-1)+1).join(','),
      employer_id: empl.id,
      job_category_id: JobCategory.all[rand(4)].id
  )
end

=end