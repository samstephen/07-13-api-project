# ---------------------------------------------------------------------
# Resources Menu
# ---------------------------------------------------------------------

get "/resources_manager" do
  erb :"resources/resources_manager"
end



# ---------------------------------------------------------------------
# Add a Resource
# ---------------------------------------------------------------------

post "/save_resource" do
  @resource_type = ResourceType.find(params["category"])

  @new_resource = Resource.add({"post" => params["post"],
                                "type_id" => params[@resource_type.id],
                                "assignment_id" => params["assignment_id"]})

  erb :"resources/resource_added"
end



# ---------------------------------------------------------------------
# Find a Resource
# ---------------------------------------------------------------------

get "/resource/:id" do
  @resource = Resource.find(params[:id])
  @contributors = Contribute.contributors_of_assignment(@assignment.id)
  @users = []
  @contributors.each do |contributor|
    @users << User.find(contributor.user_id)
  end

  # Takes manager to user/user.id
  erb :"resource/show"
end

get "/resource/view" do
  @resource = Resource.all
  erb :"resource/view"
end


get "/resource_add_to_database" do
  add_hash = {"link" => params["resource"]["link"], "assignments_id" => params["resource"]["assignments_id"]}

  Resource.add(add_hash)
  erb :"success/success"
end

get "/resource/edit" do
  @resource = Resource.all
  @assignments = Assignment.all
  erb :"resource/edit"
end

get "/resource_change_in_database" do
  resource_to_change = Resource.find(params["resource"]["change_id"])
  resource_to_change.link = params["resource"]["link"]
  resource_to_change.assignments_id = params["resource"]["assignments_id"]

  resource_to_change.save
  erb :"success/success"
end

get "/resource/delete" do
  @resource = Resource.all
  erb :"resource/delete"
end

get "/resource_delete_from_database" do
  Resource.delete(params["resource"]["delete_id"])
  erb :"success/success"
end





# ---------------------------------------------------------------------
# Links from resources_manager to CRUD
# ---------------------------------------------------------------------
get "/resources/:webpage" do
  erb :"resources/#{params["webpage"]}"
end


