extends Control

onready var text = $Horizontal/Center/Text

func _ready():
	$Horizontal/Index.text = str(get_index() + 1)

func load_direction(data : Dictionary):
	if data.has("text"):
		text.set_text(data["text"])

func get_data():
	var data = {}
	data["text"] = text.get_text()
	data["step"] = get_index() + 1
	
	return data

func _on_TextEdit_text_changed():
	if $Horizontal/Text/Hint.text.length() == 0:
		$Horizontal/Text/Hint.visible = true
	else:
		$Horizontal/Text/Hint.visible = false


func _on_Text_text_changed():
	var count = text.get_line_count()
	for line in text.get_line_count():
		count += text.get_line_wrap_count(line)
	text.rect_min_size.y = text.get_line_height() * count
