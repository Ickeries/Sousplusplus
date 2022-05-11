extends Control
class_name Textbar

signal search_entered(text)
signal search_edited(text)

var hidden = true

func _on_Line_text_changed(new_text):
	$Tip.visible = (new_text.length() == 0)

func _on_Line_focus_entered():
	$Tip.visible = false


func _on_Line_text_entered(new_text):
	pass

func set_hidden(value):
	$Line.secret = value
