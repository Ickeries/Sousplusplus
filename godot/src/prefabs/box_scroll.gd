extends Control

const DIST_TO_SCROLL : = 25.0
const POSITION_LERP_SPEED : = 10.0
onready var items = $Items
onready var to_position : Vector2 = items.rect_position
onready var start_position : Vector2 = items.rect_position
var pressed : bool = false
var scrolling : bool = false
var starting_press_position : = Vector2(0,0)

func _ready():
	pass

func _physics_process(delta):
	items.rect_position = lerp(items.rect_position, to_position, delta * 10.0)
	$Scrollbar.value = lerp($Scrollbar.value, -to_position.y, delta * 10.0)

func _on_Scroll_gui_input(event):
	if event is InputEventMouseButton:
		if event.get_button_index() == BUTTON_LEFT:
			if event.pressed:
				pressed = true
				starting_press_position = event.position
			else:
				pressed = false
				scrolling = false
	
	# Check if input is already handled
	if get_tree().is_input_handled():
		return false
	
	# Scroll the control node
	if event is InputEventMouseMotion:
		if pressed:
			if scrolling:
				to_position.y += event.relative.y
				to_position.y = clamp(to_position.y,-items.rect_size.y * 0.5, 0)
				$ScrollTimer.start()
				$Scrollbar.visible = true
			else:
				if event.position.distance_to(starting_press_position) > DIST_TO_SCROLL:
					scrolling = true
	
	if scrolling:
		get_tree().set_input_as_handled()


func _on_Items_resized():
	$Scrollbar.value = -to_position.y
	$Scrollbar.page = rect_size.y


func _on_ScrollTimer_timeout():
	$Scrollbar.visible = false
