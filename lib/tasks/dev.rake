namespace :dev  do
  task fake_users: :environment do
    User.where("role != ?","admin").destroy_all
    15.times do |i|     
      user = User.new(
        email: FFaker::Name::first_name + "@example.com",
        password: "123456",
        role: "normal",
        name: FFaker::Name::first_name,
        introduction: FFaker::Lorem::sentence(30),
        company: FFaker::Company::name,
        job_title: FFaker::Job::title,
        website: "test" + i.to_s + "website.com",
        twitter: "test" + i.to_s + "twitter",
        github: "test" + i.to_s + "github"
      )
      user.save!
      puts user.email
    end
  end 
end