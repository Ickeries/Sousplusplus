extends Node


# Online 
func search_recipes_online(text : String):
	text = text.to_lower()
	var statement = """Select * from recipes where LOWER(recipe_name) like '%c%s%c';""" % ["%",text, "%"]
	return Database.query_online(statement)

func search_recipes_by_user_id(id : int):
	var statement = """Select * from recipes where user_id = %s;""" % [id]
	return Database.query_online(statement)

func search_user_favorite_recipes(id : int):
	var statement = """Select * from recipes as a where exists (Select * from user_favorites as b where b.user_id = %s and a.recipe_id = b.recipe_id);""" % [id]
	return Database.query_online(statement)


# Offline 
func search_recipes_offline(text : String):
	var statement = """Select * from recipes where recipe_name like '%c%s%c';""" % ["%",text, "%"]
	return Database.query(statement)
