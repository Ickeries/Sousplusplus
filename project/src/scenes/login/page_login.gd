extends Control


func _on_Return_pressed():
	Events.emit_signal("return_to_previous_page", "fade_to_black")


func _on_Login_pressed():
	var user = Users.login_user($Inputs/Username/Line.text, $Inputs/Password/Line.text)
	if user:
		Global.current_id = user.user_id
		Events.emit_signal("set_page", "Kitchen", "fade_to_black")
	else:
		Global.print_message("Invalid login information!")


func _on_CreateAccount_pressed():
	Events.emit_signal("set_page", "CreateAccount", "fade_to_black")


func _on_Login_visibility_changed():
	if Global.current_user:
		$Inputs.visible = false
		$Buttons.visible = false
		$Profile_Settings.visible = true
	Events.emit_signal("show_bottom_menu", false)
