extends Control

var id : int = -1
var pressed : bool = false
func set_item(dictionary : Dictionary):
	if dictionary.has("recipe_id"):
		id = int(dictionary.recipe_id)
	if dictionary.has("recipe_name"):
		$Title.text = dictionary.recipe_name
	if dictionary.has("recipe_description"):
		$Description.text = dictionary.recipe_description
	if dictionary.has("creator"):
		$Creator.text= dictionary.creator


func _on_Item_gui_input(event):
	
	if event is InputEventMouseButton:
		if event.get_button_index() == BUTTON_LEFT:
			if event.pressed:
				pressed = true
			else:
				pressed = false
	
	# Check if input is already handled
	if get_tree().is_input_handled():
		return false
	
	
	
	if event is InputEventMouseButton:
		if event.button_index == BUTTON_LEFT:
			if event.pressed:
				Global.current_recipe = $Title.get_text()
				get_tree().change_scene("res://src/scenes/RecipePage.tscn")
