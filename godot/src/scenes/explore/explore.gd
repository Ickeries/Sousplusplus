extends Control

var item_loaded = load("res://src/prefabs/items/Item.tscn")
onready var items = $Scroll/Container/Items
func _ready():
	pass

func update_list(array : Array):
	for child in items.get_children():
		child.queue_free()
	for i in array:
		var item_instance = item_loaded.instance()
		items.add_child(item_instance)
		item_instance.set_data(i)



func _on_Textbar_search_entered(text):
	var results = parse_json(Pipeline.get_recipes_by_name(text))
	update_list(results)
