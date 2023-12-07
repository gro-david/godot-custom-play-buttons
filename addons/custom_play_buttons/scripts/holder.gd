@tool
extends PanelContainer

var play_button_scene = preload("res://addons/custom_play_buttons/play_button.tscn")
var play_button_list_element_scene = preload("res://addons/custom_play_buttons/play_button_list_element.tscn")
var editor_interface

func _ready():
	add_theme_stylebox_override("panel", get_theme_stylebox("LaunchPadNormal", "EditorStyles"))
	$window/container.add_theme_stylebox_override("panel", get_theme_stylebox("Background", "EditorStyles"))

func _on_window_close_requested():
	$window.hide()
	update_play_buttons()
	save_buttons_to_config()

func update_play_buttons():
	# delete every play button
	for child in $play_button_holder.get_children():
		if not child.has_meta("custom_play_button"):
			continue
		child.queue_free()

	var play_button_list_holder = get_node("window/container/play_button_config_holder/")
	for list_element in play_button_list_holder.get_children():
		if not list_element.get_child(0).has_meta("play_button_list_element"):
			continue
		var play_button = play_button_scene.instantiate()
		play_button.scene_to_run = list_element.get_node("container/filepath").text
		play_button.tooltip_text = "Run '" + str(list_element.get_node("container/filepath").text.split("/")[-1]) + "'"
		$play_button_holder.add_child(play_button)


func save_buttons_to_config():
	var config_file = ConfigFile.new()

	var play_button_list_holder = get_node("window/container/play_button_config_holder/")
	var i = 0
	for list_element in play_button_list_holder.get_children():
		if not list_element.get_child(0).has_meta("play_button_list_element"):
			continue
		config_file.set_value("Play Buttons", str(i), list_element.get_node("container/filepath").text)
		i += 1

	config_file.save("res://addons/custom_play_buttons/buttons.cfg")

func load_buttons_from_config():
	var config_file = ConfigFile.new()
	var err = config_file.load("res://addons/custom_play_buttons/buttons.cfg")

	if err != OK:
		return

	if not config_file.has_section("Play Buttons"):
		return

	var play_button_list_holder = get_node("window/container/play_button_config_holder/")
	for i in range(0, config_file.get_section_keys("Play Buttons").size()):
		var play_button_list_element = play_button_list_element_scene.instantiate()
		play_button_list_element.get_node("container/filepath").text = config_file.get_value("Play Buttons", str(i))
		play_button_list_holder.add_child(play_button_list_element)
	
	update_play_buttons()