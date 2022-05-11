extends Control

onready var username_bar = $Inputs/Username
onready var password_bar = $Inputs/Password

func reset():
	username_bar.set_text("")
	password_bar.set_text("")
	

func _on_Return_pressed():
	Events.emit_signal("set_page","Kitchen", "fade_to_black")


func _on_Login_pressed():
	var user = Users.login_user(username_bar.get_text(), password_bar.get_text())
	if user:
		Global.current_id = user.user_id
		Global.current_password = user.user_password
		Global.current_user_name = user.user_name
		Events.emit_signal("set_page", "Kitchen", "fade_to_black")
	else:
		Global.print_message("Invalid login information!")

func _on_CreateAccount_pressed():
	Events.emit_signal("set_page", "CreateAccount", "fade_to_black")


func _on_Login_visibility_changed():
	reset()
	if Global.current_user:
		$Inputs.visible = false
		$Buttons.visible = false
		$Profile_Settings.visible = true
	Events.emit_signal("show_bottom_menu", false)
	
func _on_CheckBox_toggled(button_pressed):
	password_bar.set_hidden(button_pressed)
