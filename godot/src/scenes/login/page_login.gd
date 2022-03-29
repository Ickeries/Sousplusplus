extends Control


func _on_Return_pressed():
	Global.emit_signal("enter_return")
