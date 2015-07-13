require_relative "../database_class_methods.rb"
require_relative "../database_instance_methods.rb"

class Assignment
  extend DatabaseClassMethods
  include DatabaseInstanceMethods

  attr_reader :id
  attr_accessor :description, :repo

  # Initializes a new user object.
  #
  # assignments_options           - Hash containing key/values.
  #   - id (optional)             - Integer of the assignment's record id in the 'assignments' table.
  #   - description (optional)    - String of the assignment's description.
  #   - repo (optional)           - String of the assignment's repo url.
  #
  # Examples:
  #
  #   Assignment.new({  "id" => 1,
  #                     "description" => "CookcoLab is an app allows users to share recipes.",
  #                     "repo" => "https://github.com/samstephen/06-23-cookcolab"
  #                 })
  #   => #<Assignment:f32o23424>  INTEGER PRIMARY KEY, description TEXT, repo STRING
  #
  # Returns a Assignment object.

  def initialize(options={})
    @id = options["id"]
    @description = options["description"]
    @repo = options["repo"]
  end

end






