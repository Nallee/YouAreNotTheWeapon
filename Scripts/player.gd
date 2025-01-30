extends RigidBody2D

var torque_strength = 30000 # Ajuster ce facteur pour contrôler la vitesse de rotation
@onready var body = $"."
@onready var pause_menu: CanvasLayer = $PauseMenu
@onready var rocket = $Rocket_pos
@onready var deathtimer = $DeathTimer
@onready var vfxexplosion = $VFXExplosion
@onready var levelmanager = $"../LevelManager"
@onready var targetsprite = $"../LevelManager".target
@onready var portait = $PlayerUI/Portait
@onready var rocketsprite = $AnimatedSprite2D
@onready var dialog = levelmanager.dialog
@onready var timer = levelmanager.timer
var isready: bool = false
var iswin: bool = false
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$PlayerUI/Portait.sprite_frames = targetsprite
	portait.play()
	pause_menu.set_visible(false)
	$PlayerUI/Panel/Annonce.text = "You have %s seconds" % timer

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	
	var front = $"Point direction".global_position
	var mouse_pos = get_global_mouse_position()
	var target_angle = get_angle_to(mouse_pos)
	var current_angle = get_angle_to(front)
	var angle_difference = target_angle - current_angle
	var velocity_vector = (front - body.global_position).normalized()
	
	var threshold = 0.1

	if Input.is_action_pressed("rightclick") and isready == false:
		isready = true
		
		
		
	if abs(angle_difference) > threshold and isready == true:
		apply_torque(angle_difference * torque_strength)
		set_angular_damp(5)
	else:
		apply_torque(0)
		set_angular_damp(1000)
	
	if Input.is_action_pressed("leftclick") and isready == true:
		apply_central_force(velocity_vector * 100000 * delta)
		$VFXFire.set_emitting(true)
		
	else:	
		apply_central_force(velocity_vector * 0)
		$VFXFire.set_emitting(false)
		
	if Input.is_action_pressed("rightclick") and isready == true:
		Engine.set_time_scale(0.3)
		torque_strength = 50000
	else:
		Engine.set_time_scale(1)
		torque_strength = 30000
		
	if $PlayerUI/Panel.seconds == levelmanager.timer:
		print("boom")
		deathtimer.start()
		vfxexplosion.set_emitting(true)
		rocketsprite.set_visible(false)
	

func _on_nose_area_body_entered(body):
	print("boom")
	deathtimer.start()
	vfxexplosion.set_emitting(true)
	rocketsprite.set_visible(false)
	
	
func _on_death_timer_timeout() -> void:
	if iswin == false:
		get_tree().reload_current_scene()
	


func _on_button_pressed() -> void:
	var nextlevel = levelmanager.nextlevel
	get_tree().change_scene_to_file(nextlevel)
