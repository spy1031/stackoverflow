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

  task fake_questions: :environment do
    Question.destroy_all
    15.times do |i|
      Question.create!(
        title: FFaker::Book.title,
        content: FFaker::Lorem.paragraph,
        user: User.all.sample
      )
    end
    puts "have created #{Question.count} fake Questions"
  end
  
  task fake_favorites: :environment do
    Favorite.destroy_all
    10.times do |i|
      Favorite.create!(
        user_id: 6,
        question_id: i + 2
      )
    end
    puts "have created #{Favorite.count} fake Favorites"
  end

  task fake_solutions: :environment do
    Question.all.each do |question|
      3.times do |i|
        question.solutions.create!(
          content: FFaker::Lorem.sentence,
          user: User.all.sample
        )
      end
    end
    puts "have created #{Solution.count} fake Solutions"
  end
  
    task rebuild: ["db:drop", "db:create", "db:migrate", "db:seed", :fake_users, :fake_questions, :fake_favorites]

  
end