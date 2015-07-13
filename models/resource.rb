require_relative "../database_class_methods.rb"
require_relative "../database_instance_methods.rb"

class Resource
  extend DatabaseClassMethods
  include DatabaseInstanceMethods

  attr_reader :id
  attr_accessor :post, :type_id, :assignment_id

  # Initializes a new user object.
  #
  # user_options - Hash containing key/values.
  #   - id (optional)   - Integer of the user record in the 'users' table.
  #   - type_id (optional) - Integer of the type's record in the 'types' table.
  #   - assignment_id (optional) - Integer of the assignment's record in the 'assignments' table.
  #   - post (optional) - String of the user's name.
  #
  # Examples:
  #
  #   Resource.new({  "id" => 1,
  #                   "type_id" => "2",
  #                   "assignment_id" => "1",
  #                   "post" => "http://samstephen.github.io/orm/2015/06/16/orm.html"
  #               })
  #   => #<User:f32o23424>  INTEGER PRIMARY KEY, type_id INTEGER, assignment_id INTEGER, post TEXT
  #
  # Returns a Resource object.

  def initialize(options={})
    @id = options["id"]
    @type_id = options["type_id"]
    @assignment_id = options["assignment_id"]
    @post = options["post"]
  end

  def category
    Type.find(@type_id)
  end

  def assignment_of_resource
    Assignment.find(@assignment_id)
  end

end



