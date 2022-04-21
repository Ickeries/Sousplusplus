extends Node


func create_user(username : String, password : String):
	var user_dict = {}
	user_dict["name"] = username
	user_dict["password"] = password
	Global.db.open_db()
	Global.db.insert_row("users", user_dict)
	Global.db.close_db()

func login_user(username : String, password : String):
	var statement = """Select * from users where name = '%s' and password = '%s';""" % [username, password]
	return Global.query_single(statement)

func get_user_name_by_id(id : int):
	var statement = """Select name from users where id = %s;""" % [id]
	var result = Global.query_single(statement)
	if result:
		return result["name"]
	return null

func get_user_favorite_recipes(id : int):
	pass
