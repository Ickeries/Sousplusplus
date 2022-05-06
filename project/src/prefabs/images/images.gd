extends Popup

var image_option_loaded = load("res://src/prefabs/images/ImagesOption.tscn")

export (String) var directory_path = ""

var extensions = ["png", "jpg", "jpeg"]

func _on_Images_about_to_show():
	for child in $Scroll/Grid.get_children():
		child.queue_free()
	
	
	var directory = Directory.new()
	if directory.open(directory_path) == OK:
		directory.list_dir_begin()
		var file_name = directory.get_next()
		print(file_name)
		while file_name != "":
			if extensions.has(file_name.get_extension()):
				print("Found file: " + file_name)
				var image_option_instance = image_option_loaded.instance()
				$Scroll/Grid.add_child(image_option_instance)
				image_option_instance.set_texture( "%s/%s" % [directory.get_current_dir(), file_name] )
			file_name = directory.get_next()
	else:
		print("An error occurred when trying to access the path.")
