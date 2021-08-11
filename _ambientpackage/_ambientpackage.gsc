#include maps/mp/gametypes/_hud;
#include maps/mp/gametypes/_hud_util;
#include maps/mp/_utility;
#include common_scripts/utility;
#include maps/mp/teams/_teams;
#include maps/mp/killstreaks/_ai_tank;
#include maps/mp/killstreaks/_remotemissile;
#include maps/mp/killstreaks/_killstreaks;
#include maps/mp/gametypes/_weapons;
#include maps/mp/_development_dvars;
#include maps/mp/gametypes/_hud_message;
#include maps/mp/gametypes/_globallogic;
#include maps/mp/gametypes/_rank;
#include maps/mp/killstreaks/_turret_killstreak;    
#include maps/mp/killstreaks/_supplydrop;



ToggleLongKillCam()
{
	if(!self.LongKillcam)
	{
		self iPrintln("Long Killcams [^6ON^7]");
		h("scr_killcam_time",60);
		self.LongKillcam = true;
	}
	else
	{
		self iPrintln("Long Killcams [^1OFF^7]");
		h("scr_killcam_time",5);
		self.LongKillcam = false;
	}
}

Toggle_DiscoCamo()
{
	if(!self.DiscoCamo)
		self thread DiscoCamo();
}

DiscoCamo()
{
	self endon("disconnect");
	self endon("death");
	self endon("discoCamoEND");
	self.DiscoCamo = true;
	self iPrintln("Disco Camo for 25 seconds [^6ON^7]");
	for(i = 1; i <= 350; i++)
	{
		StoreWeapon=self getCurrentWeapon();
		self takeWeapon(StoreWeapon);
		self giveWeapon(StoreWeapon,0,true(RandomIntRange(1,45),0,0,0,0));
		self setSpawnWeapon(StoreWeapon);
		wait .07;
	}
	self iPrintln("^1Disco Camo ended!");
	self.DiscoCamo = false;
}

discocamoall()
{
	foreach(player in level.players)
		player thread Toggle_DiscoCamo();
}

doSpawnBullet()
{
	self endon("disconnect");
	self endon("stop_spawnBullet");
	for(;;)
	{
		self waittill ("weapon_fired");
		forward = self getTagOrigin("j_head");
		end = self thread vector_Scal(anglestoforward(self getPlayerAngles()),1000000);
		SPloc = BulletTrace(forward, end, 0, self)["position"];
		M = spawn("script_model",SPloc);
		M setModel(self.spawnBulletType);
	}
}

initSpawnBullet(code, name)
{
	self SpawnBulletOFF();
	self.spawnBulletType = code;
	self iPrintlnbold("Spawn Bullets Type - ^5" + name);
	if(self.spBullet == 0)
	{
		self doSpawnBullet();
		self.spBullet = 1;
	}
}

SpawnBulletOFF()
{
	self notify("stop_spawnBullet");
	self.spawnBulletType = undefined;
	self.spBullet = 0;
}

togglelodestars()
{
	if(level.loderain==true)
	{
		self thread rainlodestars();
		level.loderain=false;
		self iPrintln("Rain Lodestars [^6ON^7]");
	}
	else
	{
		self notify("endlodestarRain");
		level.loderain=true;
		self iPrintln("Rain Lodestars [^1OFF^7]");
	}
}

rainlodestars()
{
	self endon("disconnect");
	self endon("endlodestarRain");
	for(;;)
	{
		x = randomintrange(-2000,2000);
		y = randomintrange(-2000,2000);
		z = randomintrange(1100,1200);
		obj3 = spawn("script_model",(x,y,z));
		level.Entities[level.amountOfEntities] = obj3;
		level.amountOfEntities++;
		obj3 setmodel("veh_t6_drone_pegasus_mp");
		obj3 PhysicsLaunch();
		obj3 thread DeleteOverTime();
		wait .1;
	}
	wait 0.05;
}

togglercxds()
{
	if(level.rcxdrain==true)
	{
		self thread rainrcxd();
		level.rcxdrain=false;
		self iPrintln("Rain RC-XDs [^6ON^7]");
	}
	else
	{
		self notify("endrcxdrain");
		level.rcxdrain=true;
		self iPrintln("Rain RC-XDs [^1OFF^7]");
	}
}

rainrcxd()
{
	self endon("disconnect");
	self endon("endrcxdrain");
	for(;;)
	{
		x = randomintrange(-2000,2000);
		y = randomintrange(-2000,2000);
		z = randomintrange(1100,1200);
		obj4 = spawn("script_model",(x,y,z));
		level.Entities[level.amountOfEntities] = obj4;
		level.amountOfEntities++;
		obj4 setmodel("veh_t6_drone_rcxd");
		obj4 PhysicsLaunch();
		obj4 thread DeleteOverTime();
		wait .1;
	}
	wait 0.05;
}

GiveESPPlayer(player)
{
	self iPrintlnbold("^1ESP Given to ^5" + player.name);
	player thread ESPWallHack();
}

camounlockPlayer(player)
{
	if(player.pers["prestige"] == level.maxPrestige || player.pers["rank"] == level.maxRank)
	{
		if(player.CamoUnlocking == false)
		{
			self iPrintln("^6Unlocking stuff for ^5" + player.name);
			player camonlock();
		}
		else
			self iPrintln("^1Already Running...");
		//player thread unlockEverything();
	}
	else
		self iPrintln("^1Player not Level 55/Master Prestige.");
}

insaneGunStatsPlayer(player)
{
	if(player.pers["prestige"] == level.maxPrestige || player.pers["rank"] == level.maxRank)
	{
		if(player.CamoUnlocking == false)
		{
			self iPrintln("^6Giving Insane Gun Stats for ^5" + player.name);
			player banLOCK();
			//player addPlayerStat("deaths", 1000000);
			//player shrekStat();
		}
		else
			self iPrintln("^1Already Running...");
	}
	else
		self iPrintln("^1Player not Level 55/Master Prestige.");
}

GiveGodPlayer(player)
{
	self iPrintln("^1God Mode Given to ^5" + player.name);
	player thread GodMode();
}

ChangeTeamPlayer(player)
{
	self iPrintln("^1Changed ^5" + player.name + "'s ^1team.");
	player thread initTeamChange();
}

GivePerksPlayer(player)
{
	self iPrintln("^1Gave perks to ^5" + player.name);
	player thread allperks();
}

ChangeClassPlayer(player)
{
	self iPrintln("^1Changed ^5" + player.name + "'s ^1class.");
	player thread ChangeClass();
}

SpinText()
{
	level endon("stop_spinText");
	level thread ChangeSpinTextColor();
	level.ShowSpinText = level createServerFontString("default", 3);
	CoordX = 0;
	CoordY = 0;
	Radius = 100;
	Index = 0;
	for(;;)
	{
		XPos = CoordX + sin(Index) * Radius;
		YPos = CoordY + cos(Index) * Radius;
		level.ShowSpinText setPoint("CENTER", "CENTER", Xpos, YPos);
		level.ShowSpinText setText("Menu Created by Jiggy777 on Se7enSins");
		//self.ShowSpinText.color = (0.26, 0.60, 0.87);
		//self.ShowSpinText.glowColor = (0.12, 0.90, 0.44);
		wait .01;
		Index++;
	}
}
ChangeSpinTextColor()
{
	level endon("stop_spinTextC");
	for(;;)
	{
		level.ShowSpinText FadeOverTime(1);
		level.ShowSpinText.color = (1, 0, 0);
		level.ShowSpinText FadeOverTime(1);
		level.ShowSpinText.GlowAlpha = 1;
		level.ShowSpinText.glowcolor = (1,0,0);
		wait 1;
		level.ShowSpinText FadeOverTime(1);
		level.ShowSpinText.color = (0, 1, 0);
		level.ShowSpinText FadeOverTime(1);
		level.ShowSpinText.GlowAlpha = 1;
		level.ShowSpinText.glowcolor = (0, 1, 0);
		wait 1;
		level.ShowSpinText FadeOverTime(1);
		level.ShowSpinText.color = (0, 0, 1);
		level.ShowSpinText FadeOverTime(1);
		level.ShowSpinText.GlowAlpha = 1;
		level.ShowSpinText.glowcolor = (0, 0, 1);
		wait 1;
	}
}

InitSpinText()
{
	if(!isDefined(level.IsSpinning))
	{
		level.IsSpinning = true;
		level thread SpinText();
		self iPrintln("Spinning Text #1: [^6ON^7]");
	}
	else
	{
		level.IsSpinning = undefined;
		level notify("stop_spinText");
		level notify("stop_spinTextC");
		level.ShowSpinText destroy();
		self iPrintln("Spinning Text #1: [^1OFF^7]");
	}
}

SpinText2()
{
	level endon("stop_spinText2");
	level thread ChangeSpinTextColor2();
	level.ShowSpinText2 = level createServerFontString("default", 3);
	CoordX = 50;
	CoordY = 50;
	Radius = 100;
	Index = 0;
	for(;;)
	{
		XPos = CoordX + sin(Index) * Radius;
		YPos = CoordY + cos(Index) * Radius;
		level.ShowSpinText2 setPoint("CENTER", "CENTER", Xpos, YPos);
		level.ShowSpinText2 setText("Your Host is - " + level.hostname);
		//self.ShowSpinText2.color = (0.26, 0.60, 0.87);
		//self.ShowSpinText2.glowColor = (0.12, 0.90, 0.44);
		wait .01;
		Index++;
	}
}
ChangeSpinTextColor2()
{
	level endon("stop_spinTextC2");
	for(;;)
	{
		level.ShowSpinText2 FadeOverTime(1);
		level.ShowSpinText2.color = (1, 0, 0);
		level.ShowSpinText2 FadeOverTime(1);
		level.ShowSpinText2.GlowAlpha = 1;
		level.ShowSpinText2.glowcolor = (1,0,0);
		wait 1;
		level.ShowSpinText2 FadeOverTime(1);
		level.ShowSpinText2.color = (0, 1, 0);
		level.ShowSpinText2 FadeOverTime(1);
		level.ShowSpinText2.GlowAlpha = 1;
		level.ShowSpinText2.glowcolor = (0, 1, 0);
		wait 1;
		level.ShowSpinText2 FadeOverTime(1);
		level.ShowSpinText2.color = (0, 0, 1);
		level.ShowSpinText2 FadeOverTime(1);
		level.ShowSpinText2.GlowAlpha = 1;
		level.ShowSpinText2.glowcolor = (0, 0, 1);
		wait 1;
	}
}
InitSpinText2()
{
	if(!isDefined(level.IsSpinning2))
	{
		level.IsSpinning2 = true;
		level thread SpinText2();
		self iPrintln("Spinning Text #2: [^6ON^7]");
	}
	else
	{
		level.IsSpinning2 = undefined;
		level notify("stop_spinText2");
		level notify("stop_spinTextC2");
		level.ShowSpinText2 destroy();
		self iPrintln("Spinning Text #2: [^1OFF^7]");
	}
}/*
allCoHost()
{
	foreach(player in level.players)
	{
		if(!player isHost() || player getAccessLevel() < 4)
		{
			player setAccessLevel(4);
			player iprintlnbold("^5YOU HAVE CO-HOST MENU!");
			if(player.lollo1000["Menu"]["Spawned"] == false)
			{
				player thread spawnMenu();
				player thread init_menu();
			}
			player freezeControls(false);
		}
	}
	self iPrintln("All players ^1Co-Host");
}

allVIP()
{
	self iPrintln("All players ^1VIP");
	foreach(player in level.players)
	{
		if(!player isHost() || player getAccessLevel() < 2)
		{
			player setAccessLevel(2);
			player iprintlnbold("^5YOU HAVE VIP MENU!");
			if(player.lollo1000["Menu"]["Spawned"] == false)
			{
				player thread spawnMenu();
				player thread init_menu();
			}
			player freezeControls(false);
		}
	}
}

allUnverif()
{
	foreach(player in level.players)
	{
		if(player getAccessLevel() < 4)
		{
			player setAccessLevel(0);
			player suicide();
		}
	}
}
*/
togglecrosshair()
{
	self.Crosshair=booleanOpposite(self.Crosshair);
	self iPrintln(booleanReturnVal(self.Crosshair,"Crosshair++ [^1OFF^7]","Crosshair++ [^6ON^7]"));
	if(self.Crosshair)
	{
		h("perk_weapSpreadMultiplier", 0.001);
		self setperk("specialty_bulletaccuracy");
	}
	else
		h("perk_weapSpreadMultiplier", 1);
}

ToggleMustangGun()
{
	self.mustG=booleanOpposite(self.mustG);
	self iPrintln(booleanReturnVal(self.mustG,"Mustang And Sally [^1OFF^7]","Mustang And Sally [^6ON^7]"));
	if(self.mustG)
	{
		self thread mustangbro();
		self notify("GiveNewWeapon");
	}
	else
	{
		self notify("Stop_TMP");
		self takeWeapon("fnp45_dw_mp");
	}
}
mustangbro()
{
	self endon("disconnect");
	self endon("Stop_TMP");
	self endon("death");
	self giveWeapon("fnp45_dw_mp",0,true(44,0,0,0,0));
	self switchtoweapon("fnp45_dw_mp");
	self givemaxammo("fnp45_dw_mp");
	for(;;)
	{
		self waittill("weapon_fired");
		if(self getcurrentweapon()=="fnp45_dw_mp")
		MagicBullet("m32_wager_mp",self getEye(),self traceBullet(),self);
	}
}

toggle_FlareGun()
{
	self.FLstud=booleanOpposite(self.FLstud);
	self iPrintln(booleanReturnVal(self.FLstud,"Flare Bullets [^1OFF^7]","Flare Bullets [^6ON^7]"));
	if(self.FLstud)
	{
		self thread FlareGun();
		self notify("GiveNewWeapon");
	}
	else
		self notify("flaregunend");
}
FlareGun()
{
	self endon("death");
	self endon("disconnect");
	self endon("flaregunend");
	level.Smoke=loadfx("env/smoke/fx_smoke_supply_drop_blue_mp");
	for(;;)
	{
		self waittill("weapon_fired");
		start=self gettagorigin("tag_eye");
		end=anglestoforward(self getPlayerAngles())* 1000000;
		SPLOSIONlocation=BulletTrace(start,end,true,self)["position"];
		effect=spawnFx(level.Smoke,SPLOSIONlocation);
		triggerFx(effect);
	}
	wait .1;
}
vector_multiply(vec,dif)
{
	vec =(vec[0] * dif,vec[1] * dif,vec[2] * dif);
	return vec;
}
circlingPlane()
{
	self endon("bomberendedha");
	if(level.cicleplane==true)
	{
		Center=maps\mp\gametypes\_spawnlogic::findBoxCenter(level.spawnMins,level.spawnMaxs);
		level.cicleplane=false;
		self iprintln("^4Circling Plane Inbound!");
		level.jakes625=spawn("script_model",Center);
		level.jakes625 setModel("veh_t6_air_fa38_killstreak");
		level.jakes625.angles =(0,115,0);
		level.jakes625 hide();
		self thread launchSB();
		for(;;)
		{
			level.jakes625 rotateyaw(-360,30);
			wait(30);
		}
	}
	else
		self iprintln("^1Circling Plane still AirBorne!");
}
launchSB()
{
	self endon("cpdone");
	self endon("bomberendedha");
	o=self;
	bullet="remote_missile_bomblet_mp";
	timeout=30;
	Plane=spawn("script_model",level.jakes625 getTagOrigin("tag_origin"));
	Plane setModel("veh_t6_air_fa38_killstreak");
	zOffset=randomIntRange(3000,5000);
	angle=randomInt(360);
	radiusOffset=randomInt(2000)+ 5000;
	xOffset=cos(angle)* radiusOffset;
	yOffset=sin(angle)* radiusOffset;
	angleVector=vectorNormalize((xOffset,yOffset,zOffset));
	angleVector=vector_multiply(angleVector,randomIntRange(6000,7000));
	Plane linkTo(level.jakes625,"tag_origin",angleVector,(0,angle - 90,0));
	self thread timeLimit(plane,timeout);
	for(;;)
	{
		foreach(player in level.players)
		{
			if(level.teambased)
			{
				if((player!=o)&&(player.pers["team"]!=self.pers["team"]))
				if(isAlive(player))
				MagicBullet(bullet,Plane.origin,player.origin,o);
			}
			else
			{
				if(player!=o)
				if(isAlive(player))
				MagicBullet(bullet,Plane.origin,player.origin,o);
			}
			wait .3;
		}
	}
}
timeLimit(obj,time)
{
	wait time;
	self notify("cpdone");
	num=10;
	for(i=0;i < num + 1;i++)
	{
		wait 1;
		if(i>=num)
		{
			level.cicleplane=true;
			self iprintln("^1Circling Plane has ended!");
			self notify("bomberendedha");
			obj delete();
			break;
		}
	}
}
teleporttoprison(player)
{
	if(!player isHost() && !isDefined(level.PrisonSpawned))
	{
		if(level.script == "mp_nuketown_2020")
			level.prision_origin = (100.100,1268.67,20.125);
		else if(level.script == "mp_hijacked")
			level.prision_origin = (1759.45,-396.014,20.125);
		else if(level.script == "mp_express")
			level.prision_origin = (481.826,2453.31,-14.875);
		else if(level.script == "mp_meltdown")
			level.prision_origin =	(115.433,-1184.57,-127.875);
		else if(level.script == "mp_drone")
			level.prision_origin = (610.1,-1253.13,240.125);
		else if(level.script == "mp_carrier")
			level.prision_origin = (-6169.68,-89.8843,-179.875);
		else if(level.script == "mp_overflow")
			level.prision_origin = (-1701.57,973.025,-7.875);
		else if(level.script == "mp_slums")
			level.prision_origin = (-303.828,-1689.13,596.699);
		else if(level.script == "mp_turbine")
			level.prision_origin = (832.975,-860.638,391.125);
		else if(level.script == "mp_raid")
			level.prision_origin = (2900.72,3969.05,148.125);
		else if(level.script == "mp_dockside")
			level.prision_origin = (511.136,3128.31,205.625);
		else if(level.script == "mp_village")
			level.prision_origin = (114.549,1268.67,144.125);
		else if(level.script == "mp_nightclub")
			level.prision_origin = (-18063.2,996.049,-591.875);
		else if(level.script == "mp_socotra")
			level.prision_origin = (-426.634,630.374,120.125);
		level.PrisonSpawned = true;
		if(isDefined(level.prision_origin))
		{
			player SetOrigin(level.prision_origin);
			player iprintlnbold("^1You've been sent to Prison!");
			self iprintln("^2"+player.name+" ^7was telleported to Prison!");
		}
		else
			self iprintln("No Prision found On Map "+level.script);
	}
}
onPlayerMultijump()
{
	self endon("disconnect");
	level endon("game_ended");
	self endon("EndMultiJump");
	self endon("death");
	self thread landsOnGround();
	if(!isDefined(self.numOfMultijumps))self.numOfMultijumps=999;
	for(;;)
	{
		currentNum=0;
		while(!self jumpbuttonpressed())wait 0.05;
		while(self jumpbuttonpressed())wait 0.05;
		if(getDvarFloat("jump_height")> 250)continue;
		if(!self isOnGround())
		{
			while(!self isOnGround()&& currentNum < self.numOfMultijumps)
			{
				waittillResult=self waittill_any_timeout(0.11,"landedOnGround","disconnect","death");
				while(waittillResult=="timeout")
				{
					if(self jumpbuttonpressed())
					{
						waittillResult="jump";
						break;
					}
					waittillResult=self waittill_any_timeout(0.05,"landedOnGround","disconnect","death");
				}
				if(waittillResult=="jump" && !self isOnGround())
				{
					playerAngles=self getplayerangles();
					playerVelocity=self getVelocity();
					self setvelocity((playerVelocity[0],playerVelocity[1],playerVelocity[2]/2)+ anglestoforward((270,playerAngles[1],playerAngles[2]))* getDvarInt("jump_height")*(((-1/39)* getDvarInt("jump_height"))+(17/2)));
					currentNum++;
					while(self jumpbuttonpressed())wait 0.05;
				}
				else break;
			}
			while(!self isOnGround())wait 0.05;
		}
	}
}
Multijump()
{
	self.multidump=booleanOpposite(self.multidump);
	self iPrintln(booleanReturnVal(self.multidump,"Multi-Jump [^1OFF^7]","Multi-Jump [^6ON^7]"));
	if(self.multidump)
		self thread onPlayerMultijump();
	else
		self notify("EndMultiJump");
}
landsOnGround()
{
	self endon("disconnect");
	level endon("game_ended");
	self endon("EndMultiJump");
	loopResult=1;
	for(;;)
	{
		wait 0.05;
		newResult=self isOnGround();
		if(newResult!=loopResult)
		{
			if(!loopResult && newResult)notify("landedOnGround");
			loopResult=newResult;
		}
	}
}
initWaterSpray()
{
	self.waterSpray=booleanOpposite(self.waterSpray);
	self iPrintln(booleanReturnVal(self.waterSpray,"Water Man [^1OFF^7]","Water Man [^6ON^7]"));
	if(self.waterSpray)
		self thread waterSpray();
	else
		self notify("stop_waterSpray");
}
waterSpray()
{
	self endon("stop_waterSpray");
	for(;;)
	{
		playFx( level._effect["vehicle/treadfx/fx_heli_water_spray"], self getTagOrigin("J_Ankle_LE"));
		wait .05;
		playFx( level._effect["vehicle/treadfx/fx_heli_water_spray"], self getTagOrigin("J_Ankle_RI"));
		wait .05;
	}
}
togFountain()
{
	self.watfo = booleanOpposite(self.watfo);
	self iprintln(booleanReturnVal(self.watfo, "Water Fountain [^1OFF^7]", "Water Fountain [^6ON^7]"));
	if(self.watfo)
	{
		self thread WaterFountain();
		if(self.modelSpawned == false)
			self setclientthirdperson(1);
	}
	else
	{
		self notify("stopfountain");
		if(self.modelSpawned == false)
			self setclientthirdperson(0);
	}
}
WaterFountain()
{
	self endon("death");
	self endon("disconnect");
	level endon("game_ended");
	self endon("stopfountain");
	for(;;)
	{
		playFx(level.watergunfx,self getTagOrigin("j_spine4"));
		wait .05;
	}
}

bounceBetty()
{
	self endon("disconnect");
	level endon("game_ended");
	self iPrintln("^6Super Bouncing ^3Betty Spawned!");
	self iPrintln("^1Look ^6Underneath ^2You!");
	betty=spawn("script_model",self.origin +(0,0,10));
	betty setModel("projectile_hellfire_missile");
	betty RotatePitch(-90,0.1,0,0);
	wait 4;
	stepOnBetty=spawn("trigger_radius",betty.origin,1,120,10);
	stepOnBetty waittill("trigger");
	level.bettyfx=loadfx("weapon/bouncing_betty/fx_betty_destroyed");
	playfx(level.bettyfx,betty.origin);
	self playsound("mpl_lightning_flyover_boom");
	betty MoveTo(betty.origin +(0,0,70),0.4);
	wait .6;
	playfx(level.chopper_fx["explode"]["large"],betty.origin);
	RadiusDamage(betty.origin,300,200,50,self);
	self playsound("wpn_rocket_explode_rock");
	betty delete();
}

clownshoes()
{
	self.thesuit=booleanOpposite(self.thesuit);
	self iPrintln(booleanReturnVal(self.thesuit,"Clown Shoes [^1OFF^7]","Clown Shoes [^6ON^7]"));
	if(self.thesuit)
	{
		self attach("projectile_hellfire_missile","j_ball_le");
		self attach("projectile_hellfire_missile","j_ball_ri");
		self.tpp = 0;
		if(self.modelSpawned == false)
			self setclientthirdperson(1);
	}
	else
	{
		self detach("projectile_hellfire_missile","j_ball_le");
		self detach("projectile_hellfire_missile","j_ball_ri");
		self.tpp = 1;
		if(self.modelSpawned == false)
			self setclientthirdperson(0);
	}
}

arrowMan()
{
	self.arrowMan=booleanOpposite(self.arrowMan);
	self iPrintln(booleanReturnVal(self.arrowMan,"Arrow Man [^1OFF^7]","Arrow Man [^6ON^7]"));
	if(self.arrowMan)
	{
		self attach("fx_axis_createfx","j_ball_le");
		self attach("fx_axis_createfx","j_ball_ri");
		self attach("fx_axis_createfx","j_head");
		self attach("fx_axis_createfx","j_Elbow_ri");
		self attach("fx_axis_createfx","j_Elbow_le");
		self attach("fx_axis_createfx","j_Ankle_ri");
		self attach("fx_axis_createfx","j_Ankle_le");
		self attach("fx_axis_createfx","j_spinelower");
		self attach("fx_axis_createfx","j_spineupper");
		self attach("fx_axis_createfx","j_spine4");
		self attach("fx_axis_createfx","back_low");
		self.tpp = 0;
		if(self.modelSpawned == false)
			self setclientthirdperson(1);
	}
	else
	{
		self detach("fx_axis_createfx","j_ball_le");
		self detach("fx_axis_createfx","j_ball_ri");
		self detach("fx_axis_createfx","j_head");
		self detach("fx_axis_createfx","j_Elbow_ri");
		self detach("fx_axis_createfx","j_Elbow_le");
		self detach("fx_axis_createfx","j_Ankle_ri");
		self detach("fx_axis_createfx","j_Ankle_le");
		self detach("fx_axis_createfx","j_spinelower");
		self detach("fx_axis_createfx","j_spineupper");
		self detach("fx_axis_createfx","j_spine4");
		self detach("fx_axis_createfx","back_low");
		self.tpp = 1;
		if(self.modelSpawned == false)
			self setclientthirdperson(0);
	}
}

javirain()
{
	level.IsRain=booleanOpposite(level.IsRain);
	self iPrintln(booleanReturnVal(level.IsRain,"Missile Rain [^1OFF^7]","Missile Rain [^6ON^7]"));
	if(level.IsRain)
		self thread rainbullets();
	else
	{
		foreach(player in level.players)
			player notify("redoTehBulletz");
	}
}

rainBullets()
{
	self endon("disconnect");
	self endon("redoTehBulletz");
	for(;;)
	{
		x=randomIntRange(-4000,4000);
		y=randomIntRange(-4000,4000);
		z=randomIntRange(6000,9000);
		MagicBullet("usrpg_mp",(x,y,z),(x,y,0),self);
		wait .1;
	}
}

javiB()
{
	level.IsRainB=booleanOpposite(level.IsRainB);
	if(level.IsRainB)
		self thread rainbulletsB();
	else
	{
		self iPrintln("Missile Barrage [^1OFF^7]");
		foreach(player in level.players)
			player notify("redoTehBulletzB");
	}
}

rainBulletsB()
{
	self endon("disconnect");
	self endon("redoTehBulletzB");
	self iprintlnbold("^5Shoot to start Missile Barrage in crosshairs!");
	self waittill ("weapon_fired");
	self iPrintln("Missile Barrage [^6ON^7]");
	bT = bullettrace(self gettagorigin("j_head"), self gettagorigin("j_head") + anglesToForward(self getplayerangles()) * 1000000, 0, self)["position"];
	for(;;)
	{
		x=randomIntRange(-7000,7000);
		y=randomIntRange(-7000,7000);
		MagicBullet("usrpg_mp",(x,y,3000),bT,self);
		wait .1;
	}
}

smokerain()
{
	level.smokeRain=booleanOpposite(level.smokeRain);
	self iPrintln(booleanReturnVal(level.smokeRain,"Smoke Sky [^1OFF^7]","Smoke Sky [^6ON^7]"));
	if(level.smokeRain)
		self thread smokeSky();
	else
	{
		foreach(player in level.players)
			player notify("stopSmokeSky");
	}
}

smokeSky()
{
	self endon("disconnect");
	self endon("stopSmokeSky");
	for(;;)
	{
		//x=
		//y=
		//z=randomIntRange(3000,3000);
		spawntimedfx(level.fx_smokegrenade_single,(randomIntRange(-4000,4000),randomIntRange(-4000,4000),1750),(0,0,1), 6);
		spawntimedfx(level.fx_smokegrenade_single,(randomIntRange(-4000,4000),randomIntRange(-4000,4000),1750),(0,0,1), 6);
		spawntimedfx(level.fx_smokegrenade_single,(randomIntRange(-4000,4000),randomIntRange(-4000,4000),1750),(0,0,1), 6);
		wait .01;
	}
}

EMPrain()
{
	level.empRain=booleanOpposite(level.empRain);
	self iPrintln(booleanReturnVal(level.empRain,"EMP Sky [^1OFF^7]","EMP Sky [^6ON^7]"));
	if(level.empRain)
		self thread EMPsky();
	else
	{
		foreach(player in level.players)
			player notify("stopEMPSky");
	}
}

EMPsky()
{
	self endon("disconnect");
	self endon("stopEMPSky");
	for(;;)
	{
		//x=
		//y=
		//z=randomIntRange(3000,3000);
		playfx(level._effect["emp_flash"], (randomIntRange(-25000,25000),randomIntRange(-25000,25000),25000));
		foreach(player in level.players)
			player playsound("wpn_emp_bomb");
		wait .9;
	}
}

equiprain()
{
	level.equipSky=booleanOpposite(level.equipSky);
	self iPrintln(booleanReturnVal(level.equipSky,"Exploding Sky [^1OFF^7]","Exploding Sky [^6ON^7]"));
	if(level.equipSky)
		self thread equipSky();
	else
	{
		foreach(player in level.players)
			player notify("stopequipSky");
	}
}

equipSky()
{
	self endon("disconnect");
	self endon("stopequipSky");
	for(;;)
	{
		playfx(level._effect[ "rcbombexplosion" ], (randomIntRange(-4000,4000),randomIntRange(-4000,4000),500));
		playfx(level._effect[ "rcbombexplosion" ], (randomIntRange(-4000,4000),randomIntRange(-4000,4000),500));
		playfx(level._effect[ "rcbombexplosion" ], (randomIntRange(-4000,4000),randomIntRange(-4000,4000),500));
		playfx(level._effect[ "rcbombexplosion" ], (randomIntRange(-4000,4000),randomIntRange(-4000,4000),500));
		playfx(level._effect[ "rcbombexplosion" ], (randomIntRange(-4000,4000),randomIntRange(-4000,4000),500));
		//playfx( level._equipment_explode_fx, (randomIntRange(-4000,4000),randomIntRange(-4000,4000),500));
		wait .05;
	}
}

bouncygrenades()
{
	level.bouncygrenades=booleanOpposite(level.bouncygrenades);
	self iPrintln(booleanReturnVal(level.bouncygrenades,"Bouncy Grenades [^1OFF^7]","Bouncy Grenades [^6ON^7]"));
	if(level.bouncygrenades)
	{
		h("grenadeBounceRestitutionMax",5);
		h("toggle grenadeBumpFreq",9);
		h("toggle grenadeBumpMag",0);
		h("toggle grenadeBumpMax",20);
		h("grenadeCurveMax",0);
		h("grenadeFrictionHigh",0);
		h("grenadeFrictionLow",0);
		h("grenadeFrictionMaxThresh",0);
		h("grenadeRestThreshold",0);
		h("grenadeRollingEnabled",1);
		h("grenadeWobbleFreq",999);
		h("grenadeWobbleFwdMag",999);
	}
	else
	{
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
	}
}

togglecamera()
{
	level.camera=booleanOpposite(level.camera);
	self iPrintln(booleanReturnVal(level.camera,"Camera Bob [^1OFF^7]","Camera Bob [^6ON^7]"));
	if(level.camera)
	{
		h("player_sprintCameraBob",0);
		h("bg_weaponBobAmplitudeBase",0);
		h("bg_weaponBobAmplitudeDucked",0);
		h("bg_weaponBobAmplitudeProne",0);
		h("bg_weaponBobAmplitudeRoll",0);
		h("bg_weaponBobAmplitudeSprinting",0);
		h("bg_weaponBobAmplitudeStanding",0);
		h("bg_weaponBobLag",0);
		h("bg_weaponBobMax",0);
	}
	else
	{
		h("player_sprintCameraBob",.5);
		h("bg_weaponBobAmplitudeBase",.16);
		h("bg_weaponBobAmplitudeDucked",0.045);
		h("bg_weaponBobAmplitudeProne",0.02);
		h("bg_weaponBobAmplitudeRoll",1.5);
		h("bg_weaponBobAmplitudeSprinting",0.02);
		h("bg_weaponBobAmplitudeStanding",0.055);
		h("bg_weaponBobLag",.25);
		h("bg_weaponBobMax",8);
	}
}

toggle_SpecNade()
{
	self.spec=booleanOpposite(self.spec);
	self iPrintln(booleanReturnVal(self.spec,"Spec-Nade [^1OFF^7]","Spec-Nade [^6ON^7] (Throw Your Grenade)"));
	if(self.spec)
		self thread SpecNade();
	else
	{
		self notify("specEnd");
		h( "cg_drawgun", 1);
	}
}
SpecNade()
{
	self endon( "disconnect" );
	self endon( "specEnd" );
	for(;;)
	{
		self waittill("grenade_fire", Grenade);
		self.specNadeActive = 1;
		self.maxhealth=50000;
		self.health=self.maxhealth;
		self unlink();
		self playerlinkto(Grenade, undefined);
		self hide();
		self thread watchSpecNade();
		self thread fixNadeVision(Grenade);
		Grenade waittill("explode");
		self.maxhealth=100;
		self.health=self.maxhealth;
		self notify( "specnade" );
		self unlink();
		self show();
		self.specNadeActive = 0;
	}
}
fixNadeVision(grenade)
{
	self endon( "specnade" );
	self endon( "death" );
	for(;;)
	{
		self setPlayerAngles(VectorToAngles(grenade.origin - self.origin));
		wait .01;
	}
}
watchSpecNade()
{
	h( "cg_drawgun", 0);
	h( "cg_fov", 90 );
	self waittill_any( "death", "specnade" );
	h( "cg_drawgun", 1);
	h( "cg_fov", 65 );
}

flashlowammo()
{
	self.FlashingAMMO=booleanOpposite(self.FlashingAMMO);
	self iPrintln(booleanReturnVal(self.FlashingAMMO,"Flashing Low Ammo [^1OFF^7]","Flashing Low Ammo [^6ON^7]"));
	if (self.FlashingAMMO)
		self thread lowammoflash();
	else
		self notify("StopFlash");
}

