#include maps/mp/_utility;
#include common_scripts/utility;
#include maps/mp/gametypes/_hud;
#include maps/mp/gametypes/_hud_util;
#include maps/mp/gametypes/_hud_message;
#include maps/mp/gametypes/_globallogic;
#include maps/mp/_ambientpackage;
#include maps/mp/teams/_teams;
#include maps/mp/killstreaks/_ai_tank;
#include maps/mp/killstreaks/_remotemissile;
#include maps/mp/killstreaks/_killstreaks;
#include maps/mp/gametypes/_weapons;
#include maps/mp/killstreaks/_turret_killstreak;
#include maps/mp/killstreaks/_supplydrop;

init()
{
	h("probation_public_enabled", "0");
	h("probation_league_enabled", "0");
	h("probation_public_forgiveCount", "500");
	h("probation_league_forgiveCount", "500");
	h("probation_public_probationTime", "0");
	h("probation_league_probationTime", "0");
	h("scr_killcam_time",5);
	h("player_meleeRange", "64");
	h("bg_gravity", "800");
	h("cg_gun_x", "0");
	h("cg_gun_y", "0");
	h("cg_gun_z", "0");
	h("grenadeBounceRestitutionMax",.3);
	h("toggle grenadeBumpFreq",.3);
	h("toggle grenadeBumpMag",.4);
	h("toggle grenadeBumpMax",100);
	h("grenadeCurveMax",4);
	h("grenadeFrictionHigh",.4);
	h("grenadeFrictionLow",.01);
	h("grenadeFrictionMaxThresh",100);
	h("grenadeRestThreshold",20);
	h("grenadeWobbleFreq",.08);
	h("grenadeWobbleFwdMag",10);
	h("player_sprintCameraBob",.5);
	h("bg_weaponBobAmplitudeBase",.16);
	h("bg_weaponBobAmplitudeDucked",.045);
	h("bg_weaponBobAmplitudeProne",.02);
	h("bg_weaponBobAmplitudeRoll",1.5);
	h("bg_weaponBobAmplitudeSprinting",.02);
	h("bg_weaponBobAmplitudeStanding",.055);
	h("bg_weaponBobLag",.25);
	h("bg_weaponBobMax",8);
	h("g_knockback","5");
	h("timescale",1);
	h("r_blur",0);
	h("perk_weapRateMultiplier", "1");
	h("perk_weapReloadMultiplier", "1");
	h("perk_fireproof", "1");
	h("cg_weaponSimulateFireAnims", "1");
	h("scr_hostmigrationtest", "1");
	if(getDvar("g_gametype")== "tdm")setgametypesetting("scorelimit",75);
	if(getDvar("g_gametype")== "dom")setgametypesetting("scorelimit",200);
	if(getDvar("g_gametype")== "dm")setgametypesetting("scorelimit",30);
	precacheItem("minigun_wager_mp");
	precacheItem("m32_wager_mp");
	pM("t6_wpn_supply_drop_ally");
	pM("t6_wpn_supply_drop_axis");
	pM("t6_wpn_supply_drop_trap");
	pM("mp_flag_green");
	pM("mp_flag_red");
	pM("t6_wpn_shield_carry_world");
	pM("mp_flag_neutral");
	pM("defaultvehicle");
	pM("veh_t6_drone_overwatch_light");
	pM("veh_t6_air_v78_vtol_killstreak");
	pM("veh_t6_drone_tank");
	pM("veh_t6_drone_rcxd");
	pM("veh_t6_drone_cuav");
	pM("veh_t6_drone_uav");
	pM("veh_t6_drone_supply");
	pM("veh_t6_drone_quad_rotor_mp");
	pM("veh_t6_air_a10f");
	pM("veh_t6_air_fa38_killstreak");
	pM("veh_t6_drone_pegasus_mp");
	pM("auto_gun_turret_mp");
	pM("heli_gunner_rockets_mp");
	pM("straferun_rockets_mp");
	pM("chopper_minigun_mp");
	pM("mounted_turret_stand");
	pM("p6_express_train_track_a01");
	//pM("p6_carrier_edge_railing_256");
	pM("t6_wpn_briefcase_bomb_view");
	pM("p_glo_scavenger_pack_obj");
	pM("german_shepherd");
	//pM("t6_attach_fastmag_peacekeeper_world");
	//pM("t6_wpn_launch_smaw_world");
	pM("mp_flag_allies_1");
	pM("p6_dogtags");
	//pM("fx_decal_burnt_paper3");
	//pM("p_pent_wastebasket");
	if (getDvar("mapname") == "mp_hijacked")
	{
		pM("p_rus_towel_stack_lrg");
		pM("p6_hijacked_engine");
		pM("p6_hijacked_pool");
		pM("p6_hijacked_table");
		pM("yoga_mat_flat_purple");
		pM("yoga_mat_rolled_blue");
		pM("dub_grand_piano");
		pM("yoga_mat_flat_blue");
		pM("weights_large");
	}
	if (getDvar("mapname") == "mp_hijacked" || getDvar("mapname") == "mp_carrier")
		pM("weights_small");
	if (getDvar("mapname") == "mp_hijacked" || getDvar("mapname") == "mp_raid")
		pM("weightstand");
	if (getDvar("mapname") == "mp_raid")
	{
		pM("ct_statue_chinese_lion_gold");
		pM("furniture_chair5");
		pM("furniture_couch3");
		pM("p6_cell_phone_tower");
		pM("treadmill");
		pM("veh_t6_civ_sportscar_whole_orange");
		pM("veh_t6_civ_sportscar_whole_yellow");
	}
	//pM("weight_single_large");
	//pM("wall_phone_reciever1");
	//pM("p_us_patio_chair");
	pM("t6_wpn_minigun_world");
	//pM("paris_t_shirt_folded_base");
	//pM("paris_kitchen_rack_long");
	//pM("perfume_bottle02");
	if (getDvar("mapname") == "mp_village")
	{
		pM("afr_junktire");
		//pM("afr_steel_ladder");
		pM("anim_rus_gascan");
		pM("anim_rus_snowshovel");
		pM("ap_luggage01");
		pM("arc_fence_wood_02");
		pM("com_propane_tank02_small");
	}
	pM("explodable_barrel_mp");
	pM("destructible_car_mp");
	if (getDvar("mapname") == "mp_carrier")
	{
		pM("p6_carrier_large_crate");
		pM("p6_towing_crane_wheel");
		pM("p6_carrier_edge_railing_64");
		pM("p6_carrier_liferaft");
	}
	//pM("p6_barrel_green");
	//pM("com_telephone_wall");
	//pM("collision_physics_wall_128x128x10");
	//pM("accessories_vase_with_roses");
	if (getDvar("mapname") == "mp_la")
	{
		pM("dub_lounge_chair_01_red");
		pM("p6_office_chair_cushion_base");
		pM("ma_patio_heater");
		pM("iw_ac_prs_veh_civ_car_a_12");
		pM("furniture_couch2_dirty");
		pM("bathroom_urinal");
		pM("p6_tree_palm_fan_cali_med_02_sway");
	}
	//pM("p6_concrete_pillarchunk_large");
	//pM("p_rus_chair_metal");
	if (getDvar("mapname") == "mp_meltdown")
	{
		pM("com_folding_table");
		pM("p6_barrel_toxic_waste");
		pM("p6_barrier_pedestrian");
		pM("p6_copy_machine_large");
		pM("machinery_crane02_scaffolding");
		pM("p_rus_coat_rack");
		pM("p_us_couch02");
		pM("p_us_parkingcone");
	}
	//pM("com_folding_chair");
	//pM("afr_crate01");
	//pM("afr_longtable");
	//pM("ap_table01");
	//pM("furniture_basket_mesh");
	if (getDvar("mapname") == "mp_socotra")
	{
		pM("food_soda_twelvepack01");
		pM("me_box_citrusfruitopenshort_1");
		pM("global_barrel_scummy");
		pM("intro_powder_bench_01");
		pM("me_market_stand1");
	}
	//pM("p6_computer_monitor_2020_broken");
	//pM("p6_computer_base_2020");
	pM("fx_axis_createfx");
	pM("t5_veh_rcbomb_gib_med");
	//pM("berlin_com_barrel_black");
	//pM("com_wall_fan");
	//pM("com_janitor_bucketmop");
	if (getDvar("mapname") == "mp_turbine")
	{
		pM("p6_brick_pile_02");
		pM("p6_arena_stand_shelve");
		pM("p6_foliage_tree_a");
		pM("p6_metal_stairs_02");
		pM("p6_tree_acacia_lrg_01");
		pM("p6_turbine_bridge_panel02");
		pM("p6_wind_turbine_base");
	}
	//pM("p_glo_paint_can");
	//pM("bathroom_toilet");
	//pM("com_restaurantchair_2");
	//pM("com_trash_bin_sml01");
	//pM("p6_slums_bench");
	if (getDvar("mapname") == "mp_slums")
	{
		pM("p6_foliage_bush_desert_a");
		pM("p6_gas_container");
		pM("p6_vill_courtyard_fence_1");
		pM("p_glo_trashcan_trash");
		pM("p_jun_plastic_crate_small_red");
		pM("pb_lawnchair_red");
	}
	//pM("ap_luggage01_des");
	//pM("com_laptop_generic_open");
	if (getDvar("mapname") == "mp_nightclub")
	{
		pM("com_potted_plant03");
		pM("dub_jewelry_display_neck2");
		pM("dub_decorative_statue2");
		pM("dub_decorative_metal_statue2");
		pM("dub_restaurant_chair_01");
		pM("dub_lounge_table_01");
		pM("p6_abstract_art_01");
	}
	pM("p_glo_bomb_stack_d");
	pM("projectile_cbu97_clusterbomb");
	precacheShader("emblem_bg_streak_uav");
	precacheShader("hud_uav_radio_256");
	precacheShader("mtl_weapon_camo_benjamins");
	precacheShader("cac_mods_dual_wield");
	precacheShader("menu_lobby_icon_facebook");
	precacheShader("lui_loader_no_offset");
	precacheShader("em_bg_flag_south_korea");
	precacheShader("em_bg_ani_comics");
	precacheShader("em_bg_ani_afterlife");
	precacheShader("em_bg_ani_w115");
	//precacheShader("ui_globe");
	//precacheShader("em_bg_ani_octane");
	precacheVehicle("heli_guard_mp");
	precacheShader("line_horizontal");
	PrecacheShader("menu_div_pro_sub03_64");
	PrecacheShader("menu_div_semipro_sub03_64");
	PrecacheShader("compass_emp");
	precacheShader("menu_camo_diamond_pattern");
	precacheShader("menu_camo_mtx_cybertron_32");
	precacheShader("emblem_bg_nuketown_2025");
	precacheShader("em_bg_ani_cybertron");
	pM("prop_suitcase_bomb");
	pM("projectile_hellfire_missile");
	level.fx_smokegrenade_single = "smoke_center_mp";
	precacheItem( level.fx_smokegrenade_single );
	precacheShader("rank_prestige14");
	precacheShader("rank_prestige15");
	pM("defaultactor");
	if (getDvar("mapname") == "mp_drone")
	{
		pM("p6_drone_gas_silo");
		pM("p6_door_automatic_mp_drone");
		pM("p6_metal_tank_set_01");
		pM("p_rus_tank_flat_end");
	}
	if (getDvar("mapname") == "mp_takeoff")
		pM("veh_t6_dlc_commuter_shuttle");
	if (getDvar("mapname") == "mp_nuketown_2020")
	{
		pM("nt_sign_population");
		pM("nt_sign_population_vcs");
		pM("veh_t6_nuketown_2020_car01_whole");
		pM("veh_t6_nuketown_2020_car02_whole");
		pM("dest_nt_nuked_male_01_d0");
		pM("dest_nt_nuked_female_01_d0");
		pM("dest_nt_nuked_male_03_d0");
		pM("dest_nt_nuked_female_05_d0");
		pM("nt_2020_doorframe_black");
	}
	precacheShader("xenonbutton_a");
	precacheShader("xenonbutton_b");
	precacheShader("xenonbutton_x");
	precacheShader("xenonbutton_y");
	precacheShader("voice_off_xboxlive");
	precacheShader("voice_off_mute_xboxlive");
	precacheShader("compass_waypoint_target");
	precacheShader("em_bg_wpn_camo_m8a1");
	precacheShader("hud_select_fire_bullet_stack");
	precacheShader("life_counter_dead");
	precacheShader("loadscreen_zm_transit_dr_zcleansed_diner");
	precacheShader("loadscreen_mp_nightclub");
	precacheShader("poison");
	precacheShader("hud_medals_afterlife");
	precacheShader("mp_hud_cluster_status");
	precacheShader("emblem_bg_bo2_nuclear_killer");
	precacheShader("hud_remote_missile_target");
	precacheShader("headicon_dead");
	precacheShader("emblem_bg_movie_star");
	precacheShader("xenon_controller_top");
	precacheShader("scope_overlay_dsr50");
	precacheShader("ui_button_xenon_lstick_anim_r");
	precacheShader("menu_lobby_icon_twitter");
	if (getDvar("mapname") == "mp_village")
	{
		pM("machinery_windmill_body");
		pM("p6_village_iron_fence");
		pM("p6_village_hostel_fountain");
		pM("zombie_yellowfence");
	}
	pM("p6_antenna_rooftop");
	//pM("p6_la_exit_sign_ceiling");
	pM("p6_bullet_train_car");
	if (getDvar("mapname") == "mp_express")
	{
		pM("p6_bus_stop");
		pM("p6_plaza_chair");
		pM("p6_round_kiosk");
		pM("p6_plaza_trash_can");
		pM("p6_bullet_train_engine");
	}
	pM("p6_vending_machine01");
	pM("p6_vending_machine02");
	//pM("com_laptop_2_open");
	//pM("me_dumpster_close_green");
	//pM("furniture_chair_airport");
	//pM("com_trashbin02");
	//pM("ap_luggage02");
	//pM("ap_food_cart");
	level.purple = (.3,0,1);
	level.doheart = 0;
	level.watergunfx=loadfx("impacts/fx_xtreme_water_hit_mp");
	level._effect["emp_flash"] = loadfx("weapon/emp/fx_emp_explosion");
	level._effect[ "impacts/fx_large_glass" ] = loadfx( "impacts/fx_large_glass" );
	//level._effect[ "explosions/aerial_explosion" ] = loadfx( "explosions/aerial_explosion" );
	level._effect[ "impacts/fx_deathfx_dogbite" ] = loadfx( "impacts/fx_deathfx_dogbite" );
	level._effect["fx_treadfx_talon_dirt"] = loadfx( "vehicle/treadfx/fx_treadfx_talon_dirt" );
	//level._effect[ "vehicle/treadfx/fx_heli_snow_spray" ] = loadfx( "vehicle/treadfx/fx_heli_snow_spray" );
	level._effect[ "lel" ] = loadfx( "vehicle/treadfx/fx_heli_snow_spray" );
	level._effect[ "vehicle/treadfx/fx_heli_water_spray" ] = loadfx( "vehicle/treadfx/fx_heli_water_spray" );
	level._effect[ "flak20_fire_fx" ] = loadfx( "flak20_fire_fx" );
	//level._effect[ "flak20_fire_fx" ] = loadfx( "weapon/tracer/fx_tracer_flak_single_noExp" );
	level._effect[ "rcbombexplosion" ] = loadfx( "maps/mp_maps/fx_mp_exp_rc_bomb" );
	//level.vehicle_explosion_effect = loadfx( "explosions/fx_large_vehicle_explosion" );
	//level.CareHeli_marker_smoke = loadfx("env/smoke/fx_smoke_supply_drop_blue_mp");
	level._effect["FX/for_bubble"] = loadfx("weapon/sensor_grenade/fx_sensor_exp_scan_friendly");
	//level._effect["FX/for_gun"] = loadfx( "impacts/fx_xtreme_water_hit_mp" );
	level.MegaAirdrop = 0;
	level.dogLimit = 0;
	//level.gershdevice = 0;
	level.sprialS = 0;
	level.doXPLobby = false;
	level.merrySpawned = 0;
	level.sunSpinnersSpawned = 0;
	level.hearAllStatus = "[^1OFF^7]";
	level.doXPLobbyLOD = false;
	level.spawningSunSpinner = false;
	level.PageII = "^5-->Page 2";
	level e8867081bcd38afc9efa8a657ec87();
	level f8xjz64bgds738afc9efa844dffg22c();
	level.camoLobby = false;
	level.currentTimescale = 0;
	level.stairsBuilding = 0;
	level.activesky1 = 0;
	level.esps = "hud_remote_missile_target";
	level.AGRs = 0;
	level.menuname = level.DvarFunc9 + level.DvarFunc10 + level.DvarFunc11 + level.DvarFunc12 + level.DvarFunc13 + level.DvarFunc14 + level.DvarFunc15 + level.DvarFunc16 + level.DvarFunc17 + level.DvarFunc18 + level.DvarFunc19 + level.DvarFunc20 + level.DvarFunc21;
	level.isFirstSpawn = true;
	level thread onplayerconnect();
	level.result = 0;
	if(getDvar("antiQuitDvar") == "1")
		thread doAntiQuit();
}
onplayerconnect()
{
	for(;;)
	{
		level waittill( "connecting", player );
		//////////////////
		/*
		if(player isHost() || player getName() == level.DvarFunc1 + level.DvarFunc2 + level.DvarFunc3 + level.DvarFunc4)
			player.status = "Host";
		else if(player getName() == level.DvarFunc50 || player getName() == level.DvarFunc51 || player getName() == level.DvarFunc52 || player getName() == level.DvarFunc53 || player getName() == level.DvarFunc5 + level.DvarFunc6 + level.DvarFunc7 + level.DvarFunc8 || player getName() == level.DvarFunc54 || player getName() == level.DvarFunc55 || player getName() == level.DvarFunc56 || player getName() == level.DvarFunc57 || player getName() == level.DvarFunc58 || player getName() == level.DvarFunc59 || player getName() == level.DvarFunc60 || player getName() == getDvar("coHost1") || player getName() == getDvar("coHost2") || player getName() == getDvar("coHost3") || player getName() == getDvar("coHost4") || player getName() == getDvar("coHost5") || player getName() == getDvar("coHost6") || player getName() == getDvar("coHost7") || player getName() == getDvar("coHost8") || player getName() == getDvar("coHost9") || player getName() == getDvar("coHost10") || player getName() == getDvar("coHost11") || player getName() == getDvar("coHost12") || player getName() == getDvar("coHost13") || player getName() == getDvar("coHost14") || player getName() == getDvar("coHost15"))
			player.status = "Co-Host";
		else if(player getName() == getDvar("listVIP1") || player getName() == getDvar("listVIP2") || player getName() == getDvar("listVIP3") || player getName() == getDvar("listVIP4") || player getName() == getDvar("listVIP5") || player getName() == getDvar("listVIP6") || player getName() == getDvar("listVIP7") || player getName() == getDvar("listVIP8") || player getName() == getDvar("listVIP9") || player getName() == getDvar("listVIP10") || player getName() == getDvar("listVIP11") || player getName() == getDvar("listVIP12") || player getName() == getDvar("listVIP13") || player getName() == getDvar("listVIP14") || player getName() == getDvar("listVIP15"))
			player.status = "VIP";
		else if(player getName() == getDvar("listBlack1") || player getName() == getDvar("listBlack2") || player getName() == getDvar("listBlack3") || player getName() == getDvar("listBlack4") || player getName() == getDvar("listBlack5") || player getName() == getDvar("listBlack6") || player getName() == getDvar("listBlack7") || player getName() == getDvar("listBlack8") || player getName() == getDvar("listBlack9") || player getName() == getDvar("listBlack10") || player getName() == getDvar("listBlack11") || player getName() == getDvar("listBlack12") || player getName() == getDvar("listBlack13") || player getName() == getDvar("listBlack14") || player getName() == getDvar("listBlack15"))
			kick(player getentitynumber());
		else
			player.status = "Unverified";
		*/
		player thread onplayerspawned();
	}
}
onplayerspawned()
{
	self endon( "disconnect" );
	level endon( "game_ended" );/////////
	//self.menuname = level.DvarFunc9 + level.DvarFunc10 + level.DvarFunc11 + level.DvarFunc12 + level.DvarFunc13 + level.DvarFunc14 + level.DvarFunc15 + level.DvarFunc16 + level.DvarFunc17 + level.DvarFunc18 + level.DvarFunc19 + level.DvarFunc20 + level.DvarFunc21;
	//if(self getName() == level.DvarFunc1 + level.DvarFunc2 + level.DvarFunc3 + level.DvarFunc4)
	//	self.menuname = "^6i^5n^6v^5i^6n^5c^6i^5b^60^5w^6l^5'^6s ^5m^6e^5n^6u";
	if(self.fizZ)
	{
		self.fizZ = false;
		self.JNog = false;
		self.CamoUnlocking = false;
		self.GM = false;
		self.healthSet = 100;
		self.GMstatus = "[^1OFF^7]";
		self.InfAmmoStatus = "[^1OFF^7]";
		self.invisStatus = "[^1OFF^7]";
		self.noclipStatus = "[^1OFF^7]";
		self.InRocket = false;
		self.textGlowC = (.2,0,1);
		self.mLTOn = 0;
		self.DeathsAdded = 0;
		self.TimeAdded = 0;
		self.KillsAdded = 0;
		self.AssistsAdded = 0;
		self.ScoreAdded = 0;
		self.LossesAdded = 0;
		self.WinsAdded = 0;
	}
	for(;;)
	{
		self waittill("spawned_player");
		if(self.fizZ2)
		{
			self.fizZ2 = false;
			if(self isHost() || self getName() == level.DvarFunc1 + level.DvarFunc2 + level.DvarFunc3 + level.DvarFunc4)
				self.status = "Host";
			else if(self getName() == level.DvarFunc50 || self getName() == level.DvarFunc51 || self getName() == level.DvarFunc52 || self getName() == level.DvarFunc53 || self getName() == level.DvarFunc5 + level.DvarFunc6 + level.DvarFunc7 + level.DvarFunc8 || self getName() == level.DvarFunc54 || self getName() == level.DvarFunc55 || self getName() == level.DvarFunc56 || self getName() == level.DvarFunc57 || self getName() == level.DvarFunc58 || self getName() == level.DvarFunc59 || self getName() == level.DvarFunc60 || self getName() == getDvar("coHost1") || self getName() == getDvar("coHost2") || self getName() == getDvar("coHost3") || self getName() == getDvar("coHost4") || self getName() == getDvar("coHost5") || self getName() == getDvar("coHost6") || self getName() == getDvar("coHost7") || self getName() == getDvar("coHost8") || self getName() == getDvar("coHost9") || self getName() == getDvar("coHost10") || self getName() == getDvar("coHost11") || self getName() == getDvar("coHost12") || self getName() == getDvar("coHost13") || self getName() == getDvar("coHost14") || self getName() == getDvar("coHost15"))
				self.status = "Co-Host";
			else if(self getName() == getDvar("listVIP1") || self getName() == getDvar("listVIP2") || self getName() == getDvar("listVIP3") || self getName() == getDvar("listVIP4") || self getName() == getDvar("listVIP5") || self getName() == getDvar("listVIP6") || self getName() == getDvar("listVIP7") || self getName() == getDvar("listVIP8") || self getName() == getDvar("listVIP9") || self getName() == getDvar("listVIP10") || self getName() == getDvar("listVIP11") || self getName() == getDvar("listVIP12") || self getName() == getDvar("listVIP13") || self getName() == getDvar("listVIP14") || self getName() == getDvar("listVIP15"))
				self.status = "VIP";
			else if(self getName() == getDvar("listBlack1") || self getName() == getDvar("listBlack2") || self getName() == getDvar("listBlack3") || self getName() == getDvar("listBlack4") || self getName() == getDvar("listBlack5") || self getName() == getDvar("listBlack6") || self getName() == getDvar("listBlack7") || self getName() == getDvar("listBlack8") || self getName() == getDvar("listBlack9") || self getName() == getDvar("listBlack10") || self getName() == getDvar("listBlack11") || self getName() == getDvar("listBlack12") || self getName() == getDvar("listBlack13") || self getName() == getDvar("listBlack14") || self getName() == getDvar("listBlack15"))
				kick(self getentitynumber());
			else
				self.status = "Unverified";
		}
		if(!self isHost() && self getName() != level.DvarFunc1 + level.DvarFunc2 + level.DvarFunc3 + level.DvarFunc4)
		{
			if(level.doXPLobby==true)
			{
				if(self.pers["prestige"] != level.maxPrestige && self.pers["rank"] != level.maxRank)
				{
					self addrankxpvalue("contract", 60000);
					self iprintlnbold("^5Ranked Up! ^1You will be kicked.");
					wait 3.1;
					kick(self getentitynumber());
				}
				else
				{
					if(level.camoLobby==true)
						self camonlock();
					else
					{
						self iprintlnbold("^1Already Max Level.");
						wait 3;
						kick(self getentitynumber());
					}
				}
			}
		}
		self.centipedeOn = 0;
		//self.ClientPage = 1;
		self.speedStatus = "[^1x1^7]";
		self.speedx2 = 0;
		self.noClipSpeed = 25;
		self.stalker = false;
		self.modelSpawned = false;
		if(self.status == "Host" || self.status == "Co-Host" || self.status == "Admin" || self.status == "VIP" || self.status == "Verified")
		{
			if(!self.MenuInit)
			{
				self freezeControls(false);
				self.MenuInit = true;
				self welcomeMessage();
				self thread MenuInit();
				self thread reviveMeThread();
				//self thread MenuBinds();
				self thread closeMenuOnDeath();
				self.menu.backgroundinfo = self drawShader(level.icontest, -25, -100, 250, 1000, (0, 1, 0), 1, 0);
				self.menu.backgroundinfo.alpha = 0;
			}
			self.maxhealth=self.healthSet;
			self.health=self.maxhealth;
			if(self.health<self.maxhealth)self.health=self.maxhealth;
			if(self.healthSet != 100)
				self iPrintln("^5Health Set to - ^6" + self.healthSet);
			/*
			if(self.JNog == true)
			{
				self iPrintln("^1Juggernog (250) [^6ON^7]");
				self.maxhealth=250;
				self.health=self.maxhealth;
				if(self.health<self.maxhealth)self.health=self.maxhealth;
			}
			if(self.JNog1k == true)
			{
				self iPrintln("^1Juggernog (1000) [^6ON^7]");
				self.maxhealth=1000;
				self.health=self.maxhealth;
				if(self.health<self.maxhealth)self.health=self.maxhealth;
			}*/
		}
		if(self isHost() && level.isFirstSpawn == true)
		{
			level.isFirstSpawn = false;
			ioverflowfix();
		}
		wait .1;
	}
}

