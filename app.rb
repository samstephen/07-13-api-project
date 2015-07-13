require "pry"
require "sinatra"
require "sinatra/json"
require "sinatra/reloader"

# SQL/Database
require "sqlite3"
require_relative 'database_setup.rb'

# Models
require_relative 'models/user.rb'
require_relative 'models/contribute.rb'
require_relative 'models/assignment.rb'
require_relative 'models/type.rb'
require_relative 'models/resource.rb'

# Controllers
require_relative "controllers/main.rb"
require_relative "controllers/users.rb"
require_relative 'controllers/assignments.rb'
require_relative 'controllers/resources.rb'


# create rows for types
Type.add({ "id" => 1, "category" => "video" })
Type.add({ "id" => 2, "category" => "article" })