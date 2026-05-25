extends Node

var escena_actual: String = ""

# =========================================================
# INVENTARIO (¡Sincronizado y Unificado!)
# =========================================================
var inventario: Array = []

# TRUCO MÁGICO: Cualquier script que use "inventory" leerá y escribirá en "inventario"
var inventory: Array:
	get: return inventario
	set(value): inventario = value

# =========================================================
# MISIONES
# =========================================================
var misiones = {}

# =========================================================
# FLAGS / EVENTOS
# =========================================================
var flags = {}

# =========================================================
# DATOS DEL JUGADOR
# =========================================================
var vida_player = 100
var energia_player = 100

# =========================================================
# ACCESOS
# =========================================================
var acceso_mantenimiento = false
var acceso_reactor = false
var acceso_laboratorio = false
var acceso_seguridad = false
var acceso_observacion = false
var acceso_puente = false
var acceso_enfermeria = false

# =========================================================
# EVENTOS IMPORTANTES
# =========================================================
var alien_salvado = false
var reactor_reparado = false
var nave_activada = false
var alarma_activada = false
var experimento_descubierto = false

# =========================================================
# PROGRESO GENERAL
# =========================================================
var tiempo_jugado = 0
var cantidad_guardados = 0


# =========================================================
# FUNCIONES DE INVENTARIO
# =========================================================
func agregar_objeto(nombre_objeto):
	if nombre_objeto not in inventario:
		inventario.append(nombre_objeto)
		print("OBJETO AGREGADO: ", nombre_objeto)

func tiene_objeto(nombre_objeto):
	return nombre_objeto in inventario

# Esta función ahora lee directamente el inventario correcto
func has_item(nombre_del_item: String) -> bool:
	return inventario.has(nombre_del_item)

func eliminar_objeto(nombre_objeto):
	if nombre_objeto in inventario:
		inventario.erase(nombre_objeto)
		print("OBJETO ELIMINADO: ", nombre_objeto)


# =========================================================
# MISIONES
# =========================================================
func iniciar_mision(nombre_mision):
	misiones[nombre_mision] = "activa"
	print("MISIÓN INICIADA: ", nombre_mision)

func completar_mision(nombre_mision):
	misiones[nombre_mision] = "completada"
	print("MISIÓN COMPLETADA: ", nombre_mision)

func estado_mision(nombre_mision):
	if nombre_mision in misiones:
		return misiones[nombre_mision]
	return "ninguna"


# =========================================================
# FLAGS / EVENTOS
# =========================================================
func activar_flag(nombre_flag):
	flags[nombre_flag] = true
	print("FLAG ACTIVADA: ", nombre_flag)

func desactivar_flag(nombre_flag):
	flags[nombre_flag] = false
	print("FLAG DESACTIVADA: ", nombre_flag)

func tiene_flag(nombre_flag):
	if nombre_flag in flags:
		return flags[nombre_flag]
	return false


# =========================================================
# GUARDAR PARTIDA
# =========================================================
func guardar_partida():
	var player = get_tree().get_first_node_in_group("player")
	if player == null:
		print("ERROR: NO SE ENCONTRÓ EL PLAYER")
		return

	cantidad_guardados += 1

	var datos = {
		"escena": get_tree().current_scene.scene_file_path,
		"player_x": player.global_position.x,
		"player_y": player.global_position.y,
		"inventario": inventario,
		"misiones": misiones,
		"flags": flags,
		"vida_player": vida_player,
		"energia_player": energia_player,
		"acceso_mantenimiento": acceso_mantenimiento,
		"acceso_reactor": acceso_reactor,
		"acceso_laboratorio": acceso_laboratorio,
		"acceso_seguridad": acceso_seguridad,
		"acceso_observacion": acceso_observacion,
		"acceso_puente": acceso_puente,
		"acceso_enfermeria": acceso_enfermeria,
		"alien_salvado": alien_salvado,
		"reactor_reparado": reactor_reparado,
		"nave_activada": nave_activada,
		"alarma_activada": alarma_activada,
		"experimento_descubierto": experimento_descubierto,
		"tiempo_jugado": tiempo_jugado,
		"cantidad_guardados": cantidad_guardados
	}

	var archivo = FileAccess.open("user://savegame.save", FileAccess.WRITE)
	archivo.store_var(datos)
	archivo.close()
	print("PARTIDA GUARDADA")


# =========================================================
# CARGAR PARTIDA
# =========================================================
func cargar_partida():
	if FileAccess.file_exists("user://savegame.save"):
		var archivo = FileAccess.open("user://savegame.save", FileAccess.READ)
		var datos = archivo.get_var()
		archivo.close()

		if "inventario" in datos:
			inventario = datos["inventario"]

		if "misiones" in datos:
			misiones = datos["misiones"]

		if "flags" in datos:
			flags = datos["flags"]

		if "vida_player" in datos:
			vida_player = datos["vida_player"]

		if "energia_player" in datos:
			energia_player = datos["energia_player"]

		if "acceso_mantenimiento" in datos:
			acceso_mantenimiento = datos["acceso_mantenimiento"]

		if "acceso_reactor" in datos:
			acceso_reactor = datos["acceso_reactor"]

		if "acceso_laboratorio" in datos:
			acceso_laboratorio = datos["acceso_laboratorio"]

		if "acceso_seguridad" in datos:
			acceso_seguridad = datos["acceso_seguridad"]

		if "acceso_observacion" in datos:
			acceso_observacion = datos["acceso_observacion"]

		if "acceso_puente" in datos:
			acceso_puente = datos["acceso_puente"]

		if "acceso_enfermeria" in datos:
			acceso_enfermeria = datos["acceso_enfermeria"]

		if "alien_salvado" in datos:
			alien_salvado = datos["alien_salvado"]

		if "reactor_reparado" in datos:
			reactor_reparado = datos["reactor_reparado"]

		if "nave_activada" in datos:
			nave_activada = datos["nave_activada"]

		if "alarma_activada" in datos:
			alarma_activada = datos["alarma_activada"]

		if "experimento_descubierto" in datos:
			experimento_descubierto = datos["experimento_descubierto"]

		if "tiempo_jugado" in datos:
			tiempo_jugado = datos["tiempo_jugado"]

		if "cantidad_guardados" in datos:
			cantidad_guardados = datos["cantidad_guardados"]

		if "escena" in datos:
			get_tree().change_scene_to_file(datos["escena"])

			var player = null
			while player == null:
				await get_tree().process_frame
				player = get_tree().get_first_node_in_group("player")

			player.global_position = Vector2(datos["player_x"], datos["player_y"])

		print("PARTIDA CARGADA")
	else:
		print("NO EXISTE PARTIDA GUARDADA")


# =========================================================
# REINICIAR TODO
# =========================================================
func reiniciar_datos():
	inventario.clear()
	misiones.clear()
	flags.clear()

	vida_player = 100
	energia_player = 100

	acceso_mantenimiento = false
	acceso_reactor = false
	acceso_laboratorio = false
	acceso_seguridad = false
	acceso_observacion = false
	acceso_puente = false
	acceso_enfermeria = false

	alien_salvado = false
	reactor_reparado = false
	nave_activada = false
	alarma_activada = false
	experimento_descubierto = false

	tiempo_jugado = 0
	print("DATOS REINICIADOS")


# =========================================================
# VARIABLES DE COMBATE
# =========================================================
var victorias_necesarias: int = 1
var llave_recompensa: String = ""
var sala_antes_del_combate: String = ""
