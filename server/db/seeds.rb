skill_list = %w{css html javascript python ruby photoshop copywriting actionscript flash}
100.times do |index|
  Freelancer.create!(
      password: 'asdfqwer',
      password_confirmation: 'asdfqwer',
      first_name: 'Freelancer', last_name: "#{index}",
      email: "freelancer-#{index}@gmail.com", account_status: 'active', job_category_id: JobCategory.all[rand(4)].id,
      job_title: 'Designer',
      years_of_experience: 4,
      education_and_certificates: 'education and cert',
      other_information: 'about me......',
      accolades_and_awards: 'my accolades and awards.....',
      portfolio: 'portfolio....',
      day_rate: '99',
      photo_url: 'https://si0.twimg.com/profile_images/1019961979/Formal_Avatar_Face_B_W_Sample.jpg',
      professional_history: "This is summary for freelancer-#{index}", 
      skills: skill_list.sample(rand(skill_list.size-1)+1).join(','),
      location: 'Malaysia'
  )
end