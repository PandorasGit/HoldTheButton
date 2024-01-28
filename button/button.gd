extends Node3D

var is_held := false
var time_held := 0.0
var time_string
var seconds
var minutes
var hours
var millis 
var days

func _physics_process(delta):
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
		is_held = false
		$AnimationPlayer.play("RESET")
		print(":<")
		$AudioStreamPlayer.stop()
	if Input.is_action_just_pressed("everything"):
		is_held = true
		$AnimationPlayer.play("click_in")
		print(":>")
		$AudioStreamPlayer.play()
