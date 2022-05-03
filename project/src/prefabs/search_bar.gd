extends Textbar

func set_text(text : String):
	$Vertical/Header/Text.text = text
	_on_Text_text_changed(text)

func get_text():
	return $Vertical/Header/Text.text

func _on_SearchButton_pressed():
	emit_signal("search_entered",get_text())


func _on_Text_text_changed(new_text):
	emit_signal("search_edited", get_text())
	if new_text.length() > 0:
		$Vertical/Header/Tip.visible = false
	else:
		$Vertical/Header/Tip.visible = true
