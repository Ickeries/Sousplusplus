extends Node

# States: idle, focused, grab

onready var host = get_parent()
var state = "idle"

func _physics_process(delta):
	if state:
		_logic()

func _logic():
	match(state):
		"idle":
			pass
func change_state(new_state):
	state = new_state
	_enter_state()


func _enter_state():
	pass


func _on_Animator_animation_finished(anim_name):
	if anim_name == "fill":
		change_state("held")
