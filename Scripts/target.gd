extends Area2D

@onready var player = %Player
@onready var levelmanager = $"../LevelManager"
@onready var endtimer = $Timer
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_body_entered(body):
	print("Target hit")
	
	player.vfxexplosion.set_emitting(true)
	player.rocketsprite.set_visible(false)
	endtimer.start()
	



func _on_timer_timeout() -> void:
	player.pause_menu.set_visible(true)
	
