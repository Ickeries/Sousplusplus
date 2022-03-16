extends UIButton

const DIST_TO_SCROLL : = 25.0
const POSITION_LERP_SPEED : = 10.0

export (NodePath) var container_path = ""
onready var container = get_node_or_null(container_path)

func _ready():
	move_child($Scrollbar, get_child_count()-1)

func _on_Items_resized():
	$Scrollbar.set_page(rect_size.y)
	$Scrollbar.set_max($Container.rect_size.y)

func _on_Scrollbar_scrolling():
	pass
	
	
func _on_Scroll_vertical_scrolled(value):
	if container:
		container.rect_position.y += value
		$Scrollbar.set_value(-container.rect_position.y)
		container.rect_position.y = clamp(container.rect_position.y, -$Container.rect_size.y ,0)
