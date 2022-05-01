extends Control

signal filter_exited()
signal filter_applied()

onready var filter_category_loaded = load("res://src/prefabs/filter/FilterCategory.tscn")

export (Array, String) var categories = []


# Loops through every given recipe and checks if the recipe has tags coinciding with all enabled options
func filter_recipes(recipes):
	var new_recipes = []
	var options = get_all_enabled_options()
	for recipe in recipes:
		var recipe_tags = Recipe.get_recipe_tags_by_id(recipe["recipe_id"])
		var filtered = false
		for option in options:
			if recipe_tags.find(option) == -1:
				filtered = true
				break
		if filtered == false:
			new_recipes.push_back(recipe)
	return new_recipes


func get_all_enabled_options():
	var enabled = []
	for category in $Vertical/Scroll/Center/Vertical.get_children():
		for option in category.get_options():
			if option.pressed:
				enabled.push_back(option.text)
	return enabled


func _on_Apply_pressed():
	emit_signal("filter_applied")


func _on_Cancel_pressed():
	emit_signal("filter_exited")
