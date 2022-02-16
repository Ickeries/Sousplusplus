extends Node

signal give_image (image)

var current_user = null


onready var http : = HTTPRequest.new()
onready var image : = Image.new()
onready var texture : = ImageTexture.new()

func _ready():
	add_child(http)
	http.connect("request_completed", self, "on_request_completed")
	http.request("https://spoonacular.com/recipeImages/579247-90x90.jpg")


func on_request_completed(result, response_code, headers, body):
	var image_error = image.load_jpg_from_buffer(body)
	if image_error != OK:
		print("LEL NO")
	texture.create_from_image(image)
	emit_signal("give_image", texture)
