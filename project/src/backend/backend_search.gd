extends Node


func get_recipes_by_name(text : String):
	var statement = """Select * from recipes as a inner join users as b on a.user_id = b.id
						where recipe_name like '%c%s%c';""" % ["%",text, "%"]
	
	var results = Global.query(statement)
	return results

func get_recipes_by_user_id(id : int):
	var statement = """Select * from recipes where user_id = %s;""" % [id]
	return Global.query(statement)
