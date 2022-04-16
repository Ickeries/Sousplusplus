extends Control

var item_loaded = load("res://src/prefabs/items/Item.tscn")
var add_new_recipe_loaded = load("res://src/scenes/explore/PageExploreAddNewRecipe.tscn")

onready var category_loaded = load("res://src/scenes/explore/PageExploreCategory.tscn")

onready var items = $Scroll/Center/Vertical/Grid


func _ready():
	call_deferred("_deferred")
	
func _deferred():
	pass


func add_category(title : String, items):
	var category_instance = category_loaded.instance()
	$Scroll/Center/Vertical.add_child(category_instance)
	category_instance.set_title(title)
	category_instance.add_items(items)

func _on_Searchbar_search_entered(text):
	# Get recipes by name
	for category in $Scroll/Center/Vertical.get_children():
		category.queue_free()
	
	var results = Search.get_recipes_by_name(text)
	add_category("Best Results (%s)" % results.size(), results)
	add_category("Best Results (%s)" % results.size(), results)

func _on_Searchbar_filter_pressed(value):
	$Filter.visible = !$Filter.visible

func _on_Button_pressed():
	$Vertical/Header/Margin/Filter/Ingredients.visible = !$Vertical/Header/Margin/Filter/Ingredients.visible 


func _on_Explore_visibility_changed():
	Events.emit_signal("show_bottom_menu", true)
	_on_Searchbar_search_entered($Header/Searchbar.get_text())

#Its ugly but it works
func _on_Diet_Options_pressed():
	if $Filter/ItemList/VBoxContainer/PanelContainer/Diet_Options/Vegan_Check_Box.visible == true:
		$Filter/ItemList/VBoxContainer/PanelContainer/Diet_Options/Vegan_Check_Box.hide()
		$Filter/ItemList/VBoxContainer/PanelContainer/Diet_Options/Vegetarian_Check_Box.hide()
	else:
		$Filter/ItemList/VBoxContainer/PanelContainer/Diet_Options/Vegan_Check_Box.show()
		$Filter/ItemList/VBoxContainer/PanelContainer/Diet_Options/Vegetarian_Check_Box.show()


