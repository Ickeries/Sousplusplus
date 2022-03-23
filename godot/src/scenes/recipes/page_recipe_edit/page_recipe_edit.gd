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
	_on_Container_resized()
	call_deferred("_deferred")

func _deferred():
	pass
	
func load_recipe(id : int):
	pass


func _on_Return_pressed():
	visible = false

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


onready var description_animator = $Scroll/Container/Vertical/Description/Animator

# Description
func _on_EditDescription_pressed():
	if description_animator.get_current_animation() == "confirm":
		description_animator.play("edit")
	else:
		description_animator.play("confirm")


func _on_ClearDescription_pressed():
	pass # Replace with function body.


func _on_Container_resized():
	$ScrollBar.max_value = $Scroll/Container.rect_size.y
	$ScrollBar.page = $Scroll.rect_size.y

func _on_ScrollBar_value_changed(value):
	$Scroll.scroll_vertical = value