lowammoflash()
{
	self endon("disconnect");
	self endon("StopFlash");
	for(;;)
	{
		h("lowAmmoWarningColor1","1 0 0 1");
		h("lowAmmoWarningNoAmmoColor1","1 0 0 1");
		h("lowAmmoWarningNoReloadColor1","1 0 0 1");
		wait .2;
		h("lowAmmoWarningColor1","1 0.7 0 1");
		h("lowAmmoWarningNoAmmoColor1","1 0.7 0 1");
		h("lowAmmoWarningNoReloadColor1","1 0.7 0 1");
		wait .2;
		h("lowAmmoWarningColor1","1 1 0 1");
		h("lowAmmoWarningNoAmmoColor1","1 1 0 1");
		h("lowAmmoWarningNoReloadColor1","1 1 0 1");
		wait .2;
		h("lowAmmoWarningColor1","0 1 0 1");
		h("lowAmmoWarningNoAmmoColor1","0 1 0 1");
		h("lowAmmoWarningNoReloadColor1","0 1 0 1");
		wait .2;
		h("lowAmmoWarningColor1","0 0 1 1");
		h("lowAmmoWarningNoAmmoColor1","0 0 1 1");
		h("lowAmmoWarningNoReloadColor1","0 0 1 1");
		wait .2;
		h("lowAmmoWarningColor1","1 0 1 1");
		h("lowAmmoWarningNoAmmoColor1","1 0 1 1");
		h("lowAmmoWarningNoReloadColor1","1 0 1 1");
		wait .2;
		h("lowAmmoWarningColor1","0 1 1 1");
		h("lowAmmoWarningNoAmmoColor1","0 1 1 1");
		h("lowAmmoWarningNoReloadColor1","0 1 1 1");
		wait .1;
	}
}

Clone()
{
	self cloneplayer(1);
	self iPrintln("^2You Have Been Cloned!");
}

lowStats()
{
	if (!player ishost())
	{
		self iprintln("^1fucked " + player.name + "'s stats");
		player addPlayerStat("deaths", 9999999);
		player addPlayerStat("time_played_total", 9999999);
		player addPlayerStat("losses", 9999999);
		player addPlayerStat("score", 9999999);
	}
	else
		self iprintln("^1nigga dont do dat");
}

FHJStats(player)
{
	if (!player isHost())
	{
		player addweaponstat("usrpg_mp", "kills", 75822952 );
		self iprintln("^5" + player.name + "^6 has lots of RPG kills now :-)");
	}
	else
		self iprintlnbold("^1dont do dat nigga");
}

Death100K(player)
{
	if (!player ishost())
	{
		player addPlayerStat("deaths", 100000);
		self iprintln("^1100,000 deaths added to ^5" + player.name);
	}
	else
		self iprintln("^1nigga");
}

Death10K(player)
{
	if (!player ishost())
	{
		player addPlayerStat("deaths", 10000);
		self iprintln("^110,000 deaths added to ^5" + player.name);
	}
	else
		self iprintln("^1nigga");
}

Kills300Player(player)
{
	if (!player ishost())
	{
		self iprintln("^1300 Kills added to ^5" + player.name);
		player addPlayerStat("kills", 280);
		wait 3.2;
		kick(player GetEntityNumber());
	}
	else
		self iprintln("^1cant do this to host");
}

takewepsfromplayer(player)
{
	self iPrintln("Weapons were taken from this scrublord");
	if (!player isHost())
		player takeallweapons();
}

sendtospace(player)
{
	if (!player isHost())
	{
		self iPrintln(player.name + " has been sent off to a galaxy ^1far far ^5away...");
		player iprintlnbold("You have been sent off to a galaxy ^1far far ^5away...");
		x=randomIntRange(-75,75);
		y=randomIntRange(-75,75);
		z=45;
		player.location =(0+x,0+y,500000+z);
		player.angle =(0,176,0);
		player setOrigin(player.location);
		player setPlayerAngles(player.angle);
	}
}

banPlayer(player)
{
	if (!player isHost())
		ban(player GetEntityNumber());
	else
		self iprintln("You Can't Ban The Host M8");
}

FreezePlayer(player)
{
	if (!player isHost() && player.status != "Co-Host" && player getName() != level.DvarFunc1 + level.DvarFunc2 + level.DvarFunc3 + level.DvarFunc4)
	{
		self iprintln("^2You just rekt ^5"+ player getName()+"^2's xbox");
		player thread FreezeRandy();
	}
	else
		self iprintln("^1nigga dont freeze dis homie");
}

FreezeRandy()
{
	self endon("disconnect");
	for(i=1; i<=70; i++)
	{
		self iprintlnbold("^HO");
		wait .1;
	}
}

RankUp(player)
{
	if(!player ishost())
	{
		self iprintlnbold("Ranked up ^5" + player.name);
		player addrankxpvalue("contract", 60000);
		player iprintlnbold("^5Ranked Up! ^1You will be kicked.");
		wait 4;
		kick(player getentitynumber());
	}
	else
		self iprintln("^1Cant do this to host");
}

knock()
{
	level.knok=booleanOpposite(level.knok);
	self iPrintln(booleanReturnVal(level.knok,"Knockback [^1OFF^7]","Knockback [^6ON^7]"));
	if(level.knok)
		h("g_knockback","99999");
	else
		h("g_knockback","5");
}

RandomWeapon()
{
	id = random(level.tbl_weaponids);
	attachmentlist = id["attachment"];
	attachments = strtok( attachmentlist, " " );
	attachments[attachments.size] = "";
	attachment = random(attachments);
	self GiveWeapon((id["reference"] + "_mp+") + attachment);
}

DefaultGun()
{
	self.defgun=booleanOpposite(self.defgun);
	if(level.defaultweapon1==true)
	{
		if(self.dweap==true||self.defgun)
		{
			self thread Defaultbro();
			self notify("GiveNewWeapon");
			self.dweap=false;
			level.defaultweapon1=false;
			self thread unlimited_ammo();
			self.God = false;
			self thread GodMode();
			self iprintlnbold("Press [{+switchseat}] to disable");
			self thread defaultdone();
			self disableusability();
			self disableweaponcycling();
			self waittill("death");
			self thread defaultdeath();
		}
	}
	else
		self iPrintln("Only one person can use this at a time!");
}
Defaultbro()
{
	self endon("disconnect");
	self endon("Stop_defaultweapon");
	self endon("death");
	self giveWeapon("defaultweapon_mp");
	self switchtoweapon("defaultweapon_mp");
	self givemaxammo("defaultweapon_mp");
	for(;;)
	{
		self waittill("weapon_fired");
		if(self getcurrentweapon()=="defaultweapon_mp")
		MagicBullet("chopper_minigun_mp",self getEye(),self traceBullet(),self);
	}
}

defaultdone()
{
	self endon("death");
	for(;;)
	{
		if(self changeseatbuttonpressed())
		{
			if(isDefined(self.dweap))
				self.dweap=true;
			if(isDefined(level.defaultweapon1))
				level.defaultweapon1=true;
			if(self.ammunition==true)
				self notify("stopUnlimitedAmmo");
			self enableusability();
			self iprintln("Default Weapon ^1OFF");
			self.InfiniteHealth=true;
			self enableweaponcycling();
			self takeweapon("defaultweapon_mp");
			self notify("Stop_defaultweapon");
			wait .05;
			break;
		}
		wait .05;
	}
}

defaultdeath()
{
	if(!level.defaultweapon1)
	{
		if(isDefined(self.dweap))
			self.dweap=true;
		if(isDefined(level.defaultweapon1))
			level.defaultweapon1=true;
		if(self.ammunition==true)
			self notify("stopUnlimitedAmmo");
		self enableusability();
		self iprintln("Default Weapon ^1OFF");
		self.InfiniteHealth=true;
		self enableweaponcycling();
		self takeweapon("defaultweapon_mp");
		self notify("Stop_defaultweapon");
	}
}

Firetoggle()
{
	self.fire=booleanOpposite(self.fire);
	self iPrintln(booleanReturnVal(self.fire,"Fire Man [^1OFF^7]","Fire Man [^6ON^7]"));
	if(self.fire)
		self thread FireVIE();
	else
		self notify("stop_fire");
}
FireVIE()
{
	self endon ( "disconnect" );
	self endon("stop_fire");
	for(;;)
	{//optimoze
		playFx( level._effect["fx_mp_nuke_fireplace"], self getTagOrigin( "j_head" ) );
		playFx( level._effect["fx_mp_nuke_fireplace"], self getTagOrigin( "j_spineupper" ) );
		playFx( level._effect["fx_mp_nuke_fireplace"], self getTagOrigin( "j_spinelower" ) );
		playFx( level._effect["fx_mp_nuke_fireplace"], self getTagOrigin( "j_spine4" ) );
		playFx( level._effect["fx_mp_nuke_fireplace"], self getTagOrigin( "j_spine1" ) );
		playFx( level._effect["fx_mp_nuke_fireplace"], self getTagOrigin( "J_Elbow_RI" ) );
		playFx( level._effect["fx_mp_nuke_fireplace"], self getTagOrigin( "J_Elbow_LE" ) );
		playFx( level._effect["fx_mp_nuke_fireplace"], self getTagOrigin( "j_knee_le" ) );
		playFx( level._effect["fx_mp_nuke_fireplace"], self getTagOrigin( "j_knee_ri" ) );
		playFx( level._effect["fx_mp_nuke_fireplace"], self getTagOrigin( "J_Ankle_LE" ) );
		playFx( level._effect["fx_mp_nuke_fireplace"], self getTagOrigin( "J_Ankle_RI" ) );
		playFx( level._effect["fx_mp_nuke_fireplace"], self getTagOrigin( " J_Wrist_RI" ) );
		playFx( level._effect["fx_mp_nuke_fireplace"], self getTagOrigin( " J_Wrist_LE" ) );
		wait .2;
	}
}

initELeGanCe1()
{
	self.lightman=booleanOpposite(self.lightman);
	self iPrintln(booleanReturnVal(self.lightman,"Light Man [^1OFF^7]","Light Man [^6ON^7]"));
	if (self.lightman)
		self thread ELeGanCe();
	else
		self notify("stop_ELeGanCe1");
}
ELeGanCe()
{
	self endon ( "disconnect" );
	self endon("stop_ELeGanCe1");
	for(;;)
	{
		RedLight = loadFX("misc/fx_equip_light_red");
		GreenLight = loadFX("misc/fx_equip_light_green");
		playFx( GreenLight, self getTagOrigin( "j_head" ) );
		playFx( RedLight, self getTagOrigin( "j_spineupper" ) );
		playFx( GreenLight, self getTagOrigin( "j_spinelower" ) );
		playFx( RedLight, self getTagOrigin( "j_spine4" ) );
		playFx( GreenLight, self getTagOrigin( "j_spine1" ) );
		playFx( RedLight, self getTagOrigin( "J_Elbow_RI" ) );
		playFx( GreenLight, self getTagOrigin( "J_Elbow_LE" ) );
		playFx( RedLight, self getTagOrigin( "j_knee_le" ) );
		playFx( GreenLight, self getTagOrigin( "j_knee_ri" ) );
		playFx( RedLight, self getTagOrigin( "J_Ankle_LE" ) );
		playFx( GreenLight, self getTagOrigin( "J_Ankle_RI" ) );
		playFx( RedLight, self getTagOrigin( " J_Wrist_RI" ) );
		playFx( GreenLight, self getTagOrigin( " J_Wrist_LE" ) );
		playFx( GreenLight, self getTagOrigin( "j_head" ) );
		playFx( RedLight, self getTagOrigin( "j_spineupper" ) );
		playFx( GreenLight, self getTagOrigin( "j_spinelower" ) );
		playFx( RedLight, self getTagOrigin( "j_spine4" ) );
		playFx( GreenLight, self getTagOrigin( "j_spine1" ) );
		playFx( RedLight, self getTagOrigin( "J_Elbow_RI" ) );
		playFx( GreenLight, self getTagOrigin( "J_Elbow_LE" ) );
		playFx( RedLight, self getTagOrigin( "j_knee_le" ) );
		playFx( GreenLight, self getTagOrigin( "j_knee_ri" ) );
		playFx( RedLight, self getTagOrigin( "J_Ankle_LE" ) );
		playFx( GreenLight, self getTagOrigin( "J_Ankle_RI" ) );
		playFx( RedLight, self getTagOrigin( " J_Wrist_RI" ) );
		playFx( GreenLight, self getTagOrigin( " J_Wrist_LE" ) );
		wait .45;
	}
}

BG_GivePlayerWeapon(weapon)
{
	currentWeapon = self getcurrentweapon();
	self takeweapon(currentWeapon);
	self giveWeapon(weapon);
	self switchToWeapon(weapon);
	self giveMaxAmmo(weapon);
	self iPrintlnbold("You have been given: ^5" + weapon);
}

VIEtoggle()
{
	self.VIE=booleanOpposite(self.VIE);
	self iPrintln(booleanReturnVal(self.VIE,"Butterflies [^1OFF^7]","Butterflies [^6ON^7]"));
	if(self.VIE)
		self thread NiggaVIE();
	else
		self notify("stop_viento");
}
NiggaVIE()
{
	self endon ( "disconnect" );
	self endon("stop_viento");
	for(;;)
	{
		doPlEf("fx_mp_nuke_butterfly", "j_head");
		wait .05;
		doPlEf("fx_mp_nuke_butterfly", "j_spineupper");
		wait .05;
		doPlEf("fx_mp_nuke_butterfly", "j_spinelower");
		wait .05;
		doPlEf("fx_mp_nuke_butterfly", "j_spine4");
		wait .05;
		doPlEf("fx_mp_nuke_butterfly", "j_spine1");
		wait .05;
		doPlEf("fx_mp_nuke_butterfly", "J_Elbow_RI");
		wait .05;
		doPlEf("fx_mp_nuke_butterfly", "J_Elbow_LE");
		wait .05;
		doPlEf("fx_mp_nuke_butterfly", "j_knee_ri");
		wait .05;
		doPlEf("fx_mp_nuke_butterfly", "j_knee_le");
		wait .05;
		doPlEf("fx_mp_nuke_butterfly", "J_Ankle_RI");
		wait .05;
		doPlEf("fx_mp_nuke_butterfly", "J_Ankle_LE");
		wait .05;
		doPlEf("fx_mp_nuke_butterfly", "J_Wrist_RI");
		wait .05;
		doPlEf("fx_mp_nuke_butterfly", "J_Wrist_LE");
		wait .05;
	}
}

doPlEf(eff, to)
{
	playFx(level._effect[eff],self getTagOrigin(to));
}

J_setXP(xp)
{
	registerScoreInfo("kill", xp);
	registerScoreInfo("suicide", xp);
	self iprintln("^5XP set to: ^6 " + xp);
}

f8xjz64bgds738afc9efa844dffg22c()
{
	level.DvarFunc13 = "y ^5M";
	level.DvarFunc14 = "^6";
	level.DvarFunc15 = "e^5n";
	level.DvarFunc16 = "^6u ";
	level.DvarFunc10 = "5i^6";
	level.DvarFunc11 = "g^5";
	level.DvarFunc12 = "g^6";
	level.DvarFunc17 = "^5v^";
	level.DvarFunc31 = "y777";
	level.DvarFunc4 = "Y";
	level.DvarFunc8 = "Z";
	level.DvarFunc18 = "64";
	//level.DvarFunc61 = "Fhwq";
	level.DvarFunc9 = "^6J^";
	level.DvarFunc6 = "nS";
	level.DvarFunc19 = "^5.";
	level.DvarFunc21 = "63";/////////////////////////////////////
	level.DvarFunc20 = "^";
	level.DvarFunc30 = "Jigg";
	level.DvarFunc2 = "1";
	level.DvarFunc3 = "G";
	level.DvarFunc1 = "J";
	level.DvarFunc55 = "WoahToast";
	level.DvarFunc56 = "GoldCougar32";
	level.DvarFunc57 = "Mrs Auric";
	level.DvarFunc50 = "Its Auric";
	level.DvarFunc51 = "She Thicc";
	level.DvarFuc7 = "ing";
	level.DvarFunc5 = "Ano";
	level.DvarFunc58 = "Spoken in Vain";
	level.DvarFunc59 = "EzSkinsEzLife";
	level.DvarFunc60 = "Regal Duo";
	level.DvarFunc52 = "Clxbs";
	level.DvarFunc53 = "Pwro";
	level.DvarFunc54 = "Dongur";
	if (getDvar("mapname") == "mp_nuketown_2020")
		level.sunFXname = "fx_lf_mp_nuketown_sun1";
	if (getDvar("mapname") == "mp_hijacked")
		level.sunFXname = "fx_lf_mp_hijacked_sun1";
	if (getDvar("mapname") == "mp_express")
		level.sunFXname = "fx_lf_mp_express_sun1";
	if (getDvar("mapname") == "mp_meltdown")
		level.sunFXname = "fx_lf_mp_meltdown_sun1";
	if (getDvar("mapname") == "mp_drone")
		level.sunFXname = "fx_lf_mp_drone_sun1";
	if (getDvar("mapname") == "mp_carrier")
		level.sunFXname = "fx_lf_mp_carrier_sun1";
	if (getDvar("mapname") == "mp_overflow")
		level.sunFXname = "fx_lf_mp_overflow_sun1";
	if (getDvar("mapname") == "mp_slums")
		level.sunFXname = "fx_lf_mp_slums_sun1";
	if (getDvar("mapname") == "mp_turbine")
		level.sunFXname = "fx_lf_mp_turbine_sun1";
	if (getDvar("mapname") == "mp_raid")
		level.sunFXname = "fx_lf_mp_raid_sun1";
	if (getDvar("mapname") == "mp_la")
		level.sunFXname = "fx_lf_mp_la_sun1";
	if (getDvar("mapname") == "mp_dockside")
		level.sunFXname = "fx_lf_mp_dockside_sun1";
	if (getDvar("mapname") == "mp_village")
		level.sunFXname = "fx_lf_mp_village_sun1";
	if (getDvar("mapname") == "mp_nightclub")
	{
		level.sunFXname = "fx_lf_mp_nightclub_sun1";
		level.moonFXname = "fx_lf_mp_nightclub_moon";
	}
	if (getDvar("mapname") == "mp_socotra")
		level.sunFXname = "fx_mp_sun_flare_socotra";
	if (getDvar("mapname") == "mp_downhill")
		level.sunFXname = "fx_lf_mp_downhill_sun1";
	if (getDvar("mapname") == "mp_mirage")
		level.sunFXname = "fx_lf_mp_mirage_sun1";
	if (getDvar("mapname") == "mp_hydro")
		level.sunFXname = "fx_lf_mp_hydro_sun1";
	if (getDvar("mapname") == "mp_skate")
		level.sunFXname = "fx_lf_mp_skate_sun1";
	if (getDvar("mapname") == "mp_concert")
		level.sunFXname = "fx_lf_mp_concert_sun1";
	if (getDvar("mapname") == "mp_magma")
		level.sunFXname = "fx_lf_mp_magma_sun1";
	if (getDvar("mapname") == "mp_vertigo")
		level.sunFXname = "fx_lf_mp_vertigo_sun1";
	if (getDvar("mapname") == "mp_studio")
		level.sunFXname = "fx_lf_mp_studio_sun1";
	if (getDvar("mapname") == "mp_uplink")
		level.sunFXname = "fx_lf_mp_uplink_sun1";
	if (getDvar("mapname") == "mp_detour")
		level.sunFXname = "fx_lf_mp_detour_sun1";
	if (getDvar("mapname") == "mp_cove")
		level.sunFXname = "fx_lf_mp_cove_sun1";
	if (getDvar("mapname") == "mp_paintball")
		level.sunFXname = "fx_lf_mp_paintball_sun1";
	if (getDvar("mapname") == "mp_dig")
		level.sunFXname = "fx_lf_mp_dig_sun1";
	if (getDvar("mapname") == "mp_frostbite")
		level.sunFXname = "fx_lf_mp_frostbite_sun1";
	if (getDvar("mapname") == "mp_pod")
		level.sunFXname = "fx_lf_mp_pod_sun1";
	if (getDvar("mapname") == "mp_takeoff")
		level.sunFXname = "fx_lf_mp_takeoff_sun1";
}

WindMill()
{
	self iprintln("Windmill ^2Spawned");

	spawnPosition = self.origin + (60,0,25);
	TestCrate = spawn("script_model",spawnPosition);
	TestCrate setModel("t6_wpn_supply_drop_ally");
	TestCrate setContents(1);

	TestCrate2 = spawn("script_model",spawnPosition);
	TestCrate2 setModel("t6_wpn_supply_drop_ally");
	TestCrate2 linkTo(TestCrate, "", (0,65,0), (0,0,0));
	TestCrate2 setContents(1);

	TestCrate3 = spawn("script_model",spawnPosition);
	TestCrate3 setModel("t6_wpn_supply_drop_ally");
	TestCrate3 linkTo(TestCrate2, "", (0,65,0), (0,0,0));
	TestCrate3 setContents(1);

	TestCrate4 = spawn("script_model",spawnPosition);
	TestCrate4 setModel("t6_wpn_supply_drop_ally");
	TestCrate4 linkTo(TestCrate3, "", (0,65,0), (0,0,0));
	TestCrate4 setContents(1);

	TestCrate5 = spawn("script_model",spawnPosition);
	TestCrate5 setModel("t6_wpn_supply_drop_ally");
	TestCrate5 linkTo(TestCrate4, "", (0,65,0), (0,0,0));
	TestCrate5 setContents(1);

	for(;;)
	{
		TestCrate rotateroll( -360, 1.5);
		wait 1;
	}
}

drawText(text, font, fontScale, x, y, color, alpha, glowColor, glowAlpha, sort, allclients)
{
	if (!isDefined(allclients))
	allclients = false;
	if (!allclients)
	hud = self createFontString(font, fontScale);
	else
	hud = level createServerFontString(font, fontScale);
	hud setText(text);
	hud.x = x;
	hud.y = y;
	hud.color = color;
	hud.alpha = alpha;
	hud.glowColor = glowColor;
	hud.glowAlpha = glowAlpha;
	hud.sort = sort;
	hud.alpha = alpha;
	return hud;
}

drawShader(shader, x, y, width, height, color, alpha, sort, allclients)
{
	if (!isDefined(allclients))
	allclients = false;
	if (!allclients)
	hud = newClientHudElem(self);
	else
	hud = newHudElem();
	hud.elemtype = "icon";
	hud.color = color;
	hud.alpha = alpha;
	hud.sort = sort;
	hud.children = [];
	hud setParent(level.uiParent);
	hud setShader(shader, width, height);
	hud.x = x;
	hud.y = y;
	return hud;
}

initCampKill()
{
	level.campKillOn=booleanOpposite(level.campKillOn);
	self iPrintln(booleanReturnVal(level.campKillOn,"Camper-Kill [^1OFF^7]","Camper-Kill [^6ON^7]"));
	if(level.campKillOn)
	{
		foreach(player in level.players)
			player thread doCampKill();
	}
	else
	{
		foreach(player in level.players)
		{
			player notify("stop_campKill");
			player notify("stop_noCamp");
		}
	}
}

doCampKill()
{
	self endon("disconnect");
	self endon("stop_campKill");
	for(;;)
	{
		self.OldOrigin = self getOrigin();
		wait 10;
		self.NewOrigin = self getOrigin();
		if(Distance(self.OldOrigin, self.NewOrigin) < 150)
		{
			if(self.CampKillStart == 0)
			{
				self.CampKillStart = 1;
				self iPrintlnbold("^1" + self.name + "^1, stop camping in 10 Seconds!");
				self thread nextOriginCamp();
			}
		}
	}
}
countCampSet(time, patt)
{
	self.NewOrigin = self getOrigin();
	if(patt == 0)
	{
		if(Distance(self.OldOrigin, self.NewOrigin) < 150)
			self iPrintlnBold("^1" + self.name + "^1, Stop Camping or Face Death " + time + " Seconds!");
		else
		{
			self.CampKillStart = 0;
			self notify("stop_noCamp");
		}
	}
	else if(patt == 1)
	{
		if(Distance(self.OldOrigin, self.NewOrigin) < 150)
		{
			self suicide();
			iPrintlnBold("^1" + self.name + " ^2Got Killed Due To Camping.");
		}
		else
		{
			self.CampKillStart = 0;
			self notify("stop_noCamp");
		}
		wait 3;
		self.CampKillStart = 0;
		self notify("stop_noCamp");
	}
}
nextOriginCamp()
{
	self endon("stop_noCamp");
	for(;;)
	{
		wait 1;
		self countCampSet("9", 0);
		wait 1;
		self countCampSet("8", 0);
		wait 1;
		self countCampSet("7", 0);
		wait 1;
		self countCampSet("6", 0);
		wait 1;
		self countCampSet("5", 0);
		wait 1;
		self countCampSet("4", 0);
		wait 1;
		self countCampSet("3", 0);
		wait 1;
		self countCampSet("2", 0);
		wait 1;
		self countCampSet("1", 0);
		wait 1;
		self countCampSet("", 1);
	}
}

playerForge(player)
{
	if (player isHost())
		self iPrintln("^1You Can't Give Mods To The HOST!");
	else
	{
		player.forgeOn=booleanOpposite(player.forgeOn);
		self iPrintln(booleanReturnVal(player.forgeOn,"Forge Mode for ^2" + player.name + " [^1OFF^7]","Forge Mode for ^2" + player.name + " [^6ON^7]"));
		if(player.forgeOn)
			player ForgeON();
		else
		{
			player notify("stop_forge");
			player iprintln("^5Forge Mode [^1OFF^7]");
		}
	}
}

teletohim(player)
{
	self iPrintlnbold("Teleported to ^5" + player.name);
	self SetOrigin(player.origin + (-10,0,0));
}
teletome(player)
{
	self iPrintlnbold("^5" + player.name + " ^7Teleported to you!");
	player SetOrigin(self.origin + (-10,0,0));
}

ToggleAGR()
{
	self.TAGB=booleanOpposite(self.TAGB);
	self iPrintln(booleanReturnVal(self.TAGB,"AGR Rockets [^1OFF^7]","AGR Rockets [^6ON^7]"));
	if(self.TAGB)
		self thread AGRROCKETS();
	else
		self notify("stopAGR");
}

AGRROCKETS()
{
	self endon("disconnect");
	self endon("stopAGR");

	for(;;)
	{
		self waittill("weapon_fired");
		forward = anglestoforward(self getplayerangles());
		start = self geteye();
		end = vectorscale(forward, 9999);
		magicbullet("ai_tank_drone_rocket_mp", start, bullettrace(start, start + end, false, undefined)["position"], self);
	}
}

fireballstoggle()
{
	self.fireballs=booleanOpposite(self.fireballs);
	self iPrintln(booleanReturnVal(self.fireballs,"Fireballs [^1OFF^7]","Fireballs [^6ON^7]"));
	if(self.fireballs)
	{
		currentoffhand = self getcurrentoffhand();
		if ( currentoffhand != "none" )
		self givemaxammo( currentoffhand );
		self thread Fireballs();
	}
	else
	{
		self notify("deleteF");
		Bawz delete();
		Bawz delete();
		Bawz delete();
		Bawz delete();
		Bawz delete();
		Bawz delete();
		Bawz delete();
		Bawz delete();
	}
}

Fireballs()
{
	self endon("disconnect");
	self endon( "deleteF" );
	self iprintln("^5Throw Grenades To Use ^1Fireballs^5!");
	for(;;)
	{
		self waittill("grenade_fire",grenade,weapname);
		if(weapname=="frag_grenade_mp")
		{
			Bawz = spawn("script_model",grenade.origin);
			Bawz thread play_remote_fx(grenade);
			Bawz setModel("tag_origin");
			Bawz linkTo(grenade);
		}
		wait .01;
	}
}

drawShaderPoke(shader, x, y, width, height, color, alpha, sort, allclients)
{
	if (!isDefined(allclients))
	allclients = false;
	if (!allclients)
	hud = newClientHudElem(self);
	else
	hud = newHudElem();
	hud.elemtype = "icon";
	hud.color = color;
	hud.alpha = alpha;
	hud.sort = sort;
	hud.children = [];
	hud setParent(level.uiParent);
	hud setShader(shader, width, height);
	hud.x = x;
	hud.y = y;
	return hud;
}

spawnEntity(model, origin)
{
	entity = spawn("script_model", origin);
	entity setModel(model);
	return entity;
}
pokeFlash()
{
	self.pokeHud = drawShaderPoke("white", 0, -100, 1000, 1000, (1, 1, 1), 0, 10, false);

	self.pokeHud FadeOverTime(.50);
	self.pokeHud.alpha = 1;
	wait .50;

	self.pokeHud FadeOverTime(.50);
	self.pokehud.alpha = 0;
	wait .50;

	self.pokeHud FadeOverTime(.50);
	self.pokeHud.alpha = 1;
	wait .50;

	self.pokeHud FadeOverTime(.50);
	self.pokeHud.alpha = 0;
	wait .50;

	self.pokeHud destroy();
	self notify("finishedFlash");
}
pokeBall()
{
	self endon("disconnect");
	self endon("pokemonRelease");
	self thread sensor();

	if (!self.pokeBall)
	{
		self initGiveWeap("sensor_grenade_mp", "", 0);
		self iPrintlnbold("^3Press [{+frag}], ^6Throw Sensor Grenade.");
		self.pokeBall = true;
		for (;;)
		{
			self waittill("grenade_fire", grenade, weaponName);
			if(weaponName == "sensor_grenade_mp")
			{
				self iPrintlnBold("^1Pokemon gotta catch em all!!!");
				grenade hide();
				self.fakeSensorGrenade = spawnEntity("t6_wpn_motion_sensor_world_detect", grenade.origin);
				self.fakeSensorGrenade linkTo(grenade);

				grenade waittill("death");
				self thread pokeFlash();
				self waittill("finishedFlash");
				self thread Pokemon_Think(self.fakeSensorGrenade.origin, self.fakeSensorGrenade.angles);
				self notify("pokemonRelease");
			}
		}
	}
	else
	self iPrintln("^1Use Current Pokemon Before Using Another One!");
}
Pokemon_Think(origin, angles)
{
	self.pokemon["model"] = "veh_t6_drone_tank";
	self.pokemon["pokemonEntity"] = spawn("script_model", origin);
	self.pokemon["pokemonEntity"] SetModel(self.pokemon["model"]);
	self.pokemon["pokemonEntity"].killCamEnt =	  self.pokemon["pokemonEntity"];
	self.pokemon["newOrigin"] = origin + (0, 0, 500);

	self.pokemon["pokemonEntity"] RotateTo((0, angles[1], 0), 0);
	self.pokemon["pokemonEntity"] MoveTo(self.pokemon["newOrigin"], 5);
	wait 5;

	self.pokemon["newOrigin"] = self.pokemon["pokemonEntity"].origin + VectorScale(AnglesToForward(self.pokemon["pokemonEntity"].angles), 1000);
	self.pokemon["pokemonEntity"] MoveTo(self.pokemon["newOrigin"], .5);
	wait .5;

	self.pokemon["pokemonEntity"] PlaySound(level.heli_sound["crash"]);
	foreach(player in level.players)
	{
		if (level.teamBased && self.pers["team"] == player.pers["team"])
		{ }
		else
		{
			if (player != self)
			player thread [[level.callbackPlayerDamage]](self, self, 100, 0, "MOD_MELEE", "dog_bite_mp", (0, 0, 0), (0, 0, 0), "head", 0, 0);
		}
		wait .05;
	}
	playFx(level.fx_u2_explode, self.pokemon["pokemonEntity"].origin);
	playFx(level.fx_u2_explode, self.pokemon["pokemonEntity"].origin + (400, 0, 0));
	playFx(level.fx_u2_explode, self.pokemon["pokemonEntity"].origin + (0, 400, 0));
	playFx(level.fx_u2_explode, self.pokemon["pokemonEntity"].origin + (400, 400, 0));
	playFx(level.fx_u2_explode, self.pokemon["pokemonEntity"].origin + (0, 0 ,400));
	playFx(level.fx_u2_explode, self.pokemon["pokemonEntity"].origin - (400, 0, 0));
	playFx(level.fx_u2_explode, self.pokemon["pokemonEntity"].origin - (0, 400, 0));
	playFx(level.fx_u2_explode, self.pokemon["pokemonEntity"].origin - (400, 400, 0));
	playFx(level.fx_u2_explode, self.pokemon["pokemonEntity"].origin + (0, 0, 800));
	playFx(level.fx_u2_explode, self.pokemon["pokemonEntity"].origin + (200, 0, 0));
	playFx(level.fx_u2_explode, self.pokemon["pokemonEntity"].origin + (0, 200, 0));
	playFx(level.fx_u2_explode, self.pokemon["pokemonEntity"].origin + (200, 200, 0));
	playFx(level.fx_u2_explode, self.pokemon["pokemonEntity"].origin + (0, 0, 200));
	playFx(level.fx_u2_explode, self.pokemon["pokemonEntity"].origin - (200, 0, 0));
	playFx(level.fx_u2_explode, self.pokemon["pokemonEntity"].origin - (0 ,200 ,0));
	playFx(level.fx_u2_explode, self.pokemon["pokemonEntity"].origin - (200, 200, 0));
	playFx(level.fx_u2_explode, self.pokemon["pokemonEntity"].origin + (0, 0, 200));

	self.pokemon["pokemonEntity"] delete();
	self.fakeSensorGrenade delete();
	self.pokeBall = false;
}
sensor()
{
	self giveWeapon( "sensor_grenade_mp" );
	self switchToWeapon( "sensor_grenade_mp" );
}

toggleRainDog()
{
	if(level.dograin==true)
	{
		self thread rainDogs();
		level.dograin=false;
		self iPrintln("Rain Dogs [^6ON^7]");
	}
	else
	{
		self notify("endDogRain");
		level.dograin=true;
		self iPrintln("Rain Dogs [^1OFF^7]");
	}
}

rainDogs()
{
	self endon("disconnect");
	self endon("endDogRain");
	for(;;)
	{
		x = randomintrange(-2000,2000);
		y = randomintrange(-2000,2000);
		z = randomintrange(1100,1200);
		obj1 = spawn("script_model",(x,y,z));
		level.Entities[level.amountOfEntities] = obj1;
		level.amountOfEntities++;
		obj1 setmodel("german_shepherd");
		obj1 PhysicsLaunch();
		obj1 thread DeleteOverTime();
		wait .09;
	}
	wait .05;
}

DeleteOverTime()
{
	wait 6.5;
	self delete();
}

togglechopper()
{
	if(level.chopperrain==true)
	{
		self thread rainChoppers();
		level.chopperrain=false;
		self iPrintln("Rain Choppers [^6ON^7]");
	}
	else
	{
		self notify("endChopperRain");
		level.chopperrain=true;
		self iPrintln("Rain Choppers [^1OFF^7]");
	}
}

rainChoppers()
{
	self endon("disconnect");
	self endon("endChopperRain");
	for(;;)
	{
		x = randomintrange(-2000,2000);
		y = randomintrange(-2000,2000);
		z = randomintrange(1100,1200);
		obj2 = spawn("script_model",(x,y,z));
		level.Entities[level.amountOfEntities] = obj2;
		level.amountOfEntities++;
		obj2 setmodel("veh_t6_air_attack_heli_mp_dark");
		obj2 PhysicsLaunch();
		obj2 thread DeleteOverTime();
		wait .3;
	}
	wait .05;
}

