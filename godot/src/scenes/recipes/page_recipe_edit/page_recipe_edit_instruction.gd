extends PanelContainer

func _ready():
	$Horizontal/Number.text = str(get_index())

func _on_TextEdit_text_changed():
	if $Horizontal/Text/Hint.text.length() == 0:
		$Horizontal/Text/Hint.visible = true
	else:
		$Horizontal/Text/Hint.visible = false
