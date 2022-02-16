extends Control

var pressed : bool = false
var scrolling : int = 0
var starting_press_position : Vector2 = Vector2(0,0)

onready var vertical_to_position : Vector2 = $Body.rect_position
onready var body = $Body
func _physics_process(delta):
	body .rect_position.x = lerp(body .rect_position.x, vertical_to_position.x, delta * 10.0)
	vertical_to_position.x = clamp(vertical_to_position.x, -body .rect_size.x * 0.5, 0)

func _on_BoxList_gui_input(event):
	if event is InputEventMouseButton:
		if event.get_button_index() == BUTTON_LEFT:
			if event.pressed:
				pressed = true
				starting_press_position = event.position
			else:
				pressed = false
				scrolling = 0
	
	# Check if input is already handled
	if get_tree().is_input_handled():
		return false
	
	
	if event is InputEventMouseMotion:
		if pressed:
			if scrolling == 1:
				vertical_to_position.x += event.relative.x
				get_tree().set_input_as_handled()
			elif scrolling == 2:
				pass
			elif scrolling == 0:
				if abs(event.position.x - starting_press_position.x) > 5.5:
					scrolling = 1
				elif abs(event.position.y - starting_press_position.y) > 2.5:
					scrolling = 2
