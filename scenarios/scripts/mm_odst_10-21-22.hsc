; Globals
(global boolean debug true)
(global short ui_location -1)
(global real mainmenu_offset 0)
(global long wait_ticks 0)
(global short ui_location_clock_start -1)
(global boolean main_menu_sc_sh1_loop false)

; Externs

; Scripts
(script static unit player0
	(player_get 0)
)

(script static unit player1
	(player_get 1)
)

(script static unit player2
	(player_get 2)
)

(script static unit player3
	(player_get 3)
)

(script static void cinematic_snap_to_black
	(fade_out 0 0 0 0)
	(cinematic_preparation)
)

(script static void cinematic_preparation
	(ai_disregard (players) true)
	(object_cannot_take_damage (players))
	(player_control_fade_out_all_input 0)
	(object_hide (player0) true)
	(object_hide (player1) true)
	(object_hide (player2) true)
	(object_hide (player3) true)
	(unit_enable_vision_mode (player0) false)
	(unit_enable_vision_mode (player1) false)
	(unit_enable_vision_mode (player2) false)
	(unit_enable_vision_mode (player3) false)
	(replenish_players)
	(chud_cinematic_fade 0 0)
	(chud_show_messages false)
	(campaign_metagame_time_pause true)
	(player_enable_input false)
	(player_disable_movement false)
	(sleep 1)
	(cinematic_start)
	(camera_control true)
)

(script static void replenish_players
	(if debug
		(print "replenish player health...")
	)
	(unit_set_current_vitality (player0) 80 80)
	(unit_set_current_vitality (player1) 80 80)
	(unit_set_current_vitality (player2) 80 80)
	(unit_set_current_vitality (player3) 80 80)
)

(script static void (sleep_ui (long timer_ticks))
	(print "sleep ui script")
	(set ui_location_clock_start ui_location)
	(set wait_ticks 0)
	(sleep_until (begin
		(set wait_ticks (+ wait_ticks 1))
		(if (!= ui_location ui_location_clock_start)
			(set wait_ticks timer_ticks)
		)
		(>= wait_ticks timer_ticks)
	)
	 1)
)

(script static void (set_ui_location (short location))
	(set ui_location location)
	(sleep 1)
)

(script startup void mainmenu
	(print "mainmenu statup script")
	(wake appearance_characters)
	(mainmenu_cam)
)

(script dormant void appearance_characters
	(print "appearance characters [dormant script]")
	(sleep 1)
	(objects_attach "odst_appearance" "right_hand" "appearance_ssmg" "invalid")
	(objects_attach "elite_appearance" "right_hand_elite" "appearance_pr" "invalid")
	(custom_animation_loop "odst_appearance" "objects\characters\odst_recon\odst_recon" "combat:rifle:any:idle" false)
	(custom_animation_loop "elite_appearance" "objects\characters\dervish\dervish" "ui:pistol:idle:var1" false)
	(object_hide "odst_appearance" true)
	(object_hide "elite_appearance" true)
)

(script static void mainmenu_cam
	(cinematic_snap_to_black)
	(begin_cinematic_mainmenu)
	(fade_in 0 0 0 30)
	(cinematic_show_letterbox_immediate false)
	(object_set_always_active "b_chief" true)
	(object_set_always_active "b_player0" true)
	(object_set_always_active "b_player1" true)
	(object_set_always_active "b_player2" true)
	(object_set_always_active "b_player3" true)
	(object_set_always_active "b_elite" true)
	(object_set_always_active "b_oni" true)
	(object_set_always_active "b_oni_op_00" true)
	(object_set_always_active "b_oni_op_01" true)
	(object_set_always_active "b_oni_op_02" true)
	(object_set_always_active "b_oni_op_03" true)
	(object_set_always_active "b_dutch" true)
	(object_set_always_active "b_mickey" true)
	(object_set_always_active "b_romeo" true)
	(object_set_always_active "b_sergeant" true)
	(object_set_always_active "b_odst01" true)
	(object_set_always_active "b_odst02" true)
	(object_set_always_active "b_odst03" true)
	(object_set_always_active "b_odst04" true)
	(sleep_until (begin
		(camera_set_cinematic_scene (cinematic_tag_reference_get_scene 0 0) 0 "c100_01_anchor")
		(cinematic_set_shot (cinematic_tag_reference_get_scene 0 0) 0)
		(cinematic_object_create_cinematic_anchor "c100_01_anchor" "c100_01_anchor")
		(cinematic_scripting_create_and_animate_cinematic_object 0 0 0 "player01_1" true)
		(cinematic_scripting_create_and_animate_cinematic_object 0 0 1 "player_pod_1" true)
		(cinematic_lights_initialize_for_shot 0)
		(cinematic_clips_initialize_for_shot 0)
		(sleep 292)
		false
	)
	 1)
)

