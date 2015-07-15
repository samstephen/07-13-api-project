require "active_support"
require "active_support/inflector"

# This module will be **included** in all of my classes. It contains methods
# that will become **instance** methods in the class.

module DatabaseInstanceMethods

  # Grabs the name of the class, and turns it into a tableized version to use for SQL
  #
  # Accepts no arguments, grabbing the name of the class itself
  #
  # Returns a String of the class in SQL table form
  def table_name
    self.class.to_s.tableize
  end


  # Makes a list of column names and values for SQL to save information to the table
  #
  # Accepts 1 argument, a Hash containing keys of the Class Attributes, and values of the contents of those
  #
  # Returns a String of the key/value combinations, to plug into a SQL request
  def ready_for_sql(hash)
    single_variables = []

    hash.each do |k, v|
      if v.is_a?(String)
        single_variables << "#{k} = '#{v}'"
      else
        single_variables << "#{k} = #{v}"
      end
    end
    return vars_to_sql = single_variables.join(", ")
  end



  # "Gets" the value of a field for a given row from a table.
  #
  # field - String of the column name.
  #
  # Returns the String value of the cell in the table.
  def get(field)
    # Get the first/only row as a Hash.
    result = CONNECTION.execute("SELECT * FROM #{table_name} WHERE id = #{@id}").first

    # Return only the value for the key of the field we're seeking.
    return result[field]
  end



  # Saves the current values in our instance variables into the row in the table referenced
  # by our Object's id
  #
  # Takes no arguments, using the instance's attributes
  #
  # Returns the Object itself, along with syncing the row and Object
  def save
    CONNECTION.execute("UPDATE #{table_name} SET #{ready_for_sql(make_hash)} WHERE id = #{self.id}")
    return self
  end



  # Change a row's cell info by id
  #
  # table_name - table of the class
  # column - String
  # value - String
  # id - Integer
  #
  # Update the name of a product
  def update_cell(column, value)
    table_name = self.class.to_s.pluralize.underscore
    return CONNECTION.execute("UPDATE #{table_name} SET #{column} = '#{value}' WHERE id = #{@id}")
  end



  # Makes a hash of the Class's attributes that calls the method.
  #
  # Accepts no arguments
  #
  # Returns a Hash of the instance variable names
  def make_hash
    variables = self.instance_variables
    attr_hash = {}
    variables.each do |var|
      attr_hash["#{var.slice(1..-1)}"] = self.send("#{var.slice(1..-1)}")
    end

    return attr_hash
  end

end