extends ScrollContainer

var start_position : = Vector2(0,0)
var last_position : = Vector2(0,0)
var pressed : bool = false

var to_scroll_vertical : int = 0.0
func _ready():
	get_v_scrollbar().visible = false

func _physics_process(delta):
	pass

func _on_Scroll_gui_input(event):
	if event is InputEventMouseButton:
		if event.button_index == BUTTON_LEFT:
			if event.pressed:
				start_position = event.position
				last_position = event.position
				pressed = true
			else:
				pressed = false
	
	if event is InputEventMouseMotion:
		var dist = event.relative
		
		if pressed and event.position.distance_to(start_position) > 10.0:
			scroll_vertical -= event.relative.y
		last_position = event.position
