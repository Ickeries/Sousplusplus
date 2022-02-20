extends Control


 
func _on_Login_pressed():
	var username = $Inputs/Username.get_text()
	var password = $Inputs/Password.get_text()
	var user = parse_json(Pipeline.get_account(username, password))
	if user:
		Global.current_user = user
		get_tree().change_scene("res://src/scenes/kitchen/Kitchen.tscn")


func _on_CreateAccount_pressed():
	$Inputs/Username.clear()
	$Inputs/Password.clear()
	$Inputs/ConfirmPassword.clear()
	$Animator.play("to_create_account")

func _on_BackToLogin_pressed():
	$Inputs/Username.clear()
	$Inputs/Password.clear()
	$Inputs/ConfirmPassword.clear()
	$Animator.play("to_log_in")


# Check to see if username and passwords are valid
# Then tells pipeline to save account. Then log in.
func _on_ConfirmAccount_pressed():
	var username = $Inputs/Username.get_text()
	var password = $Inputs/Password.get_text()
	var confirm_password = $Inputs/ConfirmPassword.get_text()
	Global.current_user = {"id":1,"name":username,"password":password}
	get_tree().change_scene("res://src/scenes/kitchen/Kitchen.tscn")
