extends Textbar

onready var text = $Vertical/Header/Text

func hide_text(value : bool):
	text.secret = value

func is_text_hidden():
	return text.secret

func set_text(new_text : String):
	text.text = new_text
	_on_Text_text_changed(text.text)

func get_text():
	return text.text

func _on_SearchButton_pressed():
	emit_signal("search_entered",get_text())


func _on_Text_text_changed(new_text):
	emit_signal("search_edited", get_text())
	if new_text.length() > 0:
		$Vertical/Header/Tip.visible = false
	else:
		$Vertical/Header/Tip.visible = true
