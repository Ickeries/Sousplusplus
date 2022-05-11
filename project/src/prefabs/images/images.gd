extends Popup

onready var grid = $Scroll/Center/Grid
onready var preview = $Preview
onready var search_bar = $Searchbar

var image_option_loaded = load("res://src/prefabs/images/ImagesOption.tscn")

export (String) var directory_path = ""

var extensions = ["png", "jpg", "jpeg"]

func _ready():
	Events.connect("image_changed", self, "on_image_changed")

func on_image_changed(image_path):
	preview.texture = load(image_path)

func _on_Searchbar_search_edited(text):
	$Timer.start()



func _on_Timer_timeout():
	for image in grid.get_children():
		image.visible = true
		var image_name = image.texture.resource_path.trim_prefix("res://assets/images/")
		if image_name.find(search_bar.get_text()) == -1 and search_bar.get_text().length() > 0:
			image.visible = false

func _on_Confirm_pressed():
	Events.emit_signal("image_confirmed", preview.texture.resource_path)


func _on_Button_pressed():
	visible = false
