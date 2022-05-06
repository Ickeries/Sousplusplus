extends Control


func _on_Return_pressed():
	Global.emit_signal("enter_return")


func _on_Login_pressed():
	var user = Users.login_user($Inputs/Username/Line.text, $Inputs/Password/Line.text)
	print(user)
	if user:
		Global.current_id = user.user_id
		Events.emit_signal("return_to_previous_page", "fade_to_black")
	else:
		Global.print_message("Invalid login information!", Vector2(200,200))


func _on_CreateAccount_pressed():
	Users.create_user($Inputs/Username/Line.text, $Inputs/Password/Line.text)
	_on_Login_pressed()


func _on_Login_visibility_changed():
	if Global.current_user:
		print("Welcome " , Global.current_user.name , "!")
		$Inputs.visible = false
		$Buttons.visible = false
		$Profile_Settings.visible = true


func _on_Logout_pressed():
	pass
	#Users.login_user(null, null)
