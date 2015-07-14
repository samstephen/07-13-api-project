get "/api/assignments" do
  assign_list = Assignment.all_hash

  @assign_array = []

  assign_list.each do |assign|
    @assign_array << assign.make_hash
  end

  json @assign_array
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


get "/api/resources" do
  resource_list = Resource.all

  @resource_array = []

  resource_list.each do |rec|
    @resource_array << rec.make_hash
  end

  json @resource_array
end