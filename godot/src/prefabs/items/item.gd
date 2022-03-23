extends PanelContainer

var data = {}

var start_position : = Vector2(0,0)

func set_data(dictionary : Dictionary):
	if dictionary.has("recipe_name"):
		$Header/Vertical/Name.text = dictionary["recipe_name"]


func _on_Item_gui_input(event):
	if event is InputEventMouseButton:
		if event.button_index == BUTTON_LEFT:
			if event.pressed:
				start_position = event.position
			else:
				if event.position.distance_to(start_position) < 10.0:
					Global.emit_signal("recipe_popup_called", data)
