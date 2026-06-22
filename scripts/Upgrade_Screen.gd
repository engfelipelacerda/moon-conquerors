extends CanvasLayer

signal upgrade_chosen(upgrade_id: String)

@onready var options_container = $Control/OptionsContainer

func show_options(options: Array):
	for option in options:
		var button = Button.new()
		button.text = option.label
		button.pressed.connect(_on_option_pressed.bind(option.id))
		options_container.add_child(button)

func _on_option_pressed(id: String):
	upgrade_chosen.emit(id)
	queue_free()
