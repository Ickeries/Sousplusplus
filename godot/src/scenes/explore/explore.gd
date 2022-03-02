extends Control

var item_loaded = load("res://src/prefabs/objects/Item.tscn")

func _ready():
	pass

func update_list(array : Array):
	for child in $Scroll/Items.get_children():
		child.queue_free()
	for i in array:
		var item_instance = item_loaded.instance()
		$Scroll/Items.add_child(item_instance)
		item_instance.set_item(i)



func _on_Textbar_search_entered(text):
	var results = parse_json(Pipeline.get_recipes_from_text(text))
	update_list(results)
