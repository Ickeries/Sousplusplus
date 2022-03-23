extends CanvasLayer

signal screen_dragged (translate)
signal screen_tapped ()
var pressed : bool = false
var drag_start_position : = Vector2(0,0)

var dragging : bool = false

var handle_input : bool = false
func _on_CanvasLayer_gui_input(event):
	if event is InputEventMouseButton:
		if event.button_index == BUTTON_LEFT:
			if event.pressed:
				pressed = true
				drag_start_position = event.position
			else:
				if !dragging:
					emit_signal("screen_tapped")
				pressed = false
				dragging = false
	
	if event is InputEventMouseMotion:
		if pressed:
			# Enable Dragging
			if drag_start_position.distance_to(event.position) > 40 and dragging == false:
				dragging = true
			
			# Dragging
			if dragging:
				emit_signal("screen_dragged", -event.relative)
