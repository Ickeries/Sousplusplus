extends Control

var item_loaded = load("res://src/prefabs/items/Item.tscn")
var add_new_recipe_loaded = load("res://src/scenes/explore/PageExploreAddNewRecipe.tscn")
onready var items = $Vertical/Scroll/Center/Grid


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
	if results != null and text:
		update_list(results)
		$Label2.visible = false
	else:
		update_list([])
		$Label2.visible = true



func _on_Searchbar_filter_pressed(value):
	$Filter.popup()


func _on_Button_pressed():
	$Vertical/Header/Margin/Filter/Ingredients.visible = !$Vertical/Header/Margin/Filter/Ingredients.visible 


func _on_Kitchen_pressed():
	Global.emit_signal("enter_page", "Kitchen")


func _on_Explore_visibility_changed():
	_on_Searchbar_search_entered($Vertical/Header/Searchbar.get_text())
