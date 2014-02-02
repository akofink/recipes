class SeedDevelopmentData
  def self.run!
    create_users
    create_recipes
  end

  private

  def self.create_users
    admin = User.create email: 'admin@mailinator.com',
      password: 'Passw0rd',
      password_confirmation: 'Passw0rd',
      admin: 1
    user = User.create email: 'user@mailinator.com',
      password: 'Passw0rd',
      password_confirmation: 'Passw0rd',
      admin: 1
  end

  def self.create_recipes
    10.times do
      Recipe.create title: strings,
        body: paragraphs,
        user: rand_user
    end
  end

  def self.strings
    Lipsum.words[rand 4].to_s
  end

  def self.paragraphs
    Lipsum.paragraphs[rand 4].to_s.gsub "\n", "\n\n"
  end

  def self.rand_user
    User.first(order: "RANDOM()")
  end
end