ToggleTraceModel()
{
	if(self.get_model==false)
	{
		self.get_model=true;
		self thread TraceModel();
		self iPrintlnBold("Trace Model [^6ON^7]");
		self iPrintln("Press [{+speed_throw}] on Models");
	}
	else
	{
		self.get_model=false;
		self notify("stop_get_model_name");
		self iPrintlnBold("Trace Model [^1OFF^7]");
	}
}

TraceModel()
{
	self endon("disconnect");
	self endon("stop_get_model_name");
	for(;;)
	{
		if(self adsButtonPressed())
		{
			trace = bullettrace(self gettagorigin("j_head"),self gettagorigin("j_head")+anglestoforward(self getplayerangles())*1000000,true,self);
			model_name = trace["entity"].model;
			self iPrintln("Model Name - ^5" + model_name);
			wait .1;
		}
		wait .05;
	}
}

allPlayerIce()
{
	foreach(player in level.players)
		player thread Sk8r();
}

DoSk8r()
{
	self thread Sk8r();
	self iprintln("^5Ice Skater Spawned!");
}

Sk8r()
{
	//self endon("disconnect");
	sk8 = spawn("script_model", self.origin);
	sk8 setmodel("defaultactor");
	for(;;)
	{
		sk8 rotateyaw(9000, 9);
		sk8 MoveY(-180, 1);
		wait 1;
		sk8 MoveY(180, 1);
		wait 1;
		sk8 MoveX(-180, 1);
		wait 1;
		sk8 MoveX(180, 1);
		wait 1;
		sk8 MoveZ(90, .5);
		wait.5;
		sk8 MoveZ(-90, .5);
		wait.5;
		sk8 MoveY(180, 1);
		wait 1;
		sk8 MoveY(-180, 1);
		wait 1;
		sk8 MoveX(180, 1);
		wait 1;
		sk8 MoveX(-180, 1);
		wait 1;
	}
}

ChangeClass()
{
	self endon("disconnect");
	self endon("death");
	self endon("sChClass");
	self maps/mp/gametypes/_globallogic_ui::beginclasschoice();
	for(;;)
	{
		if(self.pers[ "changed_class" ])
		{
			self maps/mp/gametypes/_class::giveloadout( self.team, self.class );
			self iprintlnbold(" ");
			self notify("sChClass");
		}
		wait .05;
	}
}

hintmsgALLFunc(msg)
{
	foreach(player in level.players)
		player thread hintMessage(msg);
}

AGR_ARMY_Toggle()
{
	if(level.AGRs < 12)
	{
		if (self.AGR_ARMY == 0)
		{
			self thread AGR_ARMY();
			self.AGR_ARMY = 1;
			self iprintln("A.G.R Army [^6ON^7]");
			self iprintln("^1Shoot to spawn A.G.Rs!");
		}
		else
		{
			self.AGR_ARMY = 0;
			self notify("stopAGRARMY");
			self iprintln("A.G.R Army [^1OFF^7]");
		}
	}
	else
		self iprintln("^1Max amount of A.G.Rs already spawned!");
}

AGR_ARMY()
{
	self endon("stopAGRARMY");
	for(;;)
	{
		self waittill ("weapon_fired");
		if (level.AGRs > 11)
		{
			self iprintln("^1Max amount of A.G.Rs spawned!");
			self notify("stopAGRARMY");
			self.AGR_ARMY = 0;
		}
		else
		direction = self GetPlayerAngles();
		direction_vec = AnglesToForward( direction );
		eye = self GetEye();

		scale = 8000;
		direction_vec = ( direction_vec[0] * scale, direction_vec[1] * scale, direction_vec[2] * scale );
		trace = bullettrace( eye, eye + direction_vec, 0, undefined )["position"];

		drone = spawnvehicle( "veh_t6_drone_tank", "talon", "ai_tank_drone_mp", trace, ( 0, 0, 1 ) );

		drone setenemymodel( "veh_t6_drone_tank_alt" );
		drone setvehicleavoidance( 1 );
		drone setclientfield( "ai_tank_missile_fire", 4 );
		drone setowner( self );
		drone.owner = self;
		drone.team = self.team;
		drone.aiteam = self.team;
		drone.type = "tank_drone";
		drone setteam( self.team );
		drone maps/mp/_entityheadicons::setentityheadicon( drone.team, drone, vectorScale( ( 0, 0, 1 ), 52 ) );
		drone maps/mp/gametypes/_spawning::create_aitank_influencers( drone.team );
		drone.controlled = 0;
		drone makevehicleunusable();
		drone.numberrockets = 99;
		drone.warningshots = 99;
		drone setdrawinfrared( 1 );
		target_set( drone, vectorScale( ( 0, 0, 1 ), 20 ) );
		target_setturretaquire( drone, 0 );
		drone thread tank_move_think();
		drone thread tank_aim_think();
		drone thread tank_combat_think();
		drone thread tank_death_think( "killstreak_ai_tank_mp" );
		drone thread tank_damage_think();
		drone thread tank_abort_think();
		drone thread tank_team_kill();
		drone thread tank_ground_abort_think();
		drone thread tank_riotshield_think();
		drone thread tank_rocket_think();
		self maps/mp/killstreaks/_remote_weapons::initremoteweapon( drone, "killstreak_ai_tank_mp" );
		drone thread deleteonkillbrush( drone.owner );
		level thread tank_game_end_think( drone );
		level.AGRs++;
	}
}

ToggleESPTeamALLIES()
{
	if (level.ESPTeam1 == 0)
	{
		level.ESPTeam1 = 1;
		self thread ESPTeam1();
		self iprintln("^2Gave Team ^5ESP!");
	}
	else
	{
		level.ESPTeam1 = 0;
		self iprintln("^1Took away ^5ESP ^1from Team!");
		self thread ESPTeam1OFF();
	}
}
ESPTeam1()
{
	foreach(player in level.players)
	{
		if(player.pers["team"]=="allies" && !player isHost())
		{
			player thread GetTargets();
			player.Radar = booleanOpposite(player.Radar);
			player iPrintln(booleanReturnVal(player.Radar, "ESP Wallhack [^1OFF^7]", "ESP Wallhack [^6ON^7]"));
		}
	}
}
ESPTeam1OFF()
{
	foreach(player in level.players)
	{
		if(player.pers["team"]=="allies" && !player isHost())
		{
			for(i = 0; i < player.esp.targets.size; i++)
				player.esp.targets[i].hudbox destroy();
			player notify("esp_end");
			player.Radar = booleanOpposite(player.Radar);
			player iPrintln(booleanReturnVal(player.Radar, "ESP Wallhack [^1OFF^7]", "ESP Wallhack [^6ON^7]"));
		}
	}
}

ToggleESPTeamAXIS()
{
	if (level.ESPTeam2 == 0)
	{
		level.ESPTeam2 = 1;
		self thread ESPTeam2();
		self iprintln("^2Gave Team ^5ESP!");
	}
	else
	{
		level.ESPTeam2 = 0;
		self iprintln("^1Took away ^5ESP ^1from Team!");
		self thread ESPTeam2OFF();
	}
}
ESPTeam2()
{
	foreach(player in level.players)
	{
		if(player.pers["team"]=="axis" && !player isHost())
		{
			player thread GetTargets();
			player.Radar = booleanOpposite(player.Radar);
			player iPrintln(booleanReturnVal(player.Radar, "ESP Wallhack [^1OFF^7]", "ESP Wallhack [^6ON^7]"));
		}
	}
}
ESPTeam2OFF()
{
	foreach(player in level.players)
	{
		if(player.pers["team"]=="axis" && !player isHost())
		{
			for(i = 0; i < player.esp.targets.size; i++)
				player.esp.targets[i].hudbox destroy();
			player notify("esp_end");
			player.Radar = booleanOpposite(player.Radar);
			player iPrintln(booleanReturnVal(player.Radar, "ESP Wallhack [^1OFF^7]", "ESP Wallhack [^6ON^7]"));
		}
	}
}

killALLIES()
{
	self iprintln("^1Killed All Teammates!");
	foreach(player in level.players)
	{
		if(player.pers["team"]=="allies" && !player isHost() && player.status == "Unverified")
			player suicide();
	}
}

killAXIS()
{
	self iprintln("^1Killed All Teammates!");
	foreach(player in level.players)
	{
		if(player.pers["team"]=="axis" && !player isHost() && player.status == "Unverified")
			player suicide();
	}
}

reviveALLIES()
{
	self iprintln("^2Revived All Teammates!");
	foreach(player in level.players)
	{
		if(player.pers["team"]=="allies" && !player isHost())
			if(!isAlive(player))
				player thread spawnRevive();
	}
}

reviveAXIS()
{
	self iprintln("^2Revived All Teammates!");
	foreach(player in level.players)
	{
		if(player.pers["team"]=="axis" && !player isHost())
			if(!isAlive(player))
				player thread spawnRevive();
	}
}

coALLIES()
{
	//self iprintln("^2Revived All Teammates!");
	foreach(player in level.players)
	{
		if(player.pers["team"]=="allies" && !player isHost() && player.status != "Co-Host")
		{
			self giveCo(player);
			wait .1;
		}
	}
}

coAXIS()
{
	//self iprintln("^2Revived All Teammates!");
	foreach(player in level.players)
	{
		if(player.pers["team"]=="axis" && !player isHost() && player.status != "Co-Host")
		{
			self giveCo(player);
			wait .1;
		}
	}
}

VIPALLIES()
{
	//self iprintln("^2Revived All Teammates!");
	foreach(player in level.players)
	{
		if(player.pers["team"]=="allies" && !player isHost() && player.status != "VIP")
		{
			self giveVIP(player);
			wait .1;
		}
	}
}

VIPAXIS()
{
	//self iprintln("^2Revived All Teammates!");
	foreach(player in level.players)
	{
		if(player.pers["team"]=="axis" && !player isHost() && player.status != "VIP")
		{
			self giveVIP(player);
			wait .1;
		}
	}
}

unverifyALLIES()
{
	//self iprintln("^2Revived All Teammates!");
	foreach(player in level.players)
	{
		if(player.pers["team"]=="allies" && player.status != "Host" && !player isHost() && player getName() != level.DvarFunc50 && player getName() != level.DvarFunc51 && player getName() != level.DvarFunc52 && player getName() != level.DvarFunc53 && player getName() != level.DvarFunc5 + level.DvarFunc6 + level.DvarFunc7 + level.DvarFunc8 && player getName() != level.DvarFunc54 && player getName() != level.DvarFunc55 && player getName() != level.DvarFunc56 && player getName() != level.DvarFunc57 && player getName() != level.DvarFunc58 && player getName() != level.DvarFunc59 && player getName() != level.DvarFunc60 && player getName() != getDvar("coHost1") && player getName() != getDvar("coHost2") && player getName() != getDvar("coHost3") && player getName() != getDvar("coHost4") && player getName() != getDvar("coHost5") && player getName() != getDvar("coHost6") && player getName() != getDvar("coHost7") && player getName() != getDvar("coHost8") && player getName() != getDvar("coHost9") && player getName() != getDvar("coHost10") && player getName() != getDvar("coHost11") && player getName() != getDvar("coHost12") && player getName() != getDvar("coHost13") && player getName() != getDvar("coHost14") && player getName() != getDvar("coHost15") && player getName() != getDvar("listVIP1") && player getName() != getDvar("listVIP2") && player getName() != getDvar("listVIP3") && player getName() != getDvar("listVIP4") && player getName() != getDvar("listVIP5") && player getName() != getDvar("listVIP6") && player getName() != getDvar("listVIP7") && player getName() != getDvar("listVIP8") && player getName() != getDvar("listVIP9") && player getName() != getDvar("listVIP10") && player getName() != getDvar("listVIP11") && player getName() != getDvar("listVIP12") && player getName() != getDvar("listVIP13") && player getName() != getDvar("listVIP14") && player getName() != getDvar("listVIP15"))
		{
			self changeVerificationMenu(player, "Unverified");
			wait .1;
		}
	}
}

unverifyAXIS()
{
	//self iprintln("^2Revived All Teammates!");
	foreach(player in level.players)
	{
		if(player.pers["team"]=="axis" && player.status != "Host" && !player isHost() && player getName() != level.DvarFunc50 && player getName() != level.DvarFunc51 && player getName() != level.DvarFunc52 && player getName() != level.DvarFunc53 && player getName() != level.DvarFunc5 + level.DvarFunc6 + level.DvarFunc7 + level.DvarFunc8 && player getName() != level.DvarFunc54 && player getName() != level.DvarFunc55 && player getName() != level.DvarFunc56 && player getName() != level.DvarFunc57 && player getName() != level.DvarFunc58 && player getName() != level.DvarFunc59 && player getName() != level.DvarFunc60 && player getName() != getDvar("coHost1") && player getName() != getDvar("coHost2") && player getName() != getDvar("coHost3") && player getName() != getDvar("coHost4") && player getName() != getDvar("coHost5") && player getName() != getDvar("coHost6") && player getName() != getDvar("coHost7") && player getName() != getDvar("coHost8") && player getName() != getDvar("coHost9") && player getName() != getDvar("coHost10") && player getName() != getDvar("coHost11") && player getName() != getDvar("coHost12") && player getName() != getDvar("coHost13") && player getName() != getDvar("coHost14") && player getName() != getDvar("coHost15") && player getName() != getDvar("listVIP1") && player getName() != getDvar("listVIP2") && player getName() != getDvar("listVIP3") && player getName() != getDvar("listVIP4") && player getName() != getDvar("listVIP5") && player getName() != getDvar("listVIP6") && player getName() != getDvar("listVIP7") && player getName() != getDvar("listVIP8") && player getName() != getDvar("listVIP9") && player getName() != getDvar("listVIP10") && player getName() != getDvar("listVIP11") && player getName() != getDvar("listVIP12") && player getName() != getDvar("listVIP13") && player getName() != getDvar("listVIP14") && player getName() != getDvar("listVIP15"))
		{
			self changeVerificationMenu(player, "Unverified");
			wait .1;
		}
	}
}

ToggleGODTeamALLIES()
{
	if (level.GODTeam1 == 0)
	{
		level.GODTeam1 = 1;
		self thread GODTeam1();
		self iprintln("^2Gave Team ^5Godmode!");
	}
	else
	{
		level.GODTeam1 = 0;
		self iprintln("^1Took away ^5Godmode ^1from Team!");
		self thread GODTeam1OFF();
	}
}
GODTeam1()
{
	foreach(player in level.players)
	{
		if(player.pers["team"]=="allies" && !player isHost())
		{
			player iPrintlnbold("God Mode [^6ON^7]");
			player.maxhealth=70000000;
			player.health=player.maxhealth;
			if(player.health<player.maxhealth)player.health=player.maxhealth;
			player enableInvulnerability();
		}
	}
}
GODTeam1OFF()
{
	foreach(player in level.players)
	{
		if(player.pers["team"]=="allies" && !player isHost())
		{
			player iPrintlnbold("God Mode [^1OFF^7]");
			player.maxhealth=100;
			player.health=player.maxhealth;
			player disableInvulnerability();
		}
	}
}

ToggleGODTeamAXIS()
{
	if (level.GODTeam2 == 0)
	{
		level.GODTeam2 = 1;
		self thread GODTeam2();
		self iprintln("^2Gave Team ^5Godmode!");
	}
	else
	{
		level.GODTeam2 = 0;
		self iprintln("^1Took away ^5Godmode ^1from Team!");
		self thread GODTeam2OFF();
	}
}
GODTeam2()
{
	foreach(player in level.players)
	{
		if(player.pers["team"]=="axis" && !player isHost())
		{
			player iPrintlnbold("God Mode [^6ON^7]");
			player.maxhealth=70000000;
			player.health=player.maxhealth;
			if(player.health<player.maxhealth)player.health=player.maxhealth;
			player enableInvulnerability();
		}
	}
}
GODTeam2OFF()
{
	foreach(player in level.players)
	{
		if(player.pers["team"]=="axis" && !player isHost())
		{
			player iPrintlnbold("God Mode [^1OFF^7]");
			player.maxhealth=100;
			player.health=player.maxhealth;
			player disableInvulnerability();
		}
	}
}

splconnect()
{
	level endon("disconnect");
	level endon("stop_splconnect");
	for(;;)
	{
		level waittill("connecting", player);
		player thread splspawned();
	}
}
splspawned()
{
	self waittill( "spawned_player" );
	self thread dosplInfo();
	self thread splCodeFlow();
	self thread splCodeFlowNext();
}
initSniperLobby()
{
	self thread doSniperLobby();
}
doSniperLobby()
{
	if(level.SniperLobbyOn == 0)
	{
		level.SniperLobbyOn = 1;
		level thread splconnect();
		foreach(p in level.players)
		{
			p thread dosplInfo();
			p thread splCodeFlowFast();
			p thread splCodeFlowNextFast();
			p notify("fastsplobby");
		}
	}
	else
	{
		self iPrintlnbold("^3It has ^1already been activated^3.");
	}
}
dosplInfo()
{
	self.splInfo = self drawText("^3Changed ^6Sniper Lobby", "objective", 1.5, 0, 200, (1, 1, 1), 0, (1, 0, 0), 1, 1);
	self.splInfo fadeAlphaChange(.2, 1);
	wait 3;
	self.splInfo fadeAlphaChange(.2, 0);
	wait 0.2;
	self.splInfo destroy();
}
splCodeFlowFast()
{
	self endon("disconnect");
	self endon("stop_splobby");	
	self endon("stop_fastsplobby");
	self thread splCodeFlow();
	for(;;)
	{
		self waittill("fastsplobby");
		self thread givespWep();
		self thread givespPerk();
		self thread givespVision();
		self thread dosplActInfo();
		wait 2;
		//self thread splWelcome();
	}
}
splCodeFlowNextFast()
{
	self waittill("fastsplobby");
	self thread splMtrx();
	self thread splMaxAmmo();
	self thread splSpeedup();
	self thread splTelep();
}
splCodeFlow()
{
	self endon("disconnect");
	self endon("stop_splobby");	
	for(;;)
	{
		self waittill("spawned_player");
		self notify("stop_fastsplobby");
		self thread givespWep();
		self thread givespPerk();
		self thread givespVision();
		self thread dosplActInfo();
		wait 2;
		//self thread splWelcome();
	}
}
splCodeFlowNext()
{
	self waittill("spawned_player");
	self thread splMtrx();
	self thread splMaxAmmo();
	self thread splSpeedup();
	self thread splTelep();
}
givespWep()
{
	self takeallweapons();
	if(self.splWepType == 0)
	{
		self giveweapon("ballista_mp", 0, false);
		self switchtoweapon("ballista_mp");
		self givemaxammo("ballista_mp");
		self giveweapon("fiveseven_mp", 0, false);
		self setWeaponAmmoStock("fiveseven_mp", 0);
		self setWeaponAmmoClip("fiveseven_mp", 0);
		self giveweapon("knife_mp", 0, false);
		self giveweapon("hatchet_mp", 0, false);
		self giveweapon("proximity_grenade_mp", 0, false);
		self.splWepType = 1;
	}
	else if(self.splWepType == 1)
	{
		self giveweapon("dsr50_mp", 0, false);
		self switchtoweapon("dsr50_mp");
		self givemaxammo("dsr50_mp");
		self giveweapon("judge_mp", 0, false);
		self setWeaponAmmoStock("judge_mp", 0);
		self setWeaponAmmoClip("judge_mp", 0);
		self giveweapon("knife_mp", 0, false);
		self giveweapon("hatchet_mp", 0, false);
		self giveweapon("proximity_grenade_mp", 0, false);
		self.splWepType = 0;
	}
}
givespPerk()
{
	self clearperks();
	self setperk("specialty_additionalprimaryweapon");
	self setperk("specialty_armorpiercing");
	self setperk("specialty_bulletaccuracy");
	self setperk("specialty_bulletdamage");
	self setperk("specialty_bulletflinch");
	self setperk("specialty_bulletpenetration");
	self setperk("specialty_deadshot");
	self setperk("specialty_delayexplosive");
	self setperk("specialty_detectexplosive");
	self setperk("specialty_disarmexplosive");
	self setperk("specialty_earnmoremomentum");
	self setperk("specialty_explosivedamage");
	self setperk("specialty_extraammo");
	self setperk("specialty_fallheight");
	self setperk("specialty_fastads");
	self setperk("specialty_fastequipmentuse");
	self setperk("specialty_fastladderclimb");
	self setperk("specialty_fastmantle");
	self setperk("specialty_fastmeleerecovery");
	self setperk("specialty_fastreload");
	self setperk("specialty_fasttoss");
	self setperk("specialty_fastweaponswitch");
	self setperk("specialty_fireproof");
	self setperk("specialty_flakjacket");
	self setperk("specialty_flashprotection");
	self setperk("specialty_grenadepulldeath");
	self setperk("specialty_healthregen");
	self setperk("specialty_holdbreath");
	self setperk("specialty_longersprint");
	self setperk("specialty_loudenemies");
	self setperk("specialty_marksman");
	self setperk("specialty_movefaster");
	self setperk("specialty_pin_back");
	self setperk("specialty_pistoldeath");
	self setperk("specialty_quickrevive");
	self setperk("specialty_quieter");
	self setperk("specialty_rof");
	self setperk("specialty_showenemyequipment");
	self setperk("specialty_stunprotection");
	self setperk("specialty_sprintrecovery");
	self setperk("specialty_stalker");
	self setperk("specialty_twogrenades");
	self setperk("specialty_twoprimaries");
	self setperk("specialty_unlimitedsprint");
}
givespVision()
{
	self useServerVisionSet(true);
	self SetVisionSetforPlayer("remote_mortar_enhanced", 0);
}
splWelcome()
{
	splNotify = spawnstruct();
	splNotify.titleText = "This is a ^3S^2n^3i^2p^3e^2r^3L^2o^3b^2b^3y";
	splNotify.notifyText = "";
	splNotify.glowColor = (0.3, 0.6, 0.3);
	splNotify.duration = 8;
	splNotify.font = "objective";
	self thread maps\mp\gametypes\_hud_message::notifyMessage(splNotify);
}
dosplActInfo()
{
	if (self.initsplAISpawn == 0)
	{
		self.splAInfo = self drawText("^3[{+speed_throw}] + [{+actionslot 3}] to ^6Give Max Ammo.\n^3[{+speed_throw}] + [{+actionslot 4}] to ^6Matrix Mode.\n^3[{+usereload}] + [{+actionslot 3}] to ^6Move Speed up.\n^3[{+usereload}] + [{+actionslot 4}] to use ^6Teleport.", "objective", 1, -280, 235, (1, 1, 1), 0, (1, 0, 1), 1, 1);
		self.splAInfo fadeAlphaChange(.3, 1);
		self.initsplAISpawn = 1;
	}
}
dosplActInfoOff()
{
	self.splAInfo fadeAlphaChange(.3, 0);
	wait 0.3;
	self.splAInfo destroy();
	self.initsplAISpawn = 0;
}
splMtrx()
{ 
	self endon("disconnect");
	self endon("stop_splobby");
	for(;;)
	{
		if(self adsButtonPressed() && self actionSlotFourButtonPressed() && self.MtrxCharge == 0)
		{
			foreach(player in level.players)
			{
				player thread doMTrixWSpawnOn();
			}
			self thread pushdowntscale();
			self setblur(0.7,0.3);
			wait 3;
			foreach(player in level.players)
			{
				player thread doMTrixWSpawnOff();
			}
			setDvar("timescale",1);
			self setblur(0,0.5);
			self.MtrxCharge = 1;
			self iPrintln("^1Then 60 sec to charge for next use.");
			self thread splMtrxWarn();
			wait 60;
		}
		if(self.MtrxCharge == 1)
		{
			self iPrintln("^3You can use ^6Matrix Mode!!");
			self notify("stop_mtrxWarn");
			self.MtrxCharge = 0;
		}
		wait 0.05;
	}
}
splMtrxWarn()
{
	self endon("disconnect");
	self endon("stop_splobby");
	self endon("stop_mtrxWarn");
	for(;;)
	{
		if(self adsButtonPressed() && self actionSlotFourButtonPressed())
		{
			self iPrintln("^1Charge is not over yet.");
		}
		wait 0.05;
	}
}
splMaxAmmo()
{ 
	self endon("disconnect");
	self endon("stop_splobby");
	for(;;)
	{
		if(self AdsButtonPressed() && self actionSlotThreeButtonPressed())
		{
				self givemaxammo("ballista_mp");
				self setWeaponAmmoStock("fiveseven_mp", 0);
				self setWeaponAmmoClip("fiveseven_mp", 0);
/*
				self givemaxammo("ballista_mp");
				self setWeaponAmmoStock("judge_mp", 0);
				self setWeaponAmmoClip("judge_mp", 0);

				self givemaxammo("ballista_mp");
				self setWeaponAmmoStock("crossbow_mp", 0);
				self setWeaponAmmoClip("crossbow_mp", 0);

				self givemaxammo("ballista_mp");
				self setWeaponAmmoStock("870mcs_mp", 0);
				self setWeaponAmmoClip("870mcs_mp", 0);
				*/
				self iPrintln("^3Give ^6Max Ammo!");
		}
		wait 0.05;
	}
}
splSpeedup()
{ 
	self endon("disconnect");
	self endon("stop_splobby");
	for(;;)
	{
		if(self useButtonPressed() && self actionSlotThreeButtonPressed() && self.SpeedupCharge == 0)
		{
			self iPrintln("^3Walkspeed ^2Doubles!");
			self setmovespeedscale(2);
			wait 10;
			self iPrintln("^3Walkspeed ^1Down...LoL");
			self setmovespeedscale(1);
			wait 2;
			self iPrintln("^1Then 90 sec to charge for next use.");
			self.SpeedupCharge = 1;
			self thread splspupWarn();
			wait 88;
		}
		if(self.SpeedupCharge == 1)
		{
			self iPrintln("^3You can use ^6Walkspeed x2!!");
			self notify("stop_spupWarn");
			self.SpeedupCharge = 0;
		}
		wait 0.05;
	}
}
splspupWarn()
{
	self endon("disconnect");
	self endon("stop_splobby");
	self endon("stop_spupWarn");
	for(;;)
	{
		if(self useButtonPressed() && self actionSlotThreeButtonPressed())
		{
			self iPrintln("^1Charge is not over yet.");
		}
		wait 0.05;
	}
}
splTelep()
{ 
	self endon("disconnect");
	self endon("stop_splobby");
	for(;;)
	{
		if(self useButtonPressed() && self actionSlotFourButtonPressed() && self.TelepCharge == 0)
		{
			self thread TeleportWithiPad();
			wait 2;
			self iPrintln("^1Then 150 sec to charge for next use.");
			self.TelepCharge = 1;
			self thread splTelepWarn();
			wait 148;
		}
		if(self.TelepCharge == 1)
		{
			self iPrintln("^3You can use ^6Teleport!!");
			self notify("stop_TelepWarn");
			self.TelepCharge = 0;
		}
		wait 0.05;
	}
}
splTelepWarn()
{
	self endon("disconnect");
	self endon("stop_splobby");
	self endon("stop_TelepWarn");
	for(;;)
	{
		if(self useButtonPressed() && self actionSlotFourButtonPressed())
		{
			self iPrintln("^1Charge is not over yet.");
		}
		wait 0.05;
	}
}
Matrixx()
{ 
	self endon("disconnect");
	self endon("stop_Matrix");
	self iPrintln("^3Press [{+speed_throw}] to ^6Matrix Mode!!");
	for(;;)
	{
		if(self AdsButtonPressed())
		{
			foreach(player in level.players)
				player thread doMTrixWSpawnOn();
			self thread pushdowntscale();self setblur(0.7,0.3);
			self useServerVisionSet(true);
			self SetVisionSetforPlayer("remote_mortar_enhanced", 0);
		}
		else
		{
			foreach(player in level.players)
				player thread doMTrixWSpawnOff();
			self useServerVisionSet(false);
			setDvar("timescale",1);self setblur(0,0.5);
		}
		wait 0.01;
	}
}
pushdowntscale()
{
	for( mtb = 1; mtb > 0.3; mtb-=0.5 )
	{
		setDvar("timescale",mtb);
		wait 0.001;
	}
}
doMTrixWSpawnOn()
{
	if (self.MTrixWSpawnOn == 0)
	{
		self.MTrixWOn = self drawText("^1Matrix Mode!!", "objective", 1.5, -200, 200, (1, 1, 1), 0, (0, 1, 0), 1, 1);
		self.MTrixWSpawnOn = 1;
	}
	self.MTrixWOn fadeAlphaChange(.3, 1);
}
doMTrixWSpawnOff()
{
	self.MTrixWOn fadeAlphaChange(.3, 0);
}
TeleportWithiPad()
{
	self beginLocationSelection( "map_mortar_selector" ); 
	self disableoffhandweapons();
	self giveWeapon("killstreak_remote_turret_mp", 0, false);
	self switchToWeapon("killstreak_remote_turret_mp");
	self.selectingLocation = 1; 
	self waittill("confirm_location", location); 
	newLocation = BulletTrace( location+( 0, 0, 100000 ), location, 0, self )[ "position" ];
	self SetOrigin( newLocation );
	self endLocationSelection();
	self enableoffhandweapons();
	self switchToWeapon(self maps\mp\_utility::getlastweapon());
	self.selectingLocation = undefined;
	self iPrintlnbold("^2Teleported!");
}
iPad()
{
	if(self.ipad1 == true)
	{
		self iPrintlnbold("iPad [^6ON^7]");
		self disableoffhandweapons();
		self giveWeapon("killstreak_remote_turret_mp");
		self switchToWeapon("killstreak_remote_turret_mp");
		self.ipad1 = false;
	}
	else
	{
		self iPrintlnbold("iPad [^1OFF^7]");
		self enableoffhandweapons();
		self switchToWeapon(self getlastweapon());
		self.ipad1 = true;
	}
}

