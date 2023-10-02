desc "Fill the database tables with some sample data"
task({ :sample_data => :environment }) do
  if Rails.env.development?
    Director.destroy_all
  end

  15.times do 
    d = Director.new
    d.name = Faker::Name.name
    d.dob = Faker::Date.birthday(max_age: 85, min_age: 25)
    d.save
  end
end
