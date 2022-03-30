extends Textbar

signal filter_pressed(value)

func get_text():
	return $Line.text

func _on_SearchButton_pressed():
	emit_signal("search_entered", $Line.text)