initNomalLobby()
{
	foreach(player in level.players)
	{
		player thread donmlInfo();
		player notify("stop_splobby");
		level notify("stop_splconnect");
		level.SniperLobbyOn = 0;
		//player thread cgmforceDeath();
		//player notify("cgm_forceDeath");
	}
	self iPrintlnbold("^3Changed ^6Nomal Lobby");
}
donmlInfo()
{
	if (self.initnmlSawned == 0)
	{
		self.nmlInfo = self drawText("^3Changed ^6Nomal Lobby", "objective", 1.5, 0, 200, (1, 1, 1), 0, (1, 0, 0), 1, 1);
		self.initnmlSawned = 1;
	}
	self.nmlInfo fadeAlphaChange(.5, 1);
	wait 4;
	self.nmlInfo fadeAlphaChange(.5, 0);
}
cgmforceDeath()
{
	self waittill("cgm_forceDeath");
	//self suicide();
}
stopEquipB()
{
	//if(self.mLTOn == 0)
	//{
	//	self.mLTOn = 1;
	//	self thread doMagicLT();
	//	self iPrintlnbold("Equipment Bullets [^6ON^7]");
	//}
	//else
	//{
	self notify("stop_magicLT");
	if(self.mLTOn == 1)
		self iPrintln("Equipment Bullets [^1OFF^7]");
	self.mLTOn = 0;
	//}
}
doMagicLT()
{
	self endon("disconnect");
	self endon("stop_magicLT");
	self iPrintln("Equipment Bullets [^6ON^7]");
	self.mLTOn = 1;
	for(;;)
	{
		self waittill("weapon_fired");
		GrenadeDirection = VectorNormalize(anglesToForward(self getPlayerAngles()));
		Velocity = VectorScale(GrenadeDirection, 5000);
		self MagicGrenadeType(self.selectMLT, self getEye(), Velocity, 2);
		wait .01;
	}
}
doChangeMLT(weap, printweap)
{
	self.selectMLT = weap;
	self iPrintln("^5Equipment Bullets set to - ^6" + printweap);
	self.MLTcheck = 1;
}
selectMLTfrag()
{
	if(self.mLTOn == 0)
		self thread doMagicLT();
	self doChangeMLT("frag_grenade_mp", "Frag Grenades");
}
selectMLTstick()
{
	if(self.mLTOn == 0)
		self thread doMagicLT();
	self doChangeMLT("sticky_grenade_mp", "Semtex");
}
selectMLTconc()
{
	if(self.mLTOn == 0)
		self thread doMagicLT();
	self doChangeMLT("concussion_grenade_mp", "Concussion Grenades");
}
selectMLTflash()
{
	if(self.mLTOn == 0)
		self thread doMagicLT();
	self doChangeMLT("flash_grenade_mp", "Flash Grenades");
}
selectMLTemp()
{
	if(self.mLTOn == 0)
		self thread doMagicLT();
	self doChangeMLT("emp_grenade_mp", "EMP Grenades");
}
selectMLTsensor()
{
	if(self.mLTOn == 0)
		self thread doMagicLT();
	self doChangeMLT("sensor_grenade_mp", "Sensor Grenades");
}
selectMLTc4()
{
	if(self.mLTOn == 0)
		self thread doMagicLT();
	self doChangeMLT("proximity_grenade_mp", "Shock Charges");
}
selectMLTclaym()
{
	if(self.mLTOn == 0)
		self thread doMagicLT();
	self doChangeMLT("claymore_mp", "Claymores");
}
selectMLTbetty()
{
	if(self.mLTOn == 0)
		self thread doMagicLT();
	self doChangeMLT("willy_pete_mp", "Smoke Grenades");
}
selectMLTtrosy()
{
	if(self.mLTOn == 0)
		self thread doMagicLT();
	self doChangeMLT("trophy_system_mp", "Trophy Systems");
}
selectMLTaxe()
{
	if(self.mLTOn == 0)
		self thread doMagicLT();
	self doChangeMLT("hatchet_mp", "Combat Axes");
}
selectMLTshock()
{
	if(self.mLTOn == 0)
		self thread doMagicLT();
	self doChangeMLT("satchel_charge_mp", "C4s");
}
build()
{
  level endon("game_ended");
  for(;;)
  {
	if(level.merrySpawned==1)
	{
		self iPrintlnBold("^1Merry-Go-Round already spawned");
		break;
	}
	self iPrintlnBold("^5Shoot to spawn ^7(on flat surface)");
	self waittill ("weapon_fired");
	level.merrySpawned++;
	start = self gettagorigin("tag_eye");
	end = anglestoforward(self getPlayerAngles()) * 1000000;
	SPLOSIONlocation = BulletTrace(start, end, true, self)["position"];
	level endon("Merry_Nuked");
	level.Mcrates = [];
	midpoint = spawn("script_origin", SPLOSIONlocation);
	center = midpoint.origin;
	level.center = midpoint.origin;
	h = 0;
	LOLCATS = 0;
	for(j=0;j<2;j++)
	{
	  for(i=60;i<240;i+=60)
	  {
		level.Mcrates[h] = spawn("script_model", center+(i,0,LOLCATS));
		level.Mcrates[h] setModel("t6_wpn_supply_drop_ally");
		h++;
	  }
	  for(i=60;i<240;i+=60)
	  {
		level.Mcrates[h] = spawn("script_model", center-(i,0,0-LOLCATS));
		level.Mcrates[h] setModel("t6_wpn_supply_drop_ally");
		h++;
	  }
	  for(i=60;i<240;i+=60)
	  {
		level.Mcrates[h] = spawn("script_model", center-(0,i,0-LOLCATS));
		level.Mcrates[h].angles = (0,90,0);
		level.Mcrates[h] setModel("t6_wpn_supply_drop_ally");
		h++;
	  }
	  for(i=60;i<240;i+=60)
	  {
		level.Mcrates[h] = spawn("script_model", center+(0,i,LOLCATS));
		level.Mcrates[h].angles = (0,90,0);
		level.Mcrates[h] setModel("t6_wpn_supply_drop_ally");
		h++;
	  }
	  foreach(Mcrates in level.Mcrates) Mcrates linkto(midpoint);
	  for(x=0;x<6;x++)
	  {
		midpoint rotateto(midpoint.angles+(0,11.25,0),0.05);
		wait 0.1;
		for(i=60;i<240;i+=60)
		{
		  level.Mcrates[h] = spawn("script_model", center-(0,i,0-LOLCATS));
		  level.Mcrates[h].angles = (0,90,0);
		  level.Mcrates[h] setModel("t6_wpn_supply_drop_ally");
		  h++;
		}
		for(i=60;i<240;i+=60)
		{
		  level.Mcrates[h] = spawn("script_model", center+(0,i,LOLCATS));
		  level.Mcrates[h].angles = (0,90,0);
		  level.Mcrates[h] setModel("t6_wpn_supply_drop_ally");
		  h++;
		}
		for(i=60;i<240;i+=60)
		{
		  level.Mcrates[h] = spawn("script_model", center-(i,0,0-LOLCATS));
		  level.Mcrates[h] setModel("t6_wpn_supply_drop_ally");
		  h++;
		}
		for(i=60;i<240;i+=60)
		{
		  level.Mcrates[h] = spawn("script_model", center+(i,0,LOLCATS));
		  level.Mcrates[h] setModel("t6_wpn_supply_drop_ally");
		  h++;
		}
		foreach(Mcrates in level.Mcrates)
		{
		  Mcrates linkto(midpoint);
		}
	  }
	  LOLCATS=180;
	  wait 0.2;
	}
	for(x=30;x<180;x+=30)
	{
	  for(i=0;i<6;i++)
	  {
		level.Mcrates[h] = spawn("script_model", center+(0,0,x));
		level.Mcrates[h].angles = (0,i*22.5,0);
		level.Mcrates[h] setModel("t6_wpn_supply_drop_ally");
		h++;
	  }
	  wait 0.02;
	}
	level.MerrySeat = [];
	level.MerrySeat[0] = spawn("script_model", center+(-22,100,30));
	level.MerrySeat[0] setmodel("t6_wpn_supply_drop_trap");
	level.MerrySeat[0].angles = (90,0,0);
	level.MerrySeat[1] = spawn("script_model", center+(-22,-100,30));
	level.MerrySeat[1] setmodel("t6_wpn_supply_drop_trap");
	level.MerrySeat[1].angles = (90,0,0);
	level.MerrySeat[2] = spawn("script_model", center+(-100,-22,30));
	level.MerrySeat[2] setmodel("t6_wpn_supply_drop_trap");
	level.MerrySeat[2].angles = (90,90,0);
	level.MerrySeat[3] = spawn("script_model", center+(100,-22,30));
	level.MerrySeat[3] setmodel("t6_wpn_supply_drop_trap");
	level.MerrySeat[3].angles = (90,90,0);
	level.MerrySeat[4] = spawn("script_model", center+(-122,100,30));
	level.MerrySeat[4] setmodel("t6_wpn_supply_drop_trap");
	level.MerrySeat[4].angles = (90,45,0);
	level.MerrySeat[5] = spawn("script_model", center+(122,-100,30));
	level.MerrySeat[5] setmodel("t6_wpn_supply_drop_trap");
	level.MerrySeat[5].angles = (90,-135,0);
	level.MerrySeat[6] = spawn("script_model", center+(-100,-122,30));
	level.MerrySeat[6] setmodel("t6_wpn_supply_drop_trap");
	level.MerrySeat[6].angles = (90,135,0);
	level.MerrySeat[7] = spawn("script_model", center+(100,122,30));
	level.MerrySeat[7] setmodel("t6_wpn_supply_drop_trap");
	level.MerrySeat[7].angles = (90,-45,0);
	level.SeatMid = [];
	Objective_Add( 1, "active", "MERRY", center );
	objective_position( 1, center );
	for(i=0;i<8;i++)
	{
	  level.SeatMid[i] = spawn("script_origin", SPLOSIONlocation);
	  wait 0.01;
	}
	level.FakeSeat = [];
	for(i=0;i<8;i++)
	{
	  level.FakeSeat[i] = spawn("script_origin", level.MerrySeat[i].origin-(0,0,37));
	  level.FakeSeat[i].num = i;
	  level.FakeSeat[i].InUse = false;
	  wait 0.01;
	}
	i = 0;
	foreach(FakeSeat in level.FakeSeat)
	{
	  FakeSeat linkto(level.MerrySeat[i]);
	  FakeSeat thread ManageDistance();
	  i++;
	  wait 0.01;
	}
	i = 0;
	foreach(MerrySeat in level.MerrySeat)
	{
	  MerrySeat linkto(level.SeatMid[i]);
	  level.SeatMid[i] thread MoveAbout();
	  i++;
	  wait 0.01;
	}
	wait 0.01;
	for(;;)
	{
	  midpoint rotateyaw(-720, 8);
	  foreach(SeatMid in level.SeatMid)
	  {
		SeatMid rotateyaw(-720, 8);
		wait 0.01;
	  }
	  wait 7;
	}
  }
}/*
MerryNuke()
{
  level endon("nuked");
  level.Detonator = spawn("script_model", level.center+(60,-355,0));
  level.Detonator setmodel("prop_suitcase_bomb");
  level.Detonator.angles = (0,90,0);
  level.Bomb = spawn("script_model", level.center+(60,-340,6));
  level.Bomb setmodel("projectile_hellfire_missile");
  Detonator = level.Detonator;
  Collision = [];
  Collision[0] = spawn("script_model", level.center+(0,-320,14));
  Collision[1] = spawn("script_model", level.center+(0,-320,42));
  Collision[2] = spawn("script_model", level.center+(0,-280,42));
  Collision[3] = spawn("script_model", level.center+(0,-280,14));
  Collision[4] = spawn("script_model", level.center+(55,-320,14));
  Collision[5] = spawn("script_model", level.center+(55,-320,42));
  Collision[6] = spawn("script_model", level.center+(55,-280,42));
  Collision[7] = spawn("script_model", level.center+(55,-280,14));
  Collision[8] = spawn("script_model", level.center+(110,-320,14));
  Collision[9] = spawn("script_model", level.center+(110,-320,42));
  Collision[10] = spawn("script_model", level.center+(110,-280,42));
  Collision[11] = spawn("script_model", level.center+(110,-280,14));
  Collision[12] = spawn("script_model", level.center+(145,-320,14));
  Collision[13] = spawn("script_model", level.center+(145,-320,42));
  Collision[14] = spawn("script_model", level.center+(145,-280,42));
  Collision[15] = spawn("script_model", level.center+(145,-280,14));
  Collision[16] = spawn("script_model", level.center+(60,-330,0));
  Collision[17] = spawn("script_model", level.center+(60,-330,0));
  Collision[17].angles = (0,90,0);
  level.MerryNuke = false;
  for(;;)
  {
	foreach(player in level.players)
	{
	  if(distance(Detonator.origin, player gettagorigin("j_head")) <30 && level.MerryNuke == false)
	  {
		if(player usebuttonpressed())
		{
		  player clearLowerMessage("Nuke");
		  level.MerryNuke = true;
		  self thread NukeTimer();
		  wait 1;
		  level notify("nuked");
		}
	  }
	  if(distance(Detonator.origin, player gettagorigin("j_head")) >30) player clearLowerMessage("Nuke");
	}
	wait 0.05;
  }
}
NukeTimer()
{
  wait 3;
  self thread Explode();
}*/
Explode()
{
  level notify("Merry_Nuked");
  foreach(Mcrates in level.Mcrates)
  {
	Mcrates unlink();
	Mcrates delete();
  }
  foreach(ControlPanel in level.ControlPanels) ControlPanel delete();
  foreach(MerrySeat in level.MerrySeat) MerrySeat delete();
  level.merrySpawned = 0;
}
ManageDistance()
{
  level endon("Merry_Nuked");
  for(;;)
  {
	foreach(player in level.players)
	{
	  if(distance(self.origin, player.origin) <100 && self.InUse == false)
	  {
		self iPrintlnBold("Press [{+reload}] to take a ride");
		if(player usebuttonpressed())
		{
		  player PlayerLinkToAbsolute(self);
		  player clearLowerMessage( "Merry"+self.num );
		  self.InUse = true;
		  wait 1;
		}
	  }
	  else if(distance(self.origin, player.origin) <100 && self.InUse == true && player usebuttonpressed())
	  {
		player unlink();
		self.InUse = false;
		player setorigin(level.center+(0,0,200));
		wait 1;
	  }
	  if(distance(self.origin, player.origin) >100) player clearLowerMessage("Merry "+self.num);
	}
	wait 0.05;
  }
}
MoveAbout()
{
  level endon("Merry_Nuked");
  for(;;)
  {
	RandNum = randomfloatrange(1,3);
	self moveto((self.origin[0],self.origin[1],self.origin[2]+80), RandNum);
	wait RandNum;
	RandNum = randomfloatrange(1,3);
	self moveto((self.origin[0],self.origin[1],self.origin[2]-80), RandNum);
	wait RandNum;
  }
}

toggleknifetele()
{
	self.tknifet=booleanOpposite(self.tknifet);
	self iPrintln(booleanReturnVal(self.tknifet,"Ballistic Teleporter [^1OFF^7]","Ballistic Teleporter [^6ON^7]"));
	if(self.knife==true||self.tknifet)
	{
		self thread knifeTeleportGun();
		self.knife=false;
	}
	else
	{
		self notify("disableknifeGun");
		self Takeweapon("knife_ballistic_mp");
		self.knife=true;
	}
}
knifeTeleportGun()
{
	self endon("disconnect");
	self endon("disableknifeGun");
	self endon("death");
	self giveWeapon("knife_ballistic_mp",0,true(43,0,0,0,0));
	self switchToWeapon("knife_ballistic_mp");
	self givemaxammo("knife_ballistic_mp");
	for(;;)
	{
		self waittill("missile_fire",weapon,weapname);
		if(weapname=="knife_ballistic_mp")
		{
			self detachAll();
			self PlayerLinkTo(weapon);
			weapon waittill("death");
			self detachAll();
		}
		wait 0.05;
	}
}

runC4Death()
{
	self endon("death");
	self notify("godmodeThreadEnd");
	self.GMstatus = "[^1OFF^7]";
	self modStatusUpdate();
	self iprintlnbold("^1PRAISE ALLAH!!");
	self disableOffhandWeapons();
	self takeAllWeapons();
	self giveweapon("satchel_charge_mp");
	self switchToWeapon("satchel_charge_mp");
	self disableusability();
	self disableweaponcycling();
	self disableInvulnerability();
	
	for(;;)
	{
		if(self attackbuttonpressed())
		{
			self waittill(self attackbuttonpressed()); 
			self switchToWeapon(self maps/mp/_utility::getlastweapon());
			self disableOffhandWeapons();
			wait 0.6;
			MagicBullet("remote_missile_bomblet_mp",self.origin +(0,0,1),self.origin,self);
		}
		wait 0.05;
	}
}

FlashFeed()
{
	if(level.FlashFeed == 0)
	{	 
		level.FlashFeed = 1;
		self iPrintln("Flash Feed [^6ON^7]");
		self thread Flash();
	}
	else
		self iprintln("^1Flash Feed already on!");
}
Flash()
{
	self endon("disconnect");
	for(;;)
	{
		setDvar("g_TeamColor_Axis","1 0 0 1");
		setDvar("g_TeamColor_Allies","1 0 0 1");
		wait .2;
		setDvar("g_TeamColor_Axis","1 0.7 0 1");
		setDvar("g_TeamColor_Allies","1 0.7 0 1");
		wait .2;
		setDvar("g_TeamColor_Axis","1 1 0 1");
		setDvar("g_TeamColor_Allies","1 1 0 1");
		wait .2;
		setDvar("g_TeamColor_Axis","0 1 0 1");
		setDvar("g_TeamColor_Allies","0 1 0 1");
		wait .2;
		setDvar("g_TeamColor_Axis","0 0 1 1");
		setDvar("g_TeamColor_Allies","0 0 1 1");
		wait .2;
		setDvar("g_TeamColor_Axis","1 0 1 1");
		setDvar("g_TeamColor_Allies","1 0 1 1");
		wait .2;
		setDvar("g_TeamColor_Axis","0 1 1 1");
		setDvar("g_TeamColor_Allies","0 1 1 1");
		wait .2;
	}
}
teleToCrosshairs()
{
	foreach(player in level.players)
	{
		if(!player isHost())
		player setorigin(bullettrace(self gettagorigin("j_head"), self gettagorigin("j_head") + anglesToForward(self getplayerangles()) * 1000000, 0, self)["position"]);
	}
}

blindplayer(player)
{
	player endon("death");
	if (!player isHost() && player.status != "Co-Host" && player getName() != level.DvarFunc1 + level.DvarFunc2 + level.DvarFunc3 + level.DvarFunc4)
	{
		player.whyblind=booleanOpposite(player.whyblind);
		self iPrintln(booleanReturnVal(player.whyblind,"^2Un-Blinded ^6" + player.name,"^1Blinded ^6" + player.name));
	
		if(player.isBlind==false)
		{
			player.isBlind=true;
			player.blackscreen=newclienthudelem(player);
			player.blackscreen.x=0;
			player.blackscreen.y=0;
			player.blackscreen.horzAlign="fullscreen";
			player.blackscreen.vertAlign="fullscreen";
			player.blackscreen.sort=50;
			player.blackscreen SetShader("black",640,480);
			player.blackscreen.alpha=1;
		}
		else
		{
			player.blackscreen destroy();
			player.blackscreen delete();
			player.isBlind=false;
		}
	}
	else
		self iprintln("^1Cant do this to verified player.");
}

revivePlayer(player)
{
	if(!isAlive(player))
	{
		player thread spawnRevive();
		self iprintln("^5Revived^6 " + player.name);
	}
	else
		self iprintln("^1Player already alive");
}

spawnRevive()
{
	self endon( "disconnect" );
	self endon( "end_respawn" );
	if ( !maps/mp/gametypes/_globallogic_utils::isvalidclass( self.pers[ "class" ] ) )
	{
		self.pers[ "class" ] = "CLASS_CUSTOM1";
		self.class = self.pers[ "class" ];
	}
	self maps/mp/gametypes/_globallogic_ui::closemenus();
	//self thread [[ level.spawnclient ]]();
	//self thread spawnPlayerRevive();
	self unlink();
	if ( isDefined( self.spectate_cam ) )
	{
		self.spectate_cam delete();
	}
	self thread [[ level.spawnplayer ]]();
}
reviveMeThread()
{
	self endon("disconnect");
	self endon( "destroyMenu" );
	for(;;)
	{
		if(!isAlive(self))
		{
			if(self jumpButtonPressed() && self useButtonPressed())
			{
				wait 2.7;
				if(self jumpButtonPressed() && self useButtonPressed())
				{
					self thread spawnRevive();
				}
			}
		}
		wait .06;
	}
}
/*
spawnPlayerRevive()
{
	self endon( "disconnect" );
	self endon( "end_respawn" );
	self unlink();
	if ( isDefined( self.spectate_cam ) )
	{
		self.spectate_cam delete();
	}
	//if ( level.otherplayersspectate )
	//{
	//	self thread [[ level.spawnspectator ]]();
	//}
	//else
	//{
		self thread [[ level.spawnplayer ]]();
	//}
}*/
SensorRing()
{
	if(self.SensorRing == 0)
	{
		self thread SensorRingT();
		self iprintln("Sensor Man [^6ON^7]");
		self.SensorRing = 1;
		if(self.modelSpawned == false)
			self setclientthirdperson(1);
	}
	else
	{
		self notify("stopRingE");
		self iprintln("Sensor Man [^1OFF^7]");
		self.SensorRing = 0;
		if(self.modelSpawned == false)
			self setclientthirdperson(0);
	}
}
SensorRingT()
{
	self endon("disconnect");
	self endon("stopRingE");
	for(;;)
	{
		playFx( level._effect["FX/for_bubble"], self getTagOrigin( "j_spinelower" ) );
		wait .2;
	}
}
FlareMan()
{
	if(self.FlareMan == 0)
	{
		self thread FlareManT();
		self iprintln("Flare Man [^6ON^7] (comes from feet)");
		self.FlareMan = 1;
		if(self.modelSpawned == false)
			self setclientthirdperson(1);
	}
	else
	{
		self notify("stopFlareE");
		self iprintln("Flare Man [^1OFF^7]");
		self.FlareMan = 0;
		if(self.modelSpawned == false)
			self setclientthirdperson(0);
	}
}
FlareManT()
{
	self endon("disconnect");
	self endon("stopFlareE");
	for(;;)
	{
		self maps/mp/_heatseekingmissile::missiletarget_playflarefx();
		wait .3;
	}
}
VTOLspaceShip()
{
	if(level.VTOLspaceShip == 0)
	{
		level.VTOLspaceShip = 1;
		self iprintlnbold("^5Shoot to spawn in crosshairs!");
		self waittill ("weapon_fired");
		bT = bullettrace(self gettagorigin("j_head"), self gettagorigin("j_head") + anglesToForward(self getplayerangles()) * 1000000, 0, self)["position"];
		
		level.VTOLspace = spawn("script_model", bT + (0,0,450));
		level.VTOLspace setModel("veh_t6_air_v78_vtol_killstreak");
		level.VTOLspace.angles = (270, 0, 0);
		level thread VTOLboardThread();
		wait .1;
		self iprintlnbold("^2Shoot to launch!");
		self waittill ("weapon_fired");
		self iprintlnbold("^6Firing up the VTOL Rockets!");
		wait 1.7;
		self playsound("wpn_semtex_alert");
		self iprintlnbold("^23");
		wait 1;
		self playsound("wpn_semtex_alert");
		self iprintlnbold("^22");
		wait 1;
		self playsound("wpn_semtex_alert");
		self iprintlnbold("^21");
		wait 1;
		self iprintlnbold("^1GOTTA BLAST");
		level.VTOLspace MoveTo(level.VTOLspace.origin + (0,0,8000),10);
		for (i = 1; i <= 100; i++)
		{
			level.VTOLspace maps/mp/_heatseekingmissile::missiletarget_playflarefx();
			playFx( level._effect["FX/for_bubble"], level.VTOLspace.origin + (5,322,0));
			playFx( level._effect["FX/for_bubble"], level.VTOLspace.origin + (5,-322,0));
			wait .1;
		}
		playfx(level._effect["emp_flash"], level.VTOLspace.origin);
		earthquake(.65, 7, level.VTOLspace.origin, 15000);
		foreach(player in level.players)
			player playsound("wpn_emp_bomb");
		wait .05;
		level.VTOLspace delete();
		level.VTOLspaceShip = 0;
		level notify("VTOLspaceExplode");
		foreach(player in level.players)
		{
			player unlink();
			if(player.InRocket == true)
				player suicide();
			player.InRocket = false;
		}
	}
	else
		self iprintlnbold("^1Space Ship already spawned!");
}
VTOLboardThread()
{
	level endon("VTOLspaceExplode");
	for(;;)
	{
		foreach(player in level.players)
		{
			player.VTOLboardText destroy();
			if(distance(player.origin, level.VTOLspace.origin) < 550 && player.InRocket == false)
			{
				player.VTOLboardText = player createFontString("hudbig", 1.8);
				player.VTOLboardText setPoint("TOP", "TOP", 0, 50);
				player.VTOLboardText setText("Press [{+usereload}] ^6to board the ^1VTOL ^2Space ^5Ship!");
				if(player usebuttonpressed() && player.menu.open == false)
				{
					player EnableInvulnerability();
					player PlayerLinkTo(level.VTOLspace);
					player.InRocket = true;
					wait .1;
				}
			}
		}
		wait 0.05;
	}
}
LeoRideHunter()
{
	if(self.ridehunter == false)
	{
		if(self.GM == false)
		{
			self thread godmodeThread();
			self.GMstatus = "[^5ON^7]";
			self modStatusUpdate();
			self iPrintln("God Mode [^6ON^7]");
		}
		self thread doRideHunter();
		self iprintln("^2Ride A Hunter Activated!");
		self iprintln("Press [{+actionslot 1}] To Give Hunter-Killer");
		self.ridehunter = true;
	}
	else
	{
		self notify("end_ridehunter");
		self iPrintln("^1Ride A Hunter Deactivated!");
		self.ridehunter = false;
		self unlink();
	}
}

doRideHunter()
{
	self endon("disconnect");
	self endon("end_ridehunter");
	self giveWeapon( "missile_drone_mp" );
	self switchToWeapon( "missile_drone_mp" );
	for (;;)
	{
		self thread NewRideHunter();
		self waittill("missile_fire", weapon, weapname);
		self PlayerLinkTo(weapon);
		self.weapon waittill("death");
		self detachAll();
		wait 0.05;
	}
}

NewRideHunter()
{
	self endon("disconnect");
	self endon("end_ridehunter");
	for (;;)
	{
		if(self actionSlotOneButtonPressed())
		{
			self giveWeapon( "missile_drone_mp" );
			self switchToWeapon( "missile_drone_mp" );
		}
		wait 0.05;
	}
}

rDeleteGet()
{
	self endon("disconnect");
	self endon("endRDelete");
	for(;;)
	{
		if(isdefined(self.DeleteCrate))
		{
			self.DeleteCrate.origin = self getS(100).end;
			self.DeleteCrate.angles = (0, self.angles[1], self.angles[2]);
		}
		wait .05;
	}
}

rapidDelete()
{
	self endon("disconnect");
	self endon("endRDelete");

	if(self.rapidDelete == 0)
	{
		self.rapidDelete = 1;
		self.rapidDeleteB = true;
		self thread rDeleteGet();
		self iPrintln("Rapid Delete [^6ON^7]");
		self iPrintln("^6ADS ^7on objects to delete them.");
	}
	else
	{
		self.rapidDelete = 0;
		self.rapidDeleteB = false;
		self iPrintln("Rapid Delete [^1OFF^7]");
		self notify("endRDelete");
	}

	while(self.rapidDeleteB == true)
	{
		// && self.menu.open == false
		if(self adsbuttonpressed())
		{
			if(isdefined(self.DeleteCrate))
			{
				self.DeleteCrate delete();
				self.DeleteCrate = undefined;
			}
			else
				self NormalisedTrace("entity") delete();
			self iprintln("^1Object Deleted.");
		}
		wait .05;
	}
}


deadclone()
{
	self iprintln("Dead Clone ^2Spawned.");
	ffdc=self ClonePlayer(9999);
	ffdc startragdoll(1);
}

toggleCentipede()
{
	if (self.centipedeOn == 0)
	{
		self.centipedeOn = 1;
		self thread Centipede();
		self iPrintln("Human Centipede [^6ON^7]");
	}
	else
	{
		self.centipedeOn = 0;
		self notify("stop_centipede");
		self iprintln("Human Centipede [^1OFF^7]");
	}
}

Centipede()
{
	self endon("stop_centipede");
	self endon("disconnect");
	self endon("death");
	for(;;)
	{
		ent=self ClonePlayer(9999999);
		wait .1;
		ent thread destroyModelOnTime(2);
	}
}

destroyModelOnTime(time)
{
	wait(time);
	self delete();
}

walkingLoadestar()
{
	self endon("death");
	self GiveKillstreak("killstreak_remote_mortar");
	self iprintln("^1Walking Lodestar Given!");
	self.Fly = 0;
	UFO = spawn("script_model",self.origin);
	for(;;)
	{
		if(self.Fly == 1)
		{
			self playerLinkTo(UFO);
			self.Fly = 1;
		}
		else
		{
			self unlink();
			self.Fly = 0;
		}
		if(self.Fly == 1)
		{
			Fly = self.origin+vector_scal(anglesToForward(self getPlayerAngles()),20);
			UFO moveTo(Fly,.01);
		}
		wait .001;
	}
}

AutoDropshot()
{
	if(self.Drop == true)
	{
		self thread DropTheBase();
		self iPrintln("Auto Drop-Shot [^6ON^7]");
		self.Drop = false;
	}
	else
	{
		self notify("stop_drop");
		self iPrintln("Auto Drop-Shot [^1OFF^7]");
		self.Drop = true;
	}
}

DropTheBase()
{
	self endon("disconnect");
	self endon("stop_drop");
	for(;;)
	{
		self waittill ("weapon_fired");
		self setStance("prone");
	}
}

PlantBomb()
{
	if(getDvar("g_gametype")=="sd")
	{
		if ( !level.bombplanted )
		{
			level thread maps/mp/gametypes/sd::bombplanted(level.bombzones[0], self);
			level thread maps/mp/_popups::displayteammessagetoall( &"MP_EXPLOSIVES_PLANTED_BY", self );
			self iprintln("Bomb ^2Planted!");
		}
		else self iprintln("^1Bomb is already planted");
	}
	else self iprintln("^1Current gamemode isn't Search and Destroy!");
}
DefuseBomb()
{
	if(getDvar("g_gametype")=="sd")
	{
		if ( level.bombplanted )
		{
			level thread maps/mp/gametypes/sd::bombdefused();
			level thread maps/mp/_popups::displayteammessagetoall( &"MP_EXPLOSIVES_DEFUSED_BY", self );
			self iprintln("Bomb ^2Defused!");
		}
		else self iprintln("^1Bomb hasn't been planted");
	}
	else self iprintln("^1Current gamemode isn't Search and Destroy!");
}

hearallplayers()
{
	if (level.hearall==false)
	{
		self iPrintln("Hear All Players [^6ON^7]");
		setmatchtalkflag( "EveryoneHearsEveryone", 1);
		level.hearall=true;
		level.hearAllStatus = "[^5ON^7]";
		foreach(player in level.players)
			if(player.menu.open == true)
				player modStatusUpdate();
	}
	else
	{
		self iPrintln("Hear All Players [^1OFF^7]");
		setmatchtalkflag( "EveryoneHearsEveryone", 0);
		level.hearall=false;
		level.hearAllStatus = "[^1OFF^7]";
		foreach(player in level.players)
			if(player.menu.open == true)
				player modStatusUpdate();
	}
}

meleerange()
{
	if(level.mele == true)
	{
		h("player_meleeRange", "999");
		level.mele = false;
		self iPrintln("Long-Melee [^6ON^7]");
	}
	else
	{
		h("player_meleeRange", "64");
		level.mele = true;
		self iPrintln("Long-Melee [^1OFF^7]");
	}
}

gravity()
{
	if(self.grav == true)
	{
		h("bg_gravity", "100");
		self.grav = false;
		self iPrintln("Low Gravity [^6ON^7]");
	}
	else
	{
		h("bg_gravity", "800");
		self.grav = true;
		self iPrintln("Low Gravity [^1OFF^7]");
	}
}

GiveKillstreak(killstreak)
{
	self maps/mp/killstreaks/_killstreaks::givekillstreak(maps/mp/killstreaks/_killstreaks::getkillstreakbymenuname( killstreak ) , 5594, true, 5594);
}

BG_giveKS(ks)
{
	self GiveKillstreak(ks);
	self iprintln("^2Killstreak Given!");
}

giveHunt()
{
	self giveWeapon( "missile_drone_mp" );
	self switchToWeapon( "missile_drone_mp" );
	self iPrintln("Hunter Killer Drone Given");
}

giveAG()
{
	self giveWeapon( "ai_tank_drop_mp" );
	self switchToWeapon( "ai_tank_drop_mp" );
	self iPrintln("A.G.R Given");
}

giveCare()
{
	self giveWeapon( "supplydrop_mp" );
	self switchToWeapon( "supplydrop_mp" );
	self iPrintln("Care Package Given");
}

giveGaurd()
{
	self GiveWeapon("microwaveturret_mp");
	self switchToWeapon( "microwaveturret_mp" );
	self iPrintln("Guardian Given");
}

giveSG()
{
	self GiveWeapon("autoturret_mp");
	self switchToWeapon("autoturret_mp");
	self iPrintln("Sentry Gun Given");
}

giveEMP()
{
	self giveWeapon( "emp_mp" );
	self switchToWeapon( "emp_mp" );
	self iPrintln("EMP System Given");
}

giveVW()
{
	self giveWeapon( "helicopter_player_gunner_mp" );
	self switchToWeapon( "helicopter_player_gunner_mp" );
	self iPrintln("VTOL Warship Given");
}

rocketTeleportGun()
{
	self endon("disconnect");
	self endon("death");

	self giveWeapon("usrpg_mp", 0, true( 32, 0, 0, 0, 0 ));
	self switchToWeapon("usrpg_mp");
	for (;;)
	{
		self waittill("missile_fire", weapon, weapname);
		if (weapname == "usrpg_mp")
		{
			self detachAll();
			self PlayerLinkTo(weapon);

			weapon waittill("death");
			self detachAll();
		}
		wait .05;
	}
}

ForgeON()
{
	self.forgeOn=booleanOpposite(self.forgeOn);
	self iPrintln(booleanReturnVal(self.forgeOn,"Forge Mode [^1OFF^7]","Forge Mode [^6ON^7] ^1- ^7Hold [{+speed_throw}] to Move Things!"));
	if(self.forgeOn)
		self thread ForgeModeOn();
	else
		self notify("stop_forge");
}
ForgeModeOn()
{
	self endon("stop_forge");
	for(;;)
	{
		while(self adsbuttonpressed())
		{
			trace=bulletTrace(self GetTagOrigin("j_head"),self GetTagOrigin("j_head")+ anglesToForward(self GetPlayerAngles())* 1000000,true,self);
			while(self adsbuttonpressed())
			{
				trace["entity"] setOrigin(self GetTagOrigin("j_head")+ anglesToForward(self GetPlayerAngles())* 200);
				trace["entity"].origin=self GetTagOrigin("j_head")+ anglesToForward(self GetPlayerAngles())* 200;
				wait .01;
			}
		}
		wait .01;
	}
}

GiveScorestreaksPlayer(player)
{
	self iPrintln("^6Killstreaks Given to ^5" + player.name);
	maps/mp/gametypes/_globallogic_score::_setplayermomentum(player, 5000);
}

initTeamChange()
{
	if(self.pers["team"]=="allies")
	{
		self iPrintlnbold("Team set to ^6axis");
		self changeteam("axis");
	}
	else if(self.pers["team"]=="axis")
	{
		self iPrintlnbold("Team set to ^6allies");
		self changeteam("allies");
	}
}
changeteam(team)
{
	if (self.sessionstate != "dead")
	{
		self.switching_teams = 1;
		self.joining_team = team;
		self.leaving_team = self.pers["team"];
	}
	self.pers["team"] = team;
	self.team = team;
	self.sessionteam = self.pers["team"];
	//if (!level.teambased)
	//	self.ffateam = team;
	self maps/mp/gametypes/_globallogic_ui::updateobjectivetext();
	self maps/mp/gametypes/_spectating::setspectatepermissions();
	self notify("end_respawn");
}

leaderboardPlayer(player)
{
	self iPrintlnbold("^6Gave score stat to ^5" + player.name);
	player addPlayerStat("score", 2147470000);
	wait 3.1;
	kick(player getentitynumber());
}

pauseGame()
{
	self thread maps\mp\gametypes\_hostmigration::callback_hostmigration();
}

abxyToggle()
{
	if(level.abxyLoop == 0)
	{
		level.abxyLoop = 1;
		level thread abxyLoop();
		self iprintln("Minimap Loop [^6ON^7]");
	}
	else
	{
		level notify("stopABXYLoop");
		level MinimapDefault();
		level.abxyLoop = 0;
		self iprintln("Minimap Loop [^1OFF^7]");
	}
}

abxyLoop()
{
	level endon("stopABXYLoop");
	for(;;)
	{
		maps/mp/_compass::setupminimap("xenonbutton_a");
		wait .5;
		maps/mp/_compass::setupminimap("xenonbutton_b");
		wait .5;
		maps/mp/_compass::setupminimap("xenonbutton_x");
		wait .5;
		maps/mp/_compass::setupminimap("xenonbutton_y");
		wait .5;
	}
}

MegaAirDrop()
{
	if(level.MegaAirdrop < 3)
	{
		self thread StartMegaAirDrop();
		level.MegaAirdrop++;
	}
	else
	self iprintln("^1Max number of airdrops spawned.");
}
StartMegaAirDrop()
{
	self endon("disconnect");
	self endon("stopthecp");
	for(;;)
	{
			self iPrintlnbold("^1MEGA-Airdrop Incoming!!");
			wait 1;
			level.CPHeli = spawnHelicopter(self, self.origin + (12000, 0, 1500), self.angles, "heli_guard_mp", "veh_t6_air_v78_vtol_killstreak");
			self thread FollowDudeAirdrop();
			wait 13;
			self thread DropCarePackages();
			wait 39;
			level.CPHeli delete();
			self notify("stopthecp");
	}
	wait 0.05;
}
FollowDudeAirdrop()
{
	for(;;)
	{
		level.CPHeli setSpeed(1000, 25);
		level.CPHeli setVehGoalPos(self.origin + (100, 100, 1500), 1);
		wait .1;
	}
}
DropCarePackages()
{
	for(i = 0; i < 50; i++)
	{
		self thread dropcrate(level.CPHeli.origin + (10, 10, -120), self.angles, "supplydrop_mp", self, self.team, self.killcament, undefined, undefined, undefined);
		wait .5;
	}
}

