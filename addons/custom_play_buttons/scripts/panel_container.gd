@tool
extends PanelContainer


# Called when the node enters the scene tree for the first time.
func _ready():
	add_theme_stylebox_override("panel", get_theme_stylebox("LaunchPadNormal", "EditorStyles"))

