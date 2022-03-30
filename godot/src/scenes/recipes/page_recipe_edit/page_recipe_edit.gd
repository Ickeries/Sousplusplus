extends Control

signal recipe_page_hide()

var recipe_id = ""

var ingredient_loaded = load("res://src/scenes/recipes/page_recipe_edit/PageRecipeEditIngredient.tscn")
var instruction_loaded = load("res://src/scenes/recipes/page_recipe_edit/PageRecipeEditInstruction.tscn")

onready var ingredient_list = $Scroll/Container/Vertical/Ingredients/Vertical/List
onready var tags = $Scroll/Container/Vertical/Tags/Vertical/Horizontal
var ingredient_list_item_loaded = load("res://src/prefabs/items/list_items/IngredientListItem.tscn")

func _ready():
	Global.connect("update_data", self, "on_update_data")

func on_update_data(id : int):
	var recipe = parse_json(Pipeline.get_recipe_by_id(id))
	if recipe:
		recipe_id = recipe["recipe_id"]
		name_text.text = recipe["recipe_name"]
		description_text.text = recipe["recipe_description"]
		var ingredients = parse_json(Pipeline.get_recipe_ingredients_by_id(recipe["recipe_id"]))
		Global.delete_children(ingredient_list)
		if ingredients:
			for ingredient in ingredients:
				var ingredient_instance = ingredient_loaded.instance()
				ingredient_list.add_child(ingredient_instance)
				ingredient_instance.set_data(ingredient)

func get_recipe_data():
	var temp_data = {}
	temp_data["recipe_id"] = recipe_id
	temp_data["recipe_description"] = description_text.text
	temp_data["recipe_name"] = name_text.text
	temp_data["creator_name"] = "david"
	temp_data["instructions"] = get_recipe_ingredient_data()
	return temp_data

func get_recipe_ingredient_data():
	var ingredient_data = []
	for ingredient in ingredient_list.get_children():
		ingredient_data.push_back(ingredient.get_data())
	return ingredient_data


func save_to_local_database():
	# Update data
	var recipe_data = JSON.print(get_recipe_data())
	Pipeline.save_recipe(recipe_data)


func _on_AddTag_pressed():
	if tags.get_child_count() < 5:
		var line_edit_instance = LineEdit.new()
		tags.add_child(line_edit_instance)


func _on_RemoveTag_pressed():
	if tags.get_child_count() > 0:
		tags.remove_child(tags.get_child(tags.get_child_count()-1))


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

onready var instructions_list = $Scroll/Container/Vertical/Instructions/Vertical/List

func _on_AddInstruction_pressed():
	var instruction_instance = instruction_loaded.instance()
	instructions_list.add_child(instruction_instance)
	
func _on_RemoveInstruction_pressed():
	if instructions_list.get_child_count() > 0:
		instructions_list.remove_child(instructions_list.get_child(instructions_list.get_child_count()-1))