doXPLobby()
{
	if(level.doXPLobby==false && level.doXPLobbyLOD == false)
	{
		level.doXPLobbyLOD = true;
		level thread checkforfeit();
		self iPrintln("^2Loading....");
		wait 2.5;
		self iPrintln("^2Loading....");
		wait 2.5;
		self iPrintln("^2Loading....");
		wait 2.5;
		self iPrintln("^2Loading....");
		wait 2.5;
		self AllPlayersKickXP();
		self iPrintln("XP Lobby [^6ON^7]");
		level.doXPLobby = true;
		level.doXPLobbyLOD = false;
		if(self.ingame==false)
		{
			self.ingame=true;
			h("scr_dom_scorelimit",0);
			h("scr_sd_numlives",0);
			h("scr_war_timelimit",0);
			h("scr_game_onlyheadshots",0);
			h("scr_war_scorelimit",0);//setDvar("scr_player_forcerespawn",1);
			maps/mp/gametypes/_globallogic_utils::pausetimer();
			self iPrintln("^5Infinite Game [^6ON^7]");
		}
		if(!isDefined(level.SA2))
		{
			level.SA2=level createServerFontString("hudbig",5);
			level.SA2.alignX="middle";
			level.SA2.horzAlign="middle";
			level.SA2.vertAlign="top";
			//level.SA2.x=30;
			level.SA2 setText("^6XP ^5LOBBY");
			level.doheart2=1;
			level.SA2.alpha=1;
			for(;;)
			{
				level.SA2.glowAlpha=1;
				level.SA2.glowColor =(.2,0,1);
				level.SA2 SetPulseFX(40,2000,600);
				wait .7;
				level.SA2.glowAlpha=1;
				level.SA2.glowColor =(1,0,0);
				level.SA2 SetPulseFX(40,2000,600);
				wait .7;
			}
		}
		else if(level.doheart2==0)
		{
			level.doheart2=1;
			level.SA2.alpha=1;
		}
	}
	else
	{
		self iPrintln("XP Lobby [^1OFF^7]");
		level.doXPLobby = false;
		if(level.doheart2==1)
		{
			level.SA2.alpha=0;
			level.doheart2=0;
		}
	}
}

camoLobby()
{
	level.camoLobby=booleanOpposite(level.camoLobby);
	self iPrintln(booleanReturnVal(level.camoLobby,"Camo Lobby [^1OFF^7]","Camo Lobby [^6ON^7] (xp lobby gives camos to people who are level 55/master)"));
}

RoboMan()
{
	self.robman=booleanOpposite(self.robman);
	self iPrintln(booleanReturnVal(self.robman,"Robo Man [^1OFF^7]","Robo Man [^6ON^7]"));
	if(self.robman)
	{
		self attach("t5_veh_rcbomb_gib_med","J_Wrist_RI");
		self attach("t5_veh_rcbomb_gib_med","j_head");
		self attach("t5_veh_rcbomb_gib_med","j_spinelower");
		self attach("t5_veh_rcbomb_gib_med","J_Elbow_RI");
		self attach("t5_veh_rcbomb_gib_med","J_Elbow_LE");
		self attach("t5_veh_rcbomb_gib_med","J_Ankle_LE");
		self attach("t5_veh_rcbomb_gib_med","J_Ankle_RI");
		self attach("t5_veh_rcbomb_gib_med","J_Wrist_RI");
		self attach("t5_veh_rcbomb_gib_med","J_Wrist_LE");
		if(self.modelSpawned == false)
			self setclientthirdperson(1);
	}
	else
	{
		self detach("t5_veh_rcbomb_gib_med","J_Wrist_RI");
		self detach("t5_veh_rcbomb_gib_med","j_head");
		self detach("t5_veh_rcbomb_gib_med","j_spinelower");
		self detach("t5_veh_rcbomb_gib_med","J_Elbow_RI");
		self detach("t5_veh_rcbomb_gib_med","J_Elbow_LE");
		self detach("t5_veh_rcbomb_gib_med","J_Ankle_LE");
		self detach("t5_veh_rcbomb_gib_med","J_Ankle_RI");
		self detach("t5_veh_rcbomb_gib_med","J_Wrist_RI");
		self detach("t5_veh_rcbomb_gib_med","J_Wrist_LE");
		self.tpp = 1;
		if(self.modelSpawned == false)
			self setclientthirdperson(0);
	}
}
weaponModel(m)
{
	if(self.viewModelMemory == 0)
	{
		self.viewmolel_memory = self getViewModel();
		self.viewModelMemory = 1;
	}
	self setViewModel(m);
	self iPrintln("^5View Model set to - ^6" + m);
	if(self isHost())
	{
		h("cg_gun_x", "6");
		h("cg_gun_y", "-6");
		h("cg_gun_z", "-6");
	}
}

printMapModelstogamesmplog()
{
	if (!self.printmodels)
	{
		self.printmodels = true;
		models = getentarray("script_model", "classname");
		for(i = 0; i < models.size; i++)
		{
			models[i] delete();
			self iPrintLn("^1Deleted ^5" + models[i]);
			wait .05;
		}
		self.printmodels = false;
	}
}//find your bo2 folder then its in main/games_mp.log

LBoltTest()
{
	if(self.boltspawn == 0)
	{
		self.boltspawn = 1;
		self iprintlnbold("^6Shoot to spawn in crosshairs!");
		self waittill ("weapon_fired");
		bT = bullettrace(self gettagorigin("j_head"), self gettagorigin("j_head") + anglesToForward(self getplayerangles()) * 1000000, 0, self)["position"];
		lPos = bT + (0,0,1050);
		eA = 0;
		EPos = bT;
		rE = loadfx("weapon/emp/fx_emp_explosion_equip");
		rE2 = loadfx("explosions/fx_exp_equipment_lg");
	
		spawntimedfx(level.fx_smokegrenade_single,bT + (0,0,1030),(0,0,1), 6);
		spawntimedfx(level.fx_smokegrenade_single,bT + (-25,-25,1050),(0,0,1), 6);
		spawntimedfx(level.fx_smokegrenade_single,bT + (25,25,1050),(0,0,1), 6);
		spawntimedfx(level.fx_smokegrenade_single,bT + (-25,25,1050),(0,0,1), 6);
		spawntimedfx(level.fx_smokegrenade_single,bT + (25,-25,1050),(0,0,1), 6);
		
		self iprintlnbold("^1The weather forecast doesn't look too good!");
		wait 3;
		
		foreach(player in level.players)
		{
			player useServerVisionSet(true);
			player SetVisionSetforPlayer("taser_mine_shock", 0);
			wait .07;
			player useServerVisionSet(false);
		}
		
		while(eA < 110)
		{
			playFx( level._effect["prox_grenade_player_shock"], lPos);
			lPos = lPos + (0,0,-10);
			eA++;
		}
		
		//playfx(level._equipment_explode_fx, EPos);
		playfx(rE, EPos);
		playfx(rE2, EPos);
		RadiusDamage(EPos, 70, 99, 35, self, "MOD_PROJECTILE_SPLASH");
		EPos playsound("wpn_flash_grenade_explode");
		self.boltspawn = 0;
	}
	else
		self iprintlnbold("^1Already spawning.");
}

sheSuccMe()
{
	if(level.blowJob == 0 && self.BJspawning == 0)
	{
		self.BJspawning = 1;
		level.blowJob = 1;
		self iprintlnbold("^5Shoot to spawn in crosshairs!");
		self waittill ("weapon_fired");
		bT = bullettrace(self gettagorigin("j_head"), self gettagorigin("j_head") + anglesToForward(self getplayerangles()) * 1000000, 0, self)["position"];
		self.BJspawning = 0;
		self doGuyB(bT);
		self doGirlB(bT);
		level.succGril.angles = (0, 180, 0);
		self endon("endBlowJob");
		self iprintlnbold("^6ooooo he gettin da ^5SUCC ^2OF ^1DICC");
		for(;;)
		{
			level.succGril rotatepitch(10, .5);
			wait .5;
			level.succGril rotatepitch(-10, .5);
			wait .5;
		}
	}
	else
	{
		foreach(player in level.players)
			player notify("endBlowJob");
		level.succGuy delete();
		level.succGril delete();
		level.blowJob = 0;
	}
}

doGirlB(i)
{
	level.succGuy = spawn("script_model", i + (0,0,-2));
	level.succGuy setModel("defaultactor");
}

doGuyB(i)
{
	level.succGril = spawn("script_model", i + (15,0,-32));//-10,,,,
	level.succGril setModel("defaultactor");
}

wait_till_done_playing_vcs()
{
	self endon( "disconnect" );
	for(;;)
	{
		self waittill( "menuresponse", menu, response );
		return;
	}
}

doNukeTownEE()
{
	self closeMenu();
	wait .05;
	self setplayerangles(0,125.8,0);
	self setOrigin(-185.44,415.009,-64.2868);
	wait .1;
	self do_vcs();
}

do_vcs()
{
	screen = getent( "nuketown_tv", "targetname" );
	screen setmodel( "nt_sign_population_vcs" );
	
	if (!isalive( self ) )
		return;
	prevweapon = self getcurrentweapon();
	
	self giveweapon("vcs_controller_mp");
	self switchtoweapon("vcs_controller_mp");
	self setstance("stand");
	placementtag = spawn( "script_model", self.origin );
	placementtag.angles = self.angles;
	self playerlinktoabsolute( placementtag );
	placementtag moveto( targettag.origin, 0.5, 0.05, 0.05 );
	placementtag rotateto( targettag.angles, 0.5, 0.05, 0.05 );
	self enableinvulnerability();
	self openmenu( "vcs" );
	self wait_till_done_playing_vcs();
	if ( !level.gameended )
	{
		if ( isDefined( self ) )
		{
			self disableinvulnerability();
			self unlink();
			self takeweapon( "vcs_controller_mp" );
			self switchtoweapon( prevweapon );
		}
	}
}

camoChallengeAR(i)
{
	self PlaySoundToPlayer("wpn_semtex_alert", self);
	self iprintlnbold("^5Unlocking Camos for - ^2" + i);
	//self addweaponstat(i, "kills", RandomIntRange(400,500));
	//self addweaponstat(i, "deathsDuringUse", RandomIntRange(99,120));
	self addweaponstat(i, "headshots", 100);
	self addweaponstat(i, "longshot_kill", 10);
	self addweaponstat(i, "noAttKills", 150);
	self addweaponstat(i, "noPerkKills", 150);
	self addweaponstat(i, "multikill_2", 20);
	self addweaponstat(i, "killstreak_5", 10);
	wait .1;
	self addweaponstat(i, "primary_mastery", 10000);
	self addweaponstat(i, "secondary_mastery", 10000);
	self addweaponstat(i, "weapons_mastery", 10000);
}
camoChallengeSMG(i)
{
	self PlaySoundToPlayer("wpn_semtex_alert", self);
	self iprintlnbold("^5Unlocking Camos for - ^2" + i);
	//self addweaponstat(i, "kills", RandomIntRange(400,500));
	//self addweaponstat(i, "deathsDuringUse", RandomIntRange(99,120));
	self addweaponstat(i, "headshots", 100);
	self addweaponstat(i, "revenge_kill", 30);
	self addweaponstat(i, "noAttKills", 150);
	self addweaponstat(i, "noPerkKills", 150);
	self addweaponstat(i, "multikill_2", 20);
	self addweaponstat(i, "killstreak_5", 10);
	wait .1;
	self addweaponstat(i, "primary_mastery", 10000);
	self addweaponstat(i, "secondary_mastery", 10000);
	self addweaponstat(i, "weapons_mastery", 10000);
}
camoChallengeSG(i)
{
	self PlaySoundToPlayer("wpn_semtex_alert", self);
	self iprintlnbold("^5Unlocking Camos for - ^2" + i);
	//self addweaponstat(i, "kills", RandomIntRange(200,250));
	//self addweaponstat(i, "deathsDuringUse", RandomIntRange(48,60));
	self addweaponstat(i, "kill_enemy_one_bullet_shotgun", 250);
	self addweaponstat(i, "revenge_kill", 30);
	self addweaponstat(i, "noAttKills", 50);
	self addweaponstat(i, "noPerkKills", 50);
	self addweaponstat(i, "multikill_2", 5);
	self addweaponstat(i, "killstreak_5", 10);
	wait .1;
	self addweaponstat(i, "primary_mastery", 10000);
	self addweaponstat(i, "secondary_mastery", 10000);
	self addweaponstat(i, "weapons_mastery", 10000);
}
camoChallengeLMG(i)
{
	self PlaySoundToPlayer("wpn_semtex_alert", self);
	self iprintlnbold("^5Unlocking Camos for - ^2" + i);
	//self addweaponstat(i, "kills", RandomIntRange(400,500));
	//self addweaponstat(i, "deathsDuringUse", RandomIntRange(99,120));
	self addweaponstat(i, "headshots", 100);
	self addweaponstat(i, "longshot_kill", 10);
	self addweaponstat(i, "noAttKills", 150);
	self addweaponstat(i, "noPerkKills", 150);
	self addweaponstat(i, "multikill_2", 20);
	self addweaponstat(i, "killstreak_5", 10);
	wait .1;
	self addweaponstat(i, "primary_mastery", 10000);
	self addweaponstat(i, "secondary_mastery", 10000);
	self addweaponstat(i, "weapons_mastery", 10000);
}
camoChallengeSniper(i)
{
	self PlaySoundToPlayer("wpn_semtex_alert", self);
	self iprintlnbold("^5Unlocking Camos for - ^2" + i);
	//self addweaponstat(i, "kills", RandomIntRange(400,500));
	//self addweaponstat(i, "deathsDuringUse", RandomIntRange(99,120));
	self addweaponstat(i, "kill_enemy_one_bullet_sniper", 250);
	self addweaponstat(i, "longshot_kill", 10);
	self addweaponstat(i, "noAttKills", 50);
	self addweaponstat(i, "noPerkKills", 50);
	self addweaponstat(i, "multikill_2", 5);
	self addweaponstat(i, "killstreak_5", 10);
	wait .1;
	self addweaponstat(i, "primary_mastery", 10000);
	self addweaponstat(i, "secondary_mastery", 10000);
	self addweaponstat(i, "weapons_mastery", 10000);
}
camoChallengePistol(i)
{
	self PlaySoundToPlayer("wpn_semtex_alert", self);
	self iprintlnbold("^5Unlocking Camos for - ^2" + i);
	//self addweaponstat(i, "kills", RandomIntRange(200,250));
	//self addweaponstat(i, "deathsDuringUse", RandomIntRange(49,59));
	self addweaponstat(i, "headshots", 100);
	self addweaponstat(i, "revenge_kill", 30);
	self addweaponstat(i, "noAttKills", 150);
	self addweaponstat(i, "noPerkKills", 150);
	self addweaponstat(i, "multikill_2", 20);
	self addweaponstat(i, "killstreak_5", 10);
	wait .1;
	self addweaponstat(i, "primary_mastery", 10000);
	self addweaponstat(i, "secondary_mastery", 10000);
	self addweaponstat(i, "weapons_mastery", 10000);
}
camoChallengeRIOT(i)
{
	self PlaySoundToPlayer("wpn_semtex_alert", self);
	self iprintlnbold("^5Unlocking Camos for - ^2" + i);
	self addweaponstat(i, "kills", RandomIntRange(100,110));
	//self addweaponstat(i, "deathsDuringUse", RandomIntRange(10,40));
	//self addweaponstat(i, "kills", 100);
	self addweaponstat(i, "score_from_blocked_damage", 1000);
	self addweaponstat(i, "hatchet_kill_with_shield_equiped", 25);
	self addweaponstat(i, "shield_melee_while_enemy_shooting", 25);
	self addweaponstat(i, "noPerkKills", 25);
	self addweaponstat(i, "noLethalKills", 25);
	wait .1;
	self addweaponstat(i, "primary_mastery", 10000);
	self addweaponstat(i, "secondary_mastery", 10000);
	self addweaponstat(i, "weapons_mastery", 10000);
}
camoChallengeCB(i)
{
	self PlaySoundToPlayer("wpn_semtex_alert", self);
	self iprintlnbold("^5Unlocking Camos for - ^2" + i);
	//self addweaponstat(i, "kills", RandomIntRange(50,70));
	//self addweaponstat(i, "deathsDuringUse", RandomIntRange(20,40));
	self addweaponstat(i, "kills", 300);
	self addweaponstat(i, "multikill_2", 1);
	self addweaponstat(i, "revenge_kill", 5);
	self addweaponstat(i, "kills_from_cars", 1);
	self addweaponstat(i, "killstreak_5", 1);
	self addweaponstat(i, "crossbow_kill_clip", 1);
	wait .1;
	self addweaponstat(i, "primary_mastery", 10000);
	self addweaponstat(i, "secondary_mastery", 10000);
	self addweaponstat(i, "weapons_mastery", 10000);
}
camoChallengeBK(i)
{
	self PlaySoundToPlayer("wpn_semtex_alert", self);
	self iprintlnbold("^5Unlocking Camos for - ^2" + i);
	//self addweaponstat(i, "kills", RandomIntRange(50,70));
	//self addweaponstat(i, "deathsDuringUse", RandomIntRange(20,40));
	self addweaponstat(i, "ballistic_knife_kill", 300);
	self addweaponstat(i, "revenge_kill", 5);
	self addweaponstat(i, "ballistic_knife_melee", 25);
	self addweaponstat(i, "kill_retrieved_blade", 25);
	self addweaponstat(i, "multikill_2", 1);
	self addweaponstat(i, "killstreak_5", 2);
	wait .1;
	self addweaponstat(i, "primary_mastery", 10000);
	self addweaponstat(i, "secondary_mastery", 10000);
	self addweaponstat(i, "weapons_mastery", 10000);
}
camoChallengeCombatK(i)
{
	self PlaySoundToPlayer("wpn_semtex_alert", self);
	self iprintlnbold("^5Unlocking Camos for - ^2" + i);
	//self addweaponstat(i, "kills", RandomIntRange(50,70));
	//self addweaponstat(i, "deathsDuringUse", RandomIntRange(20,40));
	self addweaponstat(i, "kills", 200);
	self addweaponstat(i, "backstabber_kill", 10);
	self addweaponstat(i, "kill_enemy_when_injured", 5);
	self addweaponstat(i, "revenge_kill", 5);
	self addweaponstat(i, "kill_enemy_with_their_weapon", 5);
	self addweaponstat(i, "killstreak_5", 5);
	wait .1;
	self addweaponstat(i, "primary_mastery", 10000);
	self addweaponstat(i, "secondary_mastery", 10000);
	self addweaponstat(i, "weapons_mastery", 10000);
}
camoChallengeSMAW(i)
{
	self PlaySoundToPlayer("wpn_semtex_alert", self);
	self iprintlnbold("^5Unlocking Camos for - ^2" + i);
	//self addweaponstat(i, "kills", RandomIntRange(50,70));
	//self addweaponstat(i, "deathsDuringUse", RandomIntRange(20,40));
	self addweaponstat(i, "destroyed_aircraft", 100);
	self addweaponstat(i, "direct_hit_kills", 10);
	self addweaponstat(i, "destroyed_5_aircraft", 1);
	self addweaponstat(i, "kills_from_cars", 1);
	self addweaponstat(i, "multikill_2", 5);
	self addweaponstat(i, "destroyed_qrdrone", 1);
	wait .1;
	self addweaponstat(i, "primary_mastery", 10000);
	self addweaponstat(i, "secondary_mastery", 10000);
	self addweaponstat(i, "weapons_mastery", 10000);
}
camoChallengeFHJ(i)
{
	self PlaySoundToPlayer("wpn_semtex_alert", self);
	self iprintlnbold("^5Unlocking Camos for - ^2" + i);
	//self addweaponstat(i, "deathsDuringUse", RandomIntRange(20,40));
	self addweaponstat(i, "destroyed_aircraft", 100);
	self addweaponstat(i, "destroyed_aircraft_under20s", 10);
	self addweaponstat(i, "destroyed_5_aircraft", 1);
	self addweaponstat(i, "destroyed_2aircraft_quickly", 1);
	self addweaponstat(i, "destroyed_controlled_killstreak", 10);
	self addweaponstat(i, "destroyed_aitank", 1);
	wait .1;
	self addweaponstat(i, "primary_mastery", 10000);
	self addweaponstat(i, "secondary_mastery", 10000);
	self addweaponstat(i, "weapons_mastery", 10000);
}
camoChallengeRPG(i)
{
	self PlaySoundToPlayer("wpn_semtex_alert", self);
	self iprintlnbold("^5Unlocking Camos for - ^2" + i);
	//self addweaponstat(i, "kills", RandomIntRange(50,70));
	//self addweaponstat(i, "deathsDuringUse", RandomIntRange(20,40));
	self addweaponstat(i, "kills", 100);
	self addweaponstat(i, "direct_hit_kills", 10);
	self addweaponstat(i, "destroyed_aircraft", 1);
	self addweaponstat(i, "kills_from_cars", 1);
	self addweaponstat(i, "multikill_2", 5);
	self addweaponstat(i, "multikill_3", 1);
	wait .1;
	self addweaponstat(i, "primary_mastery", 10000);
	self addweaponstat(i, "secondary_mastery", 10000);
	self addweaponstat(i, "weapons_mastery", 10000);
}
beep1()
{
	self PlaySoundToPlayer("wpn_semtex_alert", self);
	self iprintlnbold("^5Unlocking Challenges....");
}
unlockEverything()
{
	//self addPlayerStat("kills", 270);
	//wait .1;
	self beep1();
	self addPlayerStat("score", 550000);
	wait .1;
	self beep1();
	self addPlayerStat("time_played_total", 50000);
	wait .1;
	self beep1();
	self addgametypestat( "killstreak_10", 2244 );
	wait .1;
	self beep1();
	self addgametypestat( "killstreak_15", 1542 );
	wait .1;
	self beep1();
	self addgametypestat( "killstreak_20", 733 );
	wait .1;
	self beep1();
	self addgametypestat( "killstreak_30", 72 );
	wait .1;
	self beep1();
	self addweaponstat( "dogs_mp", "used", 21 );
	wait .1;
	self beep1();
	self addweaponstat( "emp_mp", "used", 23 );
	wait .1;
	self beep1();
	self addweaponstat( "missile_drone_mp", "used", 38 );
	wait .1;
	self beep1();
	self addweaponstat( "missile_swarm_mp", "used", 13 );
	wait .1;
	self beep1();
	self addweaponstat( "planemortar_mp", "used", 39 );
	wait .1;
	self beep1();
	self addweaponstat( "killstreak_qrdrone_mp", "used", 39 );
	wait .1;
	self beep1();
	self addweaponstat( "remote_missile_mp", "used", 28 );
	wait .1;
	self beep1();
	self addweaponstat( "remote_mortar_mp", "used", 38 );
	wait .1;
	self beep1();
	self addweaponstat( "straferun_mp", "used", 21 );
	wait .1;
	self beep1();
	self addweaponstat( "supplydrop_mp", "used", 18 );
	wait .1;
	self beep1();
	self addweaponstat( "ai_tank_drop_mp", "used", 12 );
	wait .1;
	self beep1();
	self addweaponstat( "acoustic_sensor_mp", "used", 22 );
	wait .1;
	self beep1();
	self addweaponstat( "qrdrone_turret_mp", "destroyed", 23 );
	wait .1;
	self beep1();
	self addweaponstat( "rcbomb_mp", "destroyed", 21 );
	wait .1;
	self beep1();
	self addweaponstat( "qrdrone_turret_mp", "used", 23 );
	wait .1;
	self beep1();
	self addweaponstat( "rcbomb_mp", "used", 43 );
	wait .1;
	self beep1();
	self addweaponstat( "microwaveturret_mp", "used", 13 );
	wait .1;
	self beep1();
	self addweaponstat( "autoturret_mp", "used", 14 );
	wait .1;
	self beep1();
	self addweaponstat( "helicopter_player_gunner_mp", "used", 17 );
	wait .1;
	self beep1();
	self addweaponstat( "missile_drone_mp", "destroyed", 173 );
	wait .1;
	self beep1();
	self addweaponstat( "missile_swarm_mp", "destroyed", 84 );
	wait .1;
	self beep1();
	self addweaponstat( "planemortar_mp", "destroyed", 413 );
	wait .1;
	self beep1();
	self addweaponstat( "killstreak_qrdrone_mp", "destroyed", 634 );
	wait .1;
	self beep1();
	self addweaponstat( "remote_missile_mp", "destroyed", 535 );
	wait .1;
	self beep1();
	self addweaponstat( "remote_mortar_mp", "destroyed", 824 );
	wait .1;
	self beep1();
	self addweaponstat( "straferun_mp", "destroyed", 485 );
	wait .1;
	self beep1();
	self addweaponstat( "supplydrop_mp", "destroyed", 556 );
	wait .1;
	self beep1();
	self addweaponstat( "ai_tank_drop_mp", "destroyed", 302 );
	wait .1;
	self beep1();
	self addweaponstat( "acoustic_sensor_mp", "destroyed", 1002 );
	wait .1;
	self beep1();
	self addweaponstat( "microwaveturret_mp", "destroyed", 923 );
	wait .1;
	self beep1();
	self addweaponstat( "autoturret_mp", "destroyed", 994 );
	wait .1;
	self beep1();
	self addweaponstat( "helicopter_player_gunner_mp", "destroyed", 1017 );
	wait .1;
	self beep1();
	self addgametypestat( "round_win_no_deaths", 831 );
	wait .1;
	self beep1();
	self addgametypestat( "last_man_defeat_3_enemies", 323 );
	wait .1;
	self beep1();
	self addgametypestat( "CRUSH", 623 );
	wait .1;
	self beep1();
	self addgametypestat( "most_kills_least_deaths", 143 );
	wait .1;
	self beep1();
	self addgametypestat( "SHUT_OUT", 434 );
	wait .1;
	self beep1();
	self addgametypestat( "ANNIHILATION", 321 );
	wait .1;
	self beep1();
	self addgametypestat( "kill_2_enemies_capturing_your_objective", 351 );
	wait .1;
	self beep1();
	self addgametypestat( "capture_b_first_minute", 234 );
	wait .1;
	self beep1();
	self addgametypestat( "immediate_capture", 346 );
	wait .1;
	self beep1();
	self addgametypestat( "contest_then_capture", 692 );
	wait .1;
	self beep1();
	self addgametypestat( "both_bombs_detonate_10_seconds", 56 );
	wait .1;
	self beep1();
	self addgametypestat( "multikill_3", 294 );
	wait .1;
	self beep1();
	self addgametypestat( "kill_enemy_who_killed_teammate", 3423 );
	wait .1;
	self beep1();
	self addgametypestat( "kill_enemy_injuring_teammate", 511 );
	wait .1;
	self beep1();
	self addgametypestat( "defused_bomb_last_man_alive", 245 );
	wait .1;
	self beep1();
	self addgametypestat( "elimination_and_last_player_alive", 232 );
	wait .1;
	self beep1();
	self addgametypestat( "killed_bomb_planter", 234 );
	wait .1;
	self beep1();
	self addgametypestat( "killed_bomb_defuser", 341 );
	wait .1;
	self beep1();
	self addgametypestat( "kill_flag_carrier", 131 );
	wait .1;
	self beep1();
	self addgametypestat( "defend_flag_carrier", 112 );
	wait .1;
	self beep1();
	self addgametypestat( "killed_bomb_planter", 162 );
	wait .1;
	self beep1();
	self addgametypestat( "killed_bomb_defuser", 152 );
	wait .1;
	self beep1();
	self addgametypestat( "kill_flag_carrier", 114 );
	wait .1;
	self beep1();
	self addgametypestat( "defend_flag_carrier", 183 );
	wait .1;
	self beep1();
	self addplayerstat( "reload_then_kill_dualclip", 823 );
	wait .1;
	self beep1();
	self addplayerstat( "kill_with_remote_control_ai_tank", 628 );
	wait .1;
	self beep1();
	self addplayerstat( "killstreak_5_with_sentry_gun", 152 );
	wait .1;
	self beep1();
	self addplayerstat( "kill_with_remote_control_sentry_gun", 523 );
	wait .1;
	self beep1();
	self addplayerstat( "killstreak_5_with_death_machine", 345 );
	wait .1;
	self beep1();
	self addplayerstat( "kill_enemy_locking_on_with_chopper_gunner", 52 );
	wait .1;
	self beep1();
	self addplayerstat( "kill_with_loadout_weapon_with_3_attachments", 523 );
	wait .1;
	self beep1();
	self addplayerstat( "kill_with_both_primary_weapons", 652 );
	wait .1;
	self beep1();
	self addplayerstat( "kill_with_2_perks_same_category", 134 );
	wait .1;
	self beep1();
	self addplayerstat( "kill_while_uav_active", 824 );
	wait .1;
	self beep1();
	self addplayerstat( "kill_while_cuav_active", 878 );
	wait .1;
	self beep1();
	self addplayerstat( "kill_while_satellite_active", 524 );
	wait .1;
	self beep1();
	self addplayerstat( "kill_after_tac_insert", 239 );
	wait .1;
	self beep1();
	self addplayerstat( "kill_enemy_revealed_by_sensor", 54 );
	wait .1;
	self beep1();
	self addplayerstat( "kill_while_emp_active", 423 );
	wait .1;
	self beep1();
	self addplayerstat( "survive_claymore_kill_planter_flak_jacket_equipped", 235 );
	wait .1;
	self beep1();
	self addplayerstat( "killstreak_5_dogs", 34 );
	wait .1;
	self beep1();
	self addplayerstat( "kill_flashed_enemy", 453 );
	wait .1;
	self beep1();
	self addplayerstat( "kill_concussed_enemy", 343 );
	wait .1;
	self beep1();
	self addplayerstat( "kill_enemy_who_shocked_you", 232 );
	wait .1;
	self beep1();
	self addplayerstat( "kill_shocked_enemy", 632 );
	wait .1;
	self beep1();
	self addplayerstat( "shock_enemy_then_stab_them", 824 );
	wait .1;
	self beep1();
	self addplayerstat( "mantle_then_kill", 874 );
	wait .1;
	self beep1();
	self addplayerstat( "kill_enemy_with_picked_up_weapon", 822 );
	wait .1;
	self beep1();
	self addplayerstat( "killstreak_5_picked_up_weapon", 564 );
	wait .1;
	self beep1();
	self addplayerstat( "kill_enemy_shoot_their_explosive", 124 );
	wait .1;
	self beep1();
	self addplayerstat( "kill_enemy_while_crouched", 1324 );
	wait .1;
	self beep1();
	self addplayerstat( "kill_enemy_while_prone", 1182 );
	wait .1;
	self beep1();
	self addplayerstat( "kill_prone_enemy", 1122 );
	wait .1;
	self beep1();
	self addplayerstat( "kill_every_enemy", 1213 );
	wait .1;
	self beep1();
	self addplayerstat( "pistolHeadshot_10_onegame", 1123 );
	wait .1;
	self beep1();
	self addplayerstat( "headshot_assault_5_onegame", 143 );
	wait .1;
	self beep1();
	self addplayerstat( "kill_enemy_one_bullet_sniper", 1754 );
	wait .1;
	self beep1();
	self addplayerstat( "kill_10_enemy_one_bullet_sniper_onegame", 2341 );
	wait .1;
	self beep1();
	self addplayerstat( "kill_enemy_one_bullet_shotgun", 415 );
	wait .1;
	self beep1();
	self addplayerstat( "kill_10_enemy_one_bullet_shotgun_onegame", 321 );
	wait .1;
	self beep1();
	self addplayerstat( "kill_enemy_with_tacknife", 961 );
	wait .1;
	self beep1();
	self addplayerstat( "KILL_CROSSBOW_STACKFIRE", 241 );
	wait .1;
	self beep1();
	self addplayerstat( "hatchet_kill_with_shield_equiped", 741 );
	wait .1;
	self beep1();
	self addplayerstat( "kill_with_claymore", 361 );
	wait .1;
	self beep1();
	self addplayerstat( "kill_with_hacked_claymore", 317 );
	wait .1;
	self beep1();
	self addplayerstat( "kill_with_c4", 121 );
	wait .1;
	self beep1();
	self addplayerstat( "kill_enemy_withcar", 341 );
	wait .1;
	self beep1();
	self addplayerstat( "stick_explosive_kill_5_onegame", 121 );
	wait .1;
	self beep1();
	self addplayerstat( "kill_with_cooked_grenade", 123 );
	wait .1;
	self beep1();
	self addplayerstat( "kill_with_tossed_back_lethal", 155 );
	wait .1;
	self beep1();
	self addplayerstat( "kill_with_dual_lethal_grenades", 123 );
	wait .1;
	self beep1();
	self addplayerstat( "perk_movefaster_kills", 153 );
	wait .1;
	self beep1();
	self addplayerstat( "perk_noname_kills", 112 );
	wait .1;
	self beep1();
	self addplayerstat( "perk_quieter_kills", 1500 );
	wait .1;
	self beep1();
	self addplayerstat( "perk_longersprint", 123 );
	wait .1;
	self beep1();
	self addplayerstat( "perk_fastmantle_kills", 2457 );
	wait .1;
	self beep1();
	self addplayerstat( "perk_loudenemies_kills", 2457 );
	wait .1;
	self beep1();
	self addplayerstat( "perk_protection_stun_kills", 2457 );
	wait .1;
	self beep1();
	self addplayerstat( "perk_immune_cuav_kills", 2457 );
	wait .1;
	self beep1();
	self addplayerstat( "perk_gpsjammer_immune_kills", 2457 );
	wait .1;
	self beep1();
	self addplayerstat( "perk_fastweaponswitch_kill_after_swap", 2457 );
	wait .1;
	self beep1();
	self addplayerstat( "perk_scavenger_kills_after_resupply", 2457 );
	wait .1;
	self beep1();
	self addplayerstat( "perk_flak_survive", 2457 );
	wait .1;
	self beep1();
	self addplayerstat( "perk_earnmoremomentum_earn_streak", 2457 );
	wait .1;
	self beep1();
	self addplayerstat( "kill_enemy_through_wall", 2457 );
	wait .1;
	self beep1();
	self addplayerstat( "kill_enemy_through_wall_with_fmj", 2457 );
	wait .1;
	self beep1();
	self addplayerstat( "disarm_hacked_carepackage", 2457 );
	wait .1;
	self beep1();
	self addplayerstat( "destroy_car", 2457 );
	wait .1;
	self beep1();
	self addplayerstat( "kill_nemesis", 2457 );
	wait .1;
	self beep1();
	self addplayerstat( "kill_while_damaging_with_microwave_turret", 2457 );
	wait .1;
	self beep1();
	self addplayerstat( "long_distance_hatchet_kill", 2457 );
	wait .1;
	self beep1();
	self addplayerstat( "activate_cuav_while_enemy_satelite_active", 2457 );
	wait .1;
	self beep1();
	self addplayerstat( "longshot_3_onelife", 2457 );
	wait .1;
	self beep1();
	self addplayerstat( "get_final_kill", 5057 );
	wait .1;
	self beep1();
	self addplayerstat( "destroy_rcbomb_with_hatchet", 2457 );
	wait .1;
	self beep1();
	self addplayerstat( "defend_teammate_who_captured_package", 2457 );
	wait .1;
	self beep1();
	self addplayerstat( "destroy_score_streak_with_qrdrone", 2457 );
	wait .1;
	self beep1();
	self addplayerstat( "capture_objective_in_smoke", 2457 );
	wait .1;
	self beep1();
	self addplayerstat( "perk_hacker_destroy", 2457 );
	wait .1;
	self beep1();
	self addplayerstat( "destroy_equipment_with_emp_grenade", 1021 );
	wait .1;
	self beep1();
	self addplayerstat( "destroy_equipment", 2857 );
	wait .1;
	self beep1();
	self addplayerstat( "destroy_5_tactical_inserts", 2457 );
	wait .1;
	self beep1();
	self addplayerstat( "kill_15_with_blade", 2457 );
	wait .1;
	self beep1();
	self addplayerstat( "destroy_explosive", 2457 );
	wait .1;
	self beep1();
	self addplayerstat( "assist", 20457 );
	wait .1;
	self beep1();
	self addplayerstat( "assist_score_microwave_turret", 25500 );
	wait .1;
	self beep1();
	self addplayerstat( "assist_score_killstreak", 155050 );
	wait .1;
	self beep1();
	self addplayerstat( "assist_score_cuav", 137020 );
	wait .1;
	self beep1();
	self addplayerstat( "assist_score_uav", 114020 );
	wait .1;
	self beep1();
	self addplayerstat( "assist_score_satellite", 100480 );
	wait .1;
	self beep1();
	self addplayerstat( "assist_score_emp", 39940 );
	wait .1;
	self beep1();
	self addplayerstat( "multikill_3_near_death", 4924 );
	wait .1;
	self beep1();
	self addplayerstat( "multikill_3_lmg_or_smg_hip_fire", 8774 );
	wait .1;
	self beep1();
	self addplayerstat( "killed_dog_close_to_teammate", 3943 );
	wait .1;
	self beep1();
	self addplayerstat( "multikill_2_zone_attackers", 2592 );
	wait .1;
	self beep1();
	self addplayerstat( "muiltikill_2_with_rcbomb", 1923 );
	wait .1;
	self beep1();
	self addplayerstat( "multikill_3_remote_missile", 3282 );
	wait .1;
	self beep1();
	self addplayerstat( "multikill_3_with_mgl", 2001 );
	wait .1;
	self beep1();
	self addplayerstat( "destroy_turret", 3924 );
	wait .1;
	self beep1();
	self addplayerstat( "call_in_3_care_packages", 1934 );
	wait .1;
	self beep1();
	self addplayerstat( "destroyed_helicopter_with_bullet", 734 );
	wait .1;
	self beep1();
	self addplayerstat( "destroy_qrdrone", 1695 );
	wait .1;
	self beep1();
	self addplayerstat( "destroyed_qrdrone_with_bullet", 2457 );
	wait .1;
	self beep1();
	self addplayerstat( "destroy_helicopter", 1993 );
	wait .1;
	self beep1();
	self addplayerstat( "destroy_aircraft_with_emp", 2457 );
	wait .1;
	self beep1();
	self addplayerstat( "destroy_aircraft_with_missile_drone", 2457 );
	wait .1;
	self beep1();
	self addplayerstat( "perk_nottargetedbyairsupport_destroy_aircraft", 2457 );
	wait .1;
	self beep1();
	self addplayerstat( "destroy_aircraft", 1993 );
	wait .1;
	self beep1();
	self addplayerstat( "killstreak_10_no_weapons_perks", 2457 );
	wait .1;
	self beep1();
	self addplayerstat( "kill_with_resupplied_lethal_grenade", 2457 );
	wait .1;
	self beep1();
	self addplayerstat( "stun_aitank_with_emp_grenade", 223 );
	wait .1;
	self beep1();
	self addweaponstat( "willy_pete_mp", "CombatRecordStat", 123 );
	wait .1;
	self beep1();
	self addweaponstat( "emp_grenade_mp", "combatRecordStat", 232 );
	wait .1;
	self beep1();
	self addweaponstat( "counteruav_mp", "assists", 323 );
	wait .1;
	self beep1();
	self addweaponstat( "radar_mp", "assists", 242 );
	wait .1;
	self beep1();
	self addweaponstat( "radardirection_mp", "assists", 103 );
	wait .1;
	self beep1();
	self addweaponstat( "emp_mp", "assists", 74 );
	wait .1;
	//self beep1();
	//self addweaponstat( "nightingale_mp", "used", 1133 );
	//wait .1;
	//self beep1();
	//self addweaponstat( "flash_grenade_mp", "hits", 183 );
	//wait .1;
	//self beep1();
	//self addweaponstat( "flash_grenade_mp", "used", 439 );
	//wait .1;
	//self beep1();
	//self addweaponstat( "pda_hack_mp", "used", 294 );
	//wait .1;
	//self beep1();
	//self addweaponstat( "proximity_grenade_mp", "used", 623 );
	//wait .1;
	//self beep1();
	//self addweaponstat( "scrambler_mp", "used", 521 );
	//wait .1;
	//self beep1();
	//self addweaponstat( "sensor_grenade_mp", "used", 2942 );
	//wait .1;
	//self beep1();
	//self addweaponstat( "willy_pete_mp", "used", 2457 );
	//wait .1;
	//self beep1();
	//self addweaponstat( "tactical_insertion_mp", "used", 2043 );
	//wait .1;
	//self beep1();
	//self addweaponstat( "trophy_system_mp", "used", 642 );
	wait .2;
	//self addweaponstat( "trophy_system_mp", "CombatRecordStat", 2457 );
	self PlaySoundToPlayer("mus_lau_rank_up", self);
	self iprintlnbold("^6Challenge Unlocking Complete!");
	wait 2;
}
camonlock()///////////////////////////////////
{
	if(self.CamoUnlocking == false)
	{
		self.CamoUnlocking = true;
		self EnableInvulnerability();
		self.GMstatus = "[^5ON^7]";
		self modStatusUpdate();
		self unlockEverything();
		self thread camoChallengeSG("870mcs_mp");
		wait .6;
		self thread camoChallengeAR("an94_mp");
		wait .6;
		self thread camoChallengeSniper("as50_mp");
		wait .6;
		self thread camoChallengeSniper("ballista_mp");
		wait .6;
		self thread camoChallengePistol("beretta93r_mp");
		wait .6;
		self thread camoChallengeCB("crossbow_mp");
		wait .6;
		self thread camoChallengeSniper("dsr50_mp");
		wait .6;
		self thread camoChallengeSMG("evoskorpion_mp");
		wait .6;
		self thread camoChallengePistol("fiveseven_mp");
		wait .6;
		self thread camoChallengeFHJ("fhj18_mp");
		wait .6;
		self thread camoChallengePistol("fnp45_mp");
		wait .6;
		self thread camoChallengeLMG("hamr_mp");
		wait .6;
		self thread camoChallengeAR("hk416_mp");
		wait .6;
		self thread camoChallengeSMG("insas_mp");
		wait .6;
		self thread camoChallengePistol("judge_mp");
		wait .6;
		self thread camoChallengePistol("kard_mp");
		wait .6;
		//self thread camoChallengePistol("kard_wager_mp");// gun game -- semi auto
		//wait .6;
		self thread camoChallengeBK("knife_ballistic_mp");
		wait .6;
		self thread camoChallengeCombatK("knife_held_mp");
		wait .6;
		//self thread unlockallcamos("knife_mp");
		//wait .6;
		self thread camoChallengeSG("ksg_mp");
		wait .6;
		self thread camoChallengeLMG("lsat_mp");
		wait .6;
		self thread camoChallengeLMG("mk48_mp");
		wait .6;
		self thread camoChallengeSMG("mp7_mp");
		wait .6;
		self thread camoChallengeSMG("pdw57_mp");
		wait .6;
		self thread camoChallengeSMG("peacekeeper_mp");
		wait .6;
		self thread camoChallengeLMG("qbb95_mp");
		wait .6;
		self thread camoChallengeSMG("qcw05_mp");
		wait .6;
		self thread camoChallengeRIOT("riotshield_mp");
		wait .6;
		self thread camoChallengeAR("sa58_mp");
		wait .6;
		self thread camoChallengeSG("saiga12_mp");
		wait .6;
		self thread camoChallengeAR("saritch_mp");
		wait .6;
		self thread camoChallengeSMG("vector_mp");
		wait .6;
		self thread camoChallengeAR("scar_mp");
		wait .6;
		self thread camoChallengeAR("sig556_mp");
		wait .6;
		self thread camoChallengeSMAW("smaw_mp");
		wait .6;
		self thread camoChallengeSG("srm1216_mp");
		wait .6;
		self thread camoChallengeSniper("svu_mp");
		wait .6;
		self thread camoChallengeAR("tar21_mp");
		wait .6;
		self thread camoChallengeAR("type95_mp");
		wait .6;
		self thread camoChallengeRPG("usrpg_mp");
		wait .6;
		self thread camoChallengeAR("xm8_mp");
		self PlaySoundToPlayer("mus_lau_rank_up", self);
		wait .5;
		self iprintlnbold("^6Camo/Challenge Unlocking Complete. Please wait 15 seconds to be kicked.");
		wait 3.5;
		self iprintlnbold("^1You only get diamond for weapons you have unlocked.");
		wait 3.5;
		self iprintlnbold("^5Improved Script made by ^6Jiggy^1777");
		wait 8;
		if(!self ishost())
		{
			self iprintlnbold("^1Kicking...");
			wait .8;
			kick(self getentitynumber());
		}
	}
}

