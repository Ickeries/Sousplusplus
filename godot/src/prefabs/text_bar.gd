extends Control
signal search_entered(text)

onready var line = $Line

func clear():
	$Line.text = ""
	_on_Line_text_changed($Line.text)

func get_text() -> String:
	return line.text


func _on_Line_text_changed(new_text):
	$Tip.visible = (new_text.length() == 0)
	emit_signal("search_entered", new_text)


func _on_Line_focus_entered():
	$Tip.visible = false


func _on_Line_text_entered(new_text):
	emit_signal("search_entered", new_text)
