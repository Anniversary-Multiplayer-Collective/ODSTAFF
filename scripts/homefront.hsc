; Globals

(global short start_event 0)

; Externs

(script extern void (mp_sync_global (string global)))

; Scripts

(script startup void host_main
	(sleep 90)
	(wake host_phantom_sync)
	(mp_wake_script client_phantom_control)
)

(script dormant void host_phantom_sync
	(sleep_until 
		(begin
			(print "new start")
			(mp_sync_global start_event)
			(sleep (random_range 1000 1200))
			(set start_event 1)
			(sleep 90)
			(set start_event 0)
			(sleep (* 60 30))
			false
		)
	)
)

(script dormant void client_phantom_control
	(sleep_until
		(begin
			(if (= start_event 1)
				(begin
					(mp_object_create "phantom_01")
					(sleep 10)
					(object_set_function_variable "phantom_01" "scripted_object_function_c" 1 1)
					(object_set_function_variable "phantom_01" "scripted_object_function_a" 1 1)
					(object_set_function_variable "phantom_01" "scripted_object_function_b" 1 1)
					(scenery_animation_start "phantom_01" "cone_collective\objects\levels\multi\homefront\homefront_phantom\homefront_phantom" "homefront_phantom_anim_01")
					(object_set_custom_animation_speed "phantom_01" 0.35)
					(sleep 190)
					(object_set_function_variable "phantom_01" "scripted_object_function_d" 1 1)
					(sleep_until (= (scenery_get_animation_time "phantom_01") 0))
					(object_set_function_variable "phantom_01" "scripted_object_function_c" 0 1)
					(object_set_function_variable "phantom_01" "scripted_object_function_a" 0 1)
					(object_set_function_variable "phantom_01" "scripted_object_function_b" 0 1)
					(object_set_function_variable "phantom_01" "scripted_object_function_d" 0 1)
					(mp_object_destroy "phantom_01")
				)
			)
			false	
		)
	)
)
