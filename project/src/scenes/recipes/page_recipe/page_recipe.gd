extends Control

onready var name_text = $Front/Scroll/Vertical/Header/Vertical/Name
onready var description_text = $Front/Scroll/Vertical/Description/Vertical/Text


onready var ingredient_list = $Back/Scroll/Vertical/Ingredients/Vertical/List
onready var directions_list = $Back/Scroll/Vertical/Directions/Vertical/List

var ingredient_loaded = load("res://src/scenes/recipes/page_recipe/PageRecipeIngredient.tscn")
var direction_loaded = load("res://src/scenes/recipes/page_recipe/PageRecipeDirection.tscn")

var recipe_data = {}
var user_id = -1

func _ready():
	Events.connect("set_recipe", self, "on_set_recipe")

# Updates this page when a new recipe is loaded.
func on_set_recipe(data):
	# Check if valid data
	if !data:
		return false
	
	recipe_data = data
	
	var recipe = Recipe.get_all_recipe_data_by_id( int(recipe_data["recipe_id"]) )
	if recipe:
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
	Events.emit_signal("return_to_previous_page", "immediate")


func _on_PageRecipe_visibility_changed():
	$Animator.play("RESET")


func _on_Title_pressed():
	$Animator.play_backwards("to_back")
