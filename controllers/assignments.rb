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
get "/recipe/change_recipe_form/:id" do
  @recipe = Assignment.find(params[:id])
  erb :"recipe/change_recipe_form"
end

# Step 3: params["x"] is the id of the user being modified,
# from the users table convert row of "id" to an object
# store params["name"] in @user_name.name
# UPDATE column "name" row of id with what was entered in form. 
post "/change_recipe" do

  @recipe = Assignment.new({"id" => params["x"].to_i, "title" => params["title"], "published_date" => params["published_date"],
                        "content" => params["content"], "user_id" => params["user_id"].to_i, "meal_id" => params["meal_id"].to_i})
  @recipe.save

  @new_tag = []
  @new_tags_arr = params["tag"].split(",")

  @new_tags_arr.each do |tag|
    @new_tag << Tag.add( { "tag" => "#{tag}" } )
  end

  @tag_arr = []
  @new_tag.each do |tag_obj|
    @tag_arr << tag_obj.id
  end

  @new_recipe.id

  @tag_arr.each do | tag_id |
    AssignmentTag.add( { "recipe_id" => @new_recipe.id, "tag_id" => "#{tag_id}" } )
  end

  # confirm user's name was updated in database
  erb :"recipe/updated_recipe"
end



# ---------------------------------------------------------------------
# Links from recipes_manager to CRUD
# ---------------------------------------------------------------------
get "/assignments/:webpage" do
  erb :"assignments/#{params["webpage"]}"
end
