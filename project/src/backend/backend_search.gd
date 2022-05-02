extends Node


func get_recipes_by_name(text : String, database="offline"):
	var statement = """Select * from recipes where recipe_name like '%c%s%c';""" % ["%",text, "%"]
	
	var results = []
	if database == "offline":
		results = Database.query(statement)
	elif database == "online":
		results = Database.query_online(statement)
	return results

func get_recipes_by_user_id(id : int):
	var statement = """Select * from recipes where user_id = %s;""" % [id]
	return Database.query(statement)

func get_favorite_recipes(id : int):
	var statement = """SELECT recipe_id from user_favorites where user_id = %s; """ % [id]
	return Database.query(statement)
