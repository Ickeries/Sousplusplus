extends Control

signal recipe_page_hide()

onready var tags = $Scroll/Container/Vertical/Tags/Vertical/Horizontal
onready var description = $Scroll/Container/Vertical/Description/Vertical/Panel/Text
var ingredient_list_item_loaded = load("res://src/prefabs/items/list_items/IngredientListItem.tscn")

var data = {
"recipe_name" : "untitled",
"recipe_creator" : "david serrano",
"recipe_description" : "This is the recipe description",
"tags" : [],
"instructions" : [],
}

func _ready():
	call_deferred("_deferred")

func _deferred():
	pass
	
func load_recipe(id : int):
	pass


func _on_Return_pressed():
	emit_signal("recipe_page_hide")

func _on_AddTag_pressed():
	if tags.get_child_count() < 5:
		var line_edit_instance = LineEdit.new()
		tags.add_child(line_edit_instance)


func _on_RemoveTag_pressed():
	if tags.get_child_count() > 0:
		tags.remove_child(tags.get_child(tags.get_child_count()-1))


func _on_Save_pressed():
	data["recipe_description"] = description.text
	print(data)
