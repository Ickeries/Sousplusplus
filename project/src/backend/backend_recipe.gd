extends Node

# Returns all data of a recipe. including ingredients and instructions
func get_all_recipe_data_by_id(id : int):
	# Obtain main recipe data
	var query = """ Select * from recipes as a inner join users as b on a.user_id = b.id where recipe_id = %s;""" % [id]
	var results = Global.query_single(query)
	if results:
		# Obtain recipe ingredient data
		results["ingredients"] = Global.query(""" Select * from recipe_ingredients where recipe_id = %s;""" % [id])
		#Obtain recipe directions
		results["directions"] = Global.query(""" Select * from recipes_directions where recipe_id = %s;""" % [id])
		#Obtain recipe tags
		results["tags"] = Global.query("""Select * from recipe_tags where recipe_id = %s;""" % [id])
	return results



func get_recipe_tags_by_id(id : int):
	var list = []
	var results = Global.query("""Select tag_name from recipe_tags where recipe_id = %s;""" % [id])
	for result in results:
		list.push_back(result["tag_name"])
	return list


func clear_recipe_ingredients(id : int ):
	var statement = """Delete from recipe_ingredients where recipe_id = %s;""" % [id]
	Global.query(statement)

func save_recipe_ingredients(ingredients):
	Global.db.open_db()
	for ingredient in ingredients:
		Global.db.insert_row("recipe_ingredients", ingredient)
	Global.db.close_db()

func clear_recipe_directions(id : int):
	var statement = """Delete from recipes_directions where recipe_id = %s;""" % [id]
	Global.query(statement)

func save_recipe_directions(directions):
	Global.db.open_db()
	for direction in directions:
		Global.db.insert_row("recipes_directions", direction)
	Global.db.close_db()

func save_recipe(data : Dictionary):
	var table_name = "recipes"

	if data["recipe_id"] == -1:
		var statement = "SELECT seq FROM SQLITE_SEQUENCE WHERE name = 'recipes' LIMIT 1;"
		var result = Global.query_single(statement)
		if result:
			data["recipe_id"] = int(result["seq"]) + 1
	
	# Update recipe ingredients
	if data["ingredients"].size() > 0:
		clear_recipe_ingredients(data["recipe_id"])
		save_recipe_ingredients(data["ingredients"])
	
	if data["directions"].size() > 0:
		clear_recipe_directions(data["recipe_id"])
		save_recipe_directions(data["directions"])
	
	# Update main recipe Data
	var statement = """Replace into %s 
						(recipe_id, recipe_name, user_id, recipe_description) 
						VALUES (%s, '%s', %s, '%s'); """ % ["recipes", data["recipe_id"], data["recipe_name"], data["user_id"], data["recipe_description"]]
	print(statement)
	Global.query(statement)
