# ---------------------------------------------------------------------
# Assignments Menu
# ---------------------------------------------------------------------

get "/assignments_manager" do
  erb :"assignments/assignments_manager"
end



# ---------------------------------------------------------------------
# Add a assignment
# ---------------------------------------------------------------------

post "/save_assignment" do
  @new_assignment = Assignment.add({"title" => params["title"],
                                    "description" => params["description"],
                                    "repo" => params["repo"]})

  @contributors = params["contributors"]

  @contributors.each do |id|
  @new_contribute = Contribute.add_no_pk({"user_id" => id,
                                          "assignment_id" => @new_assignment.id})
  end

  erb :"assignments/assignment_added"
end



# ---------------------------------------------------------------------
# Find a assignment
# ---------------------------------------------------------------------

# Step 1: List all users.

# done in find_user.erb

# Each user in the ERB is linked to a route that displays a their profile.

# Step 2: Let manager select a user
get "/assignment/:id" do
  @assignment = Assignment.find(params[:id])
  @contributors = Contribute.contributors_of_assignment(@assignment.id)
  @users = []
  @contributors.each do |contributor|
    @users << User.find(contributor.user_id)
  end

  # Takes manager to user/user.id
  erb :"assignment/show"
end



# CHANGE A USER'S NAME
# ---------------

# Step 1: From user's profile (show.erb), select "update"

# Step 2: provide form for user to type a new name for user.
get "/assignment/change_assignment_form/:id" do
  @assignment = Assignment.find(params[:id])
  erb :"assignment/change_assignment_form"
end

# Step 3: params["x"] is the id of the user being modified,
# from the users table convert row of "id" to an object
# store params["name"] in @user_name.name
# UPDATE column "name" row of id with what was entered in form. 
post "/change_assignment" do

  @assignment = Assignment.new({"id" => params["x"].to_i, "title" => params["title"],
                                "description" => params["description"], "repo" => params["repo"]})
  @assignment.save

  erb :"assignment/updated_assignment"
end



# DELETE A ROW FROM USERS TABLE
# ---------------

# Step 1: From user's profile, select "delete"

# Step 2: confirm with user that deleting user will remove user from db
get "/assignment/confirm_delete_assignment/:id" do
  @assignment = Assignment.find(params[:id])
  erb :"assignment/confirm_delete_assignment"
end

# Step 3: remove the row with @user_name.id in id column
get "/assignment/delete_assignment/:id" do
  @assignment = Assignment.find(params[:id])
  Assignment.delete(@assignment.id)
  @deletedvararr = Contribute.delete_contribution(@assignment.id)
  # confirm assignment was deleted from db
  erb :"assignment/assignment_deleted"
end

# ---------------------------------------------------------------------
# Links from assignments_manager to CRUD
# ---------------------------------------------------------------------
get "/assignments/:webpage" do
  erb :"assignments/#{params["webpage"]}"
end
