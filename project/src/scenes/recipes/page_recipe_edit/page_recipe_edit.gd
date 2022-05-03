extends Control

# Nodes
onready var recipe_name_text = $SubPages/First/RecipeNameText
onready var recipe_description_text = $SubPages/Second/Scroll/Vertical/Description/Vertical/DescriptionText
onready var tag_suggested_list = $SubPages/Second/Scroll/Vertical/Tags/Vertical/SuggestedList/
onready var tag_enabled_list = $SubPages/Second/Scroll/Vertical/Tags/Vertical/EnabledList/
onready var ingredient_list = $SubPages/Third/Scroll/Center/Vertical/Ingredients/Vertical/Center/List/IngredientList
onready var direction_list = $SubPages/Third/Scroll/Center/Vertical/Directions/Vertical/List/DirectionList

onready var add_new_ingredient_button = $SubPages/Third/Scroll/Center/Vertical/Ingredients/Vertical/Center/List/AddNewIngredient
onready var add_new_direction_button = $SubPages/Third/Scroll/Center/Vertical/Ingredients/Vertical/Center/List/AddNewIngredient

var direction_loaded = preload("res://src/scenes/recipes/page_recipe_edit/PageRecipeEditDirection.tscn")
var ingredient_loaded = preload("res://src/scenes/recipes/page_recipe_edit/PageRecipeEditIngredient.tscn")
var tag_loaded = preload("res://src/scenes/recipes/page_recipe_edit/PageRecipeEditTag.tscn")
var to_position : = Vector2(0,0)

var recipe_id : int = -1
var mode = "offline"

func _ready():
	Events.connect("set_recipe", self, "load_recipe")

func _physics_process(delta):
	$SubPages.rect_position = lerp($SubPages.rect_position, to_position, delta * 5.0)

func reset():
	recipe_id = -1
	update_ingredients([])
	update_directions([])
	recipe_name_text.set_text("")
	recipe_description_text.set_text("")

func load_recipe(recipe : Control):
	var recipe_data = {}
	recipe_id = recipe.recipe_id
	mode = recipe.mode
	if mode == "offline":
		recipe_data = Recipe.get_recipe_data_offline(recipe.recipe_id)
	elif mode == "online":
		recipe_data = Recipe.get_recipe_data_online(recipe.recipe_id)
	if recipe_data.has("recipe_name"):
		recipe_name_text.set_text( recipe_data["recipe_name"] )
	
	if recipe_data.has("recipe_description"):
		recipe_description_text.set_text(recipe_data["recipe_description"])
	
	if recipe_data.has("ingredients"):
		update_ingredients(recipe_data["ingredients"])
	if recipe_data.has("directions"):
		update_directions(recipe_data["directions"])


func save_recipe():
	var data = get_data()
	if recipe_id == -1:
		Recipe.save_new_recipe_online(data)
	else:
		Recipe.save_recipe_online(data)

func update_ingredients(ingredients):
	for child in ingredient_list.get_children():
		child.queue_free()
	
	for ingredient in ingredients:
		var ingredient_instance = ingredient_loaded.instance()
		ingredient_instance.load_ingredient(ingredient)
		ingredient_list.add_child(ingredient_instance)

func update_directions(directions):
	for child in direction_list.get_children():
		child.queue_free()
	
	for direction in directions:
		var direction_instance = direction_loaded.instance()
		direction_instance.load_ingredient(direction)
		direction_list.add_child(direction_instance)

func get_data():
	var data = {}
	data["recipe_id"] = recipe_id
	data["recipe_name"] = get_recipe_name()
	data["recipe_description"] = get_description()
	data["user_id"] = Global.current_id
	data["ingredients"] = get_ingredients()
	data["directions"] = get_directions()
	return data

func get_recipe_name():
	return recipe_name_text.get_text()

func get_description():
	return recipe_description_text.get_text()

func get_ingredients():
	var ingredients = []
	for ingredient in ingredient_list.get_children():
		var data = ingredient.get_data()
		ingredients.push_back(data)
	return ingredients

func get_directions():
	var directions = []
	for direction in direction_list.get_children():
		var data = direction.get_data()
		directions.push_back(data)
	return directions

# Add a new ingredient to the list.
func _on_AddNewIngredient_pressed():
	var ingredient_instance = ingredient_loaded.instance()
	ingredient_list.add_child(ingredient_instance)

func _on_AddNewDirection_pressed():
	var direction_instance = direction_loaded.instance()
	direction_list.add_child(direction_instance)

# Updates the grid of suggested tags.
func _on_TagSearchBar_search_edited(text):
	pass 


func _on_Images_pressed():
	pass 



# Signals

func _on_1_pressed():
	to_position = Vector2(-1080,0) * 0


func _on_2_pressed():
	to_position = Vector2(-1080,0) * 1


func _on_3_pressed():
	to_position = Vector2(-1080,0) * 2


func _on_Save_pressed():
	save_recipe()
	reset()
	Events.emit_signal("return_to_previous_page", "fade_to_black")



func _on_RecipeEdit_visibility_changed():
	Events.emit_signal("show_bottom_menu", false)



func _on_Return_pressed():
	Events.emit_signal("return_to_previous_page", "fade_to_black")
