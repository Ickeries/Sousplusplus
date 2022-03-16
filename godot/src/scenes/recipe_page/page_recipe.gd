extends Control

signal recipe_page_hide()

var ingredient_list_item_loaded = load("res://src/prefabs/items/list_items/IngredientListItem.tscn")

func _ready():
	call_deferred("_deferred")

func _deferred():
	pass
	
func load_recipe(id : int):
	pass


func _on_Return_pressed():
	emit_signal("recipe_page_hide")
