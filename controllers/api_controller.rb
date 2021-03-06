#______________________________________________________________________________________________________________________#
#                                                                                                                      #
#                                                     USERS                                                            #
#______________________________________________________________________________________________________________________#

# API of all users
get "/api/users" do
  user_list = User.all

  @user_array = []

  user_list.each do |user|
    @user_array << user.make_hash
  end

  json @user_array
end



# Adds a new Assignment row to our assignments table in our database
# Returns an Object, that we turn back into a Hash to pass to json.
# An example of the address to use this api:
# "/api/users/add/new?name=Sam-Stephen&email=samueljstephen@me.com&password=deadMau5"
get "/api/users/add/:new" do
  add_hash = {"name" => params["name"], "email" => params["email"], "password" => params["password"]}

  new_user = User.add(add_hash)

  @user_as_hash = new_user.make_hash

  json @user_as_hash
end



#______________________________________________________________________________________________________________________#
#                                                                                                                      #
#                                                   ASSIGNMENTS                                                        #
#______________________________________________________________________________________________________________________#

# API of all assignments
get "/api/assignments" do
  assignment_list = Assignment.all

  @assignment_array = []

  assignment_list.each do |assignment|
    @assignment_array << assignment.make_hash
  end

  json @assignment_array
end

# Returns an Array of Hashes corresponding to any table information referenced with the
# Assignment ID passed into the route.
get "/api/assignment/:id" do
  contribute = Assignment.all_from_contributions(params["id"])
  assignment_data = Assignment.find(params["id"])
  contribute_data = []

  contribute.each do |c|
    object = Contribute.new(c)
    contribute_data << object
  end

  @data_array = []
  @data_array << assignment_data.make_hash

  contribute_data.each do |data|
    @data_array << data.make_hash
  end

  json @data_array
end



# Adds a new Assignment row to our assignments table in our database
# Returns an Object, that we turn back into a Hash to pass to json.

# An example of the address to use this api:
# "/api/assignments/add/new?title=07-13-Test-Project&description=This%20is%20a%20test.&repo=test.com/test/07-13-test-project"
get "/api/assignments/add/:new" do
  add_hash = {"title" => params["title"], "description" => params["description"], "repo" => params["repo"]}

  new_assignment = Assignment.add(add_hash)

  @assignment_as_hash = new_assignment.make_hash

  json @assignment_as_hash
end



#______________________________________________________________________________________________________________________#
#                                                                                                                      #
#                                                   CONTRIBUTES                                                        #
#______________________________________________________________________________________________________________________#

# API of all assignments
get "/api/contributes" do
  contribute_list = Contribute.all

  @contribute_array = []

  contribute_list.each do |contribute|
    @contribute_array << contribute.make_hash
  end

  json @contribute_array
end



# Adds a new Contribution row to our contributions table in our database
# Returns an Object, that we turn back into a Hash to pass to json.
#
# An example of the address to use this api:
# "/api/contributes/add/3/6?assignment_id=3&user_id=6"
get "/api/contributes/add/:assignment_id/:user_id" do
  add_hash = {"assignment_id" => params["assignment_id"], "user_id" => params["user_id"]}

  new_contribute = Contribute.add(add_hash)

  @contribute_as_hash = new_contribute.make_hash

  json @contribute_as_hash
end



#______________________________________________________________________________________________________________________#
#                                                                                                                      #
#                                                    RESOURCES                                                         #
#______________________________________________________________________________________________________________________#

# API of all resources
get "/api/resources" do
  resource_list = Resource.all

  @resource_array = []

  resource_list.each do |resource|
    @resource_array << resource.make_hash
  end

  json @resource_array
end


#______________________________________________________________________________________________________________________#
#                                                                                                                      #
#                                                    RESOURCES                                                         #
#______________________________________________________________________________________________________________________#

# API of all resources
get "/api/resources" do
  resource_list = Resource.all

  @resource_array = []

  resource_list.each do |resource|
    @resource_array << resource.make_hash
  end

  json @resource_array
end

# Adds a new Assignment row to our assignments table in our database
# Returns an Object, that we turn back into a Hash to pass to json.

# An example of the address to use this api: id,type_id,assignment_id,post
# "/api/resources/add/new?type_id=2&assignment_id=6&post=gmfholley.github.io/ruby/sinatra/orm/video/%60data_conversion%60/2015/06/28/data-conversion-video.html"
get "/api/resources/add/:new" do
  add_hash = {"type_id" => params["type_id"], "assignment_id" => params["assignment_id"], "post" => params["post"]}

  new_resource = Resource.add(add_hash)

  @resource_as_hash = new_resource.make_hash

  json @resource_as_hash
end


#______________________________________________________________________________________________________________________#
#                                                                                                                      #
#                                                   ResourceType                                                       #
#______________________________________________________________________________________________________________________#
# API of all resource_types
get "/api/resource_types" do
  resource_type_list = ResourceType.all

  @resource_type_array = []

  resource_type_list.each do |resource_type|
    @resource_type_array << resource_type.make_hash
  end

  json @resource_type_array
end
