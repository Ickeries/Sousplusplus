extends Control

func _ready():
	pass

func _on_SplashPage_gui_input(event):
	if event is InputEventMouseButton:
		if event.button_index == BUTTON_LEFT:
			if event.pressed:
				Events.emit_signal("set_page", "Explore", "fade_to_black")

func _on_Welcome_Back_Current_User_visibility_changed():
	if Global.current_user:
		$Welcome_Back_Current_User.text = ("Welcome Back "+ Global.current_user.name)
		

# Called when splash page appears
func _on_SplashPage_visibility_changed():
	print("LEL")
	if visible:
		Events.emit_signal("show_bottom_menu", false)
