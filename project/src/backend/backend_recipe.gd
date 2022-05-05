extends Node

# Returns all data of a recipe. including ingredients and instructions

func get_recipe_data_offline(id : int):
	# Obtain main recipe data
	var query = """ Select * from recipes as a inner join users as b on a.user_id = b.user_id where recipe_id = %s;""" % [id]
	var results = Database.query_single(query)
	if results:
		# Obtain recipe ingredient data
		results["ingredients"] = Database.query(""" Select * from recipe_ingredients where recipe_id = %s;""" % [id])
		#Obtain recipe directions
		results["directions"] = Database.query(""" Select * from recipes_directions where recipe_id = %s;""" % [id])
		#Obtain recipe tags
		results["tags"] = Database.query("""Select * from recipe_tags where recipe_id = %s;""" % [id])
	return results


func get_recipe_data_online(id : int):
	# Obtain main recipe data
	var query = """Select * from recipes where recipe_id = %s;""" % [id]
	var results = Database.query_online_single(query)
	if results:
		# Obtain recipe ingredient data
		results["ingredients"] = Database.query_online(""" Select * from recipe_ingredients where recipe_id = %s;""" % [id])
		#Obtain recipe directions
		results["directions"] = Database.query_online(""" Select * from recipe_directions where recipe_id = %s;""" % [id])
		#Obtain recipe tags
		results["tags"] = Database.query_online("""Select * from recipe_tags where recipe_id = %s;""" % [id])
	return results


func save_new_recipe_online(recipe):
	var query = """Insert into recipes (user_id, recipe_name, recipe_description) values (%s, '%s', '%s') RETURNING recipe_id;""" % [recipe.user_id, recipe.recipe_name, recipe.recipe_description]
	var result = Database.query_online_single(query)
	if result:
		var recipe_id = result.recipe_id
		for ingredient in recipe.ingredients:
			var statement2 = """Insert into recipe_ingredients (recipe_id, ingredient_name, ingredient_amount, ingredient_unit) values (%s, '%s', %s, '%s') """ % [recipe_id, ingredient.ingredient_name, ingredient.ingredient_amount, ingredient.ingredient_unit] 
			Database.query_online(statement2)
		
		for direction in recipe.directions:
			var statement2 = """Insert into recipe_directions (recipe_id, text, step) values (%s, '%s', %s) """ % [recipe_id, direction.text, direction.step] 
			Database.query_online(statement2)



func save_recipe_online(recipe):
	var query = """Update recipes set recipe_name = '%s', recipe_description = '%s' where recipe_id = %s""" % [recipe.recipe_name, recipe.recipe_description, recipe.recipe_id]
	Database.query_online(query)
	# Save ingredients
	var statement = """Delete from recipe_ingredients where recipe_id = %s;""" % [recipe.recipe_id]
	Database.query_online(statement)
	for ingredient in recipe.ingredients:
		var statement2 = """Insert into recipe_ingredients (recipe_id, ingredient_name, ingredient_amount, ingredient_unit) values (%s, '%s', %s, '%s') """ % [recipe.recipe_id, ingredient.ingredient_name, ingredient.ingredient_amount, ingredient.ingredient_unit] 
		Database.query_online(statement2)

	statement = """Delete from recipe_directions where recipe_id = %s;""" % [recipe.recipe_id]
	Database.query_online(statement)
	for direction in recipe.directions:
		var statement2 = """Insert into recipe_directions (recipe_id, text, step) values (%s, '%s', %s) """ % [recipe.recipe_id, direction.text, direction.step] 
		Database.query_online(statement2)

func delete_recipe(id : int):
	var statement = """Delete from recipes where recipe_id = %s""" % [id]
	Database.query_online(statement)
	
	statement = """Delete from recipe_directions where recipe_id = %s""" % [id]
	Database.query_online(statement)
	
	statement = """Delete from recipe_ingredients where recipe_id = %s""" % [id]
	Database.query_online(statement)
	
	statement = """Delete from user_favorites where recipe_id = %s""" % [id]
	Database.query_online(statement)
	
	statement = """Delete from recipe_tags where recipe_id = %s""" % [id]
	Database.query_online(statement)

func get_recipe_tags_by_id(id : int):
	var list = []
	var results = Database.query("""Select tag_name from recipe_tags where recipe_id = %s;""" % [id])
	for result in results:
		list.push_back(result["tag_name"])
	return list

func add_favorite_recipe(recipe_id: int):
	var date = "11/11/1111"
	var statement = """Insert into user_favorites (user_id, recipe_id, date_favorited)
						Values(%s, %s, '%s'); """  % [Global.current_id, recipe_id, date]
	Database.query_online(statement)

func remove_favorite_recipe(recipe_id: int):
	var statement= """DELETE from user_favorites 
					  WHERE recipe_id = %s and user_id = %s""" % [recipe_id, Global.current_id]
	Database.query_online(statement)
