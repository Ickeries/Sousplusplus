extends Control


# 
func _on_Login_pressed():
	pass # Replace with function body.


func _on_CreateAccount_pressed():
	$Animator.play("to_create_account")
	$Inputs/Username.clear()
	$Inputs/Password.clear()
	$Inputs/ConfirmPassword.clear()


func _on_BackToLogin_pressed():
	$Animator.play("to_login")
	$Inputs/Username.clear()
	$Inputs/Password.clear()
	$Inputs/ConfirmPassword.clear()


# Check to see if username and passwords are valid
# Then tells pipeline to save account. Then log in.
func _on_ConfirmAccount_pressed():
	var cat : String = "cool"
	print(cat.to_ascii())
	if $Inputs/Username.get_text().length() == 0:
		pass
	if $Inputs/Password.get_text().length() == 0:
		pass
