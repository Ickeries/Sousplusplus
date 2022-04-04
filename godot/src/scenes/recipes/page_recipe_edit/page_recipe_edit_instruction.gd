extends PanelContainer

onready var text = $Horizontal/Text/TextEdit

func _ready():
	$Horizontal/Number.text = str(get_index() + 1)


func get_data():
	var data = {}
	data["text"] = text.get_text()


func _on_TextEdit_text_changed():
	if $Horizontal/Text/Hint.text.length() == 0:
		$Horizontal/Text/Hint.visible = true
	else:
		$Horizontal/Text/Hint.visible = false
