require_relative "../database_class_methods.rb"
require_relative "../database_instance_methods.rb"

class Type
  extend DatabaseClassMethods
  include DatabaseInstanceMethods

  attr_reader :id
  attr_accessor :category

  # Initializes a new Type object.
  #
  # type_options - Hash containing key/values.
  #   - id (optional)         - Integer of the type record_id in the 'types' table.
  #   - category (optional)   - String of the type's category.
  #
  # Examples:
  #
  #   Type.new({ "id" => 1, "category" => "video" })
  #   Type.new({ "id" => 2, "category" => "article" })
  #
  # Returns a Type object.

  def initialize(options={})
    @id = options["id"]
    @category = options["category"]
  end

end






