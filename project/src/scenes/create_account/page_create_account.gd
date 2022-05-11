extends Control

onready var username_bar = $SubPages/First/UsernameBar
onready var password_bar = $SubPages/Second/PasswordBar

var password_bad_characters = [" ", ":", "#"]

var to_position = Vector2(0,0)

func _physics_process(delta):
	$SubPages.rect_position = lerp($SubPages.rect_position, to_position, delta * 5.0)

func reset():
	$SubPages.rect_position = Vector2(0,0)
	username_bar.set_text("")
	password_bar.set_text("")
	$SubPages/Second/UsernamePreview.text = ""

func _on_CreateAccount_visibility_changed():
	set_physics_process(visible)


func _on_Next1_pressed():
	if !Users.does_user_exist(username_bar.get_text()):
		to_position = Vector2(-1080,0)
		$SubPages/Second/UsernamePreview.text = username_bar.get_text()
	elif username_bar.get_text().length() == 0:
		Global.print_message("Please enter a username")
	else:
		Global.print_message("Username already exists.")


func _on_ShowPassword_pressed():
	password_bar.hide_text(!password_bar.is_text_hidden())


func _on_Confirm_pressed():
	for character in password_bad_characters:
		if password_bar.get_text().find(character) != -1:
			Global.print_message("Bad characters in password")
			return
	var created_user = Users.create_user(username_bar.get_text(), password_bar.get_text())
	Global.current_id = created_user.user_id
	Global.current_password = created_user.user_password
	Events.emit_signal("set_page", "Kitchen", "fade_to_black")


func _on_Return_pressed():
	Events.emit_signal("return_to_previous_page", "fade_to_black")
