

# API of all users
get "/api/users" do
  user_list = User.all

  @user_array = []

  user_list.each do |user|
    @user_array << user.make_hash
  end

  json @user_array
end



# API of all assignments
get "/api/assignments" do
  assignment_list = Assignment.all

  @assignment_array = []

  assignment_list.each do |assignment|
    @assignment_array << assignment.make_hash
  end

  json @assignment_array
end


# API of all resources
get "/api/resources" do
  resource_list = Resource.all

  @resource_array = []

  resource_list.each do |resource|
    @resource_array << resource.make_hash
  end

  json @resource_array
end



get "/api/assignments/:id" do
  resource = Resource.all_from_assignment(params["id"])
  contrib = Assignment.all_from_contributions(params["id"])
  assign_data = Assignment.find(params["id"])
  resource_data = []
  contrib_data = []

  resource.each do |r|
    object = Resource.new(r)
    resource_data << object
  end

  contrib.each do |c|
    object = Contribution.new(c)
    contrib_data << object
  end

  @data_array = []
  @data_array << assign_data.make_hash

  resource_data.each do |data|
    @data_array << data.make_hash
  end

  contrib_data.each do |data|
    @data_array << data.make_hash
  end

  json @data_array
end

