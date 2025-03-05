extends Node2D

#Скорость пули
@export var speed = 1000

#вектор движения
var direction = Vector2()

#старт работы скрипта
func _ready() -> void:
	#Подключает сигнал столкновений
	connect("body_entered", Callable(self, "_on_body_entered"))
	
func _process(delta: float) -> void:
	#Обновляем позицию пули
	position += direction * speed * delta
	
func _on_body_entered(body) -> void:
	#Уничтожаем пулю
	queue_free()
