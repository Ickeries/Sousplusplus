extends PanelContainer

onready var text = $Horizontal/Text/TextEdit

var recipe_id = -1

func _ready():
	$Horizontal/Number.text = str(get_index() + 1)


func set_data(data : Dictionary):
	if data.has("recipe_description"):
		text.set_text(data["recipe_description"])
	if data.has("recipe_id"):
		recipe_id = int(data["recipe_id"])

func get_data():
	var data = {}
	data["recipe_id"] = recipe_id
	data["recipe_description"] = text.get_text()
	data["step"] = get_index()
	
	return data

func _on_TextEdit_text_changed():
	if $Horizontal/Text/Hint.text.length() == 0:
		$Horizontal/Text/Hint.visible = true
	else:
		$Horizontal/Text/Hint.visible = false
