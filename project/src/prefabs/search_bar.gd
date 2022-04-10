extends Textbar

signal filter_pressed(value)

func get_text():
	return $Vertical/Header/Text.text

func _on_SearchButton_pressed():
	emit_signal("search_entered",get_text())


func _on_FilterButton_pressed():
	emit_signal("filter_pressed", $Vertical/Header/FilterButton.pressed)


func _on_Text_text_changed(new_text):
	if new_text.length() > 0:
		$Vertical/Header/Tip.visible = false
	else:
		$Vertical/Header/Tip.visible = true
