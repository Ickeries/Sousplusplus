extends Control

signal filter_exited()

onready var filter_category_loaded = load("res://src/prefabs/filter/FilterCategory.tscn")

export (Array, String) var categories = []


# Populates existing filter options by using list of recipes
func sort_recipes_by_categories(recipes):
	print(recipes)





func _on_DietButton_pressed():
	$Scroll/Vertical/Diet/Vertical/Margin/List.visible = !$Scroll/Vertical/Diet/Vertical/Margin/List.visible

func _on_CategoryButton_pressed():
	$Scroll/Vertical/Category/Vertical/List.visible = !$Scroll/Vertical/Category/Vertical/List.visible


func _on_Title_pressed():
	emit_signal("filter_exited")
