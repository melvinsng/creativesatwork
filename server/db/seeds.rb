categories = ["Writing", "Production", "Design", "Others"]
categories.each do |cat|
  JobCategory.create! name: cat
end


job_titles = {
    'Writing' => ["Copywriter", "Editor", "Journalist", "Scriptwriter", "Writer"],
    'Design' => ["Art Director", "Audio Designer", "Character Designer", "Creative Director", "Game Designer", "Graphic Designer", "Lighting Designer", "Motion Graphic Designer", "Multimedia Designer", "Product Designer", "Set Designer", "UI/UX Designer", "Wardrode Designer", "Web Designer"],
    'Production' => ["2D Animator", "3D Animator", "3D Artist", "Animator", "Audio Producer", "Camera Assistant", "Cameraman", "Casting Manager", "DI Artist", "Director", "Director and Producer", "Director of Photography", "Grip & Gaffer", "Illustrator", "Lightingman", "Location Manager", "Make Up Artist", "Musician", "Photographer", "Production Assistant", "Production Manager", "Project Manager", "Soundman", "Storyboard Artist", "VFX Artist", "Video Editor", "Video Producer", "Videographer", "Videographer and SteadiCam Operator"],
    'Others' => ["Commentator", "Host", "Marketing", "PR", "Social Media Consultant", "Translator", "Voiceover Artist", "Web Developer"]
}

job_title_map = {}
job_titles.each do |j, t|
  t.each do |i|
    job_title_map[i] = j
  end
end

path = "#{Rails.root}/db/freelancerdata.csv"
require 'csv'
file = CSV.read path
file.each do |k|
  k.collect{|x| x.strip! unless x.nil?}
  rand_password=('0'..'z').to_a.shuffle.first(8).join
  job_title = k[6]
  if job_title_map.key? job_title
    job_title_category = job_title_map[job_title]
  else
    job_title_category = 'Others'
  end
  job_title_category_id = JobCategory.where(name: job_title_category).first.id
  portfolio = nil
  if k[11] && k[11].match(/^http/)
    portfolio = k[11]
  else
    other_information = k[11]
  end
  freelancer = Freelancer.new(
      password: rand_password,
      password_confirmation: rand_password,
      email: k[0],
      phone: k[1],
      first_name: k[2],
      last_name: k[3],
      account_status: 'active',
      job_category_id: job_title_category_id,
      job_title: job_title,
      other_information: other_information,
      years_of_experience: k[7],
      education_and_certificates: k[8],
      accolades_and_awards: k[10],
      day_rate: k[12],
      skills: k[4].gsub(/\//, ','),
      location: k[5]
  )
  if freelancer.valid?
    if !portfolio.nil?
      freelancer.portfolios << Portfolio.new(
          url: portfolio
      )
    end
    freelancer.save!
  else
    p "Invalid: "
    p freelancer.errors.messages
    p "\n"
  end
end

=begin


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