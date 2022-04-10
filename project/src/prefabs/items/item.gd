extends Control

var data = {}

var start_position : = Vector2(0,0)

func set_data(dictionary : Dictionary):
	data = dictionary
	if dictionary.has("recipe_name"):
		$Name.text = dictionary["recipe_name"]
	if dictionary.has("name"):
		$Creator.text = "Made by " + dictionary["name"]

func _on_Item_gui_input(event):
	if event is InputEventMouseButton:
		if event.button_index == BUTTON_LEFT:
			if event.pressed:
				start_position = event.position
			else:
				if event.position.distance_to(start_position) < 10.0:
					Global.emit_signal("update_data", int(data["recipe_id"]))
					Global.emit_signal("enter_page", "PageRecipe")
