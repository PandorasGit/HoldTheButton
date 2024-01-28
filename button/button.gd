extends Node3D

@onready var material = preload("res://button/button.tres")

var is_held := false
var time_held := 0.0
var time_string
var seconds
var minutes
var hours
var millis 
var days
var range = Vector2.ZERO

func _physics_process(delta):
	$Camera3D.position.x = randf_range(range.x, range.y)
	$Camera3D.position.y = randf_range(range.x, range.y)
	if is_held:
		time_held += delta
		days = time_held / 86400
		hours = time_held / 3600
		minutes = time_held / 60
		seconds = fmod(time_held, 60)
		millis = fmod(time_held, 1) * 100 
		
		
		$Label.text = "You have held it for %0d Days %0d Hours %0d Minutes %02d Seconds %02d Milliseconds" % [days, hours, minutes, seconds, millis]
	else:
		time_held = 0.0

func _input(event):
	if Input.is_action_just_released("everything"):
		range = Vector2.ZERO
		fire_off()
		is_held = false
		$AnimationPlayer.play("RESET")
		print(":<")
		$AudioStreamPlayer.stop()
	if Input.is_action_just_pressed("everything"):
		
		is_held = true
		$AnimationPlayer.play("click_in")
		print(":>")
		$AudioStreamPlayer.play()
		
func fire():
	$video_background.material.albedo_texture = $Video.get_texture()
	$video_background.material.emission_texture = $Video.get_texture()
	
func fire_off():
	$video_background.material.albedo_texture = material
	$video_background.material.emission_texture = material
	
func shake():
	range = Vector2(-0.05, 0.05)
