extends Control

onready var name_text = $Scroll/Vertical/Header/Vertical/Name
onready var description_text = $Scroll/Vertical/Description/Vertical/Text


onready var ingredient_list = $Scroll/Vertical/Ingredients/Vertical/List
var ingredient_loaded = load("res://src/scenes/recipes/page_recipe/PageRecipeIngredient.tscn")
func _ready():
	Global.connect("update_data", self, "on_update_data")

func on_update_data(new_data : Dictionary):
	if !new_data.has_all(["recipe_id"]):
		return
	description_text.text = new_data["recipe_description"]
	name_text.text = new_data["recipe_name"]
	
	var ingredients = parse_json(Pipeline.get_recipe_ingredients_by_id(new_data["recipe_id"]))
	Global.delete_children(ingredient_list)
	if ingredients:
		for ingredient in ingredients:
			var ingredient_instance = ingredient_loaded.instance()
			ingredient_list.add_child(ingredient_instance)
			ingredient_instance.set_data(ingredient)
	

func _on_Button_pressed():
	Global.emit_signal("enter_return")

func _on_Edit_pressed():
	Global.emit_signal("set_page", "PageRecipeEdit")
