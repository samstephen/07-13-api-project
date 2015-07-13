require "active_support"
require "active_support/inflector"

# This module will be **extended** in all of my classes. It contains methods
# that will become **class** methods for the class.

module DatabaseClassMethods



  # Add a new record to the database.
  #
  # options - hash
  #
  # Returns an Object.
  def add(options={})
    table_name = self.to_s.pluralize.underscore

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

    CONNECTION.execute("INSERT INTO #{table_name} (#{column_names_for_sql}) VALUES (#{individual_values_for_sql});")

    id = CONNECTION.last_insert_row_id
    options["id"] = id

    self.new(options)
  end



  # Add a new record to the database.
  #
  # options - hash
  #
  # Returns an Object.
  def add_no_pk(options={})
    table_name = self.to_s.pluralize.underscore

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

    CONNECTION.execute("INSERT INTO #{table_name} (#{column_names_for_sql}) VALUES (#{individual_values_for_sql});")

    self.new(options)
  end



  # Get all of the rows for a table and convert hashes to objects
  #
  # Returns an Array containing Class objects.
  def all
    # Figure out the table's name from the class we're calling the method on.
    table_name = self.to_s.pluralize.underscore

    results = CONNECTION.execute("SELECT * FROM #{table_name}")

    results_as_objects = []

    results.each do |results_hash|
      results_as_objects << self.new(results_hash)
    end

    return results_as_objects
  end



  # Get a single row.
  #
  # record_id - The record's Integer ID.
  #
  # Returns a Class object.
  def find(record_id)
    # Figure out the table's name from the class we're calling the method on.
    table_name = self.to_s.pluralize.underscore
    
    self.new(CONNECTION.execute("SELECT * FROM #{table_name} WHERE id = #{record_id}").first)
  end
  


  # "Deletes" a row from a table
  #
  # record_id - The record's Integer ID.
  #
  # Returns an empty array
  def delete(record_id)
    table_name = self.to_s.pluralize.underscore
    CONNECTION.execute("DELETE FROM #{table_name} WHERE id = #{record_id}")
  end
  
end







