extends Control

onready var text = $Text

export (float) var skin_width = 1.0

func set_text(new_text : String):
	text.set_text(new_text)
	_on_Text_text_changed()

func get_text():
	return text.get_text()

func _on_Text_text_changed():
	var count = text.get_line_count()
	for line in text.get_line_count():
		count += text.get_line_wrap_count(line)
	text.rect_min_size.y = (text.get_line_height() * count) + skin_width
