require "active_support"
require "active_support/inflector"

# This module will be **extended** in all of my classes. It contains methods
# that will become **class** methods for the class.

module DatabaseClassMethods

  # Grabs the name of the class, and turns it into a tableized version to use for SQL
  #
  # Accepts no arguments, grabbing the name of the class itself
  #
  # Returns a String of the class in SQL table form
  def get_table_name
    self.to_s.tableize
  end



  # Makes an Array of Objects for a Hash entered as an argument.
  #
  # Accepts one argument, a Hash that we want to turn into Objects to push into an Array
  #
  # Returns an Array full of Objects of the Class that calls the method
  def make_object_array(hash)
    object_array = []

    hash.each do |object|
      object_array << self.new(object)
    end

    object_array
  end



  # Add a new record to the database.
  #
  # options - hash
  #
  # Returns an Object. (with a primary key or "pk")
  def add(options={})
    column_names = options.keys
    values = options.values

    individual_values = []

    values.each do |value|
      if value.is_a?(String)
        individual_values << "'#{value}'"
      else
        individual_values << value
      end
    end

    column_names_for_sql = column_names.join(", ")
    individual_values_for_sql = individual_values.join(", ")

    CONNECTION.execute("INSERT INTO #{get_table_name} (#{column_names_for_sql}) VALUES (#{individual_values_for_sql});")

    options["id"] = CONNECTION.last_insert_row_id

    self.new(options)
  end



  # Add a new record to the database.
  #
  # options - hash
  #
  # Returns an Object. (without a primary key or "pk")
  def add_no_pk(options={})
    column_names = options.keys
    values = options.values

    individual_values = []

    values.each do |value|
      if value.is_a?(String)
        individual_values << "'#{value}'"
      else
        individual_values << value
      end
    end

    column_names_for_sql = column_names.join(", ")
    individual_values_for_sql = individual_values.join(", ")

    CONNECTION.execute("INSERT INTO #{get_table_name} (#{column_names_for_sql}) VALUES (#{individual_values_for_sql});")

    self.new(options)
  end



  # Get all of the rows for a table and convert hashes to objects
  #
  # Returns an Array containing Class objects.
  def all
    results = CONNECTION.execute("SELECT * FROM #{get_table_name}")

    results_as_objects = []

    results.each do |results_hash|
      results_as_objects << self.new(results_hash)
    end

    return results_as_objects
  end



  # Get all of the rows for a table as hashes
  #
  # Returns an Array of hashes.
  def all_hash
    results = CONNECTION.execute("SELECT * FROM #{get_table_name};")
    return array_list = make_object_array(results)
  end




  # Get a single row.
  #
  # record_id - The record's Integer ID.
  #
  # Returns a Class object.
  def find(record_id)
    self.new(CONNECTION.execute("SELECT * FROM #{get_table_name} WHERE id = #{record_id}").first)
  end
  


  # "Deletes" a row from a table
  #
  # record_id - The record's Integer ID.
  #
  # Returns an empty array, and deletes the row from the table
  def delete(record_id)
    CONNECTION.execute("DELETE FROM #{get_table_name} WHERE id = #{record_id}")
  end

end







