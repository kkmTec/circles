extends Node2D

var rng = RandomNumberGenerator.new()
var circles = Array([], TYPE_OBJECT, "RefCounted", circle)
var window_size : Rect2 = get_viewport().get_visible_rect()

class circle:
	var position: Vector2
	var size: float
	var color: Color
	var move: Vector2
	
	func _init(pos: Vector2, s: float, col: Color, m: Vector2) -> void:
		self.position = pos
		self.size = s
		self.color = col
		self.move = m
		
	func move_control(w_s: Rect2):
		
		position.x += move.x
		position.y += move.y
		#Or as added vectors-->     position += move
		
		if position.x - size < 0:
			position.x = -position.x + 2*size
			move.x *= -1		
		if position.x + size > w_s.size.x:
			position.x = 2*w_s.size.x - position.x - 2*size
			move.x *= -1
			
		if position.y - size < 0:
			position.y = -position.y + 2*size
			move.y *= -1
		if position.y + size > w_s.size.y:
			position.y = 2*w_s.size.y - position.y - 2*size
			move.y *= -1			
			
			
	
# Called when the node enters the scene tree for the first time.
func _ready():
	circles.append(circle.new(Vector2(200,200), 100, Color(1,0,0), Vector2(1,2)))

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	queue_redraw()
	
func _input(event):
# ui_mouse_left is set in Project -> Project Settings -> Map Input
	if event.is_action_pressed("ui_mouse_left"):
		circles.append(circle.new(Vector2(event.position.x, event.position.y), rng.randi_range(20,100), Color(rng.randf_range(0.3,1.0),rng.randf_range(0.3,1.0),rng.randf_range(0.3,1.0)), Vector2(rng.randf_range(-5,5),rng.randf_range(-5,5))))
	
func _draw():
	for circle in circles:
		draw_circle(circle.position, circle.size, circle.color)
		circle.move_control(window_size)
		

	
