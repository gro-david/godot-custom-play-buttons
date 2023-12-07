@tool
extends EditorPlugin

var container = load("res://addons/custom_play_buttons/custom_play_buttons_container.tscn").instantiate()
var toolbar = null


func _enter_tree():
	add_control_to_container(CONTAINER_TOOLBAR, container)
	container.editor_interface = get_editor_interface()
	container.load_buttons_from_config()
	toolbar = container.get_parent()
	toolbar.move_child(container, toolbar.get_child_count() - 3)

func _exit_tree():
	remove_control_from_container(CONTAINER_TOOLBAR, container)
