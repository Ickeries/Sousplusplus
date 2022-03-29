extends Control

var item_loaded = load("res://src/prefabs/items/Item.tscn")
var add_new_recipe_loaded = load("res://src/scenes/explore/PageExploreAddNewRecipe.tscn")
onready var items = $Scroll/Grid
func _ready():
	update_list([])
	call_deferred("_deferred")

func _deferred():
	pass

func update_list(array : Array):
	for child in items.get_children():
		child.queue_free()
	for i in array:
		var item_instance = item_loaded.instance()
		items.add_child(item_instance)
		item_instance.set_data(i)

func _on_Searchbar_search_entered(text):
	var results = parse_json(Pipeline.get_recipes_by_name(text))
	if results != null:
		update_list(results)
	else:
		Global.print_message("No valid recipes found.", Vector2(200,300))


func _on_Scroll_gui_input(event):
	pass # Replace with function body.
