extends Control

# Nodes
onready var recipe_name_text = $SubPages/First/RecipeNameText
onready var recipe_description_text = $SubPages/Second/Scroll/Vertical/Description/Vertical/DescriptionText
onready var tag_list = $SubPages/Second/Scroll/Vertical/Tags/Vertical/SuggestedList/
onready var ingredient_list = $SubPages/Third/Scroll/Center/Vertical/Ingredients/Vertical/Center/List/IngredientList
onready var direction_list = $SubPages/Third/Scroll/Center/Vertical/Directions/Vertical/List/DirectionList

onready var add_new_ingredient_button = $SubPages/Third/Scroll/Center/Vertical/Ingredients/Vertical/Center/List/AddNewIngredient
onready var add_new_direction_button = $SubPages/Third/Scroll/Center/Vertical/Ingredients/Vertical/Center/List/AddNewIngredient

onready var image = $SubPages/First/Images

var direction_loaded = load("res://src/scenes/recipes/page_recipe_edit/PageRecipeEditDirection.tscn")
var ingredient_loaded = load("res://src/scenes/recipes/page_recipe_edit/PageRecipeEditIngredient.tscn")
var tag_loaded = load("res://src/scenes/recipes/page_recipe_edit/PageRecipeEditTag.tscn")


var to_position : = Vector2(0,0)

var recipe_id : int = -1
var tags = []
var mode = "offline"

func _ready():
	Events.connect("set_recipe", self, "load_recipe")
	Events.connect("new_recipe", self, "on_new_recipe")
	Events.connect("image_confirmed", self, "on_image_confirmed")

func _physics_process(delta):
	$SubPages.rect_position = lerp($SubPages.rect_position, to_position, delta * 5.0)

func set_edit(value : bool):
	$Delete.visible = value
	$SubPages/First/Images.disabled = !value
	$Menu/Save.visible = value
	$SubPages/Third/Scroll/Center/Vertical/Ingredients/Vertical/Center/List/AddNewIngredient.visible = value
	$SubPages/Third/Scroll/Center/Vertical/Directions/Vertical/List/AddNewDirection.visible = value

func reset():
	to_position = Vector2(-1080,0) * 0
	recipe_id = -1
	update_ingredients([])
	update_directions([])
	recipe_name_text.set_text("")
	recipe_description_text.set_text("")
	image.texture_normal = null

func load_recipe(recipe : Control):
	recipe_id = recipe.recipe_id
	var recipe_data = Recipe.get_recipe_data_online(recipe.recipe_id)
	if recipe_data.has("recipe_name"):
		recipe_name_text.set_text( recipe_data["recipe_name"] )
	
	if recipe_data.has("recipe_description"):
		recipe_description_text.set_text(recipe_data["recipe_description"])
	
	if recipe_data.has("ingredients"):
		update_ingredients(recipe_data["ingredients"])
	if recipe_data.has("directions"):
		update_directions(recipe_data["directions"])
	
	if recipe_data.has("recipe_image"):
		image.texture_normal = load("res://assets/images/%s" % [recipe_data.recipe_image])
	print(recipe_id)
	if recipe_data.has("user_id"):
		if recipe_data["user_id"] == Global.current_id:
			set_edit(true)
		elif recipe_id == -1:
			set_edit(true)
		else:
			set_edit(false)
	if recipe_id == -1:
		reset()
	
	update_tags(recipe_data["tags"])

func on_new_recipe():
	reset()
	recipe_id = -1
	set_edit(true)

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
		ingredient_instance.call_deferred("load_ingredient", ingredient)
		ingredient_list.add_child(ingredient_instance)

func update_directions(directions):
	for child in direction_list.get_children():
		child.queue_free()
	
	for direction in directions:
		var direction_instance = direction_loaded.instance()
		direction_instance.data = direction
		direction_list.add_child(direction_instance)

func update_tags(tags):
	for child in tag_list.get_children():
		child.queue_free()
	
	for tag_data in tags:
		var tag_instance = tag_loaded.instance()
		tag_instance.data = tag_data
		tag_list.add_child(tag_instance)
		tag_instance.enabled = true
	
	
	var random_tags = Search.search_random_tags(10)
	for tag_data in random_tags:
		var already_has : bool = false
		for tag in tags:
			if tag.hash() == tag_data.hash():
				already_has = true
				continue
		if already_has:
			continue
		var tag_instance = tag_loaded.instance()
		tag_instance.data = tag_data
		tag_list.add_child(tag_instance)

func get_data():
	var data = {}
	data["recipe_id"] = recipe_id
	data["recipe_name"] = get_recipe_name()
	data["recipe_description"] = get_description()
	data["recipe_image"] = get_image()
	data["user_id"] = Global.current_id
	data["ingredients"] = get_ingredients()
	data["directions"] = get_directions()
	data["tags"] = get_tags()
	return data

func get_recipe_name():
	return recipe_name_text.get_text()

func get_description():
	return recipe_description_text.get_text()

func get_image():
	return image.texture_normal.resource_path.trim_prefix("res://assets/images/")

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

func get_tags():
	var tags = []
	for tag in tag_list.get_children():
		if tag.is_pressed():
			var data = tag.get_data()
			tags.push_back(data)
	return tags

# Add a new ingredient to the list.
func _on_AddNewIngredient_pressed():
	var ingredient_instance = ingredient_loaded.instance()
	ingredient_list.add_child(ingredient_instance)

func _on_AddNewDirection_pressed():
	var direction_instance = direction_loaded.instance()
	direction_list.add_child(direction_instance)



func _on_Images_pressed():
	$Images.popup()

func on_image_confirmed(image_path):
	image.texture_normal = load(image_path)
	$Images.hide()


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
	reset()
	Events.emit_signal("return_to_previous_page", "fade_to_black")


func _on_Delete_pressed():
	if recipe_id != -1:
		Recipe.delete_recipe(recipe_id)
	reset()
	Events.emit_signal("return_to_previous_page", "fade_to_black")


func _on_Scroll_gui_input(event):
	pass # Replace with function body.

onready var tag_search_bar = $SubPages/Second/Scroll/Vertical/Tags/Vertical/TagSearchBar

func _on_CreateNewTag_pressed():
	var tag_name = tag_search_bar.get_text()
	var tag_data = Recipe.add_new_tag(tag_name)
	if tag_data:
		var tag_instance = tag_loaded.instance()
		tag_list.add_child(tag_instance)
		tag_instance.data = tag_data
		tag_instance.enabled = true
		
		tag_search_bar.set_text("")

# Updates the grid of suggested tags.
func _on_TagSearchBar_search_edited(text):
	for child in tag_list.get_children():
		if child.is_pressed():
			continue
		child.queue_free()
	
	var searched_tags = Search.search_tags(text)
	for tag_data in searched_tags:
		var tag_instance = tag_loaded.instance()
		tag_instance.data = tag_data
		tag_list.add_child(tag_instance)
