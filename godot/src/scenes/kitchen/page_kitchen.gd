extends Control

func _ready():
	if Global.current_user:
		$Top/Username.text = Global.current_user.name
		$Top/Signin.visible = false
func _on_Signin_pressed():
	get_tree().change_scene("res://src/scenes/login/Login.tscn")