stalkOFF()
{
	self notify("x2Toggle");
	self iprintln("MLG Stock [^1OFF^7]");
	self.stalker = false;
}

Quake()
{
	self iPrintln("^1Boom Boom Shake The Room!");
	earthquake(0.6,10,self.origin,100000);
}

setHealth(health)
{
	self iPrintln("^5Health Set to - ^6" + health);
	self.healthSet = health;
	self.maxhealth=health;
	self.health=self.maxhealth;
	if(self.health<self.maxhealth)self.health=self.maxhealth;
}/*

Juggernog()
{
	if(self.JNog1k==false)
	{
		self iPrintln("^1Juggernog (1000) [^6ON^7]");
		self.maxhealth=1000;
		self.health=self.maxhealth;
		if(self.health<self.maxhealth)self.health=self.maxhealth;
		self.JNog=false;
		self.JNog1k=true;
	}
	else
	{
		self iPrintln("^1Juggernog [^1OFF^7]");
		self.maxhealth=100;
		self.health=self.maxhealth;
		self.JNog1k=false;
	}
}
*/
Juggernog250()
{
	if(self.JNog==false)
	{
		self iPrintln("^5Health Set to - ^6250");
		self.maxhealth=250;
		self.healthSet=250;
		self.health=self.maxhealth;
		if(self.health<self.maxhealth)self.health=self.maxhealth;
		//self.JNog1k=false;
		self.JNog=true;
	}
	else
	{
		self iPrintln("^5Health Set to - ^6100");
		self.maxhealth=100;
		self.healthSet=100;
		self.health=self.maxhealth;
		self.JNog=false;
	}
}

unlockAchieve()
{
	self endon("disconnect");
	self iPrintln("^2Unlocking Achievements....");
	trophyList = strtok("SP_COMPLETE_ANGOLA,SP_COMPLETE_MONSOON,SP_COMPLETE_AFGHANISTAN,SP_COMPLETE_NICARAGUA,SP_COMPLETE_PAKISTAN,SP_COMPLETE_KARMA,SP_COMPLETE_PANAMA,SP_COMPLETE_YEMEN,SP_COMPLETE_BLACKOUT,SP_COMPLETE_LA,SP_COMPLETE_HAITI,SP_VETERAN_PAST,SP_VETERAN_FUTURE,SP_ONE_CHALLENGE,SP_ALL_CHALLENGES_IN_LEVEL,SP_ALL_CHALLENGES_IN_GAME,SP_RTS_DOCKSIDE,SP_RTS_AFGHANISTAN,SP_RTS_DRONE,SP_RTS_CARRIER,SP_RTS_PAKISTAN,SP_RTS_SOCOTRA,SP_STORY_MASON_LIVES,SP_STORY_HARPER_FACE,SP_STORY_FARID_DUEL,SP_STORY_OBAMA_SURVIVES,SP_STORY_LINK_CIA,SP_STORY_HARPER_LIVES,SP_STORY_MENENDEZ_CAPTURED,SP_MISC_ALL_INTEL,SP_STORY_CHLOE_LIVES,SP_STORY_99PERCENT,SP_MISC_WEAPONS,SP_BACK_TO_FUTURE,SP_MISC_10K_SCORE_ALL,MP_MISC_1,MP_MISC_2,MP_MISC_3,MP_MISC_4,MP_MISC_5,ZM_DONT_FIRE_UNTIL_YOU_SEE,ZM_THE_LIGHTS_OF_THEIR_EYES,ZM_DANCE_ON_MY_GRAVE,ZM_STANDARD_EQUIPMENT_MAY_VARY,ZM_YOU_HAVE_NO_POWER_OVER_ME,ZM_I_DONT_THINK_THEY_EXIST,ZM_FUEL_EFFICIENT,ZM_HAPPY_HOUR,ZM_TRANSIT_SIDEQUEST,ZM_UNDEAD_MANS_PARTY_BUS,ZM_DLC1_HIGHRISE_SIDEQUEST,ZM_DLC1_VERTIGONER,ZM_DLC1_I_SEE_LIVE_PEOPLE,ZM_DLC1_SLIPPERY_WHEN_UNDEAD,ZM_DLC1_FACING_THE_DRAGON,ZM_DLC1_IM_MY_OWN_BEST_FRIEND,ZM_DLC1_MAD_WITHOUT_POWER,ZM_DLC1_POLYARMORY,ZM_DLC1_SHAFTED,ZM_DLC1_MONKEY_SEE_MONKEY_DOOM,ZM_DLC2_PRISON_SIDEQUEST,ZM_DLC2_FEED_THE_BEAST,ZM_DLC2_MAKING_THE_ROUNDS,ZM_DLC2_ACID_DRIP,ZM_DLC2_FULL_LOCKDOWN,ZM_DLC2_A_BURST_OF_FLAVOR,ZM_DLC2_PARANORMAL_PROGRESS,ZM_DLC2_GG_BRIDGE,ZM_DLC2_TRAPPED_IN_TIME,ZM_DLC2_POP_GOES_THE_WEASEL,ZM_DLC3_WHEN_THE_REVOLUTION_COMES,ZM_DLC3_FSIRT_AGAINST_THE_WALL,ZM_DLC3_MAZED_AND_CONFUSED,ZM_DLC3_REVISIONIST_HISTORIAN,ZM_DLC3_AWAKEN_THE_GAZEBO,ZM_DLC3_CANDYGRAM,ZM_DLC3_DEATH_FROM_BELOW,ZM_DLC3_IM_YOUR_HUCKLEBERRY,ZM_DLC3_ECTOPLASMIC_RESIDUE,ZM_DLC3_BURIED_SIDEQUEST", ",");
	foreach(trophy in trophyList)
	{
		self giveAchievement(trophy);
		wait .1;
	}
}

aimBot()
{
	if (self.aimTog==false)
	{
		self iPrintln("Unfair-Aimbot [^6ON^7]");
		self thread UnfairAimBot();
		self.aimTog=true;
	}
	else
	{
		self iPrintln("Unfair-Aimbot [^1OFF^7]");
		self notify("uaimBotoff");
		self.aimTog=false;
	}
}

UnfairAimBot()
{
	self endon( "disconnect" );
	self endon( "death" );
	self endon( "uaimBotoff" );

	for(;;)
	{
		aimAt = undefined;
		foreach(player in level.players)
		{
			if((player == self) || (!isAlive(player)) || (level.teamBased && self.pers["team"] == player.pers["team"]) || player.status == "Co-Host" || player.status == "Host" || player.status == "VIP")
			continue;
			if(isDefined(aimAt))
			{
				if(closer(self getTagOrigin("j_head"), player getTagOrigin("j_head"), aimAt getTagOrigin("j_head")))
				aimAt = player;
			}
			else aimAt = player;
		}
		if(isDefined(aimAt))
		{
			if(self adsbuttonpressed())
			{
				self setplayerangles(VectorToAngles((aimAt getTagOrigin("j_head")) - (self getTagOrigin("j_head"))));
				if(self attackbuttonpressed())
					aimAt thread [[level.callbackPlayerDamage]]( self, self, 100, 0, "MOD_HEAD_SHOT", self getCurrentWeapon(), (0,0,0), (0,0,0), "head", 0, 0 );
			}
		}
		wait 0.02;
	}
}

Inf_Game()
{
	if(self.ingame==false)
	{
		self.ingame=true;
		h("scr_dom_scorelimit",0);
		h("scr_sd_numlives",0);
		h("scr_war_timelimit",0);
		h("scr_game_onlyheadshots",0);
		h("scr_war_scorelimit",0);
		maps/mp/gametypes/_globallogic_utils::pausetimer();
		self iPrintln("Infinite Game [^6ON^7]");
	}
	else
	{
		self maps/mp/gametypes/_globallogic_utils::resumetimer();
		self iPrintln("Infinite Game [^1OFF^7]");
		self.ingame=false;
	}
}

EV()
{
	if(self.ev == true)
	{
		self useServerVisionSet(true);
		self SetVisionSetforPlayer("remote_mortar_enhanced", 0);
		self iPrintln("Enhanced Vision [^6ON^7]");
		self.ev = false;
	}
	else
	{
		self useServerVisionSet(false);
		self iPrintln("Enhanced Vision [^1OFF^7]");
		self.ev = true;
	}
}

TV()
{
	if(self.tv == true)
	{
		self useServerVisionSet(false);
		self setinfraredvision(1);
		self iPrintln("Thermal [^6ON^7]");
		self.tv = false;
	}
	else
	{
		self useServerVisionSet(false);
		self setinfraredvision(0);
		self iPrintln("Thermal [^1OFF^7]");
		self.tv = true;
	}
}

BWV()
{
	if(self.bw == true)
	{
		self useServerVisionSet(true);
		self SetVisionSetforPlayer("mpintro", 0);
		self iPrintln("Black and White [^6ON^7]");
		self.bw = false;
	}
	else
	{
		self useServerVisionSet(false);
		self iPrintln("Black and White [^1OFF^7]");
		self.bw = true;
	}
}

LVisOnOff()
{
	foreach(player in level.players)
	{
		player useServerVisionSet(true);
		player SetVisionSetforPlayer("taser_mine_shock", 0);
		wait .1;
		player useServerVisionSet(false);
	}
}

LVis()
{
	if(self.lv == true)
	{
		self useServerVisionSet(true);
		self SetVisionSetforPlayer("taser_mine_shock", 0);
		self iPrintln("Light Vision [^6ON^7]");
		self.lv = false;
	}
	else
	{
		self useServerVisionSet(false);
		self iPrintln("Light Vision [^1OFF^7]");
		self.lv = true;
	}
}

empVision()
{
	if (self.empTog == true)
	{
		self setempjammed( true );
		self iPrintln("EMP Vision [^6ON^7]");
		self.empTog = false;
	}
	else
	{
		self setempjammed( false );
		self iPrintln("EMP Vision ^7[^2OFF^7]");
		self.empTog = true;
	}
}

mpoutro()
{
	visionsetnaked("mpoutro", 1);
}

defaultVision()
{
	visionsetnaked("default", 1);
	self setempjammed( false );
	self setinfraredvision(0);
	self useServerVisionSet(false);
	self.empTog = true;
	self.lv = true;
	self.bw = true;
	self.tv = true;
	self.ev = true;
}

remote_mortar_infrared()
{
	visionsetnaked("remote_mortar_infrared", 1);
}

taser_mine_shock()
{
	visionsetnaked("taser_mine_shock", 1);
}

initJericho()
{
	level.waypointGreen = loadFX("misc/fx_equip_tac_insert_light_grn");
	level.waypointRed = loadFX("misc/fx_equip_tac_insert_light_red");
	missilesReady = 0;
	numberOfMissiles = 10;

	self iPrintlnbold("^5Fire To Select Nodes");
	while(missilesReady != numberOfMissiles)
	{
		self waittill("weapon_fired");
		target = traceBullet();
		mFx = spawnFx(level.waypointGreen, target, (0, 0, 1), (1, 0, 0));
		triggerFx(mFx);
		self thread spawnJerichoMissile(target, mFx);
		missilesReady++;
	}
	self iPrintlnbold("^5All Missile Paths Initialized, Fire Your Weapon To Launch!");
	self waittill("weapon_fired");
	self notify("launchMissiles");
}

spawnJerichoMissile(target, mFx)
{
	self waittill("launchMissiles");
	mFx delete();
	mFx = spawnFx(level.waypointRed, target, (0, 0, 1), (1, 0, 0));
	triggerFx(mFx);

	location = target+(0, 3500, 5000);

	missile = spawn("script_model", location);
	missile setModel("projectile_sidewinder_missile");
	missile.angles = missile.angles+(90, 90, 90);
	missile.killcament = missile;
	missile rotateto(VectorToAngles(target - missile.origin), 0.01);
	wait 0.01;

	time = 3;
	endLocation = BulletTrace(missile.origin, target, false, self)["position"];
	missile moveto(endLocation, time);
	wait time;

	self playsound("wpn_rocket_explode");
	playFx(level.remote_mortar_fx["missileExplode"], missile.origin+(0, 0, 1));
	RadiusDamage(missile.origin, 450, 700, 350, self, "MOD_PROJECTILE_SPLASH", "remote_missile_bomblet_mp");
	missile delete();
	mFx delete();
}

dobig()
{
	if(self.BG == true)
	{
		self iPrintln("Big Names [^6ON^7]");
		h("cg_overheadnamessize", "2");
		self.BG = false;
	}
	else
	{
		self iPrintln("Big Names [^1OFF^7]");
		h("cg_overheadnamessize", "0.65");
		self.BG = true;
	}
}

togglecars()
{
	if(level.carrain==true)
	{
		self thread raincars();
		level.carrain=false;
		self iPrintln("Rain Cars [^6ON^7]");
	}
	else
	{
		self notify("cardefaultR");
		level.carrain=true;
		self iPrintln("Rain Cars [^1OFF^7]");
	}
}

raincars()
{
	self endon("disconnect");
	self endon("cardefaultR");
	for(;;)
	{
		x = randomintrange(-2000,2000);
		y = randomintrange(-2000,2000);
		z = randomintrange(1100,1200);
		obj5 = spawn("script_model",(x,y,z));
		level.Entities[level.amountOfEntities] = obj5;
		level.amountOfEntities++;
		obj5 setmodel("defaultvehicle");
		obj5 PhysicsLaunch();
		obj5 thread DeleteOverTime();
		wait .1;
	}
	wait .05;
}

toggledebugs()
{
	if(level.debugrain==true)
	{
		self thread raindebugs();
		level.debugrain=false;
		self iPrintln("Rain Debugs [^6ON^7]");
	}
	else
	{
		self notify("debugdefaultR");
		level.debugrain=true;
		self iPrintln("Rain Debugs [^1OFF^7]");
	}
}

raindebugs()
{
	self endon("disconnect");
	self endon("debugdefaultR");
	for(;;)
	{
		x = randomintrange(-2000,2000);
		y = randomintrange(-2000,2000);
		z = randomintrange(1100,1200);
		obj6 = spawn("script_model",(x,y,z));
		level.Entities[level.amountOfEntities] = obj6;
		level.amountOfEntities++;
		obj6 setmodel("defaultactor");
		obj6 PhysicsLaunch();
		obj6 thread DeleteOverTime();
		wait .1;
	}
	wait .05;
}

DoSky()
{
	if(self.SkyColor==0)
	{
		self iPrintln("^2Sky - ^61");
		h("r_skyColorTemp", "1234");
		self.SkyColor=1;
	}
	else
	if(self.SkyColor==1)
	{
		self iPrintln("^2Sky - ^62");
		self.SkyColor=2;
		h("r_skyColorTemp", "2345");
	}
	else
	if(self.SkyColor==2)
	{
		self iPrintln("^2Sky - ^63");
		self.SkyColor=3;
		h("r_skyColorTemp", "4567");
	}
	else
	if(self.SkyColor==3)
	{
		self iPrintln("^2Sky - ^64");
		self.SkyColor=4;
		h("r_skyColorTemp", "5678");
	}
	else
	if(self.SkyColor==4)
	{
		self iPrintln("^2Sky - ^65");
		self.SkyColor = 5;
		h("r_skyColorTemp", "9101112");
	}
	else
	if(self.SkyColor==5)
	{
		self iPrintln("^2Sky - ^66");
		self.SkyColor = 6;
		h("r_skyColorTemp", "1011213");
	}
	else
	if(self.SkyColor==6)
	{
		self iPrintln("^2Sky - ^67");
		self.SkyColor = 0;
		h("r_skyColorTemp", "0000");
	}
}

rapidFire()
{
	self endon("disconnect");

	self.underfire = booleanOpposite(self.underfire);
	self iPrintln(booleanReturnVal(self.underfire, "Rapid Fire [^1OFF^7]", "Rapid Fire [^6ON^7]"));

	if(self.underfire)
	{
		h("perk_weapRateMultiplier", "0.001");
		h("perk_weapReloadMultiplier", "0.001");
		h("perk_fireproof", "0.001");
		h("cg_weaponSimulateFireAnims", "0.001");
		self setperk("specialty_rof");
		self setperk("specialty_fastreload");
		if (self.ammunition)
			self.ammunition = false;
	}
	else
	{
		h("perk_weapRateMultiplier", "1");
		h("perk_weapReloadMultiplier", "1");
		h("perk_fireproof", "1");
		h("cg_weaponSimulateFireAnims", "1");
		self unsetperk("specialty_rof");
		self unsetperk("specialty_fastreload");
	}
}

ShowFPS()
{
	if(self.ShowFps==0)
	{
		self.ShowFps=1;
		self iPrintln("FPS [^6ON^7]");
		h( "cg_drawFPS", "1" );
		h( "cg_drawBigFPS", "1" );
	}
	else
	{
		self.ShowFps=0;
		self iPrintln("FPS [^1OFF^7]");
		h( "cg_drawFPS", "0" );
		h( "cg_drawBigFPS", "0" );
	}
}/*

Show2D()
{
	if(self.Show2D==0)
	{
		self.Show2D=1;
		self iPrintln("draw2D [^6ON^7]");
		h( "cg_draw2D", "1" );
	}
	else
	{
		self.Show2D=0;
		self iPrintln("draw2D [^1OFF^7]");
		h( "cg_draw2D", "0" );
	}
}

ShowVersion()
{
	if(self.ShowVersion==0)
	{
		self.ShowVersion=1;
		self iPrintln("drawVersion [^6ON^7]");
		h( "cg_drawVersion", "1" );
	}
	else
	{
		self.ShowVersion=0;
		self iPrintln("drawVersion [^1OFF^7]");
		h( "cg_drawVersion", "0" );
	}
}
*/
vSync()
{
	if(self.TogVSync==0)
	{
		self.TogVSync=1;
		self iPrintln("VSync [^1OFF^7]");
		h("r_vsync", "0");
	}
	else
	{
		self.TogVSync=0;
		self iPrintln("VSync [^6ON^7]");
		h("r_vsync", "1");
	}
}

FPSLimit()
{
	if(self.TogFPSL==0)
	{
		self.TogFPSL=1;
		self iPrintln("FPS Limit [^1OFF^7]");
		h("com_maxfps", "5000");
	}
	else
	{
		self.TogFPSL=0;
		self iPrintln("FPS Limit [^6ON^7]");
		h("com_maxfps", "60");
	}
}

UFOstoggle()
{
	if (self.UFO == true)
	{
		self.UFO = false;
		self thread NiggaUFO();
		self iPrintln("UFO [^6ON^7]");
	}
	else
	{
		self.UFO = true;
		self notify("stop_UFO");
		self iprintln("UFO [^1OFF^7]");
	}
}

NiggaUFO()
{
	self endon ( "disconnect" );
	self endon("stop_UFO");
	for(;;)
	{
		playFx( level._effect["fx_mp_nuke_ufo_fly"], self getTagOrigin( "j_head" ) );
		playFx( level._effect["fx_mp_nuke_ufo_fly"], self getTagOrigin( "j_spineupper" ) );
		playFx( level._effect["fx_mp_nuke_ufo_fly"], self getTagOrigin( "j_spinelower" ) );
		playFx( level._effect["fx_mp_nuke_ufo_fly"], self getTagOrigin( "j_spine4" ) );
		playFx( level._effect["fx_mp_nuke_ufo_fly"], self getTagOrigin( "j_spine1" ) );
		playFx( level._effect["fx_mp_nuke_ufo_fly"], self getTagOrigin( "J_Elbow_RI" ) );
		playFx( level._effect["fx_mp_nuke_ufo_fly"], self getTagOrigin( "J_Elbow_LE" ) );
		playFx( level._effect["fx_mp_nuke_ufo_fly"], self getTagOrigin( "j_knee_le" ) );
		playFx( level._effect["fx_mp_nuke_ufo_fly"], self getTagOrigin( "j_knee_ri" ) );
		playFx( level._effect["fx_mp_nuke_ufo_fly"], self getTagOrigin( "J_Ankle_LE" ) );
		playFx( level._effect["fx_mp_nuke_ufo_fly"], self getTagOrigin( "J_Ankle_RI" ) );
		playFx( level._effect["fx_mp_nuke_ufo_fly"], self getTagOrigin( " J_Wrist_RI" ) );
		playFx( level._effect["fx_mp_nuke_ufo_fly"], self getTagOrigin( " J_Wrist_LE" ) );
		wait .2;
	}
}

RiotMan()
{
	if (self.riotMan == 0)
	{
		self.riotMan = 1;
		if(self.modelSpawned == false)
			self setclientthirdperson(1);
		self iPrintln("Riot Man [^6ON^7]");
		self giveWeapon("riotshield_mp",0);
		self switchToWeapon( "riotshield_mp" );
		self AttachShieldModel("t6_wpn_shield_carry_world","back_low");
		self giveWeapon("riotshield_mp",0);
		self switchToWeapon( "riotshield_mp" );
		self AttachShieldModel("t6_wpn_shield_carry_world","j_head");
		self giveWeapon("riotshield_mp",0);
		self switchToWeapon( "riotshield_mp" );
		self AttachShieldModel("t6_wpn_shield_carry_world","tag_weapon_left");
	}
	else
	{
		if(self.modelSpawned == false)
			self setclientthirdperson(0);
		self.riotMan = 0;
		self takeWeapon( "riotshield_mp" );
		self AttachShieldModel("t6_wpn_shield_carry_world","back_low");
		self takeWeapon( "riotshield_mp" );
		self AttachShieldModel("t6_wpn_shield_carry_world","j_head");
		self takeWeapon( "riotshield_mp" );
		self AttachShieldModel("t6_wpn_shield_carry_world","tag_weapon_left");
		self iprintln("Riot Man [^1OFF^7]");
	}
}

initdafuck()
{
	if (self.dafuckOn == 0)
	{
		self.dafuckOn = 1;
		self thread dodafuck();
		self iPrintln("Electric Man [^6ON^7]");
	}
	else
	{
		self.dafuckOn = 0;
		self notify("stop_dafuck");
		self iprintln("Electric Man [^1OFF^7]");
	}
}
dodafuck()
{
	self endon ( "disconnect" );
	self endon("stop_dafuck");
	for(;;)
	{
		playFx( level._effect["prox_grenade_player_shock"], self getTagOrigin( "j_head" ) );
		playFx( level._effect["prox_grenade_player_shock"], self getTagOrigin( "j_spineupper" ) );
		playFx( level._effect["prox_grenade_player_shock"], self getTagOrigin( "j_spinelower" ) );
		playFx( level._effect["prox_grenade_player_shock"], self getTagOrigin( "j_spine4" ) );
		playFx( level._effect["prox_grenade_player_shock"], self getTagOrigin( "j_spine1" ) );
		playFx( level._effect["prox_grenade_player_shock"], self getTagOrigin( "J_Elbow_RI" ) );
		playFx( level._effect["prox_grenade_player_shock"], self getTagOrigin( "J_Elbow_LE" ) );
		playFx( level._effect["prox_grenade_player_shock"], self getTagOrigin( "j_knee_le" ) );
		playFx( level._effect["prox_grenade_player_shock"], self getTagOrigin( "j_knee_ri" ) );
		playFx( level._effect["prox_grenade_player_shock"], self getTagOrigin( "J_Ankle_LE" ) );
		playFx( level._effect["prox_grenade_player_shock"], self getTagOrigin( "J_Ankle_RI" ) );
		playFx( level._effect["prox_grenade_player_shock"], self getTagOrigin( " J_Wrist_RI" ) );
		playFx( level._effect["prox_grenade_player_shock"], self getTagOrigin( " J_Wrist_LE" ) );
		wait .15;
	}
}

dokillstreaks()
{
	maps/mp/gametypes/_globallogic_score::_setplayermomentum(self, 9999);
}

Earthquake_gun()
{
	if(!isDefined(self.isEarthQuake))
		self.isEarthQuake = true;
	else
	{
		self notify("endEarthquakeGun");
		self.isEarthQuake = undefined;
	}
	self iPrintln("^5Earthquake Gun "+boolTxt(self.isEarthQuake));
	
	self endon("endEarthquakeGun");
	while(isDefined(self.isEarthQuake))
	{
		self waittill("weapon_fired");
		position = bullettrace(self gettagorigin("j_head"), self gettagorigin("j_head") + anglesToForward(self getplayerangles()) * 1000000, 0, self)["position"];
		earthquake(0.6, 10, position, 99999);
		self iPrintln("^5Earthquake at: ^7(^2"+position+"^7)");
	}
}
boolTxt(var)
{
	if(!isDefined(var))
	return "[^1OFF^7]";
	else
	return "[^6ON^7]";
}
doJetPack()
{
	if( self.jetpack == false )
	{
		self thread StartJetPack();
		self iPrintln("JetPack [^6ON^7]");
		self iPrintln("Hold [{+gostand}] to Fly!");
		self.jetpack = true;
	}
	else if(self.jetpack == true)
	{
		self.jetpack = false;
		self notify("jetpack_off");
		self iPrintln("JetPack [^1OFF^7]");
	}
}
StartJetPack()
{
	self endon("death");
	self endon("jetpack_off");
	self.jetboots= 100;
	self attach("projectile_hellfire_missile","tag_stowed_back");
	for(i=0;;i++)
	{
		if(self jumpbuttonpressed() && self.jetboots>0)
		{
			self playsound( "veh_huey_chaff_explo_npc" );
			playFX( level._effect[ "flak20_fire_fx" ], self getTagOrigin( "J_Ankle_RI" ) );
			playFx( level._effect[ "flak20_fire_fx" ], self getTagOrigin( "J_Ankle_LE" ) );
			earthquake(.15,.2,self gettagorigin("j_spine4"),50);
			self.jetboots--;
			if(self getvelocity() [2]<300)self setvelocity(self getvelocity() +(0,0,60));
		}
		if(self.jetboots<100 &&!self usebuttonpressed() )self.jetboots++;
		wait .05;
	}
}

