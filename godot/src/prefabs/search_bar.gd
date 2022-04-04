extends Textbar

signal filter_pressed(value)

func get_text():
	return $Vertical/Header/Text.text

func _on_SearchButton_pressed():
	$FilterPopup.visible = !$FilterPopup.visible


func _on_FilterButton_pressed():
	emit_signal("filter_pressed", $Vertical/Header/FilterButton.pressed)
