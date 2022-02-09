extends Control

func _on_Type_text_changed(new_text):
	$Tip.visible = (new_text.length() == 0)


func _on_Type_focus_entered():
	$Tip.visible = false
