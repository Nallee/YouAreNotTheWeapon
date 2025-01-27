extends Node2D
@export var target = SpriteFrames
@export var dialog = "res://Dialogs/Level1_Intro.dialogue"
@export var dialog_start: String = "start"
@onready var introdelay = $IntroDialog
const Balloon = preload("res://Dialogs/balloon.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	introdelay.start()
	##DialogueManager.show_example_dialogue_balloon((load(dialog)))


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_intro_dialog_timeout() -> void:
	var balloon: Node = Balloon.instantiate()
	%Player/PlayerUI.add_child(balloon)
	balloon.start(load(dialog), dialog_start)