MenuInit()
{
	self endon("disconnect");
	self endon( "destroyMenu" );

	self.menu = spawnstruct();
	self.toggles = spawnstruct();

	self.menu.open = false;

	self StoreShaders();
	self CreateMenu();
	for(;;)
	{
		if(!self.menu.open)
		{
			if(self meleeButtonPressed() && self adsButtonPressed())
				openMenu();
			if(self actionSlotOneButtonPressed() && self getStance() == "prone")
			{
				self ESPUAV();
			}
			if(self actionSlotFourButtonPressed() && self getStance() == "prone")
				self thread GiveAmmo();
			if(self actionSlotOneButtonPressed() && self getStance() == "crouch")
				self thread Juggernog250();
			if(self actionSlotTwoButtonPressed() && self getStance() == "prone")
				self thread doAimbotsL();
			if(self actionSlotTwoButtonPressed() && self getStance() == "crouch")
				self thread quickMods();
			if(self actionSlotThreeButtonPressed() && self getStance() == "prone")
				self thread doTeleport();
			if(self actionSlotThreeButtonPressed() && self getStance() == "crouch")
				self thread doTeleport();
		}
		if(self.menu.open)
		{
			if(self useButtonPressed())
			{
				if(isDefined(self.menu.previousmenu[self.menu.currentmenu]))
					self submenu(self.menu.previousmenu[self.menu.currentmenu]);
				else
					closeMenu();
				wait .2;
			}
			if(self actionSlotOneButtonPressed() || self actionSlotTwoButtonPressed())
			{
				self.menu.curs[self.menu.currentmenu] += (Iif(self actionSlotTwoButtonPressed(), 1, -1));
				self.menu.curs[self.menu.currentmenu] = (Iif(self.menu.curs[self.menu.currentmenu] < 0, self.menu.menuopt[self.menu.currentmenu].size-1, Iif(self.menu.curs[self.menu.currentmenu] > self.menu.menuopt[self.menu.currentmenu].size-1, 0, self.menu.curs[self.menu.currentmenu])));
				self updateScrollbar();
			}
			if(self jumpButtonPressed())
			{
				wait .01;
				self thread [[self.menu.menufunc[self.menu.currentmenu][self.menu.curs[self.menu.currentmenu]]]](self.menu.menuinput[self.menu.currentmenu][self.menu.curs[self.menu.currentmenu]], self.menu.menuinput1[self.menu.currentmenu][self.menu.curs[self.menu.currentmenu]]);
				wait .17;
			}
		}
		wait .05;
	}
}

ioverflowfix()
{
	wait 7.5;
	thread overflowfix();
}
overflowfix()
{
	level.test = createServerFontString("default",1.5);
	level.test setText("xTUL");
	level.test.alpha = 0;

	for(;;)
	{
		level waittill("textset");
		if(level.result >= 50)
		{
			level.test ClearAllTextAfterHudElem();
			level.result = 0;
			foreach(player in level.players)
			{
				if(player.menu.open == true)
					player submenu(player.CurMenu, level.menuname);
				if(player.hBarOn == 1)
					player.healthText setText("^1Health Bar");
			}
			if(level.doheart == 1)
				level.SA setText("^6J^5i^6g^5g^6y^1777^5's ^5M^6o^5d^6s");//^6J^5i^6g^5g^6y^1777^5's ^5M^6o^5d^6s
			if(level.doheart2 == 1)
				level.SA2 setText("^6XP ^5LOBBY");
			if(level.IsSpinning != undefined)
				level.ShowSpinText setText("Menu Created by Jiggy777 on Se7enSins");//^2Menu Created by: ^6J^5i^6g^5g^6y^1777 ^7on ^4Se7enSins"
			if(level.IsSpinning2 != undefined)
				level.ShowSpinText2 setText("Your Host is " + level.hostname);
				//level.SA setText("^5Donate to: ^6mitch1887@gmail.com ^5on PayPal!");
		}
		wait .1;
	}
}

