extends Node2D

@export var delay = 0.0
@onready var timer = $Delay
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	timer.wait_time = delay
	timer.start()




func _on_delay_timeout() -> void:
	$AnimationPlayer.set_current_animation("MovingWall01")
	$AnimationPlayer.play()


func _on_area_2d_body_entered(body):
	pass

func _on_area_2d_area_entered(area: Area2D) -> void:
		print("boom")
		%Player.deathtimer.start()
		%Player.vfxexplosion.set_emitting(true)
		%Player.rocketsprite.set_visible(false)
