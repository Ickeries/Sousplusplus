extends Control

onready var state_machine = $StateMachine
onready var httprequest : = HTTPRequest.new()

var pressed : bool = false

func _ready():
	Global.connect("give_image", self, "on_give_image")

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
	
	if state_machine.state == "held":
		get_tree().set_input_as_handled()

func on_give_image(image : ImageTexture):
	$Image.set_texture(image)
