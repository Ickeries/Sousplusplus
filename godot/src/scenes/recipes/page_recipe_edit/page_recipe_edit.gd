extends Control

signal recipe_page_hide()

# Recipe ID currently being worked on.
var recipe_id = -1

var ingredient_loaded = load("res://src/scenes/recipes/page_recipe_edit/PageRecipeEditIngredient.tscn")
var direction_loaded = load("res://src/scenes/recipes/page_recipe_edit/PageRecipeEditDirection.tscn")

onready var ingredient_list = $Scroll/Container/Vertical/Ingredients/Vertical/List
onready var directions_list = $Scroll/Container/Vertical/Directions/Vertical/List

var ingredient_list_item_loaded = load("res://src/prefabs/items/list_items/IngredientListItem.tscn")

func _ready():
	Global.connect("update_data", self, "on_update_data")

func on_update_data(id : int):
	var recipe = parse_json(Pipeline.get_recipe_by_id(id))
	if recipe:
		recipe_id = int(recipe["recipe_id"])
		name_text.text = recipe["recipe_name"]
		description_text.text = recipe["recipe_description"]
		
		# Deletes stuff
		Global.delete_children(ingredient_list)
		Global.delete_children(directions_list)
		
		
		if recipe.has("ingredients"):
			for ingredient in recipe["ingredients"]:
				var ingredient_instance = ingredient_loaded.instance()
				ingredient_list.add_child(ingredient_instance)
				ingredient_instance.set_data(ingredient)
		if recipe.has("directions"):
			for direction in recipe["directions"]:
				var direction_instance = direction_loaded.instance()
				directions_list.add_child(direction_instance)
				direction_instance.set_data(direction)
	else:
		reset()
	

func get_recipe_data():
	var temp_data = {}
	temp_data["recipe_id"] = recipe_id
	temp_data["recipe_description"] = description_text.text
	temp_data["recipe_name"] = name_text.text
	temp_data["creator_name"] = "david"
	temp_data["ingredients"] = get_recipe_ingredient_data()
	temp_data["directions"] = get_recipe_directions_data()
	return temp_data

func get_recipe_ingredient_data():
	var ingredient_data = []
	for ingredient in ingredient_list.get_children():
		ingredient_data.push_back(ingredient.get_data())
	return ingredient_data

func get_recipe_directions_data():
	var directions_data = []
	for direction in directions_list.get_children():
		directions_data.push_back(direction.get_data())
	return directions_data

func save_to_local_database():
	# Update data
	var recipe_data = JSON.print(get_recipe_data())
	Pipeline.save_recipe(recipe_data)

func reset():
	pass



func _on_Save_pressed():
	save_to_local_database()
	Global.emit_signal("update_data", int(recipe_id))
	Global.emit_signal("set_page", "PageRecipe")


func _on_DontSave_pressed():
	Global.emit_signal("set_page", "PageRecipe")


onready var name_text = $Scroll/Container/Vertical/Name/Horizontal/Text
onready var description = $Scroll/Container/Vertical/Description
onready var description_text = description.get_node("Vertical/Text")


func _on_ClearDescription_pressed():
	description_text.text = ""



func _on_AddIngredient_pressed():
	var ingredient_instance = ingredient_loaded.instance()
	ingredient_instance.id = recipe_id
	ingredient_list.add_child(ingredient_instance)

func _on_RemoveIngredient_pressed():
	if ingredient_list.get_child_count() > 0:
		ingredient_list.remove_child(ingredient_list.get_child(ingredient_list.get_child_count()-1))

func _on_AddInstruction_pressed():
	var direction_instance = direction_loaded.instance()
	directions_list.add_child(direction_instance)
	direction_instance.set_data({"recipe_id":recipe_id, "recipe_description":"", "step":direction_instance.get_index()})
	
func _on_RemoveInstruction_pressed():
	if directions_list.get_child_count() > 0:
		directions_list.remove_child(directions_list.get_child(directions_list.get_child_count()-1))
