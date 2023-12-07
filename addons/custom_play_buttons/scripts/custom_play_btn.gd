@tool
extends Button

var scene_to_run = ""

func _ready():
	set_meta("custom_play_button", true)

func _on_pressed():
	get_parent().get_parent().editor_interface.play_custom_scene(scene_to_run)