extends Control


func _on_Return_pressed():
	Global.emit_signal("enter_return")


func _on_Login_pressed():
	#var data = Pipeline.login_to_user($Inputs/Username.text, $Inputs/Password.text)
	pass
