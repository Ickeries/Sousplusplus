extends Control

onready var name_text = $Front/Scroll/Vertical/Header/Vertical/Name
onready var description_text = $Front/Scroll/Vertical/Description/Vertical/Text


onready var ingredient_list = $Back/Scroll/Vertical/Ingredients/Vertical/List
var ingredient_loaded = load("res://src/scenes/recipes/page_recipe/PageRecipeIngredient.tscn")
func _ready():
	Global.connect("update_data", self, "on_update_data")

func on_update_data(id : int):
	
	var recipe = parse_json(Pipeline.get_recipe_by_id(id))
	if recipe:
		description_text.text = recipe["recipe_description"]
		name_text.text = recipe["recipe_name"]
		# Display recipe ingredients
		var ingredients = parse_json(Pipeline.get_recipe_ingredients_by_id(recipe["recipe_id"]))
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


func _on_Read_pressed():
	$Animator.play("to_back")


func _on_Return_pressed():
	$Animator.play_backwards("to_back")
