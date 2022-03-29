extends Textbar

func _on_SearchButton_pressed():
	emit_signal("search_entered", $Line.text)
