extends Node


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	var test_string = "I hate godot"
	print(Pipeline.check(test_string))


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_User_pressed():
	if Global.current_user:
		$Pages.set_current_tab(2)
	else:
		$Pages.set_current_tab(1)


func _on_Home_pressed():
	$Pages.set_current_tab(0)
