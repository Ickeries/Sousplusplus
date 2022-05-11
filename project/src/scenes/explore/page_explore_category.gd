extends VBoxContainer

onready var title = $Center/Horizontal/Title
onready var grid = $Grid

var recipe_loaded = load("res://src/prefabs/recipe/Recipe.tscn")
var mode = "offline"


func set_title(new_title : String):
	title.set_text(new_title)

func set_mode(new_mode : String):
	mode = new_mode

func add_recipes(recipes, limit):
	var count = 0
	for recipe in recipes:
		if count >= limit:
			break
		var recipe_instance = recipe_loaded.instance()
		recipe_instance.mode = mode
		recipe_instance.data = recipe
		grid.add_child(recipe_instance)
		count += 1


func _on_Hide_pressed():
	grid.visible = !grid.visible


func _on_Category_renamed():
	title.set_text(name)
