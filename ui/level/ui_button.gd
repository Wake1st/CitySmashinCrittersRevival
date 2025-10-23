@tool
class_name UIButton
extends TextureButton


@export var label: String:
	set(value):
		label = value
		
		if has_node("Label"):
			(get_node("Label") as Label).text = value
