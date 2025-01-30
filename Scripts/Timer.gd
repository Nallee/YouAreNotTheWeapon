extends Panel

var time: float = 0.0
var minutes: int = 0
var seconds: int = 0
var mil: int = 0 


func _process(delta) -> void:
	time += delta
	mil = fmod(time, 1)*100
	seconds = fmod(time,60)
	minutes = fmod(time, 3600) / 60
	$Minutes.text = "%02d:" % minutes
	$Sec.text = "%02d:" % seconds
	$Mil.text = "%02d:" % mil
