extends Control

var pressed : bool = false


func _on_Recipe_gui_input(event):
	if event is InputEventMouseButton:
		if event.get_button_index() == BUTTON_LEFT:
			if event.pressed:
				pressed = true
				$Animator.play("fill")
			else:
				pressed = false
				$Animator.play("empty")
	
	# Check if input is already handled
	if get_tree().is_input_handled():
		return false
