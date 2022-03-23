extends Control

var item_loaded = load("res://src/prefabs/items/Item.tscn")
onready var items = $Scroll/Container/Vertical
func _ready():
	call_deferred("_deferred")

func _deferred():
	_on_Container_resized()

func update_list(array : Array):
	for child in items.get_children():
		child.queue_free()
	for i in array:
		var item_instance = item_loaded.instance()
		items.add_child(item_instance)
		item_instance.set_data(i)
	
	if array.size() == 0:
		$NoRecipesFound.visible = true
	else:
		$NoRecipesFound.visible = false



func _on_Textbar_search_entered(text):
	var results = parse_json(Pipeline.get_recipes_by_name(text))
	update_list(results)


func _on_ScrollBar_value_changed(value):
	$Scroll.scroll_vertical = value
	
func _on_Container_resized():
	$ScrollBar.max_value = $Scroll/Container.rect_size.y
	$ScrollBar.page = clamp($ScrollBar.page, $Scroll.rect_size.y, $ScrollBar.max_value)
	print($ScrollBar.max_value, " and ", $ScrollBar.page)


func _on_Scroll_gui_input(event):
	pass # Replace with function body.
