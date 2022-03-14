extends Control

var ingredient_list_item_loaded = load("res://src/prefabs/items/list_items/IngredientListItem.tscn")

onready var header_title = $Scroll/Items/Header/Vertical/Title
onready var header_creator = $Scroll/Items/Header/Vertical/Creator
onready var description_title = $Scroll/Items/Description/Vertical/Text


func _ready():
	call_deferred("_deferred")

func _deferred():
	for child in $Scroll/Items/Ingredients/VBox/Container.get_children():
		child.queue_free()
	
	var recipes = parse_json(Pipeline.get_recipe_by_name(Global.current_recipe))
	if recipes.size() > 0:
		var recipe = recipes[0]
		if recipe.has("recipe_name"):
			header_title.set_text(recipe["recipe_name"])
		if recipe.has("recipe_creator"):
			header_creator.set_text(recipe["recipe_creator"])
		if recipe.has("recipe_description"):
			description_title.set_text(recipe["recipe_description"])
	
	# Ingredients
	var ingredients = parse_json(Pipeline.get_recipe_ingredients_by_name(Global.current_recipe))
	for result in ingredients:
		var ingredient_list_item_instance = ingredient_list_item_loaded.instance()
		$Scroll/Items/Ingredients/VBox/Container.add_child(ingredient_list_item_instance)
		ingredient_list_item_instance.set_data(result)

func load_recipe(id : int):
	pass


func _on_GoBack_pressed():
	get_tree().change_scene("res://src/scenes/explore/Explore.tscn")


func _on_Text_request_completion():
	print("LEL")

