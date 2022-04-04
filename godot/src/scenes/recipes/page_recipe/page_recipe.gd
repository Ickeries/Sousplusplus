extends Control

onready var name_text = $Front/Scroll/Vertical/Header/Vertical/Name
onready var description_text = $Front/Scroll/Vertical/Description/Vertical/Text


onready var ingredient_list = $Back/Scroll/Vertical/Ingredients/Vertical/List
onready var directions_list = $Back/Scroll/Vertical/Directions/Vertical/List

var ingredient_loaded = load("res://src/scenes/recipes/page_recipe/PageRecipeIngredient.tscn")
var direction_loaded = load("res://src/scenes/recipes/page_recipe/PageRecipeDirection.tscn")

var recipe_id = -1
var user_id = -1

func _ready():
	Global.connect("update_data", self, "on_update_data")

# Updates this page when a new recipe is loaded.
func on_update_data(id : int):
	var recipe = parse_json(Pipeline.get_recipe_by_id(id))
	if recipe:
		recipe_id = int(recipe["recipe_id"])
		user_id = int(recipe["user_id"])
		description_text.text = recipe["recipe_description"]
		name_text.text = recipe["recipe_name"]
		# Display recipe ingredients
		Global.delete_children(ingredient_list)
		Global.delete_children(directions_list)
		
		# Sets ingredients
		if recipe.has("ingredients"):
			for ingredient in recipe["ingredients"]:
				var ingredient_instance = ingredient_loaded.instance()
				ingredient_list.add_child(ingredient_instance)
				ingredient_instance.set_data(ingredient)
		
		# Sets directions
		if recipe.has("directions"):
			for direction in recipe["directions"]:
				var direction_instance = direction_loaded.instance()
				directions_list.add_child(direction_instance)
				direction_instance.set_data(direction)
	

func _on_Button_pressed():
	Global.emit_signal("enter_return")

func _on_Edit_pressed():
	Global.emit_signal("set_page", "PageRecipeEdit")


func _on_Read_pressed():
	$Animator.play("to_back")


func _on_Return_pressed():
	$Animator.play_backwards("to_back")


func _on_Exit_pressed():
	Global.emit_signal("enter_return")


func _on_PageRecipe_visibility_changed():
	$Animator.play("RESET")