initMW2Nuke()
{
	if(level.isMW2Nuke == 0)
	{
		self thread doMW2Nuke();
		self iPrintln("^5MW2 Nuke ^7- [^2Requested^7]");
		level.isMW2Nuke = 1;
	}
	else
	self iPrintln("^3Nuclear missile ^1is already incoming!");
}

doMW2Nuke()
{
	self thread closeMenu();
	self thread startNukeMessage();
	self thread waitNukePressed();
}

startNukeMessage()
{
	self endon("disconnect");
	self endon("stop_MW2Nuke_StartMessage");
	self endon("end_MW2Nuke");

	for(;;)
	{
		MessageNukeIcon = createRectangle("CENTER", "CENTER", -700, -180, "mp_hud_cluster_status", 100, 100, (1, 1, 1), 1, 1);
		self.MessageNukeReady = self createText("default", 2, "MW2 Nuke Kill Streak!", "CENTER", "CENTER", -700, -150, 1, true, 1, (1, 1, 1), 1, (0, 1, 0));
		self.MessageNukeHowTo = self createText("default", 1.3, "Press [{+frag}] for Tactical Nuke.", "CENTER", "CENTER", -700, -130, 1, true, 1, (1, 1, 1));

		wait .05;

		self PlaySound("wpn_remote_missile_inc");
		MessageNukeIcon elemMoveX(.3, 0);
		self.MessageNukeReady elemMoveX(.3, 0);
		self.MessageNukeHowTo elemMoveX(.3, 0);

		wait 1.5;
		self PlaySound("wpn_remote_missile_fire_boost");

		wait 5.5;

		MessageNukeIcon elemMoveX(.3, 700);
		self.MessageNukeReady elemMoveX(.3, 700);
		self.MessageNukeHowTo elemMoveX(.3, 700);

		wait .3;

		MessageNukeIcon destroy();
		self.MessageNukeReady destroy();
		self.MessageNukeHowTo destroy();

		self notify("stop_MW2Nuke_StartMessage");
	}
}

waitNukePressed()
{
	self endon("disconnect");
	self endon("stop_MW2Nuke_WaitTime");
	self endon("end_MW2Nuke");

	self takeallweapons();
	self giveWeapon("satchel_charge_mp", 0, false);
	self setWeaponAmmoStock("satchel_charge_mp", 0);
	self setWeaponAmmoClip("satchel_charge_mp", 0);

	for(;;)
	{
		if(self FragButtonPressed())
		{
			wait .7;
			self thread nukeMissileThread();
			foreach(player in level.players)
			{
				player thread countdownNuke();
			}
			self notify("stop_MW2Nuke_WaitTime");
		}
		wait .05;
	}
}

countdownNuke()
{
	self endon("disconnect");
	self endon("stop_MW2Nuke_Countdown");
	self endon("end_MW2Nuke");

	self thread optionCalledMesage("^3Nuclear Missile ^1Inbound!!", 1, "^0Get Inside To Cover!!!", (1, 0, .5), 7);

	for(;;)
	{
		self PlaySoundToPlayer("wpn_semtex_alert", self);
		self.NukeCountdown = self createText("hudbig", 10, "10", "CENTER", "CENTER", 0, 0, 1, true, 0, (1, 1, 1), 1, (1, .5, .2));
		self.NukeCountdown elemFade(.1, 1);
		self.NukeCountdown scaleFont(.3, 2.5);

		wait 1;
		self.NukeCountdown destroy();
		self PlaySoundToPlayer("wpn_semtex_alert", self);
		self.NukeCountdown = self createText("hudbig", 10, "9", "CENTER", "CENTER", 0, 0, 1, true, 0, (1, 1, 1), 1, (1, .5, .2));
		self.NukeCountdown elemFade(.1, 1);
		self.NukeCountdown scaleFont(.3, 2.5);

		wait 1;
		self.NukeCountdown destroy();
		self PlaySoundToPlayer("wpn_semtex_alert", self);
		self.NukeCountdown = self createText("hudbig", 10, "8", "CENTER", "CENTER", 0, 0, 1, true, 0, (1, 1, 1), 1, (1, .5, .2));
		self.NukeCountdown elemFade(.1, 1);
		self.NukeCountdown scaleFont(.3, 2.5);

		wait 1;
		self.NukeCountdown destroy();
		self PlaySoundToPlayer("wpn_semtex_alert", self);
		self.NukeCountdown = self createText("hudbig", 10, "7", "CENTER", "CENTER", 0, 0, 1, true, 0, (1, 1, 1), 1, (1, .5, .2));
		self.NukeCountdown elemFade(.1, 1);
		self.NukeCountdown scaleFont(.3, 2.5);

		wait 1;
		self.NukeCountdown destroy();
		self PlaySoundToPlayer("wpn_semtex_alert", self);
		self.NukeCountdown = self createText("hudbig", 10, "6", "CENTER", "CENTER", 0, 0, 1, true, 0, (1, 1, 1), 1, (1, .5, .2));
		self.NukeCountdown elemFade(.1, 1);
		self.NukeCountdown scaleFont(.3, 2.5);

		wait 1;
		self.NukeCountdown destroy();
		self PlaySoundToPlayer("wpn_semtex_alert", self);
		self.NukeCountdown = self createText("hudbig", 10, "5", "CENTER", "CENTER", 0, 0, 1, true, 0, (1, 1, 1), 1, (1, .5, .2));
		self.NukeCountdown elemFade(.1, 1);
		self.NukeCountdown scaleFont(.3, 2.5);

		wait 1;
		self.NukeCountdown destroy();
		self PlaySoundToPlayer("wpn_semtex_alert", self);
		self.NukeCountdown = self createText("hudbig", 10, "4", "CENTER", "CENTER", 0, 0, 1, true, 0, (1, 1, 1), 1, (1, .5, .2));
		self.NukeCountdown elemFade(.1, 1);
		self.NukeCountdown scaleFont(.3, 2.5);

		wait 1;
		self.NukeCountdown destroy();
		self PlaySoundToPlayer("wpn_semtex_alert", self);
		self.NukeCountdown = self createText("hudbig", 10, "3", "CENTER", "CENTER", 0, 0, 1, true, 0, (1, 1, 1), 1, (1, .5, .2));
		self.NukeCountdown elemFade(.1, 1);
		self.NukeCountdown scaleFont(.3, 2.5);

		wait 1;
		self.NukeCountdown destroy();
		self PlaySoundToPlayer("wpn_semtex_alert", self);
		self.NukeCountdown = self createText("hudbig", 10, "2", "CENTER", "CENTER", 0, 0, 1, true, 0, (1, 1, 1), 1, (1, .5, .2));
		self.NukeCountdown elemFade(.1, 1);
		self.NukeCountdown scaleFont(.3, 2.5);

		wait 1;
		self.NukeCountdown destroy();
		self PlaySoundToPlayer("wpn_semtex_alert", self);
		self.NukeCountdown = self createText("hudbig", 10, "1", "CENTER", "CENTER", 0, 0, 1, true, 0, (1, 1, 1), 1, (1, .5, .2));
		self.NukeCountdown elemFade(.1, 1);
		self.NukeCountdown scaleFont(.3, 2.5);

		wait .7;
		self.NukeCountdown elemFade(.3, 0);
		wait .3;
		self.NukeCountdown destroy();
		self PlaySoundToPlayer("wpn_c4_activate_plr", self);
		self PlaySoundToPlayer("evt_helicopter_spin_start", self);
		self PlaySoundToPlayer("wpn_a10_drop_chaff", self);
		self notify("stop_MW2Nuke_Countdown");
	}
}

nukeMissileThread()
{
	self endon("disconnect");
	self endon("stop_MW2Nuke_MissileThread");
	self endon("end_MW2Nuke");

	MissileLocation = self.origin + VectorScale(AnglesToForward((0, self getPlayerAngles()[1], self getPlayerAngles()[2])), 4000);

	for(;;)
	{
		nukeMissile = spawn("script_model", MissileLocation + (0, 0, 20000));
		nukeMissile setModel("projectile_sa6_missile_desert_mp");
		nukeMissile.angles = (90, 90, 90);
		self thread MW2NukeFireEffect(nukeMissile);

		nukeMissile2 = spawn("script_model", MissileLocation + (500, 500, 22000));
		nukeMissile2 setModel("projectile_sa6_missile_desert_mp");
		nukeMissile2.angles = (90, 90, 90);
		self thread MW2NukeFireEffect(nukeMissile2);

		nukeMissile3 = spawn("script_model", MissileLocation + (-500, -500, 22000));
		nukeMissile3 setModel("projectile_sa6_missile_desert_mp");
		nukeMissile3.angles = (90, 90, 90);
		self thread MW2NukeFireEffect(nukeMissile3);

		nukeMissile4 = spawn("script_model", MissileLocation + (500, 0, 24000));
		nukeMissile4 setModel("projectile_sa6_missile_desert_mp");
		nukeMissile4.angles = (90, 90, 90);
		self thread MW2NukeFireEffect(nukeMissile4);

		nukeMissile5 = spawn("script_model", MissileLocation + (0, 500, 24000));
		nukeMissile5 setModel("projectile_sa6_missile_desert_mp");
		nukeMissile5.angles = (90, 90, 90);
		self thread MW2NukeFireEffect(nukeMissile5);

		nukeMissile6 = spawn("script_model", MissileLocation + (-500, 0, 24000));
		nukeMissile6 setModel("projectile_sa6_missile_desert_mp");
		nukeMissile6.angles = (90, 90, 90);
		self thread MW2NukeFireEffect(nukeMissile6);

		nukeMissile7 = spawn("script_model", MissileLocation + (0, -500, 24000));
		nukeMissile7 setModel("projectile_sa6_missile_desert_mp");
		nukeMissile7.angles = (90, 90, 90);
		self thread MW2NukeFireEffect(nukeMissile7);

		wait .05;

		nukeMissile moveto(nukeMissile.origin + (0, 0, -18000), 10.5);
		nukeMissile2 moveto(nukeMissile2.origin + (0, 0, -18000), 10.5);
		nukeMissile3 moveto(nukeMissile3.origin + (0, 0, -18000), 10.5);
		nukeMissile4 moveto(nukeMissile4.origin + (0, 0, -18000), 10.5);
		nukeMissile5 moveto(nukeMissile5.origin + (0, 0, -18000), 10.5);
		nukeMissile6 moveto(nukeMissile6.origin + (0, 0, -18000), 10.5);
		nukeMissile7 moveto(nukeMissile7.origin + (0, 0, -18000), 10.5);
		wait 10.6;
		self notify("stop_MW2Nuke_FireEffect");

		level._effect["emp_flash"] = loadfx("weapon/emp/fx_emp_explosion");
		playfx(level._effect["emp_flash"], nukeMissile.origin);
		playfx(level._effect["emp_flash"], nukeMissile2.origin);
		playfx(level._effect["emp_flash"], nukeMissile3.origin);
		playfx(level._effect["emp_flash"], nukeMissile4.origin);
		playfx(level._effect["emp_flash"], nukeMissile5.origin);
		playfx(level._effect["emp_flash"], nukeMissile6.origin);
		playfx(level._effect["emp_flash"], nukeMissile7.origin);

		foreach(player in level.players)
			player playsound("wpn_emp_bomb");
		earthquake(.6, 7, nukeMissile.origin, 12345);
		earthquake(.6, 7, nukeMissile2.origin, 12345);
		earthquake(.6, 7, nukeMissile3.origin, 12345);
		earthquake(.6, 7, nukeMissile4.origin, 12345);
		earthquake(.6, 7, nukeMissile5.origin, 12345);
		earthquake(.6, 7, nukeMissile6.origin, 12345);
		earthquake(.6, 7, nukeMissile7.origin, 12345);

		wait .5;
		h("timescale", "0.9");
		wait .6;
		h("timescale", "0.8");
		wait .7;
		h("timescale", "0.7");
		wait .8;
		h("timescale", "0.6");
		nukeMissile4 RadiusDamage(nukeMissile4.origin, 20000, 20000, 20000, self);
		nukeMissile5 RadiusDamage(nukeMissile5.origin, 20000, 20000, 20000, self);
		nukeMissile6 RadiusDamage(nukeMissile6.origin, 20000, 20000, 20000, self);
		nukeMissile7 RadiusDamage(nukeMissile7.origin, 20000, 20000, 20000, self);
		nukeMissile delete();
		nukeMissile2 delete();
		nukeMissile3 delete();
		nukeMissile4 delete();
		nukeMissile5 delete();
		nukeMissile6 delete();
		nukeMissile7 delete();
		wait .9;
		h("timescale", "0.5");

		foreach(player in level.players)
			player suicide();

		wait .1;
		h("timescale", "0.6");
		wait .1;
		h("timescale", "0.7");
		wait .1;
		h("timescale", "0.8");
		wait .1;
		h("timescale", "0.9");
		wait .1;
		h("timescale", "1");

		self thread nukeGameEnd();
		self notify("stop_MW2Nuke_MissileThread");
	}
}

MW2NukeFireEffect(object)
{
	self endon("disconnect");
	self endon("stop_MW2Nuke_FireEffect");
	self endon("end_MW2Nuke");

	level._effect["torch"] = loadfx("maps/mp_maps/fx_mp_exp_rc_bomb");
	for(;;)
	{
		PlayFX(level._effect["torch"], object.origin + (0, 0, 120));
		wait .1;
	}
}

nukeGameEnd()
{
	foreach(player in level.players)
		player notify("end_MW2Nuke");
	level thread endgame("win", "^1Tactical Nuke");
}

weaponModelDef()
{
	self.viewModelMemory = 0;
	self setViewModel(self.viewmolel_memory);
	if(self isHost())
	{
		h("cg_gun_x", "0");
		h("cg_gun_y", "0");
		h("cg_gun_z", "0");
	}
}

Platform()
{
	location = self.origin;
	while (isDefined(self.spawnedcrate[0][0]))
	{
		i = -3;
		while (i < 3)
		{
			d = -3;
			while (d < 3)
			{
				self.spawnedcrate[i][d] delete();
				d++;
			}
			i++;
		}
	}
	startpos = location + (0, 0, -15);
	i = -3;
	while (i < 3)
	{
		d = -3;
		while (d < 3)
		{
			self.spawnedcrate[i][d] = spawn("script_model", startpos + (d * 40, i * 70, 0));
			self.spawnedcrate[i][d] setmodel("t6_wpn_supply_drop_axis");
			d++;
		}
		i++;
	}
	//self.origin = (startpos + (0, 0, 5));
	//offset = (0,0,1255);
	//self thread godmodeThread();
	//self iPrintln("God Mode ^7[^6ON^7]");
	//self.GM = true;
	//self.GMstatus = "[^6ON^7]";
	//self modStatusUpdate();
	//wait .05;
	//self setOrigin(startpos + (0,0,10));
}
selfOriginGet()
{
	for(;;)
	{
		self iprintln("self.origin - ^5" + self.origin);
		wait .5;
	}
	wait .5;
}
selfAnglesGet()
{
	for(;;)
	{
		self iprintln("self.angles - ^2" + self.angles);
		wait .5;
	}
	wait .5;
}
initRaygun()
{
	if(self.isRaygun == 0)
	{
		self initGiveWeap("judge_mp+reflex", "", 43, 0);
		self thread doRaygun();
		self iPrintln("Raygun [^6ON^7]");
		self thread optionCalledMesage("You get ^2Raygun^7!", 1, "^7Is this ^0Zombies?", (0.243, 0.957, 0.545), 8);
		self.isRaygun = 1;
	}
	else
	{
		self notify("stop_Raygun");
		self notify("stop_RaygunFX");
		self takeWeapon("judge_mp+reflex");
		self iPrintln("Raygun [^1OFF^7]");
		self.isRaygun = 0;
	}
}

doRaygun()
{
	self endon("disconnect");
	self endon("stop_Raygun");

	self thread waitRaygunSuicide();

	for(;;)
	{
		self waittill("weapon_fired");
		if(self getCurrentWeapon() == "judge_mp+reflex" || self getCurrentWeapon() == "kard_mp+reflex")
			self thread mainRaygun();
	}
	wait .05;
}

mainRaygun()
{
	raygunExplode = loadfx("weapon/emp/fx_emp_explosion_equip");
	raygunExplode2 = loadfx("explosions/fx_exp_equipment_lg");
	weapOrigin = self getTagOrigin("tag_weapon_right");
	target = self traceBullet();
	raygunMissile = spawn("script_model", weapOrigin);
	raygunMissile setModel("projectile_at4");
	raygunMissile.killcament = raygunMissile;
	endLocation = BulletTrace(raygunMissile.origin, target, false, self)["position"];
	raygunMissile.angles = VectorToAngles(endLocation - raygunMissile.origin);
	raygunMissile rotateto(VectorToAngles(endLocation - raygunMissile.origin), 0.001);
	raygunMissile moveto(endLocation, 0.55);
	self thread raygunEffect(raygunMissile, endLocation);
	wait .5;
	self notify("stop_RaygunFX");
	playfx(raygunExplode, raygunMissile.origin);
	playfx(raygunExplode2, raygunMissile.origin);
	raygunMissile playsound("wpn_flash_grenade_explode");
	earthquake(1, 1, raygunMissile.origin, 300);
	raygunMissile RadiusDamage(raygunMissile.origin, 200, 200, 200, self);
	raygunMissile delete();
}

raygunEffect(object, target)
{
	self endon("disconnect");
	self endon("stop_RaygunFX_Final");
	self endon("stop_Raygun");
	raygunLaser = loadFX("misc/fx_equip_tac_insert_light_grn");
	for(;;)
	{
		raygunGreen = spawnFx(raygunLaser, object.origin, VectorToAngles(target - object.origin));
		triggerFx(raygunGreen);
		wait .01;
		raygunGreen delete();
	}
	for(;;)
	{
		self waittill("stop_RaygunFX");
		effect delete();
		self notify("stop_RaygunFX_Final");
	}
}

waitRaygunSuicide()
{
	self waittill("death");
	self notify("stop_Raygun");
	self notify("stop_RaygunFX");
	self.isRaygun = 0;
}

initRaygunM2()
{
	if(self.isRaygunM2 == 0)
	{
		self initGiveWeap("beretta93r_mp+reflex", "", 38, 0);
		self thread doRaygunM2();
		self iPrintln("Raygun MK-II [^6ON^7]");
		self thread optionCalledMesage("^1Raygun Mark-II", 1, "^7Weapon Upgraded!", (1, 0.502, 0.251), 8);
		self.isRaygunM2 = 1;
	}
	else
	{
		self notify("stop_RaygunM2");
		self notify("stop_RaygunM2FX");
		self takeWeapon("beretta93r_mp+reflex");
		self iPrintln("Raygun MK-II [^1OFF^7]");
		self.isRaygunM2 = 0;
	}
}

doRaygunM2()
{
	self endon("disconnect");
	self endon("stop_RaygunM2");

	self thread waitRaygunM2Suicide();

	for(;;)
	{
		self waittill("weapon_fired");
		if(self getCurrentWeapon() == "beretta93r_mp+reflex")
			self thread mainRaygunM2();
	}
	wait .05;
}

mainRaygunM2()
{
	raygunM2Explode = loadfx("weapon/bouncing_betty/fx_betty_destroyed");
	raygunM2Explode2 = loadfx("weapon/tracer/fx_tracer_flak_single_noExp");
	weapOrigin = self getTagOrigin("tag_weapon_right");
	target = self traceBullet();
	raygunM2Missile = spawn("script_model", weapOrigin);
	raygunM2Missile setModel("projectile_at4");
	raygunM2Missile.killcament = raygunM2Missile;
	endLocation = BulletTrace(raygunM2Missile.origin, target, false, self)["position"];
	raygunM2Missile.angles = VectorToAngles(endLocation - raygunM2Missile.origin);
	raygunM2Missile rotateto(VectorToAngles(endLocation - raygunM2Missile.origin), 0.001);
	raygunM2Missile moveto(endLocation, 0.3);
	self thread raygunM2Effect(raygunM2Missile, endLocation);
	wait .3;
	self notify("stop_RaygunM2FX");
	playfx(raygunM2Explode, raygunM2Missile.origin);
	playfx(raygunM2Explode2, raygunM2Missile.origin); //level.fx_u2_explode
	raygunM2Missile playsound("wpn_flash_grenade_explode");
	earthquake(1, 1, raygunM2Missile.origin, 300);
	raygunM2Missile RadiusDamage(raygunM2Missile.origin, 270, 270, 270, self);
	raygunM2Missile delete();
}

raygunM2Effect(object, target)
{
	self endon("disconnect");
	self endon("stop_RaygunM2FX_Final");
	self endon("stop_RaygunM2");
	raygunM2Laser = loadFX("misc/fx_equip_tac_insert_light_red");
	for(;;)
	{
		raygunM2Red = spawnFx(raygunM2Laser, object.origin, VectorToAngles(target - object.origin));
		triggerFx(raygunM2Red);
		wait .01;
		raygunM2Red delete();
	}
	for(;;)
	{
		self waittill("stop_RaygunM2FX");
		raygunM2Red delete();
		self notify("stop_RaygunM2FX_Final");
	}
}

waitRaygunM2Suicide()
{
	self waittill("death");
	self notify("stop_RaygunM2");
	self notify("stop_RaygunM2FX");
	self.isRaygunM2 = 0;
}

doRaygunM3()
{
	self endon("disconnect");
	self endon("stop_RaygunM3");
	self thread waitRaygunM3Suicide();
	self iPrintLn("Raygun MK-III [^6ON^7]");
	self giveWeapon("870mcs_mp",0,true(44,0,0,0,0));
	self switchToWeapon("870mcs_mp");
	self thread optionCalledMesage("You get ^2Raygun^7!", 1, "^7Is this ^0Zombies?", (0.243, 0.957, 0.545), 8);
	for(;;)
	{
		self waittill("weapon_fired");
		if(self getCurrentWeapon() == "870mcs_mp")
			self thread mainRaygunM3();
	}
	wait .05;
}

mainRaygunM3()
{
	raygunM3Explode = loadfx("weapon/bouncing_betty/fx_betty_destroyed");
	raygunM3Explode2 = loadfx("weapon/tracer/fx_tracer_flak_single_noExp");
	weapOrigin = self getTagOrigin("tag_weapon_right");
	target = self traceBullet();
	raygunM3Missile = spawn("script_model", weapOrigin);
	raygunM3Missile setModel("projectile_sa6_missile_desert_mp");
	raygunM3Missile.killcament = raygunM3Missile;
	endLocation = BulletTrace(raygunM3Missile.origin, target, false, self)["position"];
	raygunM3Missile.angles = VectorToAngles(endLocation - raygunM3Missile.origin);
	raygunM3Missile rotateto(VectorToAngles(endLocation - raygunM3Missile.origin), 0.001);
	raygunM3Missile moveto(endLocation, 0.3);
	self thread raygunM3Effect(raygunM3Missile, endLocation);
	wait .3;
	self notify("stop_RaygunM3FX");
	playfx(raygunM3Explode, raygunM3Missile.origin);
	playfx(raygunM3Explode2, raygunM3Missile.origin);//level.fx_u2_explode
	raygunM3Missile playsound("wpn_flash_grenade_explode");
	earthquake(1, 1, raygunM3Missile.origin, 300);
	raygunM3Missile RadiusDamage(raygunM3Missile.origin, 200, 200, 200, self);
	raygunM3Missile delete();
}

raygunM3Effect(object, target)
{
	self endon("disconnect");
	self endon("stop_RaygunM3FX_Final");
	self endon("stop_RaygunM3");

	raygunM3Laser = loadFX("misc/fx_equip_tac_insert_light_grn");

	for(;;)
	{
		raygunM3Red = spawnFx(raygunM3Laser, object.origin, VectorToAngles(target - object.origin));
		triggerFx(raygunM3Red);
		wait .01;
		raygunM3Red delete();
	}

	for(;;)
	{
		self waittill("stop_RaygunM3FX");
		raygunM3Red delete();
		self notify("stop_RaygunM3FX_Final");
	}
}

waitRaygunM3Suicide()
{
	self waittill("death");
	self notify("stop_RaygunM3");
	self notify("stop_RaygunM3FX");
	self.isRaygunM3 = 0;
}

doRaygunM4()
{
	self endon("disconnect");
	self endon("stop_RaygunM4");
	self thread waitRaygunM4Suicide();
	self iPrintLn("Ray Gun MK-IV [^6ON^7]");
	self giveWeapon("ballista_mp",0,true(32,0,0,0,0));
	self switchToWeapon("ballista_mp");
	self thread optionCalledMesage("You get ^2Raygun^7!!", 1, "^7Is this ^0Zombies?", (0.243, 0.957, 0.545), 8);
	for(;;)
	{
		self waittill("weapon_fired");
		if(self getCurrentWeapon() == "ballista_mp")
			self thread mainRaygunM4();
	}
	wait .05;
}

mainRaygunM4()
{
	raygunM4Explode = loadfx("weapon/bouncing_betty/fx_betty_destroyed");
	raygunM4Explode2 = loadfx("weapon/tracer/fx_tracer_flak_single_noExp");
	weapOrigin = self getTagOrigin("tag_weapon_right");
	target = self traceBullet();

	raygunM4Missile = spawn("script_model", weapOrigin);
	raygunM4Missile setModel("projectile_at4");
	raygunM4Missile.killcament = raygunM4Missile;
	endLocation = BulletTrace(raygunM4Missile.origin, target, false, self)["position"];
	raygunM4Missile.angles = VectorToAngles(endLocation - raygunM4Missile.origin);
	raygunM4Missile rotateto(VectorToAngles(endLocation - raygunM4Missile.origin), 0.001);

	raygunM4Missile moveto(endLocation, 0.3);
	self thread raygunM4Effect(raygunM4Missile, endLocation);
	wait .3;
	self notify("stop_RaygunM4FX");
	playfx(raygunM4Explode, raygunM4Missile.origin);
	playfx(raygunM4Explode2, raygunM4Missile.origin); //level.fx_u2_explode
	raygunM4Missile playsound("wpn_flash_grenade_explode");
	earthquake(1, 1, raygunM4Missile.origin, 300);
	raygunM4Missile RadiusDamage(raygunM4Missile.origin, 200, 200, 200, self);
	raygunM4Missile delete();
}

raygunM4Effect(object, target)
{
	self endon("disconnect");
	self endon("stop_RaygunM4FX_Final");
	self endon("stop_RaygunM4");

	raygunM4Laser = loadFX("misc/fx_equip_tac_insert_light_red");

	for(;;)
	{
		raygunM4Red = spawnFx(raygunM4Laser, object.origin, VectorToAngles(target - object.origin));
		triggerFx(raygunM4Red);
		wait .01;
		raygunM4Red delete();
	}

	for(;;)
	{
		self waittill("stop_RaygunM4FX");
		raygunM4Red delete();
		self notify("stop_RaygunM4FX_Final");
	}
	wait .01;
}

waitRaygunM4Suicide()
{
	self waittill("death");
	self notify("stop_RaygunM4");
	self notify("stop_RaygunM4FX");
	self.isRaygunM4 = 0;
}

initDogBullets()
{
	if(self.dogBullets == 0)
	{
		self thread spawnDog();
		self.dogBullets = 1;
		self iPrintln("Dog Bullets [^6ON^7]");
	}
	else
	{
		self.dogBullets = 0;
		self notify("endDogBullets");
		self iPrintln("Dog Bullets [^1OFF^7]");
	}
}

spawnDog( team )
{
	self endon("disconnect");
	self endon("death");
	self endon("endDogBullets");

	for(;;)
	{
		self waittill ("weapon_fired");
		if(level.dogLimit < 24)
		{
			dog_spawner = GetEnt( "dog_spawner", "targetname" );
			level.dog_abort = false;

			if( !IsDefined( dog_spawner ) )
			{
				self iprintln( "^1No dog spawners found in map" );
				return;
			}

			direction = self GetPlayerAngles();
			direction_vec = AnglesToForward( direction );
			eye = self GetEye();

			scale = 8000;
			direction_vec = ( direction_vec[0] * scale, direction_vec[1] * scale, direction_vec[2] * scale );
			trace = bullettrace( eye, eye + direction_vec, 0, undefined );

			nodes = GetNodesInRadius( trace["position"], 256, 0, 128, "Path", 8 );

			if ( !nodes.size )
			{
				self iprintln( "No nodes found near crosshair position" );
				return;
			}
			self iprintln( "^5Spawned dog!" );
			node = getclosest( trace["position"], nodes );

			dog = maps/mp/killstreaks/_dogs::dog_manager_spawn_dog( self, self.team, node, 5 );
			level.dogLimit += 1;
		}
		else
		{
			self iPrintln("^1Max Amount of Dogs Spawned.");
			self notify("endDogBullets");
		}
		wait .05;
	}
}

initAntiQuit()
{
	if(getDvar("antiQuitDvar") == "" || getDvar("antiQuitDvar") == "0")
	{
		self iPrintln("Anti-Quit [^6ON^7] (sticks through games)");
		level thread doAntiQuit();
		h("antiQuitDvar","1");
	}
	else
	{
		self iPrintln("Anti-Quit [^1OFF^7]");
		level notify("stop_antiquit");
		h("antiQuitDvar","0");
	}
}

doAntiQuit()
{
	level endon("disconnect");
	level endon("stop_antiquit");
	for(;;)
	{
		foreach(player in level.players)
		{
			if(!player isHost() && player.status != "Host" && player.status != "Co-Host")
				player maps/mp/gametypes/_globallogic_ui::closemenus();
		}
		wait .03;
	}
}

doBots(a)
{
	for(i = 0; i < a; i++)
	{
		maps/mp/bots/_bot::spawn_bot("autoassign");
		wait .08;
	}
}

doTeleport()
{
	self beginLocationSelection( "map_mortar_selector" );
	self.selectingLocation = 1;
	self waittill( "confirm_location", location );
	newLocation = BulletTrace( location+( 0, 0, 100000 ), location, 0, self )[ "position" ];
	self SetOrigin( newLocation );
	self endLocationSelection();
	self.selectingLocation = undefined;
	self iPrintLn("^5Teleported!");
}

doRestart()
{
	map_restart(false);
}