(script static void main_menu_sc_sh1
	(cinematic_show_letterbox_immediate false)
	(camera_set_cinematic_scene (cinematic_tag_reference_get_scene 0 0) 0 "c100_01_anchor")
	(cinematic_set_shot (cinematic_tag_reference_get_scene 0 0) 0)
	(cinematic_object_create_cinematic_anchor "c100_01_anchor" "c100_01_anchor")
	(cinematic_scripting_create_and_animate_cinematic_object 0 0 0 "player01_1" true)
	(cinematic_scripting_create_and_animate_cinematic_object 0 0 1 "player_pod_1" true)
	(cinematic_lights_initialize_for_shot 0)
	(cinematic_clips_initialize_for_shot 0)
	(sleep 292)
	(cinematic_lights_destroy_shot)
	(cinematic_clips_destroy)
	(render_exposure_fade_out 0)
)

(script continuous void !main_menu_sc_sh1_looper
	(sleep_until main_menu_sc_sh1_loop)
	(main_menu_sc_sh1)
)

(script static void !main_menu_sc
	(cinematic_print "beginning scene 1")
	(cinematic_set_shot (cinematic_tag_reference_get_scene 0 0) 0)
	(main_menu_sc_sh1)
	(cinematic_lights_destroy)
	(cinematic_clips_destroy)
	(render_exposure_fade_out 0)
	(cinematic_scripting_destroy_object 0 0 0)
	(cinematic_scripting_destroy_object 0 0 1)
)

(script static void cinematic_mainmenu_cleanup
	(cinematic_scripting_clean_up 0)
)

(script static void begin_cinematic_mainmenu_debug
	(cinematic_zone_activate_for_debugging 0)
	(sleep 2)
	(camera_control true)
	(cinematic_start)
	(cinematic_show_letterbox_immediate true)
	(chud_cinematic_fade 0 0)
	(camera_set_cinematic)
	(cinematic_set_debug_mode true)
	(cinematic_set (cinematic_tag_reference_get_cinematic 0))
)

(script static void end_cinematic_mainmenu_debug
	(cinematic_destroy)
	(chud_cinematic_fade 1 0)
	(cinematic_stop)
	(cinematic_show_letterbox_immediate false)
	(camera_control false)
	(render_exposure_fade_out 0)
	(cinematic_zone_deactivate 0)
	(fade_in 0 0 0 0)
)

(script static void cinematic_mainmenu_debug
	(begin_cinematic_mainmenu_debug)
	(fade_in 0 0 0 0)
	(!main_menu_sc)
	(end_cinematic_mainmenu_debug)
)

(script static void begin_cinematic_mainmenu
	(cinematic_zone_activate 0)
	(sleep 2)
	(camera_set_cinematic)
	(cinematic_set_debug_mode false)
	(cinematic_set (cinematic_tag_reference_get_cinematic 0))
)

(script static void end_cinematic_mainmenu
	(cinematic_destroy)
	(render_exposure_fade_out 0)
)

(script static void cinematic_mainmenu
	(begin_cinematic_mainmenu)
	(fade_in 0 0 0 0)
	(!main_menu_sc)
	(end_cinematic_mainmenu)
)

(script static void settings_cam
	(print "settings cam")
	(cinematic_destroy)
	(cinematic_stop)
	(kill_active_scripts)
	(object_hide "elite_appearance" false)
	(object_hide "odst_appearance" false)
	(camera_set "settings_cam" -1)
)

(script static void leave_settings
	(print "leave settings")
	(object_hide "odst_appearance" true)
	(object_hide "elite_appearance" true)
	(mainmenu_cam)
)

(script static void server_browser_cam
	(print "server browser camera")
	(cinematic_destroy)
	(cinematic_stop)
	(kill_active_scripts)
	(fade_out 0 0 0 0)
	(sleep 5)
	(fade_in 0 0 0 9)
	(camera_set "server_browser_cam" -1)
)

(script static void leave_server_browser
	(print "leave server browser")
	(fade_in 0 0 0 9)
	(mainmenu_cam)
)

(script static void character_changed
	(sleep 1)
	(effect_new_on_object_marker "objects\characters\elite\fx\shield\shield_recharge" "elite_appearance" "body")
	(effect_new_on_object_marker "objects\characters\masterchief\fx\shield\shield_recharge" "odst_appearance" "body")
)
