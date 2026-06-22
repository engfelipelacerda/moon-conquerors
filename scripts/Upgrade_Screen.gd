extends CanvasLayer

signal upgrade_chosen(upgrade_id: String)

@onready var options_container = $Control/CenterContainer/OptionsContainer

func show_options(options: Array):
	options_container.add_theme_constant_override("separation", 12)

	for option in options:
		var button = Button.new()
		button.text = option.label
		button.custom_minimum_size = Vector2(220, 50)
		button.pressed.connect(_on_option_pressed.bind(option.id))
		options_container.add_child(button)

func _on_option_pressed(id: String):
	upgrade_chosen.emit(id)
	queue_free()
