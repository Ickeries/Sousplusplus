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

func _on_Images_about_to_show():
	for child in grid.get_children():
		child.queue_free()
	var directory = Directory.new()
	if directory.open(directory_path) == OK:
		directory.list_dir_begin()
		var file_name = directory.get_next()
		print(file_name)
		while file_name != "":
			if extensions.has(file_name.get_extension()):
				if file_name.find(search_bar.get_text()) != -1 or search_bar.get_text() == "":
					var image_option_instance = image_option_loaded.instance()
					grid.add_child(image_option_instance)
					image_option_instance.set_texture( "%s/%s" % [directory.get_current_dir(), file_name] )
			file_name = directory.get_next()
	else:
		print("An error occurred when trying to access the path.")



func _on_Searchbar_search_edited(text):
	$Timer.start()

func _on_Timer_timeout():
	_on_Images_about_to_show()


func _on_Confirm_pressed():
	Events.emit_signal("image_confirmed", preview.texture.resource_path)
