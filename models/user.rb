require_relative "../database_class_methods.rb"
require_relative "../database_instance_methods.rb"

class User
  extend DatabaseClassMethods
  include DatabaseInstanceMethods
  attr_reader :id
  attr_accessor :name, :email, :password

  # Initializes a new user object.
  #
  # user_options - Hash containing key/values.
  #   - id (optional)   - Integer of the user record in the 'users' table.
  #   - name (optional) - String of the user's name.
  #
  # Examples:
  #
  #   User.new({ "id" => 1, "name" => "Sam Stephen" })
  #   => #<User:f32o23424>  INTEGER PRIMARY KEY, user TEXT
  #
  # Returns a User object.

  def initialize(options={})
    @id = options["id"]
    @name = options["name"]
    @email = options["email"]
    @password = options["password"]
  end

end