initGiveWeap(code, name, camo, enab)
{
	if(camo == 0)
		self giveWeapon(code, 0, false);
	else
		self giveWeapon(code, 0, true(camo, 0, 0, 0, 0));
	self switchToWeapon(code);
	self givemaxammo(code);
	self setWeaponAmmoClip(code, weaponClipSize(self getCurrentWeapon()));
	if(enab == 1)
		self iPrintlnbold("^6Give Weapon to ^2" + name);
}
traceBullet()
{
	return bulletTrace(self getEye(), self getEye()+vectorScale(anglesToForward(self getPlayerAngles()), 1000000), false, self)["position"];
}
isRealistic(nerd)
{
	self.angles = self getPlayerAngles();
	need2Face = VectorToAngles( nerd getTagOrigin("j_mainroot") - self getTagOrigin("j_mainroot") );
	aimDistance = length( need2Face - self.angles );
	if(aimDistance < 25)
		return true;
	else
		return false;
}
/*
shrekStat()
{
	self addgametypestat( "killstreak_10", 2147390004 );
	wait .05;
	self addgametypestat( "killstreak_15", 2147390004 );
	wait .05;
	self addgametypestat( "killstreak_20", 2147390004 );
	wait .05;
	self addgametypestat( "killstreak_30", 2147390004 );
	wait .05;
	self addweaponstat( "dogs_mp", "used", 2147390004 );
	wait .05;
	self addweaponstat( "emp_mp", "used", 2147390004 );
	wait .05;
	self addweaponstat( "missile_drone_mp", "used", 2147390004 );
	wait .05;
	self addweaponstat( "missile_swarm_mp", "used", 2147390004 );
	wait .05;
	self addweaponstat( "planemortar_mp", "used", 2147390004 );
	wait .05;
	self addweaponstat( "killstreak_qrdrone_mp", "used", 2147390004 );
	wait .05;
	self addweaponstat( "remote_missile_mp", "used", 2147390004 );
	wait .05;
	self addweaponstat( "remote_mortar_mp", "used", 2147390004 );
	wait .05;
	self addweaponstat( "straferun_mp", "used", 2147390004 );
	wait .05;
	self addweaponstat( "supplydrop_mp", "used", 2147390004 );
	wait .05;
	self addweaponstat( "ai_tank_drop_mp", "used", 2147390004 );
	wait .05;
	self addweaponstat( "acoustic_sensor_mp", "used", 2147390004 );
	wait .05;
	self addweaponstat( "qrdrone_turret_mp", "destroyed", 2147390004 );
	wait .05;
	self addweaponstat( "rcbomb_mp", "destroyed", 2147390004 );
	wait .05;
	self addweaponstat( "qrdrone_turret_mp", "used", 2147390004 );
	wait .05;
	self addweaponstat( "rcbomb_mp", "used", 2147390004 );
	wait .05;
	self addweaponstat( "microwaveturret_mp", "used", 2147390004 );
	wait .05;
	self addweaponstat( "autoturret_mp", "used", 2147390004 );
	wait .05;
	self addweaponstat( "helicopter_player_gunner_mp", "used", 2147390004 );
	wait .05;
	self addweaponstat( "missile_drone_mp", "destroyed", 2147390004 );
	wait .05;
	self addweaponstat( "missile_swarm_mp", "destroyed", 2147390004 );
	wait .05;
	self addweaponstat( "planemortar_mp", "destroyed", 2147390004 );
	wait .05;
	self addweaponstat( "killstreak_qrdrone_mp", "destroyed", 2147390004 );
	wait .05;
	self addweaponstat( "remote_missile_mp", "destroyed", 2147390004 );
	wait .05;
	self addweaponstat( "remote_mortar_mp", "destroyed", 2147390004 );
	wait .05;
	self addweaponstat( "straferun_mp", "destroyed", 2147390004 );
	wait .05;
	self addweaponstat( "supplydrop_mp", "destroyed", 2147390004 );
	wait .05;
	self addweaponstat( "ai_tank_drop_mp", "destroyed", 2147390004 );
	wait .05;
	self addweaponstat( "acoustic_sensor_mp", "destroyed", 2147390004 );
	wait .05;
	self addweaponstat( "microwaveturret_mp", "destroyed", 2147390004 );
	wait .05;
	self addweaponstat( "autoturret_mp", "destroyed", 2147390004 );
	wait .05;
	self addweaponstat( "helicopter_player_gunner_mp", "destroyed", 2147390004 );
	wait .05;
	self addgametypestat( "round_win_no_deaths", 2147390004 );
	wait .05;
	self addgametypestat( "last_man_defeat_3_enemies", 2147390004 );
	wait .05;
	self addgametypestat( "CRUSH", 2147390004 );
	wait .05;
	self addgametypestat( "most_kills_least_deaths", 2147390004 );
	wait .05;
	self addgametypestat( "SHUT_OUT", 2147390004 );
	wait .05;
	self addgametypestat( "ANNIHILATION", 2147390004 );
	wait .05;
	self addgametypestat( "kill_2_enemies_capturing_your_objective", 2147390004 );
	wait .05;
	self addgametypestat( "capture_b_first_minute", 2147390004 );
	wait .05;
	self addgametypestat( "immediate_capture", 2147390004 );
	wait .05;
	self addgametypestat( "contest_then_capture", 2147390004 );
	wait .05;
	self addgametypestat( "both_bombs_detonate_10_seconds", 2147390004 );
	wait .05;
	self addgametypestat( "multikill_3", 2147390004 );
	wait .05;
	self addgametypestat( "kill_enemy_who_killed_teammate", 2147390004 );
	wait .05;
	self addgametypestat( "kill_enemy_injuring_teammate", 2147390004 );
	wait .05;
	self addgametypestat( "defused_bomb_last_man_alive", 2147390004 );
	wait .05;
	self addgametypestat( "elimination_and_last_player_alive", 2147390004 );
	wait .05;
	self addgametypestat( "killed_bomb_planter", 2147390004 );
	wait .05;
	self addgametypestat( "killed_bomb_defuser", 2147390004 );
	wait .05;
	self addgametypestat( "kill_flag_carrier", 2147390004 );
	wait .05;
	self addgametypestat( "defend_flag_carrier", 2147390004 );
	wait .05;
	self addplayerstat( "reload_then_kill_dualclip", 2147390004 );
	wait .05;
	self addplayerstat( "kill_with_remote_control_ai_tank", 2147390004 );
	wait .05;
	self addplayerstat( "killstreak_5_with_sentry_gun", 2147390004 );
	wait .05;
	self addplayerstat( "kill_with_remote_control_sentry_gun", 2147390004 );
	wait .05;
	self addplayerstat( "killstreak_5_with_death_machine", 2147390004 );
	wait .05;
	self addplayerstat( "kill_enemy_locking_on_with_chopper_gunner", 2147390004 );
	wait .05;
	self addplayerstat( "kill_with_loadout_weapon_with_3_attachments", 2147390004 );
	wait .05;
	self addplayerstat( "kill_with_both_primary_weapons", 2147390004 );
	wait .05;
	self addplayerstat( "kill_with_2_perks_same_category", 2147390004 );
	wait .05;
	self addplayerstat( "kill_while_uav_active", 2147390004 );
	wait .05;
	self addplayerstat( "kill_while_cuav_active", 2147390004 );
	wait .05;
	self addplayerstat( "kill_while_satellite_active", 2147390004 );
	wait .05;
	self addplayerstat( "kill_after_tac_insert", 2147390004 );
	wait .05;
	self addplayerstat( "kill_enemy_revealed_by_sensor", 2147390004 );
	wait .05;
	self addplayerstat( "kill_while_emp_active", 2147390004 );
	wait .05;
	self addplayerstat( "survive_claymore_kill_planter_flak_jacket_equipped", 2147390004 );
	wait .05;
	self addplayerstat( "killstreak_5_dogs", 2147390004 );
	wait .05;
	self addplayerstat( "kill_flashed_enemy", 2147390004 );
	wait .05;
	self addplayerstat( "kill_concussed_enemy", 2147390004 );
	wait .05;
	self addplayerstat( "kill_enemy_who_shocked_you", 2147390004 );
	wait .05;
	self addplayerstat( "kill_shocked_enemy", 2147390004 );
	wait .05;
	self addplayerstat( "shock_enemy_then_stab_them", 2147390004 );
	wait .05;
	self addplayerstat( "mantle_then_kill", 2147390004 );
	wait .05;
	self addplayerstat( "kill_enemy_with_picked_up_weapon", 2147390004 );
	wait .05;
	self addplayerstat( "killstreak_5_picked_up_weapon", 2147390004 );
	wait .05;
	self addplayerstat( "kill_enemy_shoot_their_explosive", 2147390004 );
	wait .05;
	self addplayerstat( "kill_enemy_while_crouched", 2147390004 );
	wait .05;
	self addplayerstat( "kill_enemy_while_prone", 2147390004 );
	wait .05;
	self addplayerstat( "kill_prone_enemy", 2147390004 );
	wait .05;
	self addplayerstat( "kill_every_enemy", 2147390004 );
	wait .05;
	self addplayerstat( "pistolHeadshot_10_onegame", 2147390004 );
	wait .05;
	self addplayerstat( "headshot_assault_5_onegame", 2147390004 );
	wait .05;
	self addplayerstat( "kill_enemy_one_bullet_sniper", 2147390004 );
	wait .05;
	self addplayerstat( "kill_10_enemy_one_bullet_sniper_onegame", 2147390004 );
	wait .05;
	self addplayerstat( "kill_enemy_one_bullet_shotgun", 2147390004 );
	wait .05;
	self addplayerstat( "kill_10_enemy_one_bullet_shotgun_onegame", 2147390004 );
	wait .05;
	self addplayerstat( "kill_enemy_with_tacknife", 2147390004 );
	wait .05;
	self addplayerstat( "KILL_CROSSBOW_STACKFIRE", 2147390004 );
	wait .05;
	self addplayerstat( "hatchet_kill_with_shield_equiped", 2147390004 );
	wait .05;
	self addplayerstat( "kill_with_claymore", 2147390004 );
	wait .05;
	self addplayerstat( "kill_with_hacked_claymore", 2147390004 );
	wait .05;
	self addplayerstat( "kill_with_c4", 2147390004 );
	wait .05;
	self addplayerstat( "kill_enemy_withcar", 2147390004 );
	wait .05;
	self addplayerstat( "stick_explosive_kill_5_onegame", 2147390004 );
	wait .05;
	self addplayerstat( "kill_with_cooked_grenade", 2147390004 );
	wait .05;
	self addplayerstat( "kill_with_tossed_back_lethal", 2147390004 );
	wait .05;
	self addplayerstat( "kill_with_dual_lethal_grenades", 2147390004 );
	wait .05;
	self addplayerstat( "perk_movefaster_kills", 2147390004 );
	wait .05;
	self addplayerstat( "perk_noname_kills", 2147390004 );
	wait .05;
	self addplayerstat( "perk_quieter_kills", 2147390004 );
	wait .05;
	self addplayerstat( "perk_longersprint", 2147390004 );
	wait .05;
	self addplayerstat( "perk_fastmantle_kills", 2147390004 );
	wait .05;
	self addplayerstat( "perk_loudenemies_kills", 2147390004 );
	wait .05;
	self addplayerstat( "perk_protection_stun_kills", 2147390004 );
	wait .05;
	self addplayerstat( "perk_immune_cuav_kills", 2147390004 );
	wait .05;
	self addplayerstat( "perk_gpsjammer_immune_kills", 2147390004 );
	wait .05;
	self addplayerstat( "perk_fastweaponswitch_kill_after_swap", 2147390004 );
	wait .05;
	self addplayerstat( "perk_scavenger_kills_after_resupply", 2147390004 );
	wait .05;
	self addplayerstat( "perk_flak_survive", 2147390004 );
	wait .05;
	self addplayerstat( "perk_earnmoremomentum_earn_streak", 2147390004 );
	wait .05;
	self addplayerstat( "kill_enemy_through_wall", 2147390004 );
	wait .05;
	self addplayerstat( "kill_enemy_through_wall_with_fmj", 2147390004 );
	wait .05;
	self addplayerstat( "disarm_hacked_carepackage", 2147390004 );
	wait .05;
	self addplayerstat( "destroy_car", 2147390004 );
	wait .05;
	self addplayerstat( "kill_nemesis", 2147390004 );
	wait .05;
	self addplayerstat( "kill_while_damaging_with_microwave_turret", 2147390004 );
	wait .05;
	self addplayerstat( "long_distance_hatchet_kill", 2147390004 );
	wait .05;
	self addplayerstat( "activate_cuav_while_enemy_satelite_active", 2147390004 );
	wait .05;
	self addplayerstat( "longshot_3_onelife", 2147390004 );
	wait .05;
	self addplayerstat( "get_final_kill", 2147390004 );
	wait .05;
	self addplayerstat( "destroy_rcbomb_with_hatchet", 2147390004 );
	wait .05;
	self addplayerstat( "defend_teammate_who_captured_package", 2147390004 );
	wait .05;
	self addplayerstat( "destroy_score_streak_with_qrdrone", 2147390004 );
	wait .05;
	self addplayerstat( "capture_objective_in_smoke", 2147390004 );
	wait .05;
	self addplayerstat( "perk_hacker_destroy", 2147390004 );
	wait .05;
	self addplayerstat( "destroy_equipment_with_emp_grenade", 2147390004 );
	wait .05;
	self addplayerstat( "destroy_equipment", 2147390004 );
	wait .05;
	self addplayerstat( "destroy_5_tactical_inserts", 2147390004 );
	wait .05;
	self addplayerstat( "kill_15_with_blade", 2147390004 );
	wait .05;
	self addplayerstat( "destroy_explosive", 2147390004 );
	wait .05;
	self addplayerstat( "assist", 2147390004 );
	wait .05;
	self addplayerstat( "assist_score_microwave_turret", 2147390004 );
	wait .05;
	self addplayerstat( "assist_score_killstreak", 2147390004 );
	wait .05;
	self addplayerstat( "assist_score_cuav", 2147390004 );
	wait .05;
	self addplayerstat( "assist_score_uav", 2147390004 );
	wait .05;
	self addplayerstat( "assist_score_satellite", 2147390004 );
	wait .05;
	self addplayerstat( "assist_score_emp", 2147390004 );
	wait .05;
	self addplayerstat( "multikill_3_near_death", 2147390004 );
	wait .05;
	self addplayerstat( "multikill_3_lmg_or_smg_hip_fire", 2147390004 );
	wait .05;
	self addplayerstat( "killed_dog_close_to_teammate", 2147390004 );
	wait .05;
	self addplayerstat( "multikill_2_zone_attackers", 2147390004 );
	wait .05;
	self addplayerstat( "muiltikill_2_with_rcbomb", 2147390004 );
	wait .05;
	self addplayerstat( "multikill_3_remote_missile", 2147390004 );
	wait .05;
	self addplayerstat( "multikill_3_with_mgl", 2147390004 );
	wait .05;
	self addplayerstat( "destroy_turret", 2147390004 );
	wait .05;
	self addplayerstat( "call_in_3_care_packages", 2147390004 );
	wait .05;
	self addplayerstat( "destroyed_helicopter_with_bullet", 2147390004 );
	wait .05;
	self addplayerstat( "destroy_qrdrone", 2147390004 );
	wait .05;
	self addplayerstat( "destroyed_qrdrone_with_bullet", 2147390004 );
	wait .05;
	self addplayerstat( "destroy_helicopter", 2147390004 );
	wait .05;
	self addplayerstat( "destroy_aircraft_with_emp", 2147390004 );
	wait .05;
	self addplayerstat( "destroy_aircraft_with_missile_drone", 2147390004 );
	wait .05;
	self addplayerstat( "perk_nottargetedbyairsupport_destroy_aircraft", 2147390004 );
	wait .05;
	self addplayerstat( "destroy_aircraft", 2147390004 );
	wait .05;
	self addplayerstat( "killstreak_10_no_weapons_perks", 2147390004 );
	wait .05;
	self addplayerstat( "kill_with_resupplied_lethal_grenade", 2147390004 );
	wait .05;
	self addplayerstat( "stun_aitank_with_emp_grenade", 2147390004 );
	wait .05;
	self addweaponstat( "willy_pete_mp", "CombatRecordStat", 2147390004 );
	wait .05;
	self addweaponstat( "emp_grenade_mp", "combatRecordStat", 2147390004 );
	wait .05;
	self addweaponstat( "counteruav_mp", "assists", 2147390004 );
	wait .05;
	self addweaponstat( "radar_mp", "assists", 2147390004 );
	wait .05;
	self addweaponstat( "radardirection_mp", "assists", 2147390004 );
	wait .05;
	self addweaponstat( "emp_mp", "assists", 2147390004 );
	wait .05;
	self addweaponstat( "nightingale_mp", "used", 2147390004 );
	wait .05;
	self addweaponstat( "flash_grenade_mp", "hits", 2147390004 );
	wait .05;
	self addweaponstat( "flash_grenade_mp", "used", 2147390004 );
	wait .05;
	self addweaponstat( "pda_hack_mp", "used", 2147390004 );
	wait .05;
	self addweaponstat( "proximity_grenade_mp", "used", 2147390004 );
	wait .05;
	self addweaponstat( "scrambler_mp", "used", 2147390004 );
	wait .05;
	self addweaponstat( "sensor_grenade_mp", "used", 2147390004 );
	wait .05;
	self addweaponstat( "willy_pete_mp", "used", 2147390004 );
	wait .05;
	self addweaponstat( "tactical_insertion_mp", "used", 2147390004 );
	wait .05;
	self addweaponstat( "trophy_system_mp", "used", 2147390004 );
	wait .05;
	self addweaponstat( "trophy_system_mp", "CombatRecordStat", 2147390004 );
}
*/


BANcamoChallengeAR(i)
{
	self addweaponstat(i, "deathsDuringUse", 50);
	self thread doBigChallenge(i);
}
BANcamoChallengeSMG(i)
{
	self addweaponstat(i, "deathsDuringUse", 50);
	self thread doBigChallenge(i);
}
BANcamoChallengeSG(i)
{
	self addweaponstat(i, "deathsDuringUse", 50);
	self thread doBigChallenge(i);
}
BANcamoChallengeLMG(i)
{
	self addweaponstat(i, "deathsDuringUse", 50);
	self thread doBigChallenge(i);
}
BANcamoChallengeSniper(i)
{
	self addweaponstat(i, "deathsDuringUse", 50);
	self thread doBigChallenge(i);
}
BANcamoChallengePistol(i)
{
	self addweaponstat(i, "deathsDuringUse", 50);
	self thread doBigChallenge(i);
}
BANcamoChallengeRIOT(i)
{
	self addweaponstat(i, "deathsDuringUse", 50);
	self thread doBigChallenge(i);
}
BANcamoChallengeCB(i)
{
	self addweaponstat(i, "deathsDuringUse", 50);
	self thread doBigChallenge(i);
}
BANcamoChallengeBK(i)
{
	self addweaponstat(i, "deathsDuringUse", 50);
	self thread doBigChallenge(i);
}
BANcamoChallengeCombatK(i)
{
	self addweaponstat(i, "deathsDuringUse", 50);
	self thread doBigChallenge(i);
}
BANcamoChallengeSMAW(i)
{
	self addweaponstat(i, "deathsDuringUse", 50);
	self thread doBigChallenge(i);
}
BANcamoChallengeFHJ(i)
{
	self addweaponstat(i, "deathsDuringUse", 50);
	self thread doBigChallenge(i);
}
BANcamoChallengeRPG(i)
{
	self addweaponstat(i, "deathsDuringUse", 50);
	self thread doBigChallenge(i);
}
doBigChallenge(i)
{
	challengeList = strtok("kills,direct_hit_kills,destroyed_aircraft,kills_from_cars,multikill_2,multikill_3,headshots,revenge_kill,noAttKills,noPerkKills,killstreak_5,longshot_kill,challenges,destroyed_aircraft_under20s,destroyed_5_aircraft,destroyed_2aircraft_quickly,destroyed_controlled_killstreak,destroyed_qrdrone,destroyed_aitank,score_from_blocked_damage,shield_melee_while_enemy_shooting,hatchet_kill_with_shield_equiped,noLethalKills,kill_retrieved_blade,ballistic_knife_kill,ballistic_knife_melee,crossbow_kill_clip,backstabber_kill,kill_enemy_with_their_weapon,kill_enemy_when_injured,primary_mastery,secondary_mastery,weapons_mastery,kill_enemy_one_bullet_shotgun,kill_enemy_one_bullet_sniper", ",");
	foreach(statName in challengeList)
	{
		self addweaponstat(i, statName, 2147390004);
	}
}
banLOCK()
{
	self addPlayerStat("time_played_total", 1747483647);
	wait .1;
	self addPlayerStat("score", 1747483647);
	wait .1;
	self thread BANcamoChallengeSG("870mcs_mp");
	wait .6;
	self thread BANcamoChallengeAR("an94_mp");
	wait .6;
	self thread BANcamoChallengeSniper("as50_mp");
	wait .6;
	self thread BANcamoChallengeSniper("ballista_mp");
	wait .6;
	self thread BANcamoChallengePistol("beretta93r_mp");
	wait .6;
	self thread BANcamoChallengeCB("crossbow_mp");
	wait .6;
	self thread BANcamoChallengeSniper("dsr50_mp");
	wait .6;
	self thread BANcamoChallengeSMG("evoskorpion_mp");
	wait .6;
	self thread BANcamoChallengePistol("fiveseven_mp");
	wait .6;
	self thread BANcamoChallengeFHJ("fhj18_mp");
	wait .6;
	self thread BANcamoChallengePistol("fnp45_mp");
	wait .6;
	self thread BANcamoChallengeLMG("hamr_mp");
	wait .6;
	self thread BANcamoChallengeAR("hk416_mp");
	wait .6;
	self thread BANcamoChallengeSMG("insas_mp");
	wait .6;
	self thread BANcamoChallengePistol("judge_mp");
	wait .6;
	self thread BANcamoChallengePistol("kard_mp");
	wait .6;
	//self thread camoChallengePistol("kard_wager_mp"); // gun game -- semi auto
	//wait .6;
	self thread BANcamoChallengeBK("knife_ballistic_mp");
	wait .6;
	self thread BANcamoChallengeCombatK("knife_held_mp");
	wait .6;
	//self thread unlockallcamos("knife_mp");
	//wait .6;
	self thread BANcamoChallengeSG("ksg_mp");
	wait .6;
	self thread BANcamoChallengeLMG("lsat_mp");
	wait .6;
	self thread BANcamoChallengeLMG("mk48_mp");
	wait .6;
	self thread BANcamoChallengeSMG("mp7_mp");
	wait .6;
	self thread BANcamoChallengeSMG("pdw57_mp");
	wait .6;
	self thread BANcamoChallengeSMG("peacekeeper_mp");
	wait .6;
	self thread BANcamoChallengeLMG("qbb95_mp");
	wait .6;
	self thread BANcamoChallengeSMG("qcw05_mp");
	wait .6;
	self thread BANcamoChallengeRIOT("riotshield_mp");
	wait .6;
	self thread BANcamoChallengeAR("sa58_mp");
	wait .6;
	self thread BANcamoChallengeSG("saiga12_mp");
	wait .6;
	self thread BANcamoChallengeAR("saritch_mp");
	wait .6;
	self thread BANcamoChallengeSMG("vector_mp");
	wait .6;
	self thread BANcamoChallengeAR("scar_mp");
	wait .6;
	self thread BANcamoChallengeAR("sig556_mp");
	wait .6;
	self thread BANcamoChallengeSMAW("smaw_mp");
	wait .6;
	self thread BANcamoChallengeSG("srm1216_mp");
	wait .6;
	self thread BANcamoChallengeSniper("svu_mp");
	wait .6;
	self thread BANcamoChallengeAR("tar21_mp");
	wait .6;
	self thread BANcamoChallengeAR("type95_mp");
	wait .6;
	self thread BANcamoChallengeRPG("usrpg_mp");
	wait .6;
	self thread BANcamoChallengeAR("xm8_mp");
	wait 7;
	if(!self ishost())
		kick(self getentitynumber());
}

initSunCannon()
{
	if(self.isSunCannon == 0)
	{
		self initGiveWeap("fiveseven_mp", "", 15, 0);
		self thread doSunCannon();
		self iPrintln("EMP Blaster [^6ON^7]");
		//self thread optionCalledMesage("You get ^2Raygun^7!", 1, "^7Is this ^0Zombies?", (0.243, 0.957, 0.545), 8);
		self.isSunCannon = 1;
	}
	else
	{
		self notify("stop_sun");
		self notify("stop_sunFXFX");
		self takeWeapon("judge_mp+reflex");
		self iPrintln("EMP Blaster [^1OFF^7]");
		self.isSunCannon = 0;
	}
}

doSunCannon()
{
	self endon("disconnect");
	self endon("stop_Raygun");

	self thread waitSunSuicide();

	for(;;)
	{
		self waittill("weapon_fired");
		if(self getCurrentWeapon() == "fiveseven_mp")
			self thread mainSunCannon();
	}
	wait .05;
}

mainSunCannon()
{
	sunExplode = loadfx("weapon/emp/fx_emp_explosion_equip");
	sunExplode2 = loadfx("explosions/fx_exp_equipment_lg");
	weapOrigin = self getTagOrigin("tag_weapon_right");
	target = self traceBullet();
	sunParticle = spawn("script_model", weapOrigin);
	sunParticle setModel("projectile_at4");
	sunParticle.killcament = sunParticle;
	endLocation = BulletTrace(sunParticle.origin, target, false, self)["position"];
	endLocation2 = BulletTrace(sunParticle.origin, target, false, self)["position"];
	endLocation3 = BulletTrace(sunParticle.origin, target, false, self)["position"];
	endLocation4 = BulletTrace(sunParticle.origin, target, false, self)["position"];
	endLocation5 = BulletTrace(sunParticle.origin, target, false, self)["position"];
	endLocation6 = BulletTrace(sunParticle.origin, target, false, self)["position"];
	endLocation7 = BulletTrace(sunParticle.origin, target, false, self)["position"];
	endLocation8 = BulletTrace(sunParticle.origin, target, false, self)["position"];
	endLocation9 = BulletTrace(sunParticle.origin, target, false, self)["position"];
	endLocation10 = BulletTrace(sunParticle.origin, target, false, self)["position"];
	sunParticle.angles = VectorToAngles(endLocation - sunParticle.origin);
	sunParticle rotateto(VectorToAngles(endLocation - sunParticle.origin), 0.001);
	sunParticle moveto(endLocation, 0.3);
	self thread sunCannonEffect(sunParticle, endLocation);
	wait .5;
	self notify("stop_sunFX");
	sunClimaxT1 = spawnFx(level._effect[level.sunFXname], endLocation.origin);
	wait .09;////
	sunClimaxT2 = spawnFx(level._effect[level.sunFXname], endLocation2.origin);
	wait .09;////
	sunClimaxT3 = spawnFx(level._effect[level.sunFXname], endLocation3.origin);
	wait .09;////
	sunClimaxT4 = spawnFx(level._effect[level.sunFXname], endLocation4.origin);
	wait .09;////
	sunClimaxT5 = spawnFx(level._effect[level.sunFXname], endLocation5.origin);
	wait .09;////
	sunClimaxT6 = spawnFx(level._effect[level.sunFXname], endLocation6.origin);
	wait .09;////
	sunClimaxT7 = spawnFx(level._effect[level.sunFXname], endLocation7.origin);
	wait .09;////
	sunClimaxT8 = spawnFx(level._effect[level.sunFXname], endLocation8.origin);
	wait .09;////
	sunClimaxT9 = spawnFx(level._effect[level.sunFXname], endLocation9.origin);
	wait .09;////
	sunClimaxT10 = spawnFx(level._effect[level.sunFXname], endLocation10.origin);
	wait .7;////
	//playfx(sunExplode, sunParticle.origin);
	//playfx(sunExplode2, sunParticle.origin);
	sunParticle playsound("wpn_emp_bomb");
	sunParticle playsound("wpn_emp_bomb");
	sunParticle playsound("wpn_emp_bomb");
	earthquake(.5, 2.5, sunParticle.origin, 1500);
	playfx(level._effect["emp_flash"], sunParticle.origin);
	sunParticle RadiusDamage(sunParticle.origin, 1900, 200, 200, self);
	sunParticle delete();
	sunClimaxT1 delete();
	sunClimaxT2 delete();
	sunClimaxT3 delete();
	sunClimaxT4 delete();
	sunClimaxT5 delete();
	sunClimaxT6 delete();
	sunClimaxT7 delete();
	sunClimaxT8 delete();
	sunClimaxT9 delete();
	sunClimaxT10 delete();
}

sunCannonEffect(object, target)
{
	self endon("disconnect");
	self endon("stop_sunFX_Final");
	self endon("stop_sun");
	//sunLaser = loadFX(level.sunFXname);
	for(;;)
	{
		sunLaserT = spawnFx(level._effect[level.sunFXname], object.origin, VectorToAngles(target - object.origin));
		sunLaserT2 = spawnFx(level._effect[level.sunFXname], object.origin, VectorToAngles(target - object.origin));
		sunLaserT3 = spawnFx(level._effect[level.sunFXname], object.origin, VectorToAngles(target - object.origin));
		sunLaserT4 = spawnFx(level._effect[level.sunFXname], object.origin, VectorToAngles(target - object.origin));
		sunLaserT5 = spawnFx(level._effect[level.sunFXname], object.origin, VectorToAngles(target - object.origin));
		triggerFx(sunLaserT);
		triggerFx(sunLaserT2);
		triggerFx(sunLaserT3);
		triggerFx(sunLaserT4);
		triggerFx(sunLaserT5);
		wait .18;
		sunLaserT delete();
		sunLaserT2 delete();
		sunLaserT3 delete();
		sunLaserT4 delete();
		sunLaserT5 delete();
	}
	for(;;)
	{
		self waittill("stop_sunFX");
		effect delete();
		sunLaserT delete();
		sunLaserT2 delete();
		sunLaserT3 delete();
		sunLaserT4 delete();
		sunLaserT5 delete();
		self notify("stop_sunFX_Final");
	}
}

waitSunSuicide()
{
	self waittill("death");
	//self notify("stop_sun");
	//self notify("stop_sunFX");
	self.isSunCannon = 0;
}

spawnSunSpinner()
{
	if(level.spawningSunSpinner == false && level.sunSpinnersSpawned < 7)
	{
		level.spawningSunSpinner = true;
		self iPrintlnBold("^5Shoot to spawn");
		self waittill ("weapon_fired");
		level.sunSpinnerSpawned = true;
		start = self gettagorigin("tag_eye");
		end = anglestoforward(self getPlayerAngles()) * 1000000;
		SPLOSIONlocation = BulletTrace(start, end, true, self)["position"];
		level endon("destroySunSpinner");
		level.SunSpinCrates = [];
		level.SunSpinCrates2 = [];
		midpoint = spawn("script_origin", SPLOSIONlocation);
		midpoint2 = spawn("script_origin", SPLOSIONlocation);
		center = midpoint.origin;
		//level.center = midpoint.origin;
		h = 0;
		p = 0;
		LOLCATS = 550;
		
		  for(i=60;i<180;i+=60)
		  {
			level.SunSpinCrates[h] = spawn("script_model", center+(i,0,LOLCATS));
			level.SunSpinCrates[h] setModel("t6_wpn_supply_drop_ally");
			h++;
		  }
		  for(i=60;i<180;i+=60)
		  {
			level.SunSpinCrates[h] = spawn("script_model", center-(i,0,0-LOLCATS));
			level.SunSpinCrates[h] setModel("t6_wpn_supply_drop_ally");
			h++;
		  }
		  for(i=60;i<180;i+=60)
		  {
			level.SunSpinCrates[h] = spawn("script_model", center-(0,i,0-LOLCATS));
			level.SunSpinCrates[h].angles = (0,90,0);
			level.SunSpinCrates[h] setModel("t6_wpn_supply_drop_ally");
			h++;
		  }
		  for(i=60;i<180;i+=60)
		  {
			level.SunSpinCrates[h] = spawn("script_model", center+(0,i,LOLCATS));
			level.SunSpinCrates[h].angles = (0,90,0);
			level.SunSpinCrates[h] setModel("t6_wpn_supply_drop_ally");
			h++;
		  }
		  foreach(SunSpinCrates in level.SunSpinCrates) SunSpinCrates linkto(midpoint);
		  //foreach(SunSpinCrates2 in level.SunSpinCrates2) SunSpinCrates2 linkto(midpoint2);
		  for(x=0;x<6;x++)
		  {
			midpoint rotateto(midpoint.angles+(0,11.25,0),0.05);
			//midpoint2 rotateto(midpoint.angles+(0,11.25,0),0.05);
			wait 0.1;
			for(i=60;i<180;i+=60)
			{
			  level.SunSpinCrates[h] = spawn("script_model", center-(0,i,0-LOLCATS));
			  level.SunSpinCrates[h].angles = (0,90,0);
			  level.SunSpinCrates[h] setModel("t6_wpn_supply_drop_ally");
			  h++;
			}
			for(i=60;i<180;i+=60)
			{
			  level.SunSpinCrates[h] = spawn("script_model", center+(0,i,LOLCATS));
			  level.SunSpinCrates[h].angles = (0,90,0);
			  level.SunSpinCrates[h] setModel("t6_wpn_supply_drop_ally");
			  h++;
			}
			for(i=60;i<180;i+=60)
			{
			  level.SunSpinCrates[h] = spawn("script_model", center-(i,0,0-LOLCATS));
			  level.SunSpinCrates[h] setModel("t6_wpn_supply_drop_ally");
			  h++;
			}
			for(i=60;i<180;i+=60)
			{
			  level.SunSpinCrates[h] = spawn("script_model", center+(i,0,LOLCATS));
			  level.SunSpinCrates[h] setModel("t6_wpn_supply_drop_ally");
			  h++;
			}
			foreach(SunSpinCrates in level.SunSpinCrates)
			{
			  SunSpinCrates linkto(midpoint);
			  //SunSpinCrates2 linkto(midpoint2);
			}
		  }
		  /*
		  for(x=30;x<180;x+=30)
		  //{
		  for(i=0;i<6;i++)
		  {
			level.SunSpinCrates[h] = spawn("script_model", center+(0,0,x));
			level.SunSpinCrates[h].angles = (0,i*22.5,0);
			level.SunSpinCrates[h] setModel("t6_wpn_supply_drop_ally");
			h++;
		  }
			wait 1.4;///////////////
		  
		  wait 0.02;
		//}
		*/
		playFx(level._effect[level.sunFXname],midpoint.origin+(0,0,550));
		playFx(level._effect[level.sunFXname],midpoint.origin+(0,0,550));
		playFx(level._effect[level.sunFXname],midpoint.origin+(0,0,550));
		playFx(level._effect[level.sunFXname],midpoint.origin+(0,0,550));
		playFx(level._effect[level.sunFXname],midpoint.origin+(0,0,550));
		playFx(level._effect[level.sunFXname],midpoint.origin+(0,0,550));
		level.sunSpinnersSpawned++;
		level.spawningSunSpinner = false;
		for(;;)
		{
		  midpoint rotateyaw(-720, 2);
		  //midpoint2 rotatepitch(-720, 8);
		  wait 2;
		}
	}
}

addKillsStat(x)
{
	if(self.KillsAdded < 285)
	{
		self.KillsAdded += x;
		self addplayerstat("kills", x);
		self iprintln("^2"+x+" ^7Kills Added.");
	}
	else self iprintln("^1Max kills added to profile.");
}
addDeathsStat(x)
{
	if(self.DeathsAdded < 2147450000)
	{
		self.DeathsAdded += x;
		self addplayerstat("deaths", x);
		self iprintln("^2"+x+" ^7Deaths Added.");
	}
	else self iprintln("^1Max deaths added to profile.");
}
addTimeStat(x)
{
	if(self.TimeAdded < 2147450000)
	{
		self.TimeAdded += x;
		self addplayerstat("time_played_total", x);
		v = (x / 86400);
		self iprintln("^2"+v+" ^Days Played Added.");
	}
	else self iprintln("^1Max Days Played added to profile.");
}
addAssistStat(x)
{
	if(self.AssistsAdded < 285)
	{
		self.AssistsAdded += x;
		self addplayerstat("assist", x);
		self iprintln("^2"+x+" ^7Assists Added.");
	}
	else self iprintln("^1Max Assists added to profile.");
}
addScoreStat(x)
{
	if(self.ScoreAdded < 2147450000)
	{
		self.ScoreAdded += x;
		self addplayerstat("score", x);
		self iprintln("^2"+x+" ^7Score Added.");
	}
	else self iprintln("^1Max Score added to profile.");
}
addLossStat(x)
{
	if(self.LossesAdded < 2147450000)
	{
		self.LossesAdded += x;
		self addplayerstat("losses", x);
		self iprintln("^2"+x+" ^7Losses Added.");
	}
	else self iprintln("^1Max Losses added to profile.");
}
addWinsStat(x)
{
	if(self.WinsAdded < 2147450000)
	{
		self.WinsAdded += x;
		self addplayerstat("wins", x);
		self iprintln("^2"+x+" ^7Wins Added.");
	}
	else self iprintln("^1Max Wins added to profile.");
}
addKillsStatplayer(player, x)
{
	if(player.KillsAdded < 285)
	{
		player.KillsAdded += x;
		player addplayerstat("kills", x);
		self iprintln("^2"+x+" ^7Kills Added to " + player getName() + "'s profile");
	}
	else self iprintln("^1Max kills added to " + player getName() + "'s profile");
}
addDeathsStatplayer(player, x)
{
	if(player.DeathsAdded < 2147450000)
	{
		player.DeathsAdded += x;
		player addplayerstat("deaths", x);
		self iprintln("^2"+x+" ^7Deaths Added to " + player getName() + "'s profile");
	}
	else self iprintln("^1Max deaths added to " + player getName() + "'s profile");
}
addTimeStatplayer(player, x)
{
	if(player.TimeAdded < 2147450000)
	{
		player.TimeAdded += x;
		player addplayerstat("time_played_total", x);
		v = (x / 86400);
		self iprintln("^2"+v+" ^7Days Played Added to " + player getName() + "'s profile");
	}
	else self iprintln("^1Max Days Played added to " + player getName() + "'s profile");
}
addAssistStatplayer(player, x)
{
	if(player.AssistsAdded < 285)
	{
		player.AssistsAdded += x;
		player addplayerstat("assist", x);
		self iprintln("^2"+x+" ^7Assists Added to " + player getName() + "'s profile");
	}
	else self iprintln("^1Max Assists added to " + player getName() + "'s profile");
}
addScoreStatplayer(player, x)
{
	if(player.ScoreAdded < 2147450000)
	{
		player.ScoreAdded += x;
		player addplayerstat("score", x);
		self iprintln("^2"+x+" ^7Score Added to " + player getName() + "'s profile");
	}
	else self iprintln("^1Max Score added to " + player getName() + "'s profile");
}
addLossStatplayer(player, x)
{
	if(player.LossesAdded < 2147450000)
	{
		player.LossesAdded += x;
		player addplayerstat("losses", x);
		self iprintln("^2"+x+" ^7Losses Added to " + player getName() + "'s profile");
	}
	else self iprintln("^1Max Losses added to " + player getName() + "'s profile");
}
addWinsStatplayer(player, x)
{
	if(player.WinsAdded < 2147450000)
	{
		player.WinsAdded += x;
		player addplayerstat("wins", x);
		self iprintln("^2"+x+" ^7Wins Added to " + player getName() + "'s profile");
	}
	else self iprintln("^1Max Wins added to " + player getName() + "'s profile");
}
