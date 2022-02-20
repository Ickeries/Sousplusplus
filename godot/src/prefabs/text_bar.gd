extends Control

onready var line = $Line

func clear():
	$Line.text = ""
	_on_Line_text_changed($Line.text)

func get_text() -> String:
	return line.text


func _on_Line_text_changed(new_text):
	$Tip.visible = (new_text.length() == 0)


func _on_Line_focus_entered():
	$Tip.visible = false

