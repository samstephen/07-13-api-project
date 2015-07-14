# ---------------------------------------------------------------------
# Users Menu
# ---------------------------------------------------------------------

get "/users_manager" do
  erb :"users/users_manager"
end



# ---------------------------------------------------------------------
# Add a user
# ---------------------------------------------------------------------

# Step 1: Display a form into which the user will add new user info.

#  * See bottom to see how link works *
#     get "/users/add_user_form" do
#       erb :"users/add_user_form"
#     end

# Step 2: Take the information they submitted and use it to create new record.
get "/save_user" do
  # Since the form's action was "/save_user", it sent its values here.
  #
  # Sinatra stores them for us in `params`, which is a hash. Like this:
  #
  # {"name" => "Sam Stephen"}

  # So using `params`, we can run our class/instance methods as needed
  # to create a user record.

  @new_user = User.add({"name" => params["name"]})
  erb :"users/user_added"
end



# ---------------------------------------------------------------------
# Find a user
# ---------------------------------------------------------------------

# Step 1: List all users.

# done in find_user.erb

# Each user in the ERB is linked to a route that displays a their profile.

# Step 2: Let manager select a user
get "/user/:id" do
  @user = User.find(params[:id])
  # Takes manager to user/user.id
  erb :"user/show"
end


get "/user/assignment_list/:id" do
  @user = User.find(params[:id])
  @contributes = Contribute.user_assignments(@user.id)
  @assignments_of_user = []
  @contributes.each do |contribute|
  @assignments_of_user << Assignment.find(contribute.assignment_id)
  end
  erb :"user/assignment_list"
end

# ---------------------------------------------------------------------
# User's profile
# ---------------------------------------------------------------------

# CHANGE A USER'S NAME
# ---------------

# Step 1: From user's profile (show.erb), select "update"

# Step 2: provide form for user to type a new name for user.
get "/user/change_name_form/:id" do
  @user = User.find(params[:id])
  erb :"user/change_name_form"
end

# Step 3: params["x"] is the id of the user being modified,
# from the users table convert row of "id" to an object
# store params["name"] in @user_name.name
# UPDATE column "name" row of id with what was entered in form.
get "/change_user_name" do

  @user = User.new({"id" => params["x"].to_i, "name" => params["name"]})
  @user.save
  # confirm user's name was updated in database
  erb :"user/updated_user_name"
end


# DELETE A ROW FROM USERS TABLE
# ---------------

# Step 1: From user's profile, select "delete"

# Step 2: confirm with user that deleting user will remove user from db
get "/user/confirm_delete_user/:id" do
  @user = User.find(params[:id])
  erb :"user/confirm_delete_user"
end

# Step 3: remove the row with @user_name.id in id column
get "/user/delete_user/:id" do
  @user = User.find(params[:id])
  User.delete(@user.id)
  # confirm user was deleted from db
  erb :"user/user_deleted"
end



# ---------------------------------------------------------------------
# Links from users_manager to CRUD
# ---------------------------------------------------------------------
get "/users/:webpage" do
  erb :"users/#{params["webpage"]}"
end








