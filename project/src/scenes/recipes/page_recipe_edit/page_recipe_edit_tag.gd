extends Label

var data = {} setget load_tag
var enabled : bool = false

func _ready():
	call_deferred("_deferred")

func _deferred():
	load_tag(data)
	if enabled:
		_on_Button_toggled(true)


func is_pressed():
	return $Button.is_pressed()

func load_tag(new_data):
	data = new_data
	if data.has("tag_id"):
		text = data["tag_name"]

func get_data():
	return data

func _on_Button_toggled(button_pressed):
	$Button.pressed = button_pressed
	if button_pressed:
		$Animator.play("pressed")
	else:
		$Animator.play("unpressed")
