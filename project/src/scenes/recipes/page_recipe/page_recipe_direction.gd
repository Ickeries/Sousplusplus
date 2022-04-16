extends VBoxContainer

onready var text = $Center/Text

func _ready():
	$Label.text = "Step " + str(get_index() + 1)

func set_data(data : Dictionary):
	if data.has("text"):
		text.set_text(data["text"])

func get_data():
	var data = {}
	data["text"] = text.get_text()
	return data
