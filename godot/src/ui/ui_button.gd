extends Control
class_name UIButton

signal horizontal_scrolled(value)
signal vertical_scrolled(value)
signal tapped()
signal pressed()

export var can_press : bool = false
export var can_hold : bool = false
export var horizontal_scroll : float = 0.0
export var vertical_scroll : float = 0.0

var state = ""
# Ignore if a bad input is called.
var ignore : bool = false
var pressed : bool = false
var unpressed : bool = false
var scroll : Vector2 = Vector2(0,0)
var held : bool = false
var held_timer : float = 0.0
var press_start_position = Vector2(0,0)
var press_end_position = Vector2(0,0)
func _init():
	connect("gui_input", self, "on_gui_input")


func on_gui_input(event : InputEvent):
	# Press
	unpressed = false
	if event is InputEventMouseButton:
		if event.button_index == BUTTON_LEFT:
			if event.pressed:
				press_start_position = event.position
				pressed = true
				set_physics_process(true)
			else:
				pressed = false
				unpressed = true
				set_physics_process(false)
	
	# Scroll
	if event is InputEventMouseMotion:
		press_end_position = event.position
		scroll = event.relative
	
	# If a child button already has input captured, deactivate this  button.
	if get_tree().is_input_handled():
		return false
	
	if Global.current_ui_button and Global.current_ui_button != self:
		return false
	match (state):
		"":
			if pressed:
				if horizontal_scroll and abs(press_start_position.x - press_end_position.x) > 5.0:
					state = "horizontal_scroll"
					Global.current_ui_button = self
				elif vertical_scroll and abs(press_start_position.y - press_end_position.y) > 5.0:
					state = "vertical_scroll"
					Global.current_ui_button = self
		"horizontal_scroll":
			emit_signal("horizontal_scrolled", scroll.x)
		"vertical_scroll":
			emit_signal("vertical_scrolled", scroll.y)
		"fail":
			pass
	# You are currently in a state. 
	if state:
		get_tree().set_input_as_handled()
		if pressed == false:
			Global.current_ui_button = null
			state = ""
	else:
		if unpressed and can_press:
			get_tree().set_input_as_handled()
			emit_signal("pressed")
