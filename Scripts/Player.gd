extends KinematicBody2D

const MAX_SPEED = 400
export (int) var speed
var Velocity = Vector2()

var posArray = [Vector2(0,0),Vector2(0,0)]

func _process(delta):
	if Input.is_action_pressed("move_left"):
		Velocity.x -= speed * delta
	if Input.is_action_pressed("move_right"):
		Velocity.x += speed * delta
	if Input.is_action_pressed("move_up"):
		Velocity.y -= speed * delta
	if Input.is_action_pressed("move_down"):
		Velocity.y += speed * delta
	
	Velocity *= .82
	if abs(Velocity.x) < 2:
		Velocity.x = 0
	if abs(Velocity.y) < 2:
		Velocity.y = 0

	if Velocity.length() > MAX_SPEED:
		Velocity = Velocity.normalized() * MAX_SPEED

	Velocity = move_and_slide(Velocity, Vector2(0,-1))

	$CanvasLayer/Spedometer.text = str(Velocity)
	$CanvasLayer/Spedometer2.text = str(Velocity.normalized())


func _on_DistTimer_timeout():
	posArray.append(self.global_position)
	posArray.pop_front()
	print(posArray[1].distance_to(posArray[0]))
	
