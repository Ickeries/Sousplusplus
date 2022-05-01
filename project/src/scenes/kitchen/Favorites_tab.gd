extends Button


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
var favorites_list = []
func _ready():
	pass # Replace with function body.
func _on_favorites_gui_input(event):
	var temp_list = []
	if event is InputEventMouseButton:
		if event.button_index == BUTTON_LEFT:
			if event.pressed:
				temp_list.append(Search.get_favorite_recipes(Global.current_id))
	favorites_list.append(temp_list)

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
