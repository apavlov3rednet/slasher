extends Area2D

@export var speed = 200
@export var runSpeed = 300

var target_position = Vector2()
var bullet = preload("res://scenes/bullet.tscn")
var playerPosition = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	target_position = position

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	#Вектор движения
	var velocity = Vector2()
	#Проверяем нажатие клавиш и задаем направление движения
	if Input.is_action_pressed("ui_left"):
		velocity.x -= 1
	if Input.is_action_pressed("ui_right"):
		velocity.x += 1
	if Input.is_action_pressed("ui_up"):
		velocity.y -= 1
	if Input.is_action_pressed('ui_down'):
		velocity.y += 1
		
	#Нормализуем вектор движения и проверяем зажата ли клавиша Shift
	if Input.is_action_pressed('ui_run'):
		velocity = velocity.normalized() * runSpeed
	else: 
		velocity = velocity.normalized() * speed
		
	#Обновить позицию персонажа
	position += velocity * delta
	playerPosition = position
	
	#Поворачиваем персонажа в направлении курсора мыши
	look_at(get_global_mouse_position())
	
	if Input.is_action_just_pressed('ui_select'):
		shoot()

#Логика стрельбы	
func shoot():
	#print('Shoot!')
	#инстанцируем пулю
	var bullet_instance = bullet.instantiate()
	
	#Начальная позиция пули
	bullet_instance.position = playerPosition
	
	var mouse_position = get_global_mouse_position()
	bullet_instance.direction = (mouse_position - playerPosition).normalized()
	
	#Добавляем пулю на сцену
	get_parent().add_child(bullet_instance)
	$AudioStreamPlayer.play()
	
	
	
