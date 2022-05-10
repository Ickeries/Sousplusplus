extends Node




func create_user(username : String, password : String):
	var statement = """Insert into users (user_name, user_password) values ('%s', '%s') returning user_id, user_name, user_password;""" % [username, password]
	return Database.query_online_single(statement)
func login_user(username : String, password : String):
	var statement = """Select * from users where user_name = '%s' and user_password = '%s';""" % [username, password]
	return Database.query_online_single(statement)

func does_user_exist(username : String):
	var statement = """Select user_id from users where user_name = '%s'""" % [username]
	var result = Database.query_online_single(statement)
	if result:
		return true
	else:
		return false

func get_user_name_by_id(id : int):
	var statement = """Select user_name from users where user_id = %s;""" % [id]
	var result = Database.query_online_single(statement)
	if result:
		return result["user_name"]
	return null


func get_user_created_recipes(id: int):
	var statement = """Select * from recipes where user_id = '%s';""" % [id]
	var result = Database.query_online(statement)
	return result

func get_user_favorite_recipes(id : int):
	var statement = """Select recipe_id from user_favorites where user_id = %s""" % [id]
	var results = Database.query_online(statement)
	return results
