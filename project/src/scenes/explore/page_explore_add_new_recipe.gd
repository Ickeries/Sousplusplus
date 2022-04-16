extends Control



func _on_Button_pressed():
	if Global.current_user:
		Global.emit_signal("update_data", 0)
		Global.emit_signal("enter_page", "PageRecipeEdit")
	else:
		$Warning_Popup.visible = true
		
func _on_Sign_In_pressed():
	Global.emit_signal("enter_page", "Login")
	$Warning_Popup.hide()


func _on_Return_pressed():
	Global.emit_signal("enter_return")
	$Warning_Popup.hide()

