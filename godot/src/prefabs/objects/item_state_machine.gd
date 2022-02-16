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
			host.rect_position = lerp(host.rect_position, Vector2(host.get_index() * 140,0), get_physics_process_delta_time() * 10.0)
		"held":
			host.rect_global_position = lerp(host.rect_global_position, host.get_global_mouse_position(), get_physics_process_delta_time() * 10.0)

func change_state(new_state):
	state = new_state
	_enter_state()


func _enter_state():
	pass


func _on_Animator_animation_finished(anim_name):
	if anim_name == "fill":
		change_state("held")
