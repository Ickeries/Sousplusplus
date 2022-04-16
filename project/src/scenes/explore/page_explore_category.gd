extends VBoxContainer

var item_loaded = load("res://src/prefabs/items/Item.tscn")

func set_title(title : String):
	$Horizontal/Title.set_text(title)

func add_items(items):
	for item in items:
		var item_instance = item_loaded.instance()
		item_instance.set_data(item)
		$Grid.add_child(item_instance)


func _on_Hide_pressed():
	$Grid.visible = !$Grid.visible
