require_relative "../database_class_methods.rb"
require_relative "../database_instance_methods.rb"

class Contribute
  extend DatabaseClassMethods
  include DatabaseInstanceMethods

  attr_accessor :assignment_id, :user_id

  # Initializes a new contributes object.
  #
  # contributes_options - Hash containing key/values.contributes
  #   - assignment_id (optional)    - Integer of the assignment's record in the 'assignments' table.
  #   - user_id (optional)          - Integer of the user's record in the 'users' table.
  #
  # Examples:
  #
  #   Contribute.new({ "assignment_id" => 1, "user_id" => 2 })
  #   => #<Contribute:f32o23424>  assignment_id INTEGER, user_id INTEGER
  #
  # Returns a Contribute object.

  def initialize(options={})
    @assignment_id = options["assignment_id"]
    @user_id = options["user_id"]
  end


  # Get all of the rows for a table and convert hashes to objects
  #
  # Returns an Array containing Contribute objects of assignments with a specific user_id.
  def self.user_assignments(user_id)

    results = CONNECTION.execute("SELECT * FROM contributes WHERE user_id = #{user_id}")

    results_as_objects = []

    results.each do |results_hash|
      results_as_objects << self.new(results_hash)
    end

    return results_as_objects
  end

  def self.contributors_of_assignment(assignment_id)

    results = CONNECTION.execute("SELECT * FROM contributes WHERE assignment_id = #{assignment_id}")

    results_as_objects = []

    results.each do |results_hash|
      results_as_objects << self.new(results_hash)
    end

    return results_as_objects
  end


end







