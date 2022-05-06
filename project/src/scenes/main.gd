extends Node

onready var pages = $Pages
onready var bottom_menu = $BottomMenu
onready var transition = $Transition/Animator

var previous_page = null


func _ready():
	Events.connect("set_page", self, "on_set_page")
	Events.connect("return_to_previous_page", self, "on_return_to_previous_page")
	Events.connect("show_bottom_menu", self, "on_show_bottom_menu")
	Events.connect("set_buffering", self, "on_set_buffering")

# Sets visibility of page called by page_name
func set_page(page_name, remember_previous_page=true):
	# Check if called page exists
	if !pages.has_node(page_name):
		return false
	
	if remember_previous_page:
		previous_page = get_current_page().name
	
	# Make all other pages invisible
	for page in pages.get_children():
		page.set_visible(false)
	
	# Make called page visible
	pages.get_node(page_name).set_visible(true)

func set_previous_page():
	if previous_page:
		set_page(previous_page, false)

func get_current_page():
	for page in pages.get_children():
		if page.is_visible():
			return page

# SIGNALS
func on_set_page(page_name : String, transition_animation="immediate", remember_previous_page=true):
	if pages.get_node_or_null(page_name) == null:
		return false
	# Play provided transition
	transition.play(transition_animation) if transition.has_animation(transition_animation) else transition.play("immediate")
	yield(transition, "animation_finished")
	set_page(page_name, remember_previous_page)
	transition.play_backwards(transition_animation) if transition.has_animation(transition_animation) else transition.play_backwards("immediate")

func on_return_to_previous_page(transition_animation="immediate"):
	transition.play(transition_animation) if transition.has_animation(transition_animation) else transition.play("immediate")
	yield(transition, "animation_finished")
	Events.emit_signal("loading_started")
	set_previous_page()
	transition.play_backwards(transition_animation) if transition.has_animation(transition_animation) else transition.play_backwards("immediate")


func on_show_bottom_menu(value : bool):
	bottom_menu.set_visible(value)

func on_set_buffering(value : bool):
	$Sprite.visible = value



func _on_Explore_pressed():
	Events.emit_signal("set_page", "Explore", "fade_to_black")

func _on_Kitchen_pressed():
	Events.emit_signal("set_page", "Kitchen", "fade_to_black")

func _on_Fullscreen_pressed():
	OS.window_fullscreen = !OS.window_fullscreen


func _on_Exit_pressed():
	get_tree().quit()
