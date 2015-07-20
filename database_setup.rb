# load/create our database for this program
CONNECTION = SQLite3::Database.new("api-project.db")

# never change this table, it's not modifiable by any user
CONNECTION.execute("DROP TABLE IF EXISTS resource_types;")

# creating tables (no need for "IF NOT EXISTS" if dropping table)
CONNECTION.execute("CREATE TABLE IF NOT EXISTS users (id INTEGER PRIMARY KEY, name TEXT, password TEXT, email TEXT);")
CONNECTION.execute("CREATE TABLE IF NOT EXISTS contributes (user_id INTEGER, assignment_id INTEGER);")
CONNECTION.execute("CREATE TABLE IF NOT EXISTS assignments (id INTEGER PRIMARY KEY, title TEXT, description TEXT, repo TEXT);")
CONNECTION.execute("CREATE TABLE IF NOT EXISTS resources (id INTEGER PRIMARY KEY, assignment_id TEXT, type_id INTEGER, post TEXT);")
CONNECTION.execute("CREATE TABLE resource_types (id INTEGER PRIMARY KEY, category TEXT);")

# transforms sqlite tables(or rows/columns) to ruby hashes
CONNECTION.results_as_hash = true

