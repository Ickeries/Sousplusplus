extends VBoxContainer

var recipe_loaded = load("res://src/prefabs/recipe/Recipe.tscn")
func set_title(title : String):
	$Horizontal/Title.set_text(title)

func add_items(items):
	for item in items:
		var recipe_instance = recipe_loaded.instance()
		recipe_instance.set_data(item)
		$Grid.add_child(recipe_instance)


func _on_Hide_pressed():
	$Grid.visible = !$Grid.visible
