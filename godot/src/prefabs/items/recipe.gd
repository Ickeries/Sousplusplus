extends Control

onready var httprequest : = HTTPRequest.new()

var pressed : bool = false

var moved : bool = false

func _on_Main_gui_input(event):
	if event is InputEventMouseButton:
		if event.get_button_index() == BUTTON_LEFT:
			if event.pressed:
				pressed = true
			else:
				pressed = false
	
	# Check if input is already handled
	if get_tree().is_input_handled():
		return false
	
	if state_machine.state == "held":
		get_tree().set_input_as_handled()
