extends Control


func _on_Return_pressed():
	Global.emit_signal("enter_return")


func _on_Login_pressed():
	var user = parse_json(Pipeline.login_user($Inputs/Username.get_text(), $Inputs/Password.get_text()))
	if user:
		Global.current_user = user
		Global.emit_signal("enter_return")
	else:
		Global.print_message("Invalid login information!", Vector2(200,200))
