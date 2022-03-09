extends Control

var ingredient_list_item_loaded = load("res://src/prefabs/objects/list_items/IngredientListItem.tscn")

func _ready():
	call_deferred("_deferred")

func _deferred():
	for child in $Scroll/Items/Ingredients/VBox/Container.get_children():
		child.queue_free()
	
	var recipes = parse_json(Pipeline.get_recipe_by_name(Global.current_recipe))
	if recipes.size() > 0:
		var recipe = recipes[0]
		if recipe.has("recipe_name"):
			$Scroll/Items/Header/Title.set_text(recipe["recipe_name"])
		if recipe.has("recipe_description"):
			$Scroll/Items/Header/Description.set_text(recipe["recipe_description"])
	
	var results = parse_json(Pipeline.get_recipe_ingredients_by_name(Global.current_recipe))
	for result in results:
		var ingredient_list_item_instance = ingredient_list_item_loaded.instance()
		$Scroll/Items/Ingredients/VBox/Container.add_child(ingredient_list_item_instance)
		ingredient_list_item_instance.set_data(result)

func load_recipe(id : int):
	pass


func _on_GoBack_pressed():
	get_tree().change_scene("res://src/scenes/explore/Explore.tscn")
