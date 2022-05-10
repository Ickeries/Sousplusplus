extends Control

func _ready():
	pass

func _on_SplashPage_gui_input(event):
	if event is InputEventMouseButton:
		if event.button_index == BUTTON_LEFT:
			if event.pressed:
				Events.emit_signal("set_page", "Explore", "fade_to_black")



# Called when splash page appears
func _on_SplashPage_visibility_changed():
	if visible:
		Events.emit_signal("show_bottom_menu", false)
