extends Control


func _on_Return_pressed():
	Global.emit_signal("enter_return")


func _on_Login_pressed():
	var user = Users.login_user($Inputs/Username/Line.text, $Inputs/Password/Line.text)
	if user:
		Global.current_user = user
		Global.emit_signal("enter_return")
	else:
		Global.print_message("Invalid login information!", Vector2(200,200))


func _on_CreateAccount_pressed():
	Users.create_user($Inputs/Username/Line.text, $Inputs/Password/Line.text)
	_on_Login_pressed()
