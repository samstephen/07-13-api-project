# ---------------------------------------------------------------------
# Main Menu
# ---------------------------------------------------------------------
get "/home" do
  @assignments = Assignment.all
  erb :"main/home"
end
