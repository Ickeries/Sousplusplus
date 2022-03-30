extends Control



func _on_Button_pressed():
	Global.emit_signal("update_data", 0)
	Global.emit_signal("enter_page", "PageRecipeEdit")
