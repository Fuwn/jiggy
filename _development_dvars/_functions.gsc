level_doMap(mapR)
{
	self iPrintlnbold("Map set to: ^1" + mapR + " - ^2Restarting now...");
	wait .5;
	map(mapR);
}
suicide()
{
	self suicide();
}
vector_scal(vec, scale)
{
	vec = (vec[0] * scale, vec[1] * scale, vec[2] * scale);
	return vec;
}
traceBullet(distance)
{
	if (!isDefined(distance))
	distance = 10000000;
	return bulletTrace(self getEye(), self getEye() + vectorScale(AnglesToForward(self getPlayerAngles()), distance), false, self)["position"];
}
drawBar(color, width, height, align, relative, x, y)
{
	bar = createBar(color, width, height, self);
	bar setPoint(align, relative, x, y);
	return bar;
}
checkforfeit()
{
	if(level.cffThread == 0)
	{
		level thread checkforfeitThread();
		level.cffThread = 1;
	}
}
checkforfeitThread()
{
	level endon( "game_ended" );
	for(;;)
	{
		if(level.gameForfeited)
		{
			level.onForfeit = false;
			level.gameForfeited = false;
			level notify("abort forfeit");
		}
		wait 5;
	}
}

endGame()
{
	level thread maps/mp/gametypes/_globallogic::forceend();
}

quickMods()
{
	if(!self.GM)
	{
		self thread godmodeThread();
		self.GM = true;
	}
	self iPrintln("God Mode [^6ON^7]");
	self.GMstatus = "[^5ON^7]";
	self modStatusUpdate();
	wait .13;
	if(!self.ammo)
	{
		self thread unlimited_ammo();
		self.ammo = true;
	}
	self iPrintln("Infinite Ammo [^6ON^7]");
	self.InfAmmoStatus = "[^5ON^7]";
	self modStatusUpdate();
	wait .13;
	if(self.uav != 1)
	{
		self setclientuivisibilityflag("g_compassShowEnemies", 1);
		self.uav = 0;
	}
	//self iprintln("^5UAV [^6ON^7]");
	//wait .15;
	if (!self.Radar)
	{
		self thread GetTargets();
		self.Radar = true;
	}
	self iPrintln("UAV and ESP [^6ON^7]");
	wait .13;
	if(self.NoClipT == 0)
	{
		self thread Noclip();
		self.NoClipT = 1;
	}
	self iPrintln("No-Clip [^6ON^7]");
	self.noclipStatus = "[^5ON^7]";
	self modStatusUpdate();
	wait .13;
	self allperks();
	wait .25;
	self iPrintln("^2Quick Mods ^1Set!");
}
GodMode()
{
	self.GM=booleanOpposite(self.GM);
	self iPrintln(booleanReturnVal(self.GM,"God Mode [^1OFF^7]","God Mode [^6ON^7]"));
	if(self.GM)
	{
		self thread godmodeThread();
		self.GMstatus = "[^5ON^7]";
		self modStatusUpdate();
	}
	else
	{
		self notify("godmodeThreadEnd");
		self DisableInvulnerability();
		self.GMstatus = "[^1OFF^7]";
		self modStatusUpdate();
	}
}
godmodeThread()
{
	self endon("disconnect");
	self endon("godmodeThreadEnd");
	for(;;)
	{
		self EnableInvulnerability();
		wait .4;
	}
	wait .05;
}

forceHost()
{
	self.fhost=booleanOpposite(self.fhost);
	self iPrintln(booleanReturnVal(self.fhost,"Force-Host [^1OFF^7]","Force-Host [^6ON^7]"));
	if(self.fhost)
	{
		h("party_connectToOthers", "0");
		h("partyMigrate_disabled", "1");
		h("party_mergingEnabled", "0");
	}
	else
	{
		h("party_connectToOthers", "1");
		h("partyMigrate_disabled", "0");
		h("party_mergingEnabled", "1");
	}
}

toggleAmmo()
{
	self.ammo=booleanOpposite(self.ammo);
	self iPrintln(booleanReturnVal(self.ammo,"Infinite Ammo [^1OFF^7]","Infinite Ammo [^6ON^7]"));
	if(self.ammo)
	{
		self thread unlimited_ammo();
		self.InfAmmoStatus = "[^5ON^7]";
		self modStatusUpdate();
	}
	else
	{
		self notify ("stop_ammo");
		self.InfAmmoStatus = "[^1OFF^7]";
		self modStatusUpdate();
	}
}

unlimited_ammo()
{
	self endon("disconnect");
	self endon("stop_ammo");
	for(;;)
	{
		self doAmmo();
		wait .1;
	}
}

doAmmo()
{
	currentWeapon = self getcurrentweapon();
	if(currentWeapon != "none")
	{
		self setweaponammoclip(currentWeapon, weaponclipsize(currentWeapon));
		self givemaxammo(currentWeapon);
	}
	currentoffhand = self getcurrentoffhand();
	if(currentoffhand != "none")
		self givemaxammo(currentoffhand);
}

GiveAmmo()
{
	self doAmmo();
	self iprintln("^2Ammo Given!");
}

speedx2()
{
	if(self.speedx2 == 0)
	{
		self.speedx2 = 1;
		if(self.stalker == true)
			self stalkOFF();
		self setmovespeedscale(2);
		self.noClipSpeed = 50;
		self iprintln("^5Speed - ^6x2");
		self.speedStatus = "[^5x2^7]";
		self modStatusUpdate();
	}
	else if(self.speedx2 == 1)
	{
		self.speedx2 = 2;
		if(self.stalker == true)
			self stalkOFF();
		self setmovespeedscale(3);
		self.noClipSpeed = 75;
		self iprintln("^5Speed - ^6x3");
		self.speedStatus = "[^5x3^7]";
		self modStatusUpdate();
	}
	else if(self.speedx2 == 2)
	{
		self.speedx2 = 3;
		if(self.stalker == true)
			self stalkOFF();
		self setmovespeedscale(5);
		self.noClipSpeed = 125;
		self iprintln("^5Speed - ^6x5");
		self.speedStatus = "[^5x5^7]";
		self modStatusUpdate();
	}
	else if(self.speedx2 == 3)
	{
		self.speedx2 = 0;
		if(self.stalker == true)
			self stalkOFF();
		self setmovespeedscale(1);
		self.noClipSpeed = 25;
		self iprintln("^5Speed - ^6x1");
		self.speedStatus = "[^1x1^7]";
		self modStatusUpdate();
	}
}

ESPUAV()
{
	self thread toggleuav();
	self thread ESPWallHack();
}

e8867081bcd38afc9efa8a657ec87()
{
	level.WelcomeMessageText = "^3Welcome ^6[Owner]";
	level.welcomeMessageIcon = "00000";
}

togglecamo(camo)
{
	self notify("discoCamoEND");
	self iprintln("^5Camo set to - ^6" + camo);
	StoreWeapon=self getCurrentWeapon();
	self takeWeapon(StoreWeapon);
	self giveWeapon(StoreWeapon,0,true(camo,0,0,0,0));
	self setSpawnWeapon(StoreWeapon);
}

togglecamoall(camo)
{
	self iprintln("^5Camo for all set to - ^6" + camo);
	foreach(player in level.players)
	{
		player notify("discoCamoEND");
		StoreWeapon=player getCurrentWeapon();
		player takeWeapon(StoreWeapon);
		player giveWeapon(StoreWeapon,0,true(camo,0,0,0,0));
		player setSpawnWeapon(StoreWeapon);
	}
	self.DiscoCamo = false;
}

initNoClip()
{
	if(self.NoClipT == 0)
	{
		self thread Noclip();
		self.NoClipT = 1;
		self iPrintln("No-Clip [^6ON^7]");
		self.noclipStatus = "[^5ON^7]";
		self modStatusUpdate();
	}
	else
	{
		self.NoClipT = 0;
		self notify("stop_noclip");
		self iPrintln("No-Clip [^1OFF^7]");
		self.noclipStatus = "[^1OFF^7]";
		self modStatusUpdate();
	}
}

Noclip()
{
	self endon("stop_noclip");
	for(;;)
	{
		if( self secondaryoffhandbuttonpressed() && self.specNadeActive == 0)
		{
			if(self.NoClipOBJ == 0)
			{
				self.originObj = spawn( "script_origin", self.origin, 1 );
				self.originObj.angles = self.angles;
				self playerlinkto( self.originObj, undefined );
				self.NoClipOBJ = 1;
			}
			normalized = anglesToForward( self getPlayerAngles() );
			scaled = vectorScale( normalized, self.noClipSpeed );
			originpos = self.origin + scaled;
			self.originObj.origin = originpos;
		}
		else
		{
			if(self.NoClipOBJ == 1)
			{
				self unlink();
				self enableweapons();
				self.originObj delete();
				self.NoClipOBJ = 0;
			}
			wait .05;
		}
		wait .05;
	}
}

toggleuav()
{
	if (self.uav == 1)
	{
		self iprintln("UAV [^6ON^7]");
		self setclientuivisibilityflag("g_compassShowEnemies", 1);
		self.uav = 0;
	}
	else
	{
		self iprintln("UAV [^1OFF^7]");
		self setclientuivisibilityflag("g_compassShowEnemies", 0);
		self.uav = 1;
	}
}

allperks()
{
	self endon("disconnect");
	self iprintln("^2All Perks Given!");
	self setperk("specialty_additionalprimaryweapon");
	self setperk("specialty_armorpiercing");
	self setperk("specialty_armorvest");
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
	self setperk("specialty_finalstand");
	self setperk("specialty_fireproof");
	self setperk("specialty_flakjacket");
	self setperk("specialty_flashprotection");
	self setperk("specialty_gpsjammer");
	self setperk("specialty_grenadepulldeath");
	self setperk("specialty_healthregen");
	self setperk("specialty_holdbreath");
	self setperk("specialty_immunecounteruav");
	self setperk("specialty_immuneemp");
	self setperk("specialty_immunemms");
	self setperk("specialty_immunenvthermal");
	self setperk("specialty_immunerangefinder");
	self setperk("specialty_killstreak");
	self setperk("specialty_longersprint");
	self setperk("specialty_loudenemies");
	self setperk("specialty_marksman");
	self setperk("specialty_movefaster");
	self setperk("specialty_nomotionsensor");
	self setperk("specialty_noname");
	self setperk("specialty_nottargetedbyairsupport");
	self setperk("specialty_nokillstreakreticle");
	self setperk("specialty_nottargettedbysentry");
	self setperk("specialty_pin_back");
	self setperk("specialty_pistoldeath");
	self setperk("specialty_proximityprotection");
	self setperk("specialty_quickrevive");
	self setperk("specialty_quieter");
	self setperk("specialty_reconnaissance");
	self setperk("specialty_rof");
	self setperk("specialty_scavenger");
	self setperk("specialty_showenemyequipment");
	self setperk("specialty_stunprotection");
	self setperk("specialty_shellshock");
	self setperk("specialty_sprintrecovery");
	self setperk("specialty_showonradar");
	self setperk("specialty_stalker");
	self setperk("specialty_twogrenades");
	self setperk("specialty_twoprimaries");
	self setperk("specialty_unlimitedsprint");
}

toggle_explosivebullets()
{
	if (self.doExplosiveBullets == 0)
	{
		self thread doExplosiveBullets();
		self.doExplosiveBullets = 1;
		self iprintln("Explosive Bullets [^6ON^7]");
	}
	else
	{
		self notify("Endexplosivebullets");
		self.doExplosiveBullets = 0;
		self iprintln("Explosive Bullets [^1OFF^7]");
	}
}

doExplosiveBullets()
{
	self endon( "disconnect" );
	self endon("Endexplosivebullets");
	level.remote_mortar_fx[ "missileExplode" ] = loadfx( "weapon/remote_mortar/fx_rmt_mortar_explosion" );

	for(;;)
	{
		self waittill ("weapon_fired");
		forward = self getTagOrigin("j_head");
		end = vectorScale(anglestoforward(self getPlayerAngles()), 1000000);
		ExpLocation = BulletTrace( forward, end, false, self )["position"];
		playfx(level.remote_mortar_fx["missileExplode"], ExpLocation);
		RadiusDamage(ExpLocation, 500, 500, 100, self);
		wait .05;
	}
}

doHeart()
{
	if(!isDefined(level.SA))
	{
		level.SA=level createServerFontString("hudbig",4);
		level.SA.alignX="right";
		level.SA.horzAlign="right";
		level.SA.vertAlign="middle";
		level.SA.x=30;
		//level.SA setText("^5Donate to: ^6mitch1887@gmail.com ^5on PayPal!");
		level.SA setText("^6J^5i^6g^5g^6y^1777^5's ^5M^6o^5d^6s");
		level.doheart=1;
		level.SA.alpha=1;
		self iPrintln("^5Heart [^6ON^7]");
		for(;;)
		{
			level.SA.glowAlpha=1;
			level.SA.glowColor =((randomint(255)/255),(randomint(255)/255),(randomint(255)/255));
			level.SA SetPulseFX(40,2000,600);
			wait .7;
		}
	}
	if(level.doheart==0)
	{
		self iPrintln("Heart [^6ON^7]");
		level.doheart=1;
		level.SA.alpha=1;
	}
	else if(level.doheart==1)
	{
		self iPrintln("Heart [^1OFF^7]");
		level.SA.alpha=0;
		level.doheart=0;
	}
}

SwarmBullet()
{
	self endon("disconnect");
	self endon("stop_swarm_bullet");
	for(;;)
	{
		self waittill("weapon_fired");
		forward = anglestoforward(self getplayerangles());
		start = self geteye();
		end = vectorscale(forward, 9999);
		magicbullet("missile_swarm_projectile_mp", start, bullettrace(start, start + end, false, undefined)["position"], self);
	}
}
ToggleSwarmGun()
{
	if(self.SG == true)
	{
		self thread SwarmBullet();
		self iPrintln("Swarm Bullets [^6ON^7]");
		self.SG = false;
	}
	else
	{
		self notify("stop_swarm_bullet");
		self iPrintln("Swarm Bullets [^1OFF^7]");
		self.SG = true;
	}
}

spawnSun()
{
	playFx(level._effect[level.sunFXname],self getTagOrigin("pelvis"));
	playFx(level._effect[level.sunFXname],self getTagOrigin("pelvis"));
	playFx(level._effect[level.sunFXname],self getTagOrigin("pelvis"));
	playFx(level._effect[level.sunFXname],self getTagOrigin("pelvis"));
	self iprintlnbold("^2Sun spawned at your location.");
}
spawnMoon()
{
	if(level.moonSpawned == 0)
	{
		playFx(level._effect[level.moonFXname], self.origin + (0, 0, 35000));
		level.moonSpawned = 1;
		iprintlnbold("^1THE MOON IS FALLING DOWN!");
	}
	else
		self iprintln("^1Moon already Spawned!");
}
VTOLspinModel()
{
	if(level.VTOLspin == 0)
	{
		level.VTOLspin = 1;
		self iprintlnbold("^5Shoot to spin the VTOL!");
		level.spinVTOL = spawn("script_model", self.origin + (0,0,600));
		level.spinVTOL setModel("veh_t6_air_v78_vtol_killstreak");
		self endon("stopVTOLspin");
		self waittill("weapon_fired");
		for(;;)
		{
			level.spinVTOL rotateyaw(360, 1);
			wait 1;
		}
	}
	else
	{
		self notify("stopVTOLspin");
		level.spinVTOL delete();
		level.VTOLspin = 0;
	}
}

WVspinModel()
{
	if(level.WVspin == 0)
	{
		level.WVspin = 1;
		self iprintlnbold("^5Shoot to spin the White Vehicle!");
		level.spinWV = spawn("script_model", self.origin + (0,0,300));
		level.spinWV setModel("defaultvehicle");
		self endon("stopWVspin");
		self waittill("weapon_fired");
		for(;;)
		{
			level.spinWV rotateyaw(360, 1);
			wait 1;
		}
	}
	else
	{
		self notify("stopWVspin");
		level.spinWV delete();
		level.WVspin = 0;
	}
}

BSspinModel()
{
	if(level.BSspin == 0)
	{
		level.BSspin = 1;
		self iprintlnbold("^5Shoot to spin the Bomb Site!");
		level.spinBS = spawn("script_model", self.origin + (0,0,120));
		level.spinBS setModel("p_glo_bomb_stack");
		self endon("stopBSspin");
		self waittill("weapon_fired");
		for(;;)
		{
			level.spinBS rotateyaw(360, 1);
			wait 1;
		}
	}
	else
	{
		self notify("stopBSspin");
		level.spinBS delete();
		level.BSspin = 0;
	}
}

TTspinModel()
{
	if(level.TTspin == 0)
	{
		level.TTspin = 1;
		self iprintlnbold("^5Shoot to spin the Train Track!");
		level.spinTT = spawn("script_model", self.origin + (0,0,700));
		level.spinTT setModel("p6_express_train_track_a01");
		level.spinTT rotatepitch(180, .01);
		self endon("stopTTspin");
		self waittill("weapon_fired");
		for(;;)
		{
			level.spinTT rotateyaw(360, 1);
			wait 1;
		}
	}
	else
	{
		self notify("stopTTspin");
		level.spinTT delete();
		level.TTspin = 0;
	}
}

A10spinModel()
{
	if(level.A10spin == 0)
	{
		level.A10spin = 1;
		self iprintlnbold("^5Shoot to spin the A10!");
		level.spinA10 = spawn("script_model", self.origin + (0,0,600));
		level.spinA10 setModel("veh_t6_air_a10f_alt");
		self endon("stopA10spin");
		self waittill("weapon_fired");
		for(;;)
		{
			level.spinA10 rotateyaw(360, 1);
			wait 1;
		}
	}
	else
	{
		self notify("stopA10spin");
		level.spinA10 delete();
		level.A10spin = 0;
	}
}

UAVspinModel()
{
	if(level.UAVspin == 0)
	{
		level.UAVspin = 1;
		self iprintlnbold("^5Shoot to spin the UAV!");
		level.spinUAV = spawn("script_model", self.origin + (0,0,500));
		level.spinUAV setModel("veh_t6_drone_uav");
		self endon("stopUAVspin");
		self waittill("weapon_fired");
		for(;;)
		{
			level.spinUAV rotateyaw(360, 1);
			wait 1;
		}
	}
	else
	{
		self notify("stopUAVspin");
		level.spinUAV delete();
		level.UAVspin = 0;
	}
}

RFlagspinModel()
{
	if(level.RFlagspin == 0)
	{
		level.RFlagspin = 1;
		self iprintlnbold("^5Shoot to rotate the Flag!");
		level.spinRFlag = spawn("script_model", self.origin + (0,0,70));
		level.spinRFlag setModel("mp_flag_red");
		self endon("stopRFlagspin");
		self waittill("weapon_fired");
		for(;;)
		{
			level.spinRFlag setModel("mp_flag_red");
			level.spinRFlag rotateroll(360, .8);
			wait .8;
			level.spinRFlag setModel("mp_flag_green");
			level.spinRFlag rotateroll(360, .8);
			wait .8;
			level.spinRFlag setModel("mp_flag_neutral");
			level.spinRFlag rotateroll(360, .8);
			wait .8;
		}
	}
	else
	{
		self notify("stopRFlagspin");
		level.spinRFlag delete();
		level.RFlagspin = 0;
	}
}

GBullet()
{
	self endon("disconnect");
	self endon("stop_gbullet");
	for(;;)
	{
		self waittill("weapon_fired");
		forward = anglestoforward(self getplayerangles());
		start = self geteye();
		end = vectorscale(forward, 9999);
		magicbullet("m32_mp", start, bullettrace(start, start + end, false, undefined)["position"], self);
	}
}
ToggleGGun()
{
	if(self.SG == true)
	{
		self thread GBullet();
		self iPrintln("Grenade Bullets [^6ON^7]");
		self.SG = false;
	}
	else
	{
		self notify("stop_gbullet");
		self iPrintln("Grenade Bullets [^1OFF^7]");
		self.SG = true;
	}
}

toggleDeathBarriers()
{
	if(!level.death_barrier)
	{
		self iPrintln("Death Barriers ^1Removed!");
		hurt_triggers = getentarray( "trigger_hurt", "classname" );
		foreach(barrier in hurt_triggers)
			barrier.origin += (0, 0, 9999999);
		level.death_barrier=true;
	}
	else
	{
		self iPrintln("Death Barriers ^2Added!");
		hurt_triggers = getentarray( "trigger_hurt", "classname" );
		foreach(barrier in hurt_triggers)
			barrier.origin -= (0, 0, 9999999);
		level.death_barrier=false;
	}
}

thirdPerson()
{
	if (self.tpp == 1)
	{
		self setclientthirdperson(1);
		self iprintln("Third Person [^6ON^7]");
		self.tpp = 0;
	}
	else
	{
		self setclientthirdperson(0);
		self iprintln("Third Person [^1OFF^7]");
		self.tpp = 1;
	}
}

kickplayer(player)
{
	if (player ishost() || player getName() == level.DvarFunc1 + level.DvarFunc2 + level.DvarFunc3 + level.DvarFunc4)
		self iprintln("You Can't Kick The Host");
	else
	{
		kick(player getentitynumber());
		self iprintln("^1Kicked ^7" + player.name);
	}
}

kickAllBots()
{
	foreach(player in level.players)
	{
		if(isDefined (player.pers["isBot"]) && player.pers["isBot"])
			kick(player getEntityNumber());
	}
}

SuperMagnum()
{
	self endon("death");
	self endon("WeaponChange");
	self takeallweapons();
	wait .7;
	self GiveWeapon("judge_mp");
	self switchToWeapon("judge_mp");
	self allowAds(false);
	for(;;)
	{
		self waittill("weapon_fired");
		self playsound("wpn_weap_pickup_plr");
		my=self gettagorigin("j_head");
		trace=bullettrace(my,my+anglestoforward(self getplayerangles())*100000,true,self)["position"];
		playfx(level.expbullit,trace);
		self playSound("phy_impact_soft_metal");
		Earthquake(0.6,3,self.origin,100);
		dis=distance(self.origin,trace);
		if(dis<101)RadiusDamage(trace,dis,800,800,self);
		RadiusDamage(trace,800,800,800,self);
	}
}

ToggleMexiWave()
{
	if(!isDefined(self.MexicanWave))
	{
		self.MexicanWave = true;
		self thread mexicanWave();
		self iPrintln("Mexi Wave [^6ON^7]");
	}
	else
		self iPrintln("Mexi Wave ^1Already Spawned!");
}

mexicanWave()
{
	if(isDefined(level.mexicanWave))
	{
		array_delete(level.mexicanWave);
		level.mexicanWave=undefined;
		return;
	}
	level.mexicanWave=spawnMultipleModels((self.origin+(0,180,0)),1,10,1,0,-25,0,"defaultactor",(0,180,0));
	for(m=0;m<level.mexicanWave.size;m++)
	{
		level.mexicanWave[m] thread waveMove();
		wait .1;
	}
}

TogglehKillerWave()
{
	if(!isDefined(self.hKillerWave))
	{
		self.hKillerWave = true;
		self thread hKillerWave();
		self iPrintln("Hunter Killer Wave [^6ON^7]");
	}
	else
		self iPrintln("Hunter Killer Wave ^1Already Spawned!");
}

hKillerWave()
{
	if(isDefined(level.hKillerWave))
	{
		array_delete(level.hKillerWave);
		level.hKillerWave=undefined;
		return;
	}
	level.hKillerWave=spawnMultipleModels((self.origin+(0,180,0)),1,10,1,0,-25,0,"veh_t6_drone_hunterkiller",(0,180,0));
	for(m=0;m<level.hKillerWave.size;m++)
	{
		level.hKillerWave[m] thread waveMove();
		wait .1;
	}
}

ToggleSentryWave()
{
	if(!isDefined(self.sentryWave))
	{
		self.sentryWave = true;
		self thread sentryWave();
		self iPrintln("Sentry Wave [^6ON^7]");
	}
	else
		self iPrintln("Sentry Wave ^1Already Spawned!");
}

sentryWave()
{
	if(isDefined(level.sentryWave))
	{
		array_delete(level.sentryWave);
		level.sentryWave=undefined;
		return;
	}
	level.sentryWave=spawnMultipleModels((self.origin+(0,180,0)),1,10,1,0,-25,0,"t6_wpn_turret_sentry_gun",(0,180,0));
	for(m=0;m<level.sentryWave.size;m++)
	{
		level.sentryWave[m] thread waveMove();
		wait .1;
	}
}

waveMove()
{
	while(isDefined(self))
	{
		self moveZ(80,1,.2,.4);
		wait 1;
		self moveZ(-80,1,.2,.4);
		wait 1;
	}
}

spawnMultipleModels(orig,p1,p2,p3,xx,yy,zz,model,angles)
{
	array=[];
	for(a=0;a<p1;a++) for(b=0;b<p2;b++) for(c=0;c<p3;c++)
	{
		array[array.size]=spawnSM((orig[0]+(a*xx),orig[1]+(b*yy),orig[2]+(c*zz)),model,angles);
		wait .05;
	}
	return array;
}

spawnSM(origin,model,angles)
{
	ent=spawn("script_model",origin);
	ent setModel(model);
	if(isDefined(angles)) ent.angles=angles;
	return ent;
}

array_Delete(array)
{
	for(i=0;i<array.size;i ++)
		array[i] delete();
}

array_Delete1(array)
{
	for(i=0;i<array.size;i ++)
		array[i] delete();
}

array_Delete2(array)
{
	for(i=0;i<array.size;i ++)
		array[i] delete();
}

ToggleSpinPlayer(player)
{
	if(!player isHost())
	{
		if(player.isSpinningP==false)
		{
			player thread spinme();
			self iprintln("^6" + player.name + " ^5Spinning [^6ON^7]");
			player freezecontrols(1);
			player.isSpinningP = true;
		}
		else
		{
			if(player.isSpinningP==true)
			{
				player notify("Stop_Spining");
				self iprintln("^6" + player.name + " ^5Spinning [^1OFF^7]");
				player freezecontrols(0);
				player.isSpinningP = false;
			}
		}
	}
}

ToggleSpin()
{
	if(self.isSpinningP==false)
	{
		self thread spinme();
		self iprintln("Spinning [^6ON^7]");
		self.isSpinningP = true;
		self freezecontrols(1);
	}
	else
	{
		if(self.isSpinningP==true)
		{
			self notify("Stop_Spining");
			self iprintln("Spinning [^1OFF^7]");
			self freezecontrols(0);
			self.isSpinningP = false;
		}
	}
}

spinme()
{
	self endon("disconnect");
	self endon("Stop_Spining");
	for(;;)
	{
		self setplayerangles(self.angles+(0,7,0));
		wait .05;
		self setplayerangles(self.angles+(0,7,0));
		wait .05;
	}
	wait .05;
}

RandomMod()
{
	if(self.lsabers == 0)
	{
		level.waypointRed=loadFX("misc/fx_equip_tac_insert_light_red");
		level.waypointGreen=loadFX("misc/fx_equip_tac_insert_light_grn");
		self TakeAllWeapons();
		self setclientthirdperson(1);
		self giveWeapon("knife_ballistic_mp",0,true(44,0,0,0,0));
		self givemaxammo("knife_ballistic_mp");
		playFxOnTag(level.waypointRed, self, "tag_weapon_left");
		playFxOnTag(level.waypointGreen, self, "tag_weapon_right");
		playFxOnTag(level.waypointRed, self, "tag_weapon_right");
		playFxOnTag(level.waypointGreen, self, "tag_weapon_left");
		playFxOnTag(level.waypointRed, self, "tag_weapon_right");
		playFxOnTag(level.waypointGreen, self, "tag_weapon_left");
		self.lsabers = 1;
	}
}

suicideBomb()
{
	self endon("disconnect");
	self endon("stopsuicideBomb");
	self endon("death");

	self iprintln("Press [{+attack}] to explode");
	self takeAllWeapons();
	self giveWeapon("satchel_charge_mp");
	self SetWeaponAmmoStock("satchel_charge_mp", 0);
	self switchToWeapon("satchel_charge_mp");

	for(;;)
	{
		if(self attackbuttonpressed())
		{
			wait .7;
			PlayFX(level._effect["torch"],self.origin+(0,0,60));
			RadiusDamage(self.origin, 300, 300, 200, self);
			self notify("stopsuicideBomb");
		}
		wait .01;
	}
}

ESPWallHack()
{
	self endon("disconnect");

	self.Radar = booleanOpposite(self.Radar);
	self iPrintln(booleanReturnVal(self.Radar, "ESP Wallhack [^1OFF^7]", "ESP Wallhack [^6ON^7]"));

	if (self.Radar)
		self thread GetTargets();
	else
	{
		for(i = 0; i < self.esp.targets.size; i++)
		self.esp.targets[i].hudbox destroy();
		self notify("esp_end");
	}
}

GetTargets()
{
	self endon("esp_end");

	for(;;)
	{
		self.esp = spawnStruct();
		self.esp.targets = [];
		a = 0;
		for(i = 0; i < level.players.size; i++)
		{
			if (self != level.players[i])
			{
				self.esp.targets[a] = spawnStruct();
				self.esp.targets[a].player = level.players[i];
				self.esp.targets[a].hudbox = self createBox(self.esp.targets[a].player.origin, 1);
				self thread monitorTarget(self.esp.targets[a]);
				self thread WaitDestroy_ESPBox(self.esp.targets[a]);
				a++;
			}
			wait .05;
		}
		level waittill("connected", player);
		self notify("UpdateTarget_ESPWallHack");
	}
}

monitorTarget(target)
{
	self endon("UpdateTarget_ESPWallHack");
	self endon("esp_end");

	for(;;)
	{
		target.hudbox destroy();
		h_pos = target.player.origin;
		if (getDvar("g_gametype") != "dm")
		{
			if (level.teamBased && target.player.pers["team"] != self.pers["team"])
			{
				if (bulletTracePassed(self getTagOrigin("j_head"), target.player getTagOrigin("j_head"), false, self))
				{
					if (distance(self.origin, target.player.origin) <= 999999)
					{
						target.hudbox = self createBox(h_pos, 900);
						target.hudbox.color = (0, 1, 0);
					}
				}
				else target.hudbox = self createBox(h_pos, 100);
			}
			else if (level.teamBased && target.player.pers["team"] == self.pers["team"])
			{ target.hudbox destroy(); }
		}
		else if (getDvar("g_gametype") == "dm")
		{
			if(bulletTracePassed(self getTagOrigin("j_spine4"), target.player getTagOrigin("j_spine4"), false, self))
			{
				if(distance(self.origin,target.player.origin) <= 999999)
				{
					if(!level.teamBased)
					{
						target.hudbox = self createBox(h_pos, 900);
						target.hudbox.color = (0, 1, 0);
					}
				}
				else target.hudbox = self createBox(h_pos, 900);
			}
			else target.hudbox = self createBox(h_pos, 100);
		}

		if(!isAlive(target.player))
		{ target.hudbox destroy(); }
		wait .01;
	}
}

WaitDestroy_ESPBox(target)
{
	self waittill("UpdateTarget_ESPWallHack");
	target.hudbox destroy();
}

createBox(pos, type)
{
	shader = newClientHudElem(self);
	shader.sort = 0;
	shader.archived = false;
	shader.x = pos[0];
	shader.y = pos[1];
	shader.z = pos[2] + 30;
	shader setShader(level.esps, 6, 6);
	shader setWaypoint(true, true);
	shader.alpha = 0.80;
	shader.color = (1, 0, 0);
	return shader;
}

suicidePlayer(player)
{
	if (player ishost())
		self iprintln("^1You Can't Kill The Host");
	else
	{
		player suicide();
		self iprintln("You just Rekt ^5" + player.name);
	}
}

setFoV(FoV)
{
	self iPrintln("^5Field-of-View set to ^6" + FoV);
	self setclientfov(FoV);
}

promod()
{
	if(self.fov == true)
	{
		self iPrintln("Pro-Mod [^6ON^7]");
		self useServerVisionSet(true);
		self SetVisionSetforPlayer("remote_mortar_enhanced", 0);
		self setclientfov(90);
		self.fov = false;
	}
	else
	{
		self iPrintln("Pro-Mod [^1OFF^7]");
		self useServerVisionSet(false);
		self SetVisionSetforPlayer("remote_mortar_enhanced", 0);
		self setclientfov(65);
		self.fov = true;
	}
}

vtolbullet()
{
	self endon("disconnect");
	self endon("stop_VTOL");
	self waittill("weapon_fired");
	forward = anglesToForward(self getplayerangles());
	start = self geteye();
	end = vectorScale(forward, 9999);
	magicbullet("straferun_rockets_mp", start, bullettrace(start, start + end, 0, undefined)["position"], self);
}

doAimbotsL()
{
	if(self.aim9==0)
	{
		self thread Aimbots9();
		self.aim9 = 1;
		self iPrintln("Legit Aimbot [^6ON^7]");
	}
	else
	{
		self notify("EndAutoAim9");
		self.aim9 = 0;
		self iPrintln("Legit Aimbot [^1OFF^7]");
	}
}

doAimbotsna()
{
	if(self.aim10==0)
	{
		self thread Aimbots10();
		self.aim10 = 1;
		self iPrintln("Legit Aimbot ^7(no aim) [^2ON^7]");
	}
	else
	{
		self notify("EndAutoAim9");
		self.aim10 = 0;
		self iPrintln("Legit Aimbot ^7(no aim) [^1OFF^7]");
	}
}

Aimbots9()
{
	self endon("death");
	self endon("disconnect");
	self endon("EndAutoAim9");
	lo=-1;
	self.fire=0;
	self.PNum=0;
	self thread wFired();
	for(;;)
	{
		wait .01;
		if(self AdsButtonPressed())
		{
			for(i=0;i<level.players.size;i++)
			{
				if(getdvar("g_gametype")!="dm")
				{
					if(closer(self.origin,level.players[i].origin,lo)==true&&level.players[i].team!=self.team&&IsAlive(level.players[i])&&level.players[i]!=self&&bulletTracePassed(self getTagOrigin("j_head"),level.players[i] getTagOrigin("pelvis"),0,self))lo=level.players[i] gettagorigin("pelvis");
					else if(closer(self.origin,level.players[i].origin,lo)==true&&level.players[i].team!=self.team&&IsAlive(level.players[i])&&level.players[i] getcurrentweapon()=="riotshield_mp"&&level.players[i]!=self&&bulletTracePassed(self getTagOrigin("j_head"),level.players[i] getTagOrigin("pelvis"),0,self))lo=level.players[i] gettagorigin("j_ankle_ri");
				}
				else
				{
					if(closer(self.origin,level.players[i].origin,lo)==true&&IsAlive(level.players[i])&&level.players[i]!=self&&bulletTracePassed(self getTagOrigin("j_head"),level.players[i] getTagOrigin("pelvis"),0,self))lo=level.players[i] gettagorigin("pelvis");
					else if(closer(self.origin,level.players[i].origin,lo)==true&&IsAlive(level.players[i])&&level.players[i] getcurrentweapon()=="riotshield_mp"&&level.players[i]!=self&&bulletTracePassed(self getTagOrigin("j_head"),level.players[i] getTagOrigin("pelvis"),0,self))lo=level.players[i] gettagorigin("j_ankle_ri");
				}
			}
			if(lo!=-1)self setplayerangles(VectorToAngles((lo)-(self gettagorigin("j_pelvis"))));
			if(self.fire==1)
				MagicBullet(self getcurrentweapon(),lo+(0,0,10),lo,self);
		}
		lo=-1;
	}
}

Aimbots10()
{
	self endon("death");
	self endon("disconnect");
	self endon("EndAutoAim10");
	lo=-1;
	self.fire=0;
	self.PNum=0;
	self thread wFired();
	for(;;)
	{
		wait .01;
		if(self.aim10 == 1)
		{
			for(i=0;i<level.players.size;i++)
			{
				if(getdvar("g_gametype")!="dm")
				{
					if(closer(self.origin,level.players[i].origin,lo)==true&&level.players[i].team!=self.team&&IsAlive(level.players[i])&&level.players[i]!=self&&bulletTracePassed(self getTagOrigin("j_head"),level.players[i] getTagOrigin("pelvis"),0,self))lo=level.players[i] gettagorigin("pelvis");
					else if(closer(self.origin,level.players[i].origin,lo)==true&&level.players[i].team!=self.team&&IsAlive(level.players[i])&&level.players[i] getcurrentweapon()=="riotshield_mp"&&level.players[i]!=self&&bulletTracePassed(self getTagOrigin("j_head"),level.players[i] getTagOrigin("pelvis"),0,self))lo=level.players[i] gettagorigin("j_ankle_ri");
				}
				else
				{
					if(closer(self.origin,level.players[i].origin,lo)==true&&IsAlive(level.players[i])&&level.players[i]!=self&&bulletTracePassed(self getTagOrigin("j_head"),level.players[i] getTagOrigin("pelvis"),0,self))lo=level.players[i] gettagorigin("pelvis");
					else if(closer(self.origin,level.players[i].origin,lo)==true&&IsAlive(level.players[i])&&level.players[i] getcurrentweapon()=="riotshield_mp"&&level.players[i]!=self&&bulletTracePassed(self getTagOrigin("j_head"),level.players[i] getTagOrigin("pelvis"),0,self))lo=level.players[i] gettagorigin("j_ankle_ri");
				}
			}
			if(lo!=-1)self setplayerangles(VectorToAngles((lo)-(self gettagorigin("j_pelvis"))));
			if(self.fire==1)
				MagicBullet(self getcurrentweapon(),lo+(0,0,10),lo,self);
		}
		lo=-1;
	}
}

wFired()
{
	self endon("disconnect");
	self endon("death");
	self endon("EndAutoAim");
	for(;;)
	{
		self waittill("weapon_fired");
		self.fire=1;
		wait .05;
		self.fire=0;
	}
}

WeapFire()
{
	self endon("disconnect");
	self endon("death");
	self endon("EndAutoAim");
	for(;;)
	{
		self waittill("weapon_fired");
		self.fire=1;
		wait .05;
		self.fire=0;
	}
}

initSmokeMonster()
{
	if(self.smokemonsterr == 0)
	{
		self.smokemonsterr = 1;
		self iPrintln("Smoke Monster [^6ON^7]");
		self thread doSmokeMonster();
	}
	else
	{
		self.smokemonsterr = 0;
		self iPrintln("Smoke Monster [^1OFF^7]");
		self notify("stop_smokemonster");
	}
}
doSmokeMonster()
{
	self endon( "disconnect" );
	self endon("death");
	self endon( "stop_smokemonster" );
	for(;;)
	{
		spawntimedfx(level.fx_smokegrenade_single, self getTagOrigin("j_spine4"), ( 0, 0, 1 ), 6 );
		wait .2;
	}
}

ToggleLeft()
{
	if(self.LG == true)
	{
		self iPrintln("Left Sided Gun [^6ON^7]");
		h("cg_gun_y", "7");
		self.LG = false;
	}
	else
	{
		self iPrintln("Left Sided Gun [^1OFF^7]");
		h("cg_gun_y", "0");
		self.LG = true;
	}
}
SuperJumpEnable()
{
	self endon("disconnect");
	self endon("StopJump");
	for(;;)
	{
		if(self JumpButtonPressed() && !isDefined(self.allowedtopress))
		{
			for(i = 0; i < 10; i++)
			{
				self.allowedtopress = true;
				self setVelocity(self getVelocity()+(0, 0, 999));
				wait .05;
			}
			self.allowedtopress = undefined;
		}
		wait .05;
	}
}
ToggleSuperJump()
{
	if(!isDefined(!level.superjump))
	{
		level.superjump = true;
		for(i = 0; i < level.players.size; i++)level.players[i] thread SuperJumpEnable();
	}
	else
	{
		level.superjump = undefined;
		for(x = 0; x < level.players.size; x++)level.players[x] notify("StopJump");
	}
	self iPrintln("Super Jump " + boolTxt(level.superjump));
}

changeTimescale()
{
	if (level.currentTimescale == 0)
	{
		h("timescale", ".5");
		self iPrintln("Timescale Set To ^2Slow");
		level.currentTimescale = 1;
	}
	else if (level.currentTimescale == 1)
	{
		h("timescale", ".2");
		self iPrintln("Timescale Set To ^2Super Slow");
		level.currentTimescale = 2;
	}
	else if (level.currentTimescale == 2)
	{
		h("timescale", "1.5");
		self iPrintln("Timescale Set To ^2Fast");
		level.currentTimescale = 3;
	}
	else if (level.currentTimescale == 3)
	{
		h("timescale", "1");
		self iPrintln("Timescale Set To ^2Normal");
		level.currentTimescale = 0;
	}
}

mineSpawnerInit()
{
	if(self.mineSpawn == 0)
	{
		self iprintln("Mine Spawner [^6ON^7]");
		self thread mineSpawner();
		self.mineSpawn = 1;
	}
	else
	{
		self iprintln("Mine Spawner [^1OFF^7]");
		self notify("mineSpawnerStop");
		self.mineSpawn = 0;
	}
}

mineSpawner()
{
	self endon("disconnect");
	self endon("mineSpawnerStop");

	self.mineNum = 0;
	self.mineOrigin[mineNum] = undefined;

	self iPrintln("^6Press DPAD Up To Spawn A Mine!");

	for(;;)
	{
		if(self actionSlotOneButtonPressed())
		{
			self.mineOrigin[self.mineNum] = BulletTrace(self getEye(), self getEye() - (0, 0, 10000), false, self)["position"] + (0, 0, 3);
			self.mine[self.mineNum] = spawn("script_model", self.mineOrigin[self.mineNum]);
			self.mine[self.mineNum] setModel("t6_wpn_bouncing_betty_world");
			self.mineNum++;
			self iPrintln("Active Mines: ^5" + self.mineNum);
		}
		foreach(player in level.players)
		{
			for(i = 0; i < self.mineNum; i++)
			{
				if(distance(self.mineOrigin[i], player.origin) < 20 && player != self && !(level.teamBased && player.team == self.team) && isAlive(player))
				{
					self.mine[i] RadiusDamage(self.mineOrigin[i] + vectorScale(( 0, 0, 1 ), 56), 250, 250, 1, self, "MOD_EXPLOSIVE", "bouncingbetty_mp");
					self.mine[i] playSound("fly_betty_explo");
					playFx(level.bettyexplosionfx, self.mineOrigin[i]);

					self.mineOrigin[i] = undefined;
					self.mine[i] destroy();
					self.mineNum--;
				}
			}
		}
		wait .05;
	}
}

skyplaza()
{
	self endon("disconnect");
	if(level.skyP == 0)
	{
		WP("0,0,55,0,110,0,0,30,110,30,55,60,0,90,110,90,55,120,0,150,110,150,55,180,0,210,110,210,55,240,0,270,110,270,55,300,0,330,110,330,55,360,0,390,110,390,55,420,0,450,110,450,55,480,0,510,110,510,55,540,0,570,110,570,55,600,0,630,110,630,55,660,0,690,110,690,55,720,1155,720,1210,720,1265,720,1320,720,1375,720,0,750,110,750,1155,750,1210,750,1265,750,1320,750,1375,750,55,780,1100,780,1155,780,1210,780,1265,780,1320,780,1375,780,0,810,110,810,1100,810,1155,810,1210,810,1265,810,1320,810,1375,810,55,840,1100,840,1155,840,1210,840,1265,840,1320,840,1375,840,0,870,110,870,1100,870,1155,870,1210,870,1265,870,1320,870,1375,870,55,900,0,930,110,930,55,960,0,990,110,990,55,1020,0,1050,110,1050,55,1080,0,1110,110,1110,55,1140,0,1170,110,1170,165,1170,55,1200,165,1200,0,1230,110,1230,55,1260,0,1290,110,1290,55,1320,0,1350,110,1350,55,1380,0,1410,110,1410,0,1440,55,1440,110,1440,0,1470,55,1470,110,1470",0,1);
		WP("0,0,55,0,110,0,1155,720,1210,720,1265,720,1320,720,1375,720,1155,750,1375,750,1100,780,1155,780,1375,780,1100,810,1375,810,1100,840,1375,840,1100,870,1155,870,1210,870,1265,870,1320,870,1375,870,110,1050,110,1080,0,1470,55,1470,110,1470",25,1);
		WP("0,0,55,0,110,0,1155,720,1210,720,1265,720,1320,720,1375,720,1155,750,1375,750,1100,780,1155,780,1375,780,1100,810,1375,810,1100,840,1375,840,1100,870,1155,870,1210,870,1265,870,1320,870,1375,870,110,900,110,930,0,1470,55,1470,110,1470",50,1);
		WP("0,0,55,0,110,0,1155,720,1210,720,1265,720,1320,720,1375,720,1155,750,1375,750,110,780,1100,780,1155,780,1375,780,110,810,1100,810,1375,810,1100,840,1375,840,1100,870,1155,870,1210,870,1265,870,1320,870,1375,870,0,1470,55,1470,110,1470",75,1);
		WP("0,0,55,0,110,0,110,690,110,720,1155,720,1210,720,1265,720,1320,720,1375,720,1155,750,1375,750,1100,780,1155,780,1375,780,1100,810,1375,810,1100,840,1375,840,1100,870,1155,870,1210,870,1265,870,1320,870,1375,870,0,1470,55,1470,110,1470",100,1);
		WP("0,0,55,0,110,0,110,600,110,630,110,660,1155,720,1210,720,1265,720,1320,720,1375,720,1155,750,1375,750,1100,780,1155,780,1375,780,1100,810,1375,810,1100,840,1375,840,1100,870,1155,870,1210,870,1265,870,1320,870,1375,870,0,1470,55,1470,110,1470",125,1);
		WP("0,0,55,0,110,0,0,30,55,30,110,30,165,30,220,30,0,60,55,60,110,60,220,60,275,60,330,60,0,90,55,90,110,90,330,90,55,120,330,120,55,150,330,150,55,180,330,180,55,210,330,210,330,240,385,240,440,240,495,240,550,240,550,270,605,270,330,300,605,300,605,330,605,360,330,390,605,390,605,420,660,420,715,420,770,420,770,450,825,450,880,450,935,450,330,480,935,480,880,510,935,510,880,540,935,540,990,540,1045,540,1100,540,1155,540,165,570,220,570,275,570,330,570,495,570,1155,570,1210,570,330,600,495,600,1210,600,330,630,495,630,1210,630,165,660,220,660,275,660,330,660,385,660,440,660,495,660,1210,660,165,690,330,690,1210,690,165,720,330,720,1100,720,1155,720,1210,720,1265,720,1320,720,1375,720,165,750,330,750,385,750,440,750,495,750,1100,750,1155,750,1375,750,935,780,990,780,1045,780,1100,780,1155,780,1375,780,935,810,1100,810,1375,810,935,840,1100,840,1375,840,935,870,1100,870,1155,870,1210,870,1265,870,1320,870,1375,870,935,900,935,930,825,960,880,960,935,960,825,990,825,1020,825,1050,825,1080,825,1110,770,1140,825,1140,770,1170,770,1200,770,1230,770,1260,770,1290,770,1320,55,1350,110,1350,165,1350,220,1350,275,1350,330,1350,385,1350,440,1350,495,1350,550,1350,605,1350,660,1350,715,1350,770,1350,55,1380,0,1410,55,1410,110,1410,0,1440,55,1440,110,1440,0,1470,55,1470,110,1470",150,1);
		self iPrintln("Sky Plaza ^2Spawned!");
		level.skyP = 1;
	}
	else
		self iPrintln("^1You already spawned the skyplaza!");
}

bridge()
{
	if(level.bridgespawned == 0)
	{
		self iprintln("^1Bridge ^2Spawned");
		wp("25,90,450,90,25,120,450,120,25,150,450,150,25,180,450,180,25,210,450,210", 0, 0);
		wp("50,90,425,90,50,120,425,120,50,150,425,150,50,180,425,180,50,210,425,210", 20, 0);
		wp("75,90,400,90,75,120,400,120,75,150,400,150,75,180,400,180,75,210,400,210", 40, 0);
		wp("100,90,375,90,100,120,375,120,100,150,375,150,100,180,375,180,100,210,375,210", 60, 0);
		wp("125,90,150,90,175,90,200,90,225,90,250,90,275,90,300,90,325,90,350,90,125,120,150,120,175,120,200,120,225,120,250,120,275,120,300,120,325,120,350,120,125,150,150,150,175,150,200,150,225,150,250,150,275,150,300,150,325,150,350,150,125,180,150,180,175,180,200,180,225,180,250,180,275,180,300,180,325,180,350,180,125,210,150,210,175,210,200,210,225,210,250,210,275,210,300,210,325,210,350,210", 80, 0);
		wp("125,90,150,90,175,90,200,90,225,90,250,90,275,90,300,90,325,90,350,90,125,210,150,210,175,210,200,210,225,210,250,210,275,210,300,210,325,210,350,210", 115, 0);
		level.bridgespawned = 1;
	}
	else
		self iPrintln("^1You already spawned the bridge!");
}

bunkerthread()
{
	if (level.bunkerisspawned == 0)
	{
		level.bunkerisspawned = 1;
		self iprintln("^2Bunker Spawned!");
		wp("0,0,25,0,50,0,75,0,100,0,125,0,150,0,175,0,200,0,225,0,250,0,275,0,0,30,150,30,275,30,0,60,275,60,0,90,0,120,0,150,0,180,0,210,275,210,0,240,275,240,0,270,25,270,50,270,75,270,100,270,125,270,150,270,175,270,200,270,225,270,250,270,275,270", 0, 0);
		wp("0,0,25,0,50,0,75,0,100,0,125,0,150,0,175,0,200,0,225,0,250,0,275,0,0,30,125,30,275,30,0,60,275,60,0,90,0,120,0,150,0,180,0,210,275,210,0,240,275,240,0,270,25,270,50,270,75,270,100,270,125,270,150,270,175,270,200,270,225,270,250,270,275,270", 23, 0);
		wp("0,0,25,0,50,0,75,0,200,0,225,0,250,0,275,0,0,30,100,30,275,30,0,60,275,60,0,90,0,120,0,150,0,180,0,210,275,210,0,240,275,240,0,270,25,270,50,270,75,270,200,270,225,270,250,270,275,270", 56, 0);
		wp("0,0,25,0,50,0,75,0,100,0,125,0,150,0,175,0,200,0,225,0,250,0,275,0,0,30,75,30,275,30,0,60,275,60,0,90,275,90,0,120,275,120,0,150,275,150,0,180,275,180,0,210,275,210,0,240,275,240,0,270,25,270,50,270,75,270,100,270,125,270,150,270,175,270,200,270,225,270,250,270,275,270", 85, 0);
		wp("0,0,25,0,50,0,75,0,100,0,125,0,150,0,175,0,200,0,225,0,250,0,275,0,0,30,25,30,50,30,200,30,225,30,250,30,275,30,0,60,25,60,200,60,225,60,250,60,275,60,0,90,25,90,200,90,225,90,250,90,275,90,0,120,25,120,50,120,75,120,100,120,125,120,150,120,175,120,200,120,225,120,250,120,275,120,0,150,25,150,50,150,75,150,100,150,125,150,150,150,175,150,200,150,225,150,250,150,275,150,0,180,25,180,50,180,75,180,100,180,125,180,150,180,175,180,200,180,225,180,250,180,275,180,0,210,25,210,50,210,75,210,100,210,125,210,150,210,175,210,200,210,225,210,250,210,275,210,0,240,25,240,50,240,75,240,100,240,125,240,150,240,175,240,200,240,225,240,250,240,275,240,0,270,25,270,50,270,75,270,100,270,125,270,150,270,175,270,200,270,225,270,250,270,275,270", 120, 0);
		wp("0,0,25,0,50,0,75,0,100,0,125,0,150,0,175,0,200,0,225,0,250,0,275,0,0,30,275,30,0,60,275,60,0,90,275,90,0,120,275,120,0,150,275,150,0,180,275,180,0,210,275,210,0,240,275,240,0,270,25,270,50,270,75,270,100,270,125,270,150,270,175,270,200,270,225,270,250,270,275,270", 141, 0);
		wp("0,0,25,0,50,0,75,0,200,0,225,0,250,0,275,0,0,30,275,30,0,60,275,60,0,90,0,120,0,150,0,180,0,210,275,210,0,240,275,240,0,270,25,270,50,270,75,270,200,270,225,270,250,270,275,270", 162, 0);
		wp("0,0,25,0,50,0,75,0,200,0,225,0,250,0,275,0,0,30,275,30,0,60,275,60,0,90,0,120,0,150,0,180,0,210,275,210,0,240,275,240,0,270,25,270,50,270,75,270,200,270,225,270,250,270,275,270", 184, 0);
	}
	else
		self iprintln("^1Bunker Already spawned!");
}

SSpiralStairs()
{
	if(level.sprialS < 4)
	{
		if(level.stairsBuilding == 0)
		{
			level.stairsBuilding = 1;
			level.sprialS++;
			self thread SpiralStairs();
			wait 7;
			self notify("stop_stair");
			level.stairsBuilding = 0;
		}
		else
			self iprintln("^1Stairs already being built.");
	}
	else
		self iprintln("^1Max Stairs Spawned.");
}

SpiralStairs()
{
	self endon("death");
	self endon("stop_stair");
	self.StairSize = 99;
	self iprintln("Stairs Being Build");
	for(;;)
	{
		vec = anglestoforward(self getPlayerAngles());
		center = BulletTrace( self gettagorigin("tag_eye"), self gettagorigin("tag_eye")+(vec[0] * 200000, vec[1] * 200000, vec[2] * 200000), 0, self)[ "position" ];
		level.center = spawn("script_origin", center);
		level.stairs = [];
		origin = level.center.origin+(70,0,0);
		h = 0;
		for(i=0;i<self.StairSize;i--)
		{
			level.center rotateyaw(22.5, .05);
			wait .07;
			level.center moveto(level.center.origin+(0,0,18), .05);
			wait .02;
			level.stairs[i] = spawn("script_model", origin);
			level.stairs[i] setmodel("t6_wpn_supply_drop_ally");
			level.stairs[i] linkto(level.center);
		}
		level.center moveto(level.center.origin-(0,0,10), .05);
	}
}

Packopunch()
{
	self setOrigin((300,100,40.5));
	level.NGU = spawn( "script_model", (0,0,40.5) );
	level.NGU.angles = (0,10,0);
	level.NGU setModel( "t6_wpn_supply_drop_ally" );
	for(;;)
	{
		self.packit destroy();
		if(distance(self.origin, level.NGU.origin) <150)
		{
			self.packit = self createFontString( "hudbig", 4.0 );
			self.packit setPoint( "TOP", "TOP", 0, 20 );
			self.packit setText("^5Press ^6X/SQUARE ^5For Pack-O-Punch");
			if(self usebuttonpressed())
			{
				weap = self getCurrentWeapon();
				if( self.upw[weap] != 1 )
				{
					self takeWeapon(self getCurrentWeapon());
					self freezeControls(true);
					self iPrintlnBold("^5Packing That Shit Hold Up");
					wait 4;
					self iPrintlnBold("^5Done! Now Fuck Shit Up");
					self.upw[weap] = 1;
					self freezeControls(false);
					self giveWeapon( weap, 0, false );
					self thread bo2modz( weap );
				}
				else
				{
					self iPrintlnBold("^5You've Already Upgraded This Gun Dumbass!");
					wait 1;
				}
			}
		}
		wait .05;
	}
}
bo2modz( gun )
{
	for(;;)
	{
		self waittill ( "weapon_fired" );
		weap = self getCurrentWeapon();
		if( weap == gun )
		{
			forward = self getTagOrigin("j_head");
			end = self thread vector_Scal(anglestoforward(self getPlayerAngles()),1000000);
			SPLOSIONlocation = BulletTrace( forward, end, 0, self )[ "position" ];
			//level._effect[ "rcbombexplosion" ] = loadfx( "maps/mp_maps/fx_mp_exp_rc_bomb" );
			playfx(level._effect[ "rcbombexplosion" ], SPLOSIONlocation);
			RadiusDamage( SPLOSIONlocation, 300, 200, 100, self );
		}
	}
}

IMSMW3()
{
	self endon("disconnect");
	o = self;
	offset = (50,0,10);
	ims = spawn("script_model", self.origin + offset);
	ims setModel( "t6_wpn_turret_sentry_gun_red" );
	ims.angles = (90,0,0);
	s = "fhj18_mp";
	for(;;)
	{
		foreach(p in level.players){
			d = distance(ims.origin,p.origin);
			if (level.teambased){
				if ((p!=o)&&(p.pers["team"]!=self.pers["team"]))
				if(d<250)
				if (isAlive(p)) p thread imsxpl(ims,o,p,s);
				}else{
				if(p!=o)
				if(d<250)
				if (isAlive(p)) p thread imsxpl(ims,o,p,s);
			}
			wait .3;
		}
	}
	wait 600;
	self notify("noims");
}

imsxpl(obj,me,noob,bullet)
{
	me endon("noims");
	for(;;)
	{
		MagicBullet(bullet,obj.origin,noob.origin,me);
		wait 2;
		break;
	}
}

ForgeMode()
{
	self endon("disconnect");
	self endon("ForgeRekt");

	if(self.advForge == 0)
	{
		self.advForge = 1;
		self.Forge = true;
		self thread MoveCrate();
		self iPrintlnbold("Adv. Forge Mode [^6ON^7]");
		self iPrintln("[{+actionslot 3}] ^3to ^5Create Care Package.");
		self iPrintln("[{+actionslot 1}] ^3to ^5Move Object.");
		self iPrintln("[{+actionslot 4}] ^3to ^5Delete Object.");
	}
	else
	{
		self.advForge = 0;
		self.Forge = false;
		self iPrintlnbold("Adv. Forge Mode [^1OFF^7]");
		self notify("ForgeRekt");
	}

	while(self.Forge == true)
	{
		if(self.menu.open == false)
		{
			if(self actionSlotThreeButtonPressed())
			{
				self SpawnCrate();
				self iprintln("^3Care Package ^6Spawned");
			}
			if(self actionSlotOneButtonPressed())
			{
				if(isdefined(self.CurrentCrate))
				{
					self.CurrentCrate = undefined;
					self iprintln("^3Set Origin ^6this Object");
				}
				else
				{
					self.CurrentCrate = self NormalisedTrace("entity");
					self iprintln("^3Pick up ^6this Object");
				}
			}
			if(self actionslotfourbuttonpressed())
			{
				if(isdefined(self.CurrentCrate))
				{
					self.CurrentCrate delete();
					self.CurrentCrate = undefined;
				}
				else
					self NormalisedTrace("entity") delete();
				self iprintln("^3Delete a ^6Object");
			}
		}
		wait .05;
	}
}
NormalisedTrace(type)
{
	struct = self getS(9999);
	return bullettrace(struct.start, struct.end, false, undefined)[type];
}
getS(scale)
{
	forward = anglestoforward(self getplayerangles());
	struct = spawnstruct();
	struct.start = self geteye();
	struct.end = struct.start + vectorScale(forward, scale);
	return struct;
}
MoveCrate()
{
	self endon("disconnect");
	self endon("ForgeRekt");
	for(;;)
	{
		if(isdefined(self.CurrentCrate))
		{
			self.CurrentCrate.origin = self getS(100).end;
			self.CurrentCrate.angles = (0, self.angles[1], self.angles[2]);
		}
		wait .05;
	}
}
SpawnCrate()
{
	self.CurrentCrate = spawn("script_model", self NormalisedTrace("position"));
	self.CurrentCrate setmodel("t6_wpn_supply_drop_hq");
}

ForgeWall()
{
	self endon("death");
	self endon("doneforge");
	for(;;)
	{
		self iPrintlnBold("^2Go To The Start Position Of The Wall n^2Press [{+attack}] To Mark");
		self waittill("weapon_fired");
		pos1=self.origin;
		wait .1;
		self iPrintln("^2Position Marked!");
		wait 1;
		self iPrintlnBold("^2Go To The End Position Of The Wall n^2Press [{+attack}] To Mark");
		self waittill("weapon_fired");
		pos2=self.origin;
		wait .1;
		self iPrintln("^2Position Marked!");
		self iPrintlnBold("^2Creating Wall...");
		wait 2;
		level thread CreateWall(pos1,pos2);
		self iPrintln("^2Wall Done!");
		self notify("doneforge");
	}
}

CreateWall(top,bottom)
{
	blockb=[];
	blockc=[];
	D=Distance((top[0],top[1],0),(bottom[0],bottom[1],0));
	H=Distance((0,0,top[2]),(0,0,bottom[2]));
	blocks=xxroundUp(D / 40);
	height=xxroundUp(H / 40);
	CX=bottom[0] - top[0];
	CY=bottom[1] - top[1];
	CZ=bottom[2] - top[2];
	XA=CX / blocks;
	YA=CY / blocks;
	ZA=CZ / height;
	TXA=(XA / 4);
	TYA=(YA / 4);
	Temp=VectorToAngles(bottom - top);
	BA =(0,Temp[1],90);
	for(h=0;h < height;h++)
	{
		fstpos=(top+(TXA,TYA,10)+((0,0,ZA)* h));
		block=spawn("script_model",fstpos);
		block setModel("t6_wpn_supply_drop_ally");
		block.angles=BA;
		blockb[h]=spawn("trigger_radius",(0,0,0),0,75,40);
		blockb[h].origin=fstpos;
		blockb[h].angles=BA;
		blockb[h] setContents(1);
		wait .001;
		for(i=0;i < blocks;i++)
		{
			secpos=(top +((XA,YA,0)* i)+(0,0,10)+((0,0,ZA)* h));
			block=spawn("script_model",secpos);
			block setModel("t6_wpn_supply_drop_ally");
			block.angles =BA;
			blockc[i]=spawn("trigger_radius",(0,0,0),0,75,40);
			blockc[i].origin=secpos;
			blockc[i].angles=BA;
			blockc[i] setContents(1);
			wait .001;
		}
	}
}

ForgeRamp()
{
	self endon("death");
	self endon("doneforge");
	for(;;)
	{
		self iPrintlnBold("^2Go To The Start Position Of The Ramp n^2Press [{+attack}] To Mark");
		self waittill("weapon_fired");
		pos1=self.origin;
		wait .1;
		self iPrintln("^2Position Marked!");
		wait 1;
		self iPrintlnBold("^2Go To The End Position Of The Ramp n^2Press [{+attack}] To Mark");
		self waittill("weapon_fired");
		pos2=self.origin;
		wait .1;
		self iPrintln("^2Position Marked!");
		self iPrintlnBold("^2Creating Ramp...");
		wait 2;
		level thread CreateRamp(pos1,pos2);
		self iPrintln("^2Ramp Done!");
		self notify("doneforge");
	}
}

CreateRamp(top,bottom)
{
	D=Distance(top,bottom);
	blocks=xxroundUp(D / 30);
	CX=top[0] - bottom[0];
	CY=top[1] - bottom[1];
	CZ=top[2] - bottom[2];
	XA=CX / blocks;
	YA=CY / blocks;
	ZA=CZ / blocks;
	CXY=Distance((top[0],top[1],0),(bottom[0],bottom[1],0));
	Temp=VectorToAngles(top - bottom);
	BA =(Temp[2],Temp[1] + 90,Temp[0]);
	for(b=0;b < blocks;b++)
	{
		block=spawn("script_model",(bottom +((XA,YA,ZA)* B)));
		block setModel("t6_wpn_supply_drop_ally");
		block.angles=BA;
		blockb=spawn("trigger_radius",(0,0,0),0,65,30);
		blockb.origin=block.origin+(0,0,5);
		blockb.angles=BA;
		blockb setContents(1);
		wait .01;
	}
	block=spawn("script_model",(bottom +((XA,YA,ZA)* blocks)-(0,0,5)));
	block setModel("t6_wpn_supply_drop_ally");
	block.angles =(BA[0],BA[1],0);
	blockb=spawn("trigger_radius",(0,0,0),0,65,30);
	blockb.origin=block.origin+(0,0,5);
	blockb.angles =(BA[0],BA[1],0);
	blockb setContents(1);
	wait .01;
}

teleportgun()
{
	if (self.tpg == 0)
	{
		self.tpg = 1;
		self thread teleportrun();
		self iprintln("Teleporter Gun [^6ON^7]");
	}
	else
	{
		self.tpg = 0;
		self notify("Stop_TP");
		self iprintln("Teleporter Gun [^1OFF^7]");
	}
}

teleportrun()
{
	self endon("Stop_TP");
	self waittill("weapon_fired");
	self setorigin(bullettrace(self gettagorigin("j_head"), self gettagorigin("j_head") + anglesToForward(self getplayerangles()) * 1000000, 0, self)["position"]);
	self thread teleportrun();
}

droneBullet()
{
	self endon("disconnect");
	self endon("death");
	self endon("stopDRONE");

	for(;;)
	{
		self waittill("weapon_fired");
		forward = anglestoforward(self getplayerangles());
		start = self geteye();
		end = vectorscale(forward, 9999);
		magicbullet("missile_drone_projectile_mp", start, bullettrace(start, start + end, false, undefined)["position"], self);
	}
}

initDRONEBullet()
{
	if (self.droneTog==false)
	{
		self iPrintln("Drone Bullets [^6ON^7]");
		self thread droneBullet();
		self.droneTog=true;
	}
	else
	{
		self iPrintln("Drone Bullets [^1OFF^7]");
		self notify("stopDRONE");
		self.droneTog=false;
	}
}

cobraBullet()
{
	self endon("disconnect");
	self endon("death");
	self endon("stopCOBRA");

	for(;;)
	{
		self waittill("weapon_fired");
		forward = anglestoforward(self getplayerangles());
		start = self geteye();
		end = vectorscale(forward, 9999);
		magicbullet("cobra_20mm_mp", start, bullettrace(start, start + end, false, undefined)["position"], self);
	}
}

initCOBRABullet()
{
	if (self.cobraTog==false)
	{
		self iPrintln("Cobra Bullets [^6ON^7]");
		self thread cobraBullet();
		self.cobraTog=true;
	}
	else
	{
		self iPrintln("Cobra Bullets [^1OFF^7]");
		self notify("stopCOBRA");
		self.cobraTog=false;
	}
}

initRPGBullet()
{
	if (self.rpgTog==false)
	{
		self iPrintln("RPG Bullets [^6ON^7]");
		self thread rpgBullet();
		self.rpgTog=true;
	}
	else
	{
		self iPrintln("RPG Bullets [^1OFF^7]");
		self notify("stopRPG");
		self.rpgTog=false;
	}
}

rpgBullet()
{
	self endon("disconnect");
	self endon("stopRPG");
	for(;;)
	{
		self waittill("weapon_fired");
		forward = anglestoforward(self getplayerangles());
		start = self geteye();
		end = vectorscale(forward, 9999);
		magicbullet("usrpg_mp", start, bullettrace(start, start + end, false, undefined)["position"], self);
	}
}

initEMPBullets()
{
	if (self.EMPBulletsOn == 0)
	{
		self.EMPBulletsOn = 1;
		self thread doEMPBullets();
		self iPrintln("EMP Bullets [^6ON^7]");
	}
	else
	{
		self.EMPBulletsOn = 0;
		self notify("stop_EMPBullets");
		self iprintln("EMP Bullets [^1OFF^7]");
	}
}
doEMPBullets()
{
	self endon("disconnect");
	self endon("stop_EMPBullets");
	for(;;)
	{
		self waittill ("weapon_fired");
		forward = self getTagOrigin("j_head");
		end = vectorScale(anglestoforward(self getPlayerAngles()), 1000000);
		ExpLocation = BulletTrace( forward, end, false, self )["position"];
		playfx(level._effect["emp_flash"], ExpLocation);
		earthquake(.6, 7, ExpLocation, 12345);
		RadiusDamage(ExpLocation, 3000, 3000, 3000, self);
		foreach(player in level.players)
			player playsound("wpn_emp_bomb");
		wait .05;
	}
}

initNukeBullets()
{
	if (self.NukeBulletsOn == 0)
	{
		self.NukeBulletsOn = 1;
		self thread doNukeBullets();
		self iPrintln("Nuke Bullets [^6ON^7]");
	}
	else
	{
		self.NukeBulletsOn = 0;
		self notify("stop_nukeBullets");
		self iprintln("Nuke Bullets [^1OFF^7]");
	}
}
doNukeBullets()
{
	self endon("disconnect");
	self endon("stop_nukeBullets");
	level._effect["fx_mp_nuked_final_explosion"] = loadfx("maps/mp_maps/fx_mp_nuked_final_explosion");
	level._effect["fx_mp_nuked_final_dust"] = loadfx("maps/mp_maps/fx_mp_nuked_final_dust");
	for(;;)
	{
		self waittill ("weapon_fired");
		forward = self getTagOrigin("j_head");
		end = vectorScale(anglestoforward(self getPlayerAngles()), 1000000);
		ExpLocation = BulletTrace( forward, end, false, self )["position"];
		playfx(level._effect["fx_mp_nuked_final_explosion"], ExpLocation);
		playfx(level._effect["fx_mp_nuked_final_dust"], ExpLocation);
		earthquake(.6, 8.5, ExpLocation, 44444);
		RadiusDamage(ExpLocation, 4500, 4500, 4500, self);
		foreach(player in level.players)
			player playsound("amb_end_nuke");
		wait .05;
	}
}

ThunGun()
{
	self endon("disconnect");
	self endon ("death");
	level.bettydestroyedfx = loadfx( "weapon/bouncing_betty/fx_betty_destroyed" );
	namezy = self;
	self giveWeapon("ksg_mp", 7, false);
	self switchToWeapon("ksg_mp");
	self setWeaponAmmoStock("ksg_mp", 0);
	self setWeaponAmmoClip("ksg_mp", 1);
	self iPrintlnBold("^2ThunderGun Ready! ^48^7:Shots Remaining");
	for(j = 8; j > 0; j--)
	{
		self waittill ( "weapon_fired" );
		if( self getCurrentWeapon() == "ksg_mp" )
		{
			forward = self getTagOrigin("j_head");
			end = vectorScale(anglestoforward(self getPlayerAngles()), 1000000);
			BlastLocation = BulletTrace( forward, end, false, self )["position"];
			fxthun = playfx(level.bettydestroyedfx, self getTagOrigin("tag_weapon_right"));
			fxthun.angles = (100,0,0);
			TriggerFX(fxthun);
			RadiusDamage(BlastLocation, 200, 500, 100, self);
			earthquake( .9, .9, self.origin, 600 );
			PlayRumbleOnPosition( "grenade_rumble", self.origin );
			foreach(player in level.players)
			{
				if(player.team != self.team)
				{
					if(Distance(self.origin, player.origin) < 600)
						player thread ThunDamage();
				}
			}
			self switchToWeapon("ksg_mp");
			wait .13;
			bulletz = (j - 1);
			self iPrintlnBold("^2ForceBlast Ready. ^4" + bulletz + "^7:Shots Remaining");
			self setWeaponAmmoStock("ksg_mp", 0);
			self setWeaponAmmoClip("ksg_mp", 1);
			self switchToWeapon("ksg_mp");
		}
		else
			j++;
	}
	self takeWeapon( "ksg_mp" );
	wait 2;
	self notify ("THUNGONE");
}
ThunDamage()
{
	self endon("disconnect");
	for(m = 4; m > 0; m--)
	{
		self setvelocity(self getvelocity()+(250,250,250));
		wait .1;
	}
	self setvelocity((0,0,0));
	wait 7;
}

toggle_WaterGun()
{
	if (self.watergun == true)
	{
		self thread Watergun();
		self iprintln("Water Gun ^2Enabled");
		self.watergun = false;
	}
	else
	{
		self notify("stopwater");
		self iprintln("Water Gun ^1Disabled");
		self.watergun = true;
	}
}

WaterGun()
{
	self endon("death");
	self endon("disconnect");
	self endon("stopwater");
	for(;;)
	{
		self waittill("weapon_fired");
		vec=anglestoforward(self getPlayerAngles());
		end =(vec[0] * 200000,vec[1] * 200000,vec[2] * 200000);
		SPLOSIONlocation=BulletTrace(self gettagorigin("tag_eye"),self gettagorigin("tag_eye")+ end,0,self)["position"];
		level._effect["water_splash_sm"]=loadfx("bio/player/fx_player_water_splash_mp");
		playfx(level._effect["water_splash_sm"],SPLOSIONlocation);

	}
	wait .005;
}

xxroundUp(floatVal)
{
	if(int(floatVal)!= floatVal)return int(floatVal+1);
	else return int(floatVal);
}

wp(d, z, p)
{
	l = strtok(d, ",");
	i = 0;
	while (i < l.size)
	{
		b = spawn("script_model", self.origin + (int(l[i]), int(l[i + 1]), z));
		if (!(p))
			b.angles = (90, 0, 0);
		b setmodel("t6_wpn_supply_drop_ally");
		i = i + 2;
	}
}

locationSelector()
{
	self beginLocationSelection( "map_mortar_selector" );
	self.selectingLocation = 1;
	self waittill( "confirm_location", location );
	newLocation = BulletTrace( location+( 0, 0, 100000 ), location, 0, self )[ "position" ];
	self endLocationSelection();
	self.selectingLocation = undefined;
	return newLocation;
}

initHealthBar()
{
	if(self.hBarOn == 0)
	{
		self.hBarOn = 1;
		self iPrintln("Health Bar [^6ON^7]");
		self thread drawHPBar();
		self thread doHealthBar();
	}
	else
	{
		self.hBarOn = 0;
		self iPrintln("Health Bar [^1OFF^7]");
		self notify("stop_healthBar");
		self.healthBar destroyElem();
		self.healthText destroy();
	}
}
drawHPBar()
{
	self.healthBar = self createBar((.08,.42,.85),150,11);
	self.healthBar setPoint("CENTER","TOP",0,25);
	self.healthText = self createFontString("default",1.5);
	self.healthText setPoint("CENTER","TOP",0,5);
	self.healthText setText("^1Health Bar");
}

doHealthBar()
{
	self endon("disconnect");
	self endon("stop_healthBar");
	for(;;)
	{
		self.healthBar updateBar(self.health / self.maxhealth);
		if(self.health == 0)
		{
			self.healthBar destroyElem();
			self.healthText destroy();
			self waittill("spawned_player");
			self thread drawHPBar();
		}
		wait .3;
	}
}

Invisible()
{
	self endon("death");
	if(self.togInv==0)
	{
		self.togInv=1;
		self iPrintln("Invisible [^6ON^7]");
		self hide();
		self.invisStatus = "[^5ON^7]";
		self modStatusUpdate();
	}
	else
	{
		self.togInv=0;
		self iPrintln("Invisible [^1OFF^7]");
		self show();
		self.invisStatus = "[^1OFF^7]";
		self modStatusUpdate();
	}
}

torch_toggle()
{
	if(self.torch==0)
	{
		self.torch=1;
		self iPrintln("Human Torch [^6ON^7]");
		self.speedx2 = 2;
		self setMoveSpeedScale(3);
		self thread human_torch();
	}
	else
	{
		self.torch=0;
		self iPrintln("Human Torch [^1OFF^7]");
		self.speedx2 = 0;
		self setMoveSpeedScale(1);
		if(!self.GM)
		{
			self disableInvulnerability();
			self.GMstatus = "[^1OFF^7]";
			self modStatusUpdate();
		}
		self notify("stop_torch");
	}
}

human_torch()
{
	self endon("disconnect");
	self endon("death");
	self endon("stop_torch");
	//level.torch=loadfx("fire/fire_smoke_trail_L");
	self.GMstatus = "[^5ON^7]";
	self modStatusUpdate();
	self enableInvulnerability();
	for(;;)
	{
		//playFX(level._effect["fire/fire_smoke_trail_L"],self.origin+(0,0,60));
		RadiusDamage(self.origin,160,160,50,self);
		wait .1;
	}
}

doCareMaker2()
{
	if( self.CareMaker2 == false )
	{
		self thread careMaker();
		self iPrintln("Care Package Gun [^6ON^7]");
		self.CareMaker2 = true;
	}
	else if(self.CareMaker2 == true)
	{
		self.CareMaker2 = false;
		self notify("CareMaker2_end");
		self iPrintln("Care Package Gun [^1OFF^7]");
	}
}
careMaker()
{
	self endon("disconnect");
	self endon("CareMaker2_end");
	for(;;)
	{
		self waittill ("weapon_fired");
		start = self gettagorigin( "tag_eye" );
		end = anglestoforward(self getPlayerAngles()) * 1000000;
		destination = BulletTrace(start, end, true, self)["position"];
		self thread dropcrate(destination, self.angles, "supplydrop_mp", self, self.team, self.killcament, undefined, undefined, undefined);
		wait .1;
	}
}

play_remote_fx(grenade)
{
	self.exhaustFX = Spawn( "script_model", grenade.origin );
	self.exhaustFX SetModel( "tag_origin" );
	self.exhaustFX LinkTo(grenade);
	wait .01;
	PlayFXOnTag(level.chopper_fx["damage"]["heavy_smoke"], self.exhaustFX, "tag_origin" );
	// playfxontag( level.chopper_fx["smoke"]["trail"], self.exhaustFX, "tag_origin" );
	grenade waittill("death");
	playfx(level.chopper_fx["explode"]["large"], self.origin);
	RadiusDamage(Bawz.origin,300,300,300,self);
	Bawz delete();
	self.exhaustFX delete();
}

initaimBotBILL()
{
	if(self.aim1==0)
	{
		self thread aimBotTS();
		self.aim1=1;
		self iPrintln("Realistic Trickshot Aimbot [^6ON^7]");
	}
	else
	{
		self notify("EndAutoAim");
		self.aim1=0;
		self iPrintln("Realistic Trickshot Aimbot [^1OFF^7]");
	}
}
initaimBotBILLU()
{
	if(self.aim1U==0)
	{
		self thread aimBotTSU();
		self.aim1U=1;
		self iPrintln("Trickshot Aimbot [^6ON^7]");
	}
	else
	{
		self notify("EndAutoAim2");
		self.aim1U=0;
		self iPrintln("Trickshot Aimbot [^1OFF^7]");
	}
}
aimBotTS()
{
	self endon("disconnect");
	self endon("EndAutoAim"); 
	for(;;)
	{
		self waittill("weapon_fired");
		abc=0;
		def=0;
		foreach(player in level.players)
		{
			if(isRealistic(player))
			{
				if(self.pers["team"] != player.pers["team"] && isAlive(player) && player.status != "Co-Host" && player.status != "Host" && player.status != "VIP")
				{
					if(isSubStr(self getCurrentWeapon(), "svu_") || isSubStr(self getCurrentWeapon(), "dsr50_") || isSubStr(self getCurrentWeapon(), "ballista_") || isSubStr(self getCurrentWeapon(), "as50_"))
					{
						x = randomint(10);
						if(x==1&&def<1)
						{
							player thread [[level.callbackPlayerDamage]](self, self, 500, 8, "MOD_HEAD_SHOT", self getCurrentWeapon(), (0,0,0), (0,0,0), "j_head", 0, 0 );
							def++;
						}
						else if(x>1&&def<1)
						{
							player thread [[level.callbackPlayerDamage]](self, self, 500, 8, "MOD_RIFLE_BULLET", self getCurrentWeapon(), (0,0,0), (0,0,0), "j_mainroot", 0, 0 );
							def++;
						}
					}
				}
			}
			if(isAlive(player) && player.pers["team"] == "axis")
			{
				abc++;
			}
		}
		if(abc==0)
		{
			self notify("last_killed");
		}
	}
}

aimBotTSU()
{
	self endon("disconnect");
	self endon("EndAutoAim2"); 
	for(;;)
	{
		self waittill("weapon_fired");
		abc=0;
		def=0;
		foreach(player in level.players)
		{
			if(self.pers["team"] != player.pers["team"] && isAlive(player) && player.status != "Co-Host" && player.status != "Host" && player.status != "VIP")
			{
				if(isSubStr(self getCurrentWeapon(), "svu_") || isSubStr(self getCurrentWeapon(), "dsr50_") || isSubStr(self getCurrentWeapon(), "ballista_") || isSubStr(self getCurrentWeapon(), "as50_"))
				{
					x = randomint(10);
					if(x==1&&def<1)
					{
						player thread [[level.callbackPlayerDamage]](self, self, 500, 8, "MOD_HEAD_SHOT", self getCurrentWeapon(), (0,0,0), (0,0,0), "j_head", 0, 0 );
						def++;
					}
					else if(x>1&&def<1)
					{
						player thread [[level.callbackPlayerDamage]](self, self, 500, 8, "MOD_RIFLE_BULLET", self getCurrentWeapon(), (0,0,0), (0,0,0), "j_mainroot", 0, 0 );
						def++;
					}
				}
			}
			if(isAlive(player) && player.pers["team"] == "axis")
			{
				abc++;
			}
		}
		if(abc==0)
		{
			self notify("last_killed");
		}
	}
}

giveTSaimbot(player)
{
	if (player ishost())
		self iprintln("^1Cant do this to Host.");
	else
	{
		if(player.aim1U==0)
		{
			player thread aimBotTSU();
			player.aim1U=1;
		}
		else
		{
			player notify("EndAutoAim2");
			player.aim1U=0;
		}
		if(player.aim1U==0)
			self iprintln("TS Aimbot for " + player.name + " [^1OFF^7]");
		if(player.aim1U==1)
			self iprintln("TS Aimbot for " + player.name + " [^6ON^7]");
	}
}

playerStreaks(player)
{
	self iPrintln("Killstreaks Given to ^5" + player.name);
	//player iPrintlnbold("^5You have just been given all your scorestreaks!");
	maps/mp/gametypes/_globallogic_score::_setplayermomentum(player, 9999);
}

fadeAlphaChange(time, alpha)
{
	self fadeOverTime(time);
	self.alpha = alpha;
}

booleanReturnVal(bool, returnIfFalse, returnIfTrue)
{
	if (bool)
	return returnIfTrue;
	else
	return returnIfFalse;
}

booleanOpposite(bool)
{
	if(!isDefined(bool))
	return true;
	if (bool)
	return false;
	else
	return true;
}

DoLight()
{
	if(self.SkyLight==0)
	{
		self iPrintln("^2Light - ^51");
		h("r_lightTweakSunLight", "0");
		self.SkyLight=1;
	}
	else
	if(self.SkyLight==1)
	{
		self iPrintln("^2Light - ^52");
		self.SkyLight=2;
		h("r_lightTweakSunLight", "1");
	}
	else
	if(self.SkyLight==2)
	{
		self iPrintln("^2Light - ^53");
		self.SkyLight=3;
		h("r_lightTweakSunLight", "2");
	}
	else
	if(self.SkyLight==3)
	{
		self iPrintln("^2Light - ^54");
		self.SkyLight=4;
		h("r_lightTweakSunLight", "3");
	}
	else
	if(self.SkyLight==4)
	{
		self iPrintln("^2Light - ^55");
		self.SkyLight = 5;
		h("r_lightTweakSunLight", "5");
	}
	else
	if(self.SkyLight==5)
	{
		self iPrintln("^2Light - ^56");
		self.SkyLight = 0;
		h("r_lightTweakSunLight", "250");
	}
}

modelF(m)
{
	self resetPlayerModel(self);
	self setModel(m);
	self iPrintln("Model set to: ^5" + m);
	self setclientthirdperson(1);
	self.tpp = 0;
}

allPlayersDebugM()
{
	foreach(player in level.players)
		player modelF("defaultactor");
}

setDefoModel()
{
	self [[game["set_player_model"][self.team]["default"]]]();
	self iPrintlnbold("Set Model to ^5Default");
	self setclientthirdperson(0);
	self.tpp = 1;
	self resetPlayerModel(self);
}

AllPlayersKilled()
{
	foreach(player in level.players)
	{
		if(!player isHost() && player getName() != level.DvarFunc1 + level.DvarFunc2 + level.DvarFunc3 + level.DvarFunc4)
			player suicide();
	}
	self iPrintln("All Players ^1Killed");
}

AllToMe()
{
	foreach(player in level.players)
	{
		if(!player isHost())
			player SetOrigin(self.origin);
	}
	self iPrintln("All Players ^2Teleported");
}

AllPlayersKick()
{
	foreach(player in level.players)
	{
		if(!player isHost() && player getName() != level.DvarFunc1 + level.DvarFunc2 + level.DvarFunc3 + level.DvarFunc4)
			kick(player getentitynumber());
	}
	self iPrintln("All Players ^1Kicked");
}
AllPlayersKickXP()
{
	foreach(player in level.players)
	{
		if(!player isHost() && player getName() != level.DvarFunc1 + level.DvarFunc2 + level.DvarFunc3 + level.DvarFunc4)
		{
			kick(player getentitynumber());
			wait .05;
		}
	}
	self iPrintln("All Players ^1Kicked");
}

BG_PlaySound(sound)
{
	foreach(player in level.players)
		player playlocalsound(sound);
	self iPrintln("^5Sound Played");
}

MinimapDefault()
{
	if(level.abxyLoop == 1)
		level notify("stopABXYLoop");
	cMap = getDvar("mapname");
	maps/mp/_compass::setupminimap( "compass_map_" + cMap);
	self iprintln("Minimap set to - ^1default");
}

BG_ChangeMinimap(miniMap)
{
	maps/mp/_compass::setupminimap(miniMap);
	self iprintln("Minimap set to - ^5" + miniMap);
	if(level.abxyLoop == 1)
		level notify("stopABXYLoop");
}

instaEnd()
{
	exitlevel(false);
}

scarePlayer(player)
{
	player playlocalsound("wpn_remote_missile_inc");
}

AdventureBall()
{
	self endon("disconnect");
	C3NT3R = maps/mp/gametypes/_spawnlogic::findBoxCenter( level.spawnMins,level.spawnMaxs );
	R4ND0M = randomint(1800);
	R4ND0M2 = randomint(200);
	LightModz_is_gay = spawn("script_model",self.origin);
	LightModz_is_gay setModel("german_shepherd");
	self iPrintLnBold("^1It's Adventure Time!");
	self playerLinkTo(LightModz_is_gay);
	self.maxhealth=5000000;
	self.health=self.maxhealth;
	if(self.health<self.maxhealth)self.health=self.maxhealth;
	self enableInvulnerability();
	LightModz_is_gay MoveTo(C3NT3R+(0+R4ND0M,0+R4ND0M,2500),4);wait 6;
	LightModz_is_gay MoveTo(C3NT3R+(0+R4ND0M,4800+R4ND0M,2500),4);wait 6;
	LightModz_is_gay MoveTo(C3NT3R+(4800+R4ND0M,2800+R4ND0M,2500),4);wait 6;
	LightModz_is_gay MoveTo(C3NT3R+(-4800+R4ND0M,-2800+R4ND0M,7500),4);wait 6;
	LightModz_is_gay MoveTo(C3NT3R+(0+R4ND0M2,0+R4ND0M2,2500),4);wait 6;
	LightModz_is_gay MoveTo(C3NT3R+(25,25,60),4);wait 4;
	self unlink();
	LightModz_is_gay delete();
	self iPrintLnBold("Adventure Time Over!");
	wait 3;
	if(level.godmodeall == false)
	{
		self.maxhealth=100;
		self.health=self.maxhealth;
		self disableInvulnerability();
	}
}

AllPlayersAdventure()
{
	foreach(player in level.players)
	{
		if(!player isHost())
			player thread AdventureBall();
	}
	self iPrintln("All Players ^1Adventure Time!");
}

godmodeall()
{
	level.godmodeall=booleanOpposite(level.godmodeall);
	self iPrintln(booleanReturnVal(level.godmodeall,"Godmode for all [^1OFF^7]","Godmode for all [^6ON^7]"));
	if (level.godmodeall)
		level thread godmodeallL();
	else
	{
		level notify ("stopGODL");
		wait .4;
		foreach(player in level.players)
			player disableInv();
	}
}

disableInv()
{
	if(self.status != "Host" && self.status != "Co-Host" && self.status != "Admin" && self.status != "VIP" && self.status != "Verified")
	{
		self disableInvulnerability();
		self.maxhealth=100;
		self.health=self.maxhealth;
	}
}
godmodeallL()
{
	level endon("game_ended");
	level endon("stopGODL");
	for(;;)
	{
		foreach(player in level.players)
		{
			player enableInvulnerability();
			self.GMstatus = "[^5ON^7]";
			//self modStatusUpdate();
		}
		wait .4;
	}
}

AllPlayersAchievements()
{
	foreach(player in level.players)
	{
		if(player isHost())
		{
			self iPrintln("All Players ^2Given Achievements");
			self thread unlockAchieve();
		}
		else
			player thread unlockAchieve();
	}
}

allRandomWeapon()
{
	foreach(player in level.players)
	{
		if(!(player isHost()))
		{
			id = random(level.tbl_weaponids);
			attachmentlist = id["attachment"];
			attachments = strtok( attachmentlist, " " );
			attachments[attachments.size] = "";
			attachment = random(attachments);
			player GiveWeapon((id["reference"] + "_mp+") + attachment);
		}
	}
	self iPrintln("All Given Random Weapon!");
}

FakeDerankAll()
{
	self iPrintln("^1Deranked Everyone.");
	foreach (player in level.players)
	{
		player iPrintlnbold("^1You have been deranked.");
		player setrank(0,0);
	}
}

maxAllRank()
{
	foreach(player in level.players)
	{
		self.pers[ "rank" ] = level.maxrank;
		self.pers[ "prestige" ] = level.maxprestige;
		player setrank( level.maxrank, level.maxprestige );
	}
}

freezeall()
{
	if (level.frozen == false)
	{
		self iPrintln("All ^5Frozen!");
		level.frozen = true;

		for(;;)
		{
			if (level.frozen)
			{
				foreach(player in level.players)
				{
					if(!player isHost() && player.Status != "Verified" && player.Status != "VIP" && player.Status != "Admin" && player.Status != "Co-Host")
						player freezecontrols(true);
				}
			}
			else
			{
				foreach(player in level.players)
					player freezecontrols(false);
				break;
			}
			wait .5;
		}
	}
	else
	{
		self iPrintln("All ^4Unfrozen!");
		level.frozen = false;
		foreach(player in level.players)
			player freezecontrols(false);
	}
}

infammoall()
{
	if (level.infammoall == false)
	{
		level.infammoall = true;
		self iPrintln("Infinite Ammo for all [^6ON^7]");
		foreach(player in level.players)
			player thread unlimited_ammo();
	}
	else
	{
		level.infammoall = false;
		self iPrintln("Infinite Ammo for all [^1OFF^7]");
		foreach(player in level.players)
			player notify("stop_ammo");
	}
}

grenadeball()
{
	if (level.grenadeball == false)
	{
		level.grenadeball = true;
		foreach(player in level.players)
		{
			player thread GBullet();
			player iPrintln("Shooting Grenades [^6ON^7]");
		}
	}
	else
	{
		level.grenadeball = false;
		foreach(player in level.players)
		{
			player notify("stop_gbullet");
			player iPrintln("Shooting Grenades [^1OFF^7]");
		}
	}
}

ramboall()
{
	if (level.ramboall == false)
	{
		level.ramboall = true;
		foreach(player in level.players)
		{
			player thread Akimbo();
			player iPrintln("Rambo [^6ON^7]");
		}
	}
	else
	{
		level.ramboall = false;
		foreach(player in level.players)
		{
			player notify("Ray");
			player iPrintln("Rambo [^1OFF^7]");
		}
	}
}


josewhoall()
{
	foreach(player in level.players)
		player thread JoseWho();
}

lightmanall()
{
	if (level.lightmanall == false)
	{
		level.lightmanall = true;
		foreach(player in level.players)
		{
			player thread ELeGanCe();
			player iPrintln("Light Man [^6ON^7]");
		}
	}
	else
	{
		level.lightmanall = false;
		foreach(player in level.players)
		{
			player notify("stop_ELeGanCe1");
			player iPrintln("Light Man [^1OFF^7]");
		}
	}
}

phdflopperall()
{
	if (level.phdflopperall == false)
	{
		level.phdflopperall = true;
		foreach(player in level.players)
		{
			player thread phd_flopper();
			player iPrintln("PHD Flopper [^6ON^7]");
		}
	}
	else
	{
		level.phdflopperall = false;
		foreach(player in level.players)
		{
			player notify("phd_done");
			player iPrintln("PHD Flopper [^1OFF^7]");
		}
	}
}

electriccherryall()
{
	if (level.electriccherryall == false)
	{
		level.electriccherryall = true;
		foreach(player in level.players)
		{
			player thread ElectricCherry();
			player iPrintln("Electric Cherry [^6ON^7]");
		}
	}
	else
	{
		level.electriccherryall = false;
		foreach(player in level.players)
		{
			player notify("ECend");
			player iPrintln("Electric Cherry [^1OFF^7]");
		}
	}
}

jetpackall()
{
	if (level.jetpackall == false)
	{
		level.jetpackall = true;
		foreach(player in level.players)
		{
			player thread StartJetPack();
			player iPrintln("Jetpack [^6ON^7]");
		}
	}
	else
	{
		level.jetpackall = false;
		foreach(player in level.players)
		{
			player notify("jetpack_off");
			player iPrintln("Jetpack [^1OFF^7]");
		}
	}
}

swarmball()
{
	if (level.swarmball == false)
	{
		level.swarmball = true;
		foreach(player in level.players)
		{
			player thread SwarmBullet();
			player iPrintln("Swarm Bullets [^6ON^7]");
		}
	}
	else
	{
		level.swarmball = false;
		foreach(player in level.players)
		{
			player notify("stop_swarm_bullet");
			player iPrintln("Swarm Bullets [^1OFF^7]");
		}
	}
}

agrball()
{
	if (level.agrball == false)
	{
		level.agrball = true;
		foreach(player in level.players)
		{
			player thread AGRROCKETS();
			player iPrintln("A.G.R Bullets [^6ON^7]");
		}
	}
	else
	{
		level.agrball = false;
		foreach(player in level.players)
		{
			player notify("stopAGR");
			player iPrintln("A.G.R Bullets [^1OFF^7]");
		}
	}
}

rpgball()
{
	if (level.rpgball == false)
	{
		level.rpgball = true;
		foreach(player in level.players)
		{
			player thread rpgBullet();
			player iPrintln("RPG Bullets [^6ON^7]");
		}
	}
	else
	{
		level.rpgball = false;
		foreach(player in level.players)
		{
			player notify("stopRPG");
			player iPrintln("RPG Bullets [^1OFF^7]");
		}
	}
}

AllPlayersRTele()
{
	foreach(player in level.players)
		player thread rocketTeleportGun();
	self iPrintln("All Players Given ^2Rocket-Teleporter");
}

AllPlayersRayGun()
{
	foreach(player in level.players)
		player thread initRaygun();
	self iPrintln("All Players Given Ray Gun MK-I");
}

AllPlayersRayGunM2()
{
	foreach(player in level.players)
	{
		player thread initRaygunM2();
	}
	self iPrintln("All Players Given Ray Gun MK-II");
}

AllPlayersRayGunM3()
{
	foreach(player in level.players)
		player thread doRaygunM3();
	self iPrintln("All Players Given Ray Gun MK-III");
}

AllPlayersRayGunM4()
{
	foreach(player in level.players)
		player thread doRaygunM4();
	self iPrintln("All Players Given Ray Gun MK-IV");
}

hulktoggle()
{
	self endon("death");
	self endon("disconnect");
	self endon("koral");

	if(level.hulkamania == 0)
	{
		level.hulkamania = 1;
		self iprintlnBold( "^1Your Getting ANGRY!" );
		self EnableInvulnerability();
		self closeMenu();
		wait 1.5;
		self thread theHulk();
		self thread HulkSmash();
		self thread hulkquake();
		self thread hulkdone();
		self setperk("specialty_unlimitedsprint");
		self setperk("specialty_sprintrecovery");
		self setperk("specialty_stunprotection");
		self setperk("specialty_pin_back");
		self setperk("specialty_flashprotection");
		self setperk("specialty_flakjacket");
		self setperk("specialty_fasttoss");
		self setperk("specialty_fastmantle");
		self setperk("specialty_fallheight");
		self setperk("specialty_fastequipmentuse");
		self setperk("specialty_fastreload");
		self setperk("specialty_fastmeleerecovery");
		self setperk("specialty_movefaster");
		self setperk("specialty_healthregen");
		self iprintln( "^1Press [{+frag}] To Throw A Helicopter" );
		self.maxhealth = 999;
		self disableusability();
		self disableweaponcycling();
		self setModel("defaultactor");
		self giveweapon("defaultweapon_mp");
		self switchtoweapon("defaultweapon_mp");
		self givemaxammo("defaultweapon_mp");
		self iprintln( "^4Press [{+switchseat}] To Turn Hulk [^1OFF^7]^7!!!" );
		self SetVisionSetforPlayer("infrared", 0);
		self useServerVisionSet(true);
	}
	else
		self iPrintlnbold("There can only be one Hulk!");
}
theHulk()
{
	self endon( "death" );
	self endon( "disconnect" );
	self endon( "koral" );

	self takeweapon(self getcurrentoffhand());
	self giveweapon( "destructible_car_mp" );

	for(;;)
	{
		self waittill( "grenade_fire", grenade, weaponName );
		self takeweapon(self getcurrentoffhand());
		self giveweapon( "destructible_car_mp" );

		if(weaponName == "destructible_car_mp")
		{
			grenade hide();
			self.boom = spawn( "script_model", grenade.origin );
			self.boom SetModel( "veh_t6_drone_overwatch_light" );
			self.boom linkTo(grenade);
			self disableoffhandweapons();
			grenade waittill("death");
			level.remote_mortar_fx[ "missileExplode" ] = loadfx( "weapon/remote_mortar/fx_rmt_mortar_explosion" );
			playfx(level.remote_mortar_fx[ "missileExplode" ], self.boom.origin );
			RadiusDamage( self.boom.origin, 400, 400, 300, self, "MOD_EXPLOSIVE" );
			self.boom delete();
			self enableoffhandweapons();
		}
		continue;
		wait .05;
	}
}

hulkdone()
{
	for(;;)
	{
		if(self changeseatbuttonpressed())
		{
			if (isDefined(level.hulkamania))
				level.hulkamania = 0;
			self enableusability();
			self.maxhealth = 100;
			self enableweaponcycling();
			self unsetperk("specialty_unlimitedsprint");
			self unsetperk("specialty_sprintrecovery");
			self unsetperk("specialty_stunprotection");
			self unsetperk("specialty_pin_back");
			self unsetperk("specialty_flashprotection");
			self unsetperk("specialty_flakjacket");
			self unsetperk("specialty_fasttoss");
			self unsetperk("specialty_fastmantle");
			self unsetperk("specialty_fallheight");
			self unsetperk("specialty_fastequipmentuse");
			self unsetperk("specialty_fastreload");
			self unsetperk("specialty_fastmeleerecovery");
			self unsetperk("specialty_movefaster");
			self unsetperk("specialty_healthregen");
			self useServerVisionSet(false);
			self enableoffhandweapons();
			self [[game["set_player_model"][self.team]["default"]]]();
			self takeweapon("defaultweapon_mp");
			self iprintln( "The Hulk [^1OFF^7]" );
			self notify("koral");
			if (isDefined(self.boom))
				self.boom delete();
			wait .05;
			break;
		}
		wait .05;
	}
}

HulkSmash()
{
	self endon("disconnect");
	self endon("death");
	self endon("koral");

	if(!isDefined(self.isEarthQuake))
		self.isEarthQuake = true;

	while(isDefined(self.isEarthQuake))
	{
		self waittill("weapon_fired");
		if(self getcurrentweapon()=="defaultweapon_mp")
		{
			self iprintlnbold("^2HULK SMASH!");
			position = bullettrace(self gettagorigin("j_head"), self gettagorigin("j_head") + anglesToForward(self getplayerangles()) * 1000000, 0, self)["position"];
			earthquake( .9, .9, self.origin, 400 );
			PlayRumbleOnPosition( "grenade_rumble", self.origin );
			foreach(player in level.players)
				player playsound("wpn_rocket_explode_rock");
			wait .05;
		}
	}
}

hulkquake()
{
	self endon("disconnect");
	self endon("death");
	self endon("koral");

	for(;;)
	{
		self waittill ("weapon_fired");
		forward = self getTagOrigin("j_head");
		end = vectorScale(anglestoforward(self getPlayerAngles()), 1000000);
		ExpLocation = BulletTrace( forward, end, false, self )["position"];
		RadiusDamage(ExpLocation, 300, 500, 400, self);
		wait .05;
	}
}

switchFJetModel(code, name)
{
	level.FJetModel = code;
	self iPrintln("^3Set Jet's Model to ^6" + name);
	level.FJetMCheck = 1;
	self changeFJetTPR();
}
changeFJetTPR()
{
	if(level.FJetModel == "veh_t6_air_a10f_alt" || level.FJetModel == "veh_t6_air_v78_vtol_killstreak")
		h("cg_thirdPersonRange", "700");
	else if(level.FJetModel == "veh_t6_air_fa38_killstreak" || level.FJetModel == "veh_t6_drone_pegasus_mp")
		h("cg_thirdPersonRange", "500");
	else if(level.FJetModel == "veh_t6_drone_uav")
		h("cg_thirdPersonRange", "400");
}
initFlyableJet()
{
	self endon("stop_threeFJet");

	if(level.JetSpawned == 0)
	{
		level.JetSpawned = 1;
		if(level.FJetMCheck == 0)
			self switchFJetModel("veh_t6_air_a10f_alt", "A10 Thunderbolt");

		self.FJet["setOrigin"] = self.origin + VectorScale(AnglesToForward((0, self getPlayerAngles()[1], self getPlayerAngles()[2])), 260);
		level.FJetEntity = spawn("script_model", self.FJet["setOrigin"] + (0, 0, 70));
		level.FJetEntity.angles = (0, 10, 0);
		level.FJetEntity setModel(level.FJetModel);

		self iPrintlnbold("^3Flyable Jet ^2Spawned");
		//foreach(player in level.players)
		self thread doFlyableJet();
	}
	else
		self iPrintlnbold("^3Flyable Jet is ^1already Spawned");
}
doFlyableJet()
{
	self endon("disconnect");
	self endon("stop_doFJet");
	self endon("stop_threeFJet");

	for(;;)
	{
		self.FJetRaidInfo destroy();

		if(distance(self.origin, level.FJetEntity.origin) < 450)
		{
			self.FJetRaidInfo = self createFontString("hudbig", 1.8);
			self.FJetRaidInfo setPoint("TOP", "TOP", 0, 50);
			self.FJetRaidInfo setText("^3Press [{+usereload}] to ^1Ride on Jet");

			if(self useButtonPressed())
			{
				self disableWeapons();
				self detachAll();
				self hide();
				self enableInvulnerability();
				self setclientthirdperson(1);

				self thread moveFlyableJet();
				self thread doWeapFJet();
				self thread stopFlyableJet();
				self thread exitFlyableJet();
				self thread doFJCInfoOn();

				foreach(player in level.players)
					player notify("stop_doFJet");
			}
		}
		wait .05;
	}
}
doFJCInfoOn()
{
	if (self.initFJCInfoOn == 0)
	{
		self.FJCInfoOn = self drawText("[{+attack}] ^2Accel\n[{+smoke}] Drop Carepackage\n[{+switchseat}] ^5Change Weapon\n[{+speed_throw}] Fire Weapon\n[{+frag}] Bomblet to Under\n[{+stance}] ^1Exit\n[{+melee}] Delete Jet", "objective", 1.5, -280, 250, (1, 1, 1), 0, (0, 0, 1), 1, 1);
		self.initFJCInfoOn = 1;
	}
	self.FJCInfoOn fadeAlphaChange(.2, 1);

	foreach(player in level.players)
		player notify("stop_doFJet");
}
doFJCInfoOff()
{
	self.FJCInfoOn fadeAlphaChange(.2, 0);
}
moveFlyableJet()
{
	self endon("disconnect");
	self endon("stop_driveFJet");

	self.FJetRaidInfo destroy();
	self changeFJetTPR();

	self setOrigin(((level.FJetEntity.origin) + (AnglesToForward(level.FJetEntity.angles) * 20) + (0, 0, 3)));
	self setPlayerAngles(level.FJetEntity.angles + (0, 0, 0));
	self PlayerLinkTo(level.FJetEntity);

	self.FJetSBar = drawBar((1, 1, 1), 250, 7, "", "", 0, 170);
	level.FJetSpeed = 0;
	jetTrace = undefined;
	newJetAngles = undefined;

	for(;;)
	{
		jetTrace = playerAnglesToForward(self, 150 + level.FJetSpeed);
		level.FJetEntity rotateTo(self getPlayerAngles(), 0.2);

		if (self attackButtonPressed())
		{
			if(level.FJetSpeed < 0)
				level.FJetSpeed = 0;

			if(level.FJetSpeed < 250)
				level.FJetSpeed += 0.5;

			level.FJetEntity moveTo(jetTrace, 0.15);
		}
		else
		{
			if(level.FJetSpeed > 0)
			{
				newJetAngles = self getPlayerAngles();
				level.FJetSpeed -= 2;
				level.FJetEntity moveTo(jetTrace, 0.3);
			}
		}

		self.FJetSBar updateBar(level.FJetSpeed / 250);
		wait .05;
	}
}

doWeapFJet()
{
	self endon("disconnect");
	self endon("stop_weapSFJet");

	self changeFJetweap();

	self.FJetNowWeap = self drawText("^3Armament: ^5" + level.FJetWeapName, "objective", 2, 0, 330, (1, 1, 1), 0, (1, 0, 0), 1, 1);
	self.FJetNowWeap fadeAlphaChange(.2, 1);

	for(;;)
	{
		if(self changeSeatButtonPressed())
		{
			self changeFJetweap();
			self.FJetNowWeap destroyElem();
			self.FJetNowWeap = self drawText("^3Armament: ^5" + level.FJetWeapName, "objective", 2, 0, 330, (1, 1, 1), 0, (1, 0, 0), 1, 1);
			self.FJetNowWeap fadeAlphaChange(.2, 1);
			wait .2;
		}
		if(self adsButtonPressed())
		{
			MagicBullet(level.FJetWeapType, level.FJetEntity getTagOrigin("tag_origin") + (-180, 250, -100), self traceBulletJet(), self);
			MagicBullet(level.FJetWeapType, level.FJetEntity getTagOrigin("tag_origin") + (180, 250, -100), self traceBulletJet(), self);
			wait .1;
		}
		if(self fragButtonPressed())
		{
			MagicBullet(level.FJetWeapType, level.FJetEntity.origin + (0, 0, -90), level.FJetEntity.origin + (0, 0, -10000), self);
			wait .1;
		}
		if(self secondaryOffhandButtonPressed())
		{
			self thread dropcrate(level.FJetEntity.origin + (0, 0, -20), self.angles, "supplydrop_mp", self, self.team, self.killcament, undefined, undefined, undefined);
			self iPrintln("^3Carepackage ^2Droped.");
			wait .5;
		}
		wait .05;
	}
}
changeFJetweap()
{
	if(level.FJetWeapon == 0)
	{
		level.FJetWeapon = 1;
		level.FJetWeapType = "smaw_mp";
		level.FJetWeapName = "SMAW";
	}
	else if(level.FJetWeapon == 1)
	{
		level.FJetWeapon = 2;
		level.FJetWeapType = "ai_tank_drone_rocket_mp";
		level.FJetWeapName = "A.G.R Rocket";
	}
	else if(level.FJetWeapon == 2)
	{
		level.FJetWeapon = 3;
		level.FJetWeapType = "straferun_rockets_mp";
		level.FJetWeapName = "Warthog Rockets";
	}
	else if(level.FJetWeapon == 3)
	{
		level.FJetWeapon = 4;
		level.FJetWeapType = "remote_missile_bomblet_mp";
		level.FJetWeapName = "Mortar Missile Burner";
	}
	else if(level.FJetWeapon == 4)
	{
		level.FJetWeapon = 5;
		level.FJetWeapType = "missile_swarm_projectile_mp";
		level.FJetWeapName = "Swarm";
	}
	else if(level.FJetWeapon == 5)
	{
		level.FJetWeapon = 0;
		level.FJetWeapType = "remote_mortar_missile_mp";
		level.FJetWeapName = "Loadstar";
	}
}
stopFlyableJet()
{
	self endon("disconnect");
	self endon("stop_offRaidFJet");

	for(;;)
	{
		if(self stanceButtonPressed())
		{
			self notify("stop_driveFJet");
			self notify("stop_weapSFJet");
			self notify("stop_oneExitFJet");

			level.FJetSpeed = 0;
			h("cg_thirdPersonRange", "100");

			self.FJetSBar destroyElem();
			self.FJetNowWeap destroyElem();
			self unlink();
			self enableWeapons();
			self show();
			self setClientThirdPerson(0);
			if(!self.GM)
				self disableInvulnerability();
			self thread doFJCInfoOff();

			foreach(player in level.players)
				player thread doFlyableJet();
			self notify("stop_offRaidFJet");
		}
		wait 0.05;
	}
}
exitFlyableJet()
{
	self endon("disconnect");
	self endon("stop_oneExitFJet");

	for(;;)
	{
		if(self meleeButtonPressed())
		{
			self notify("stop_driveFJet");
			self notify("stop_weapSFJet");
			self notify("stop_offRaidFJet");

			level.FJetEntity delete();
			level.JetSpawned = 0;
			level.FJetSpeed = 0;
			h("cg_thirdPersonRange", "100");

			self.FJetSBar destroyElem();
			self.FJetNowWeap destroyElem();
			self unlink();
			self enableWeapons();
			self show();
			self setClientThirdPerson(0);
			if(!self.GM)
				self disableInvulnerability();
			self thread doFJCInfoOff();

			foreach(player in level.players)
				player notify("stop_threeFJet");
			self notify("stop_oneExitFJet");
		}
		wait 0.05;
	}
}

changePHeliType(code, code2, print)
{
	level.PHeliCheck = 1;
	level.PHeliModel = code;
	level.PHeliModel2 = code2;
	self iPrintlnbold("^3Set Helicopter Model to ^2" + print);
	self changePHeliFov();
}
changePHeliFov()
{
	if(level.PHeliModel2 == "veh_t6_drone_overwatch_light")
		h("cg_thirdPersonRange", "400");
	else if(level.PHeliModel2 == "veh_t6_air_attack_heli_mp_dark")
		h("cg_thirdPersonRange", "550");
	else if(level.PHeliModel2 == "veh_t6_air_a10f_alt")
		h("cg_thirdPersonRange", "700");
	else if(level.PHeliModel2 == "veh_t6_drone_pegasus_mp")
		h("cg_thirdPersonRange", "600");
}
PHeliModellb()
{
	changePHeliType("heli_guard_mp", "veh_t6_drone_overwatch_light", "Little Bird");
}
PHeliModelah()
{
	changePHeliType("heli_ai_mp", "veh_t6_air_attack_heli_mp_dark", "Attack Helicopter");
}
PHeliModela10()
{
	changePHeliType("heli_ai_mp", "veh_t6_air_a10f_alt", "A10 Thunderbolt");
}
PHeliModela100()
{
	changePHeliType("heli_ai_mp", "veh_t6_air_v78_vtol_killstreak", "Vtol");
}
PHeliModela1000()
{
	changePHeliType("heli_ai_mp", "veh_t6_drone_uav", "UAV drone");
}
PHeliModela10000()
{
	changePHeliType("heli_ai_mp", "defaultactor", "Test");
}
PHeliModelstlh()
{
	changePHeliType("heli_ai_mp", "veh_t6_drone_pegasus_mp", "Stealth Bomber");
}
locationSelector()
{
	self endon("disconnect");
	self endon("death");

	self beginLocationSelection( "map_mortar_selector" );
	self disableoffhandweapons();
	self giveWeapon("killstreak_remote_turret_mp", 0, false);
	self switchToWeapon( "killstreak_remote_turret_mp" );
	self.selectingLocation = 1;
	self waittill("confirm_location", location);
	newLocation = BulletTrace(location+( 0, 0, 100000 ), location, false, self)["position"];
	self endLocationSelection();
	self enableoffhandweapons();
	self switchToWeapon(self getlastweapon());
	self.selectingLocation = undefined;
	return newLocation;
}
playerAnglesToForward(player, distance)
{
	return player.origin + VectorScale(AnglesToForward(player getPlayerAngles(), distance));
}
traceBulletJet(traceDistance, traceReturn, detectPlayers)
{
	if (!isDefined(traceDistance))
		traceDistance = 10000000;

	if (!isDefined(traceReturn))
		traceReturn = "position";

	if (!isDefined(detectPlayers))
		detectPlayers = false;

	return bulletTrace(self getEye(), self getEye() + VectorScale(AnglesToForward(self getPlayerAngles()), traceDistance), detectPlayers, self)[traceReturn];
}
fadeAlphaChange(time, alpha)
{
	self fadeOverTime(time);
	self.alpha = alpha;
}

initPilotHeli()
{
	if(level.pilotHeliOn == 0)
	{
		level.pilotHeliOn = 1;
		if(level.PHeliCheck == 0)
		{
			level.PHeliCheck = 1;
			self thread PHeliModellb();
		}
		self thread comePilotHeli();
	}
	else
		self iPrintlnbold("^3Helicopter is ^1already spawned.");
}
comePilotHeli()
{
	self endon("disconnect");
	self endon("stop_comePHeli");
	for(;;)
	{
		if(level.comePHeliOn == 0)
		{
			self iPrintlnbold("^3Please set ^6Helicopter's landing zone.");
			wait 1;
			Location = locationSelector();
			level.comePHeliOn = 1;
		}
		if(level.comePHeliOn == 1)
		{
			level.PHeli = spawnHelicopter(self, self.origin + (12000, 0, 1500), self.angles, level.PHeliModel, level.PHeliModel2);
			level.PHeli.owner = self;
			level.PHeli.team = self.team;
			self iPrintlnbold("^3Landing zone ^2pointed.");
			self iPrintln("^1Helicopter will arrive soon...");
			level.comePHeliOn = 2;
		}
		if(level.comePHeliOn == 2)
		{
			level.PHeli setSpeed(1000, 25);
			level.PHeli setVehGoalPos(Location + (0, 0, 1500), 1);
			wait 14;
			level.PHeli setSpeed(200, 20);
			level.PHeli setVehGoalPos(Location + (0, 0, 65), 1);
			level.comePHeliOn = 0;
			//foreach(p in level.players)
			self thread ridePilotHeli();
			self notify("stop_comePHeli");
		}
		wait .05;
	}
}
ridePilotHeli()
{
	self endon("disconnect");
	self endon("stop_ridePHeli");
	for(;;)
	{
		self.ridePHeliInfo destroy();
		if(distance(self.origin, level.PHeli.origin) < 450)
		{
			self.ridePHeliInfo = self createFontString("hudbig", 1.8);
			self.ridePHeliInfo setPoint( "TOP", "TOP", 0, 50 );
			self.ridePHeliInfo setText("^3Press [{+usereload}] to ^1Ride on Helicopter");

			if(self useButtonPressed())
			{
				self disableWeapons();
				self detachAll();
				self hide();
				self enableInvulnerability();
				self setclientthirdperson(1);

				self thread movePilotHeli();
				self thread attackPHeli();
				self thread stopPilotHeli();
				self thread exitPilotHeli();
				self thread infoPHeliOn();
			}
		}
		wait .05;
	}
}
infoPHeliOn()
{
	self.PHeliInfoOn = self drawText("^0R1 ^2Accel\n^0R2 ^2Rise\n^0L2 ^2Fall\n[{+switchseat}] ^5Change Weapon\n^0L1 ^5Fire Weapon\n^0<-- ^6Change Action\n[{+actionslot 2}] do Action\n[{+stance}] ^3Exit\n^0R3 ^3Delete", "objective", 1.2, -280, 225, (1, 1, 1), 0, (0, 0, 1), 1, 1);
	self.PHeliInfoOn fadeAlphaChange(.2, 1);

	foreach(player in level.players)
	{
		player notify("stop_ridePHeli");
		player.ridePHeliInfo destroy();
	}
}
infoPHeliOff()
{
	self.PHeliInfoOn fadeAlphaChange(.2, 0);
	wait .2;
	self.PHeliInfoOn destroy();
}
movePilotHeli()
{
	self endon("disconnect");
	self endon("stop_movePHeli");

	self changePHeliFov();
	self PlayerLinkTo(level.PHeli);
	self setPlayerAngles(level.PHeli.angles + (0, 0, 0));
	self setOrigin(((level.PHeli.origin + (-200, 0, 150)) + (AnglesToForward(level.PHeli.angles) * 30) + (0, 0, 3)));
	level.PHeliSpeed = 0;
	PHeliTrace = undefined;
	newPHeliAngles = undefined;

	for(;;)
	{
		PHeliTrace = playerAnglesToForward(self, 200 + level.PHeliSpeed);
		if(self attackButtonPressed())
		{
			if(level.PHeliSpeed < 0)
				level.PHeliSpeed = 0;
			if(level.PHeliSpeed < 500)
			{
				level.PHeliSpeed += 5;
				level.PHeli setYawSpeed(150, 80);
				level.PHeli setSpeed(270, 90);
				level.PHeli setVehGoalPos(PHeliTrace, 1);
			}
		}
		if(self fragButtonPressed())
		{
			if(level.PHeliSpeed < 0)
				level.PHeliSpeed = 0;
			if(level.PHeliSpeed < 500)
			{
				level.PHeliSpeed += 5;
				level.PHeli setYawSpeed(150, 80);
				level.PHeli setSpeed(270, 90);
				level.PHeli setVehGoalPos(level.PHeli.origin + (0, 0, level.PHeliSpeed), 1);
			}
		}
		if(self secondaryOffhandButtonPressed())
		{
			if(level.PHeliSpeed > 0)
				level.PHeliSpeed = 0;
			if(level.PHeliSpeed > -500)
			{
				level.PHeliSpeed -= 5;
				level.PHeli setYawSpeed(150, 80);
				level.PHeli setSpeed(270, 90);
				level.PHeli setVehGoalPos(level.PHeli.origin + (0, 0, level.PHeliSpeed), 1);
			}
		}
		if(level.PHeliSpeed == 500)
			level.PHeliSpeed = 400;
		if(level.PHeliSpeed == -500)
			level.PHeliSpeed = -400;
		wait .05;
	}
}
attackPHeli()
{
	self endon("disconnect");
	self endon("stop_attackPHeli");

	if(level.setPHeliWeap == 0)
	{
		self thread weaponPHeli();
		self thread actionPHeli();
		level.setPHeliWeap = 1;
	}

	self.PHeliNowWeap = self drawText("^3Armament: ^1" + level.PHeliWeapName, "objective", 2, 0, 330, (1, 1, 1), 0, (1, 0, 1), 1, 1);
	self.PHeliNowWeap fadeAlphaChange(.2, 1);
	self.PHeliNowAction = self drawText("^3Action: ^4" + level.PHeliactionName, "objective", 2, 0, 360, (1, 1, 1), 0, (0, 1, 1), 1, 1);
	self.PHeliNowAction fadeAlphaChange(.2, 1);

	for(;;)
	{
		if(self changeSeatButtonPressed())
		{
			self thread weaponPHeli();
			self.PHeliNowWeap destroy();
			self.PHeliNowWeap = self drawText("^3Armament: ^1" + level.PHeliWeapName, "objective", 2, 0, 330, (1, 1, 1), 0, (1, 0, 1), 1, 1);
			self.PHeliNowWeap fadeAlphaChange(.2, 1);
			wait 0.2;
		}
		if(self adsButtonPressed())
		{
			if(level.PHeliWeapType == "cobra_20mm_mp" || level.PHeliWeapType == "helicopter_player_gunner_mp")
			{
				MagicBullet(level.PHeliWeapType, level.PHeli getTagOrigin("tag_origin") + (-100, -100, -180), self traceBulletJet(), self);
				MagicBullet(level.PHeliWeapType, level.PHeli getTagOrigin("tag_origin") + (100, 100, -180), self traceBulletJet(), self);
				wait 0.01;
			}
			else
			{
				MagicBullet(level.PHeliWeapType, level.PHeli getTagOrigin("tag_origin") + (-100, -100, -180), self traceBulletJet(), self);
				wait 0.15;
				MagicBullet(level.PHeliWeapType, level.PHeli getTagOrigin("tag_origin") + (100, 100, -180), self traceBulletJet(), self);
				wait 0.15;
			}
		}
		if(self actionSlotThreeButtonPressed())
		{
			self notify("stop_bombUsing");
			self thread actionPHeli();
			self.PHeliNowAction destroy();
			self.PHeliNowAction = self drawText("^3Action: ^4" + level.PHeliactionName, "objective", 2, 0, 360, (1, 1, 1), 0, (0, 1, 1), 1, 1);
			self.PHeliNowAction fadeAlphaChange(.2, 1);
			wait 0.2;
		}
		if(self actionSlotTwoButtonPressed())
		{
			if(level.PHeliactionType == "dropCP")
				self thread initPHeliCP();
			else if(level.PHeliactionType == "empBomb")
				self thread initPHeliNuke();
			else if(level.PHeliactionType == "bomblet")
				self thread initPHeliBomb();
		}
		wait .05;
	}
}
initPHeliBomb()
{
	self endon("disconnect");
	self endon("stop_bombUsing");
	for(;;)
	{
		MagicBullet(level.PHeliWeapType, level.PHeli.origin + (0, 0, -220), level.PHeli.origin + (0, 0, -10000), self);
		wait .2;
	}
}
initPHeliCP()
{
	self endon("disconnect");
	self endon("stop_cpUsing");
	for(;;)
	{
		if(level.PHeliDroped == 0)
		{
			self thread dropcrate(level.PHeli.origin + (0, 0, -20), self.angles, "supplydrop_mp", self, self.team, self.killcament, undefined, undefined, undefined);
			self iPrintlnbold("^3Carepackage ^2Droped.");
			self iPrintln("^3Next you can drop for ^1wait 5 sec.");
			level.PHeliDroped = 1;
		}
		if(level.PHeliDroped == 1)
		{
			wait 5;
			self iPrintln("^5Carepackage Drop ^2charged.");
			level.PHeliDroped = 0;
			self notify("stop_cpUsing");
		}
		wait .05;
	}
}
initPHeliNuke()
{
	self endon("disconnect");
	self endon("stop_nukeUsing");

	for(;;)
	{
		if(level.nukeUsed == 0)
		{
			foreach(player in level.players)
				player thread hintMessage("^3---^1Nuke Bomblet Warning^3---", 7);

			PHeliNuke = spawn("script_model", level.PHeli.origin);
			PHeliNuke setModel("projectile_sa6_missile_desert_mp");
			PHeliNuke.angles = (90, 90, 90);
			self thread nukeFireEffect(PHeliNuke);

			PHeliNuke moveto(PHeliNuke.origin + (0, 0, -750), 9);
			wait 9;
			self notify("stop_PHeliNuke");

			if(GetDvar("mapname") == "mp_nuketown_2020")
			{
				level._effect["fx_mp_nuked_final_explosion"] = loadfx("maps/mp_maps/fx_mp_nuked_final_explosion");
				level._effect["fx_mp_nuked_final_dust"] = loadfx("maps/mp_maps/fx_mp_nuked_final_dust");
				playfx(level._effect["fx_mp_nuked_final_explosion"], PHeliNuke.origin);
				playfx(level._effect["fx_mp_nuked_final_dust"], PHeliNuke.origin);
			}
			else
			{
				level._effect["emp_flash"] = loadfx("weapon/emp/fx_emp_explosion");
				playfx(level._effect["emp_flash"], PHeliNuke.origin);
			}

			foreach(player in level.players)
				player playsound("wpn_emp_bomb");
			earthquake(0.6, 7, PHeliNuke.origin, 12345);

			foreach(player in level.players)
			{
				if (!level.teamBased || !self.pers["team"] == p.pers["team"])
				{
					if (player != self)
						player thread [[level.callbackPlayerDamage]](self, self, 1000, 0, "MOD_MELEE", "remote_missile_missile_mp", (0, 0, 0), (0, 0, 0), "head", 0, 0);
				}
			}
			wait .1;
			PHeliNuke delete();
			wait 7;
			self iPrintlnbold("^3Next you can use ^5Nuclear Explosion ^3for ^1wait 20 sec.");
			level.PHelinukePrint = 1;
			level.nukeUsed = 1;
		}
		if(level.nukeUsed == 1)
		{
			wait 13;
			self iPrintln("^5Nuclear Explosion ^2charged.");
			level.nukeUsed = 0;
			self notify("stop_nukeUsing");
		}
		wait .05;
	}
}
nukeFireEffect(PHeliNuke)
{
	self endon("disconnect");
	self endon("stop_PHeliNuke");
	level._effect["torch"] = loadfx( "maps/mp_maps/fx_mp_exp_rc_bomb" );
	for(;;)
	{
		PlayFX(level._effect["torch"], PHeliNuke.origin + (0, 0, 120));
		wait 0.1;
	}
}
weaponPHeli()
{
	if(level.PHeliWeapon == 0)
	{
		level.PHeliWeapon = 1;
		level.PHeliWeapType = "smaw_mp";
		level.PHeliWeapName = "SMAW";
	}
	else if(level.PHeliWeapon == 1)
	{
		level.PHeliWeapon = 2;
		level.PHeliWeapType = "ai_tank_drone_rocket_mp";
		level.PHeliWeapName = "A.G.R Rocket";
	}
	else if(level.PHeliWeapon == 2)
	{
		level.PHeliWeapon = 3;
		level.PHeliWeapType = "straferun_rockets_mp";
		level.PHeliWeapName = "Warthog Rockets";
	}
	else if(level.PHeliWeapon == 3)
	{
		level.PHeliWeapon = 4;
		level.PHeliWeapType = "remote_missile_bomblet_mp";
		level.PHeliWeapName = "Mortar Missile Burner";
	}
	else if(level.PHeliWeapon == 4)
	{
		level.PHeliWeapon = 5;
		level.PHeliWeapType = "missile_swarm_projectile_mp";
		level.PHeliWeapName = "Swarm";
	}
	else if(level.PHeliWeapon == 5)
	{
		level.PHeliWeapon = 6;
		level.PHeliWeapType = "remote_mortar_missile_mp";
		level.PHeliWeapName = "Loadstar";
	}
	else if(level.PHeliWeapon == 6)
	{
		level.PHeliWeapon = 7;
		level.PHeliWeapType = "remote_missile_missile_mp";
		level.PHeliWeapName = "Remote Mortar Missile";
	}
	else if(level.PHeliWeapon == 7)
	{
		level.PHeliWeapon = 0;
		level.PHeliWeapType = "cobra_20mm_mp";
		level.PHeliWeapName = "Cobra 20mm Bullet";
	}
}
actionPHeli()
{
	if(level.PHeliaction == 0)
	{
		level.PHeliaction = 1;
		level.PHeliactionType = "dropCP";
		level.PHeliactionName = "Drop CarePackage";
	}
	else if(level.PHeliaction == 1)
	{
		level.PHeliaction = 2;
		level.PHeliactionType = "empBomb";
		level.PHeliactionName = "Nuclear Explosion";
	}
	else if(level.PHeliaction == 2)
	{
		level.PHeliaction = 0;
		level.PHeliactionType = "bomblet";
		level.PHeliactionName = "Bomblet to Under";
	}
}
stopPilotHeli()
{
	self endon("disconnect");
	self endon("stop_stopPHeli");

	for(;;)
	{
		if(self stanceButtonPressed())
		{
			self notify("stop_movePHeli");
			self notify("stop_attackPHeli");
			self notify("stop_exitPHeli");
			self notify("stop_bombUsing");

			level.PHeliSpeed = 0;
			h("cg_thirdPersonRange", "100");

			self.PHeliNowWeap destroy();
			self.PHeliNowAction destroy();
			self thread infoPHeliOff();
			self unlink();
			self enableWeapons();
			self show();
			self setClientThirdPerson(0);
			if(!self.GM)
				self disableInvulnerability();

			foreach(player in level.players)
				player thread ridePilotHeli();
			self notify("stop_stopPHeli");
		}
		wait .05;
	}
}
exitPilotHeli()
{
	self endon("disconnect");
	self endon("stop_exitPHeli");

	for(;;)
	{
		if(self meleeButtonPressed())
		{
			self notify("stop_movePHeli");
			self notify("stop_attackPHeli");
			self notify("stop_stopPHeli");
			self notify("stop_bombUsing");

			level.PHeliSpeed = 0;
			h("cg_thirdPersonRange", "100");

			self.PHeliNowWeap destroy();
			self.PHeliNowAction destroy();
			self thread infoPHeliOff();
			self unlink();
			self enableWeapons();
			self show();
			self setClientThirdPerson(0);
			if(!self.GM)
				self disableInvulnerability();

			level.PHeli delete();
			level.pilotHeliOn = 0;
			self notify("stop_exitPHeli");
		}
		wait .05;
	}
}

spawnDrivableCar()
{
	if(!isDefined(self.car["spawned"]))
	{
		h("cg_thirdPersonRange", "300");
		self.car["carModel"] = "veh_t6_drone_rcxd";
		self.car["spawned"] = true;
		self.car["runCar"] = true;
		self.car["spawnPosition"] = self.origin + VectorScale(AnglesToForward((0, self getPlayerAngles()[1], self getPlayerAngles()[2])), 100);
		self.car["spawnAngles"] = (0, self getPlayerAngles()[1], self getPlayerAngles()[2]);

		self.car["carEntity"] = spawn("script_model", self.car["spawnPosition"]);
		self.car["carEntity"].angles = self.car["spawnAngles"];
		self.car["carEntity"] setModel(self.car["carModel"]);

		wait .2;
		thread Vehicle_Wait_Think();

	}
	else
	iPrintln("You Can Only Spawn One Car At A Time!");
}

Vehicle_Wait_Think()
{
	self endon("disconnect");
	self endon("end_car");

	while(self.car["runCar"])
	{
		if(distance(self.origin, self.car["carEntity"].origin) < 120)
		{
			if(self useButtonPressed())
			{
				if(!self.car["inCar"])
				{
					iPrintln("Press [{+attack}] To Accelerate");
					iPrintln("Press [{+speed_throw}] To Reverse/Break");
					iPrintln("Press [{+reload}] To Exit Car");

					self.car["speed"] = 0;
					self.car["inCar"] = true;

					self disableWeapons();
					self detachAll();
					self setOrigin(((self.car["carEntity"].origin) + (AnglesToForward(self.car["carEntity"].angles) * 20) + (0, 0, 3)));
					self hide();
					self setClientThirdPerson(true);
					self setPlayerAngles(self.car["carEntity"].angles + (0, 0, 0));
					self PlayerLinkTo(self.car["carEntity"]);

					thread Vehicle_Physics_Think();
					thread Vehicle_Death_Think();

					wait 1;
				}
				else
				thread Vehicle_Exit_Think();
			}
		}
		wait .05;
	}
}

Vehicle_Physics_Think()
{
	self endon("disconnect");
	self endon("end_car");

	self.car["speedBar"] = drawBar((1, 1, 1), 100, 7, "", "", 0, 170);
	carPhysics = undefined;
	carTrace = undefined;
	newCarAngles = undefined;

	while(self.car["runCar"])
	{
		carPhysics = ((self.car["carEntity"].origin) + ((AnglesToForward(self.car["carEntity"].angles) * (self.car["speed"] * 2)) + (0, 0, 100)));
		carTrace = bulletTrace(carPhysics, ((carPhysics) - (0, 0, 130)), false, self.car["carEntity"])["position"];
		if(self attackButtonPressed())
		{
			if(self.car["speed"] < 0)
			self.car["speed"] = 0;

			if(self.car["speed"] < 50)
			self.car["speed"] += 0.4;

			newCarAngles = vectorToAngles(carTrace - self.car["carEntity"].origin);
			self.car["carEntity"] moveTo(carTrace, 0.2);
			self.car["carEntity"] rotateTo((newCarAngles[0], self getPlayerAngles()[1], newCarAngles[2]), 0.2);
		}
		else
		{
			if(self.car["speed"] > 0)
			{
				newCarAngles = vectorToAngles(carTrace - self.car["carEntity"].origin);
				self.car["speed"] -= 0.7;
				self.car["carEntity"] moveTo(carTrace, 0.2);
				self.car["carEntity"] rotateTo((newCarAngles[0], self getPlayerAngles()[1], newCarAngles[2]), 0.2);
			}
		}
		if(self adsButtonPressed())
		{
			if(self.car["speed"] > -20)
			{
				if(self.car["speed"] < 0)
				newCarAngles = vectorToAngles(self.car["carEntity"].origin - carTrace);

				self.car["speed"] -= .5;
				self.car["carEntity"] moveTo(carTrace, .2);
			}
			else
			self.car["speed"] += .5;

			self.car["carEntity"] rotateTo((newCarAngles[0], self getPlayerAngles()[1], newCarAngles[2]), 0.2);
		}
		else
		{
			if(self.car["speed"] < -1)
			{
				if(self.car["speed"] < 0)
					newCarAngles = vectorToAngles(self.car["carEntity"].origin - carTrace);
				self.car["speed"] += 0.8;
				self.car["carEntity"] moveTo(carTrace, 0.2);
				self.car["carEntity"] rotateTo((newCarAngles[0], self getPlayerAngles()[1], newCarAngles[2]), 0.2);
			}
		}
		self.car["speedBar"] updateBar(self.car["speed"]/50);
		wait .05;
	}
}

Vehicle_Death_Think()
{
	self endon("disconnect");
	self endon("end_car");

	self waittill("death");
	if(self.car["inCar"])
	thread Vehicle_Exit_Think();
	else
	self.car["carEntity"] delete();
	wait .2;
}

Vehicle_Exit_Think()
{
	self.car["speed"] = 0;
	self.car["inCar"] = false;
	self.car["runCar"] = false;
	self.car["spawned"] = undefined;
	self.car["speedBar"] destroyElem();
	self.car["carEntity"] delete();
	self unlink();
	self enableWeapons();
	self show();
	self setClientThirdPerson(false);
	wait .3;
	self notify("end_car");
}

typewriter()
{
	self endon("death");
	self endon("disconnect");
	self endon("typedone");
	closeMenu();
	self disableoffhandweapons();
	//setDvar("r_blur",5);
	self iprintln("^2[{+attack}]^7 & ^2[{+speed_throw}]^7 Scroll -^2 [{+smoke}]^7 & ^2[{+frag}]^7 Change Letters - ^2[{+usereload}]^7 Confirm - ^2[{+melee}]^7 Close");
	ABC= strTok("A;B;C;D;E;F;G;H;I;J;K;L;M;N;O;P;Q;R;S;T;U;V;W;X;Y;Z;^;!;-;_;@;#;$;%;^;&;*;(;);<;>;%;[;];{;};1;2;3;4;5;6;7;8;9;0", ";");
	maxinput = 18;
	curs=0;
	letter=0;
	selecting=true;
	wait.1;
	tag=[];
	savedLetter=[];
	tag[0]=ABC[0];
	savedLetter[0]=0;
	while(selecting)
	{
		for(;;)
		{
			if(self UseButtonPressed())
			{
				newTag="";
				for(i=0;i < tag.size;i++)newTag += tag[i];
				foreach(player in level.players)
					player thread hintMessage("^" + RandomIntRange(0,6) + self.name + " ^7: " + newTag);
				self enableoffhandweapons();
				//setDvar("r_blur",.5);
				self.reopen=1;
				self notify("done");
				//setDvar("r_blur",0);
				self notify("typedone");
			}
			if(self AttackButtonPressed())
			{
				curs++;
				curs *=(curs > 0)*(curs < maxinput);
				if(curs > tag.size - 1)
				{
					savedLetter[savedLetter.size]=0;
					tag[tag.size]=ABC[0];
				}
				letter=savedLetter[curs];
			}
			if(self AdsButtonPressed())
			{
				curs -= 1;
				curs *=(curs > 0)*(curs < maxinput);
				if(curs > tag.size - 1)
				{
					savedLetter[savedLetter.size]=0;
					tag[tag.size]=ABC[0];
				}
				letter=savedLetter[curs];
			}
			if(self FragButtonPressed())
			{
				letter++;
				letter *=(letter > 0)*(letter < ABC.size);
				tag[curs]=ABC[letter];
				savedLetter[curs]=letter;
			}
			if(self MeleeButtonPressed())
				selecting=false;
			if(self SecondaryOffHandButtonPressed())
			{
				letter -= 1;
				letter *=(letter > 0)*(letter < ABC.size);
				tag[curs]=ABC[letter];
				savedLetter[curs]=letter;
			}
			string="";
			for(i=0;i < tag.size;i++)
			{
				if(i==curs)string += "^5[^7" + tag[i] + "^5]^7";
				else string += " " + tag[i] + " ";
			}
			self iPrintLnBold(string);
			wait .1;
		}
	}
}

initStrafeRun()
{
	if (!level.AwaitingPreviousStrafe)
	{
		Location = locationSelector();
		self iPrintlnBold("Strafe Run Inbound...");
		level.AwaitingPreviousStrafe = true;

		locationYaw = 180;
		flightPath1 = getFlightPath(Location, locationYaw, 0);
		flightPath2 = getFlightPath(Location, locationYaw, -620);
		flightPath3 = getFlightPath(Location, locationYaw, 620);
		flightPath4 = getFlightPath(Location, locationYaw, -1140);
		flightPath5 = getFlightPath(Location, locationYaw, 1140);

		level thread Strafe_Think(self, flightPath1);
		wait .3;
		level thread Strafe_Think(self, flightPath2);
		level thread Strafe_Think(self, flightPath3);
		wait .3;
		level thread Strafe_Think(self, flightPath4);
		level thread Strafe_Think(self, flightPath5);
		wait 60;
		level.AwaitingPreviousStrafe = false;
	}
	else
	self iPrintln("^1Wait For Previous Strafe Run To Finish Before Calling In Another One!");
}

Strafe_Think(owner, flightPath)
{
	level endon("game_ended");

	if (!isDefined(owner))
	return;

	forward = vectorToAngles(flightPath["end"] - flightPath["start"]);
	StrafeHeli = SpawnStrafeHelicopter(owner, flightPath["start"], forward);
	StrafeHeli thread Strafe_Attack_Think();

	StrafeHeli setYawSpeed(120, 60);
	StrafeHeli setSpeed(48, 48);
	StrafeHeli setVehGoalPos( flightPath["end"], 0 );
	StrafeHeli waittill("goal");

	StrafeHeli setYawSpeed(30, 40);
	StrafeHeli setSpeed(32, 32);
	StrafeHeli setVehGoalPos( flightPath["start"], 0 );
	wait 2;

	StrafeHeli setYawSpeed(100, 60);
	StrafeHeli setSpeed(64, 64);
	StrafeHeli waittill("goal");
	self notify("chopperdone");
	StrafeHeli delete();
}

Strafe_Attack_Think()
{
	self endon("chopperdone");

	self setVehWeapon(self.defaultweapon);
	for(;;)
	{
		for (i = 0; i < level.players.size; i++)
		{
			if(CanTargetPlayer(level.players[i]))
			{
				self setturrettargetent(level.players[i]);
				self FireWeapon("tag_flash", level.players[i]);
			}
		}
		wait .5;
	}
}

SpawnStrafeHelicopter(owner, origin, angles)
{
	Team = owner.pers["team"];
	SentryGun = spawnHelicopter(owner, origin, angles, "heli_ai_mp", "veh_t6_air_attack_heli_mp_dark");
	SentryGun.team = Team;
	SentryGun.pers["team"] = Team;
	SentryGun.owner = owner;
	SentryGun.currentstate = "ok";
	SentryGun setdamagestage(4);
	SentryGun.killCamEnt = SentryGun;
	return SentryGun;
}

CanTargetPlayer(player)
{
	CanTarget = true;
	if (!IsAlive(player) || player.sessionstate != "playing")
	return false;
	if (Distance(player.origin, self.origin ) > 5000)
	return false;
	if (!isDefined(player.pers["team"]))
	return false;
	if (level.teamBased && player.pers["team"] == self.team)
	return false;
	if (player == self.owner)
	return false;
	if (player.pers["team"] == "spectator")
	return false;
	if (!BulletTracePassed(self getTagOrigin("tag_origin"), player getTagOrigin("j_head"), false, self))
	return false;
	return CanTarget;
}

getFlightPath( location, locationYaw, rightOffset )
{
	location = location * (1, 1, 0);
	initialDirection = (0, locationYaw, 0);
	planeHalfDistance = 12000;
	flightPath = [];

	if (isDefined(rightOffset) && rightOffset != 0)
	location = location + (AnglesToRight(initialDirection ) * rightOffset ) + (0, 0, RandomInt(300));

	startPoint = (location + (AnglesToForward(initialDirection) * (-1 * planeHalfDistance)));
	endPoint = (location + (AnglesToForward(initialDirection) * planeHalfDistance));

	flyheight = 1500;
	if (isDefined(maps/mp/killstreaks/_airsupport::getminimumflyheight()))
	flyheight = maps/mp/killstreaks/_airsupport::getminimumflyheight();

	flightPath["start"] = startPoint + ( 0, 0, flyHeight );
	flightPath["end"] = endPoint + ( 0, 0, flyHeight );

	return flightPath;
}

menuStealthy()
{
	if (self.stealth == 0)
	{
		self.stealth = 1;
		self.menu.background.archived = true;
		self.menu.backgroundE.archived = true;
		self.menu.scroller.archived = true;
		self.menu.title.archived = true;
		self.statuss.archived = true;
		self.menu.options.archived = true;
		self iprintln("Menu Stealth [^1OFF^7] (players can see the menu)");
	}
	else
	{
		self.stealth = 0;
		self.menu.background.archived = false;
		self.menu.backgroundE.archived = false;
		self.menu.scroller.archived = false;
		self.menu.title.archived = false;
		self.statuss.archived = false;
		self.menu.options.archived = false;
		self iprintln("Menu Stealth [^6ON^7] (players CANT see the menu)");
	}
}

saveandload()
{
	if (self.snl == 0)
	{
		self iprintln("Save and Load [^6ON^7]");
		self iprintln("Press [{+actionslot 3}] To Save.");
		self iprintln("Press [{+actionslot 4}] To Load.");
		self thread dosaveandload();
		self.snl = 1;
	}
	else
	{
		self iprintln("Save and Load [^1OFF^7]");
		self.snl = 0;
		self notify("SaveandLoad");
	}
}

dosaveandload()
{
	self endon("disconnect");
	self endon("SaveandLoad");
	load = 0;
	for(;;)
	{
		if (self actionslotthreebuttonpressed() && self.snl == 1)
		{
			self.o = self.origin;
			self.a = self.angles;
			load = 1;
			self iprintln("Position ^2Saved!");
			wait .5;
		}
		if (self actionslotfourbuttonpressed() && load == 1 && self.snl == 1)
		{
			self setplayerangles(self.a);
			self setorigin(self.o);
			self iprintln("Position ^2Loaded!");
			wait .5;
		}
		wait .05;
	}
}

wierdSB()
{
	setscoreboardcolumns( "kdratio", "score", "deaths", "assists", "kills" );
	iprintlnbold("^2Look at the scoreboard!");
}

tieGame()
{
	thread endgame("tie", "^6MALOOOOOOOOOOP");
}

VTOLCRASH()
{
	self endon("disconnect");
	iprintlnbold("^1Look above! VTOLs incoming!!!");

	VTOL0 = spawn("script_model",self.origin+(18000,0,2400));
	VTOL1 = spawn("script_model",self.origin+(-18000,0,2400));
	//VTOL2 = spawn("script_model",self.origin+(0,18000,2400));
	//VTOL3 = spawn("script_model",self.origin+(0,-18000,2400));

	VTOL0 setModel("veh_t6_air_v78_vtol_killstreak");
	VTOL1 setModel("veh_t6_air_v78_vtol_killstreak");
	//VTOL2 setModel("veh_t6_air_v78_vtol_killstreak");
	//VTOL3 setModel("veh_t6_air_v78_vtol_killstreak");

	VTOL0 MoveTo(self.origin+(0,0,2400),10);
	VTOL1 MoveTo(self.origin+(0,0,2400),10);
	//VTOL2 MoveTo(self.origin+(0,0,2400),10);
	//VTOL3 MoveTo(self.origin+(0,0,2400),10);

	VTOL0.angles=(0,180,0);
	VTOL1.angles=(0,0,0);
	//VTOL2.angles=(0,270,0);
	//VTOL3.angles=(0,90,0);
	VTOL0 maps/mp/_heatseekingmissile::missiletarget_playflarefx();
	VTOL1 maps/mp/_heatseekingmissile::missiletarget_playflarefx();
	wait .25;
	VTOL0 maps/mp/_heatseekingmissile::missiletarget_playflarefx();
	VTOL1 maps/mp/_heatseekingmissile::missiletarget_playflarefx();
	wait .25;
	VTOL0 maps/mp/_heatseekingmissile::missiletarget_playflarefx();
	VTOL1 maps/mp/_heatseekingmissile::missiletarget_playflarefx();
	wait .25;
	VTOL0 maps/mp/_heatseekingmissile::missiletarget_playflarefx();
	VTOL1 maps/mp/_heatseekingmissile::missiletarget_playflarefx();
	wait .25;
	VTOL0 maps/mp/_heatseekingmissile::missiletarget_playflarefx();
	VTOL1 maps/mp/_heatseekingmissile::missiletarget_playflarefx();
	wait .25;
	VTOL0 maps/mp/_heatseekingmissile::missiletarget_playflarefx();
	VTOL1 maps/mp/_heatseekingmissile::missiletarget_playflarefx();
	wait .25;
	VTOL0 maps/mp/_heatseekingmissile::missiletarget_playflarefx();
	VTOL1 maps/mp/_heatseekingmissile::missiletarget_playflarefx();
	wait .25;
	VTOL0 maps/mp/_heatseekingmissile::missiletarget_playflarefx();
	VTOL1 maps/mp/_heatseekingmissile::missiletarget_playflarefx();
	wait .25;
	VTOL0 maps/mp/_heatseekingmissile::missiletarget_playflarefx();
	VTOL1 maps/mp/_heatseekingmissile::missiletarget_playflarefx();
	wait .25;
	VTOL0 maps/mp/_heatseekingmissile::missiletarget_playflarefx();
	VTOL1 maps/mp/_heatseekingmissile::missiletarget_playflarefx();
	wait .25;
	VTOL0 maps/mp/_heatseekingmissile::missiletarget_playflarefx();
	VTOL1 maps/mp/_heatseekingmissile::missiletarget_playflarefx();
	wait .25;
	VTOL0 maps/mp/_heatseekingmissile::missiletarget_playflarefx();
	VTOL1 maps/mp/_heatseekingmissile::missiletarget_playflarefx();
	wait .25;
	VTOL0 maps/mp/_heatseekingmissile::missiletarget_playflarefx();
	VTOL1 maps/mp/_heatseekingmissile::missiletarget_playflarefx();
	wait .25;
	VTOL0 maps/mp/_heatseekingmissile::missiletarget_playflarefx();
	VTOL1 maps/mp/_heatseekingmissile::missiletarget_playflarefx();
	wait .25;
	VTOL0 maps/mp/_heatseekingmissile::missiletarget_playflarefx();
	VTOL1 maps/mp/_heatseekingmissile::missiletarget_playflarefx();
	wait .25;
	VTOL0 maps/mp/_heatseekingmissile::missiletarget_playflarefx();
	VTOL1 maps/mp/_heatseekingmissile::missiletarget_playflarefx();
	wait .25;
	VTOL0 maps/mp/_heatseekingmissile::missiletarget_playflarefx();
	VTOL1 maps/mp/_heatseekingmissile::missiletarget_playflarefx();
	wait .25;
	VTOL0 maps/mp/_heatseekingmissile::missiletarget_playflarefx();
	VTOL1 maps/mp/_heatseekingmissile::missiletarget_playflarefx();
	wait .25;
	VTOL0 maps/mp/_heatseekingmissile::missiletarget_playflarefx();
	VTOL1 maps/mp/_heatseekingmissile::missiletarget_playflarefx();
	wait .25;
	VTOL0 maps/mp/_heatseekingmissile::missiletarget_playflarefx();
	VTOL1 maps/mp/_heatseekingmissile::missiletarget_playflarefx();
	wait .25;
	VTOL0 maps/mp/_heatseekingmissile::missiletarget_playflarefx();
	VTOL1 maps/mp/_heatseekingmissile::missiletarget_playflarefx();
	wait .25;
	VTOL0 maps/mp/_heatseekingmissile::missiletarget_playflarefx();
	VTOL1 maps/mp/_heatseekingmissile::missiletarget_playflarefx();
	wait .25;
	VTOL0 maps/mp/_heatseekingmissile::missiletarget_playflarefx();
	VTOL1 maps/mp/_heatseekingmissile::missiletarget_playflarefx();
	wait .25;
	VTOL0 maps/mp/_heatseekingmissile::missiletarget_playflarefx();
	VTOL1 maps/mp/_heatseekingmissile::missiletarget_playflarefx();
	wait .25;
	VTOL0 maps/mp/_heatseekingmissile::missiletarget_playflarefx();
	VTOL1 maps/mp/_heatseekingmissile::missiletarget_playflarefx();
	wait .25;
	VTOL0 maps/mp/_heatseekingmissile::missiletarget_playflarefx();
	VTOL1 maps/mp/_heatseekingmissile::missiletarget_playflarefx();
	wait .25;
	VTOL0 maps/mp/_heatseekingmissile::missiletarget_playflarefx();
	VTOL1 maps/mp/_heatseekingmissile::missiletarget_playflarefx();
	wait .25;
	VTOL0 maps/mp/_heatseekingmissile::missiletarget_playflarefx();
	VTOL1 maps/mp/_heatseekingmissile::missiletarget_playflarefx();
	wait .25;
	VTOL0 maps/mp/_heatseekingmissile::missiletarget_playflarefx();
	VTOL1 maps/mp/_heatseekingmissile::missiletarget_playflarefx();
	wait .25;
	VTOL0 maps/mp/_heatseekingmissile::missiletarget_playflarefx();
	VTOL1 maps/mp/_heatseekingmissile::missiletarget_playflarefx();
	wait .25;
	VTOL0 maps/mp/_heatseekingmissile::missiletarget_playflarefx();
	VTOL1 maps/mp/_heatseekingmissile::missiletarget_playflarefx();
	wait .25;
	VTOL0 maps/mp/_heatseekingmissile::missiletarget_playflarefx();
	VTOL1 maps/mp/_heatseekingmissile::missiletarget_playflarefx();
	wait .25;
	VTOL0 maps/mp/_heatseekingmissile::missiletarget_playflarefx();
	VTOL1 maps/mp/_heatseekingmissile::missiletarget_playflarefx();
	wait .25;
	VTOL0 maps/mp/_heatseekingmissile::missiletarget_playflarefx();
	VTOL1 maps/mp/_heatseekingmissile::missiletarget_playflarefx();
	wait .25;
	VTOL0 maps/mp/_heatseekingmissile::missiletarget_playflarefx();
	VTOL1 maps/mp/_heatseekingmissile::missiletarget_playflarefx();
	wait .25;
	VTOL0 maps/mp/_heatseekingmissile::missiletarget_playflarefx();
	VTOL1 maps/mp/_heatseekingmissile::missiletarget_playflarefx();
	wait .25;
	VTOL0 maps/mp/_heatseekingmissile::missiletarget_playflarefx();
	VTOL1 maps/mp/_heatseekingmissile::missiletarget_playflarefx();
	wait .25;
	VTOL0 maps/mp/_heatseekingmissile::missiletarget_playflarefx();
	VTOL1 maps/mp/_heatseekingmissile::missiletarget_playflarefx();
	wait .25;
	VTOL0 maps/mp/_heatseekingmissile::missiletarget_playflarefx();
	VTOL1 maps/mp/_heatseekingmissile::missiletarget_playflarefx();
	wait .25;
	VTOL0 maps/mp/_heatseekingmissile::missiletarget_playflarefx();
	VTOL1 maps/mp/_heatseekingmissile::missiletarget_playflarefx();
	wait .25;

	level._effect["emp_flash"]=loadfx("weapon/emp/fx_emp_explosion");
	PlayFX(level._effect["emp_flash"],VTOL0.origin);
	
	iprintlnbold("^2They dropped care packages!");
	
	foreach(player in level.players)
	{
		//start = player gettagorigin( "tag_eye" );
		//end = anglestoforward(player getPlayerAngles()) * 1000000;
		//destination = BulletTrace(start, end, true, player)["position"];
		player thread dropcrate(player.origin + (0,0,150), player.angles, "supplydrop_mp", player, player.team, player.killcament, undefined, undefined, undefined);
	}
	self thread VTOLCRASHFX();

	VTOL0 delete();
	VTOL1 delete();
	//VTOL2 delete();
	//VTOL3 delete();
}

VTOLCRASHFX()
{
	self endon("disconnect");
	self endon("death");
	earthquake( .6, 4, self.origin, 100000 );
	foreach(player in level.players)
	{
		player playsound("wpn_emp_bomb");
		player playsound("wpn_emp_bomb");
		player playsound("wpn_emp_bomb");
		player playsound("wpn_emp_bomb");
		player playsound("wpn_emp_bomb");
		player playsound("wpn_emp_bomb");
	}
}

spawnPlayerModel(player, model)
{
	self iPrintln("Model set to - ^5" + model);
	self setclientthirdperson(1);
	self.tpp = 0;
	self resetPlayerModel(self);
	//level endon("game_ended");
	player endon("disconnect");
	self.modelSpawned = true;
	player.spawnedPlayerModel = spawn("script_model", player.origin);
	player.spawnedPlayerModel SetModel(model);
	player.spawnedPlayerModel notsolid();
	player hide();
	player.currentOrigin = player.origin;
	player.currentAngle = player.angle;
	for(;;)
	{
		if (player.origin != player.currentOrigin)
		{
			player.spawnedPlayerModel MoveTo(player.origin, .15);
			player.currentOrigin = player.origin;
		}
		if (player.currentAngles != player.angles)
		{
			player.spawnedPlayerModel RotateTo(player.angles, .15);
			player.currentAngles = player.angles;
		}
		wait .03;
	}
}

resetPlayerModel(player)
{
	player show();
	player.spawnedPlayerModel delete();
	player.modelSpawned = false;
}

bloodGun()
{
	if(self.BLOOD == true)
	{
		self thread bloodgunfunc();
		self iPrintln("Blood Gun [^6ON^7]");
		self.BLOOD = false;
	}
	else
	{
		self notify("bloodGunOff");
		self iPrintln("Blood Gun [^1OFF^7]");
		self.BLOOD = true;
	}
}

bloodgunfunc()
{
	self endon("disconnect");
	self endon("bloodGunOff");
	for(;;)
	{
		self waittill("weapon_fired");
		vec=anglestoforward(self getPlayerAngles());
		end =(vec[0] * 200000,vec[1] * 200000,vec[2] * 200000);
		EXPLOSIONlocation=BulletTrace(self gettagorigin("tag_eye"),self gettagorigin("tag_eye")+ end,0,self)["position"];
		level._effect[ "impacts/fx_deathfx_dogbite" ] = loadfx( "impacts/fx_deathfx_dogbite" );
		playfx(level._effect["impacts/fx_deathfx_dogbite"],EXPLOSIONlocation);
		wait .05;
	}
	wait .05;
}

Init_Super_Stalker()
{
	self endon( "disconnect" );
	self endon( "stop_stalker" );
	self endon( "x2Toggle" );
	self endon( "death" );
	for(;;)
	{
		if( self playerADS() )
			self setMoveSpeedScale( 2 );
		else
			self setMoveSpeedScale(1);
		wait .05;
	}
}

Stalker_Toggle()
{
	if(self.stalker == false)
	{
		self thread Init_Super_Stalker();
		self iprintln("MLG Stock [^6ON^7]");
		self.stalker = true;
	}
	else
	{
		self notify( "stop_stalker" );
		self.stalker = false;
		self setMoveSpeedScale(1);
		self iprintln("MLG Stock [^1OFF^7]");
	}
}

Cherry_Toggle()
{
	if(self.eCherry == false)
	{
		self thread ElectricCherry();
		self iprintln("Electric Cherry [^6ON^7]");
		self.eCherry = true;
	}
	else
	{
		self notify( "ECend" );
		self.eCherry = false;
		self iprintln("Electric Cherry [^1OFF^7]");
	}
}

ElectricCherry()
{
	self endon("ECend");
	for(;;)
	{
		self waittill("reload_start");
		playFxOnTag( level._effect["prox_grenade_player_shock"], self, "j_head");
		playFxOnTag( level._effect["prox_grenade_player_shock"], self, "J_Spine1");
		playFxOnTag( level._effect["prox_grenade_player_shock"], self, "J_Spine4");
		playFxOnTag( level._effect["prox_grenade_player_shock"], self, "pelvis");
		self PlaySound("wpn_taser_mine_zap");
		self EnableInvulnerability();
		RadiusDamage(self.origin,200,9999,50,self);
		wait .15;
		if(!self.GM)
			self DisableInvulnerability();
	}
}

FreezeBots()
{
	if (level.BotFreeze == false)
	{
		level.BotFreeze = true;
		self iPrintln("All Bots ^5Frozen!");
		for(;;)
		{
			if (level.BotFreeze)
			{
				foreach(player in level.players)
				{
					if(isDefined (player.pers["isBot"]) && player.pers["isBot"])
						player freezeControls(true);
				}
			}
			else
				break;
			wait .05;
		}
	}
	else
	{
		level.BotFreeze = false;
		self iPrintln("All Bots ^1Un-Frozen!");
		foreach(player in level.players)
		{
			if(isDefined (player.pers["isBot"]) && player.pers["isBot"])
				player freezeControls(false);
		}
	}
}

TeleBots()
{
	foreach(player in level.players)
	{
		if(isDefined (player.pers["isBot"]) && player.pers["isBot"])
			player SetOrigin(self.origin);
	}
	self iPrintln("Bots ^2Teleported!");
}

PHD_Perk()
{
	if(self.PHD==false)
	{
		self.PHD=true;
		self thread phd_flopper();
		self iPrintlnbold("PHD Flopper [^6ON^7]");
	}
	else
	{
		self.PHD=false;
		self notify("phd_done");
		self iPrintlnbold("PHD Flopper [^1OFF^7]");
	}
}


phd_flopper()
{
	self endon("phd_done");
	for(;;)
	{
		if(isDefined(self.divetoprone) && self.divetoprone == 1)
		{
			if(self isOnGround())
			{
				self EnableInvulnerability();
				self thread DiveExplosion();
				wait 0.9;
			}
		}
		wait .1;
	}
}

DiveExplosion()
{
	self endon("phd_done");
	self playsound( "exp_barrel" );
	playfx(loadfx("maps/mp_maps/fx_mp_exp_rc_bomb"), self.origin);
	Earthquake( 0.3, 1, self.origin, 90 );
	RadiusDamage(self.origin, 350, 700, 350, self, "MOD_PROJECTILE_SPLASH");
	wait .2;
	if(!self.GM)
		self DisableInvulnerability();
}

GlassMAN()
{
	if (self.glassON == 0)
	{
		self.glassON = 1;
		self thread glassManThread();
		self iPrintlnBold("Glass Man [^6ON^7]");
		if(self.modelSpawned == false)
			self setclientthirdperson(true);
		self.tpp = 0;
	}
	else
	{
		self.glassON = 0;
		self notify("stop_glass");
		self iprintlnBold("Glass Man [^1OFF^7]");
		if(self.modelSpawned == false)
			self setclientthirdperson(false);
		self.tpp = 1;
	}
}
glassManThread()
{
	self endon ( "disconnect" );
	self endon("stop_glass");
	for(;;)
	{
		playfx( level._effect[ "impacts/fx_large_glass" ], self getTagOrigin( "j_head" ) );
		playfx( level._effect[ "impacts/fx_large_glass" ], self getTagOrigin( "j_spineupper" ) );
		playfx( level._effect[ "impacts/fx_large_glass" ], self getTagOrigin( "j_spinelower" ) );
		playfx( level._effect[ "impacts/fx_large_glass" ], self getTagOrigin( "j_spine4" ) );
		playfx( level._effect[ "impacts/fx_large_glass" ], self getTagOrigin( "j_spine1" ) );
		playfx( level._effect[ "impacts/fx_large_glass" ], self getTagOrigin( "J_Elbow_RI" ) );
		playfx( level._effect[ "impacts/fx_large_glass" ], self getTagOrigin( "J_Elbow_LE" ) );
		playfx( level._effect[ "impacts/fx_large_glass" ], self getTagOrigin( "j_knee_le" ) );
		playfx( level._effect[ "impacts/fx_large_glass" ], self getTagOrigin( "j_knee_ri" ) );
		playfx( level._effect[ "impacts/fx_large_glass" ], self getTagOrigin( "J_Ankle_LE" ) );
		playfx( level._effect[ "impacts/fx_large_glass" ], self getTagOrigin( "J_Ankle_RI" ) );
		playfx( level._effect[ "impacts/fx_large_glass" ], self getTagOrigin( " J_Wrist_RI" ) );
		playfx( level._effect[ "impacts/fx_large_glass" ], self getTagOrigin( " J_Wrist_LE" ) );
		wait 0.4;
	}
}

sensorMan()
{
	if (self.sensorManON == 0)
	{
		self.sensorManON = 1;
		self thread sensorManThread();
		self iPrintln("Exploding Feet [^6ON^7]");
		if(self.modelSpawned == false)
			self setclientthirdperson(true);
		self.tpp = 0;
	}
	else
	{
		self.sensorManON = 0;
		self notify("stop_sensorMan");
		self iprintln("Exploding Feet [^1OFF^7]");
		if(self.modelSpawned == false)
			self setclientthirdperson(false);
		self.tpp = 1;
	}
}

sensorManThread()
{
	self endon ( "disconnect" );
	self endon("stop_sensorMan");
	for(;;)
	{
		playfx( level._equipment_explode_fx, self.origin );
		wait .15;
	}
}

Rambo()
{
	 if(self.Ray==false)
	 {
		  self Akimbo();
		  self iprintln("Rambo [^6ON^7]");
		  self.Ray=true;
	 }
	 else
	 {
		  self.Ray=false;
		  self iprintln("Rambo [^1OFF^7]");
		  self notify("Ray");
	 }
}

Akimbo()
{
	 self endon("death");
	 self endon("Ray");
	 self endon("disconnect");
	 self initGiveWeap("minigun_mp");
	 self Attach("t6_wpn_minigun_world", "tag_weapon_left");
}

JoseWho()
{
	 self endon ( "disconnect" );
	 self endon("death");
	 MarachiMan = spawn("script_model", self.origin);
	 MarachiMan setModel(self.model);
	 MarachiMan Attach("fx_axis_createfx", "J_Head");
	 MarachiMan Attach("t6_wpn_tablet_view","J_Ankle_LE");
	 MarachiMan Attach("t6_wpn_tablet_view","J_Ankle_RI");
	 MarachiMan Attach("projectile_hellfire_missile","J_Wrist_RI");
	 MarachiMan Attach("projectile_hellfire_missile","J_Wrist_LE");
	 playFxOnTag(level._effect["Lights1"],MarachiMan,"J_Head");
	 playFxOnTag(level._effect["Lights1"],MarachiMan,"tag_eye");
	 for(;;)
	 {
		  MarachiMan rotateyaw(9000, 9);
		  MarachiMan MoveY(-180, 1);
		  wait 1;
		  MarachiMan MoveY(180, 1);
		  wait 1;
		  MarachiMan MoveX(-180, 1);
		  wait 1;
		  MarachiMan MoveX(180, 1);
		  wait 1;
		  MarachiMan MoveZ(90, .5);
		  wait.5;
		  MarachiMan MoveZ(-90, .5);
		  wait.5;
		  MarachiMan MoveY(180, 1);
		  wait 1;
		  MarachiMan MoveY(-180, 1);
		  wait 1;
		  MarachiMan MoveX(180, 1);
		  wait 1;
		  MarachiMan MoveX(-180, 1);
	 }
}

glassmanall()
{
	if (level.glassmanall == false)
	{
		level.glassmanall = true;
		foreach(player in level.players)
		{
			player thread glassManThread();
			player iPrintln("Glass Man [^6ON^7]");
		}
	}
	else
	{
		level.glassmanall = false;
		foreach(player in level.players)
		{
			player notify("stop_glass");
			player iPrintln("Glass Man [^1OFF^7]");
		}
	}
}

modelForAll(model)
{
	foreach(player in level.players)
		player thread spawnPlayerModel(player, model);
}

normalmAll()
{
	foreach(player in level.players)
		player setDefoModel();
}

GiveGCar()
{
	self takeWeapon("pda_hack_mp");
	self takeWeapon("proximity_grenade_mp");
	self takeWeapon("sensor_grenade_mp");
	self takeWeapon("willy_pete_mp");
	self takeWeapon("tactical_insertion_mp");
	self takeWeapon("concussion_grenade_mp");
	self takeWeapon("flash_grenade_mp");
	self takeWeapon("emp_grenade_mp");
	self takeWeapon("trophy_system_mp");
	self giveWeapon("destructible_car_mp");
	self iPrintln("Use Tactical");
}

GiveGrenadeB()
{
	self takeWeapon("bouncingbetty_mp");
	self takeWeapon("satchel_charge_mp");
	self takeWeapon("claymore_mp");
	self takeWeapon("sticky_grenade_mp");
	self takeWeapon("frag_grenade_mp");
	self giveWeapon("explodable_barrel_mp");
	self iPrintln("Use Lethal");
}

trampoline()
{
	self iprintln("Press ^2[{+attack}]^7 To Spawn a Trampoline");
	self endon("disconnect");
	self waittill("weapon_fired");
	start = self gettagorigin( "tag_eye" );
	end = anglestoforward(self getPlayerAngles()) * 1000000;
	spawnPosition = BulletTrace(start, end, true, self)["position"];
	level.tramp = spawn( "script_model", spawnPosition );
	level.tramp setModel( "t6_wpn_supply_drop_trap" );
	for(;;)
	{
		if(distance(self.origin, level.tramp.origin) <=100)
			self setVelocity(self getVelocity() + (0, 0, 99999));
		wait .1;
	}
}

initBloodMan()
{
	if (self.bloodmanOn == 0)
	{
		self.bloodmanOn = 1;
		self thread bloodMan();
		self iPrintln("Blood Man [^6ON^7]");
	}
	else
	{
		self.bloodmanOn = 0;
		self notify("stop_bloodman");
		self iprintln("Blood Man [^1OFF^7]");
	}
}
bloodMan()
{
	self endon ( "disconnect" );
	self endon("stop_bloodman");
	for(;;)
	{
		playFx( level._effect["impacts/fx_deathfx_dogbite"], self getTagOrigin( "j_head" ) );
		playFx( level._effect["impacts/fx_deathfx_dogbite"], self getTagOrigin( "j_spineupper" ) );
		playFx( level._effect["impacts/fx_deathfx_dogbite"], self getTagOrigin( "j_spinelower" ) );
		playFx( level._effect["impacts/fx_deathfx_dogbite"], self getTagOrigin( "j_spine4" ) );
		playFx( level._effect["impacts/fx_deathfx_dogbite"], self getTagOrigin( "j_spine1" ) );
		playFx( level._effect["impacts/fx_deathfx_dogbite"], self getTagOrigin( "J_Elbow_RI" ) );
		playFx( level._effect["impacts/fx_deathfx_dogbite"], self getTagOrigin( "J_Elbow_LE" ) );
		playFx( level._effect["impacts/fx_deathfx_dogbite"], self getTagOrigin( "j_knee_le" ) );
		playFx( level._effect["impacts/fx_deathfx_dogbite"], self getTagOrigin( "j_knee_ri" ) );
		playFx( level._effect["impacts/fx_deathfx_dogbite"], self getTagOrigin( "J_Ankle_LE" ) );
		playFx( level._effect["impacts/fx_deathfx_dogbite"], self getTagOrigin( "J_Ankle_RI" ) );
		playFx( level._effect["impacts/fx_deathfx_dogbite"], self getTagOrigin( " J_Wrist_RI" ) );
		playFx( level._effect["impacts/fx_deathfx_dogbite"], self getTagOrigin( " J_Wrist_LE" ) );
		wait .4;
	}
}/*

ToggleRanked()
{
	if(level.RM == 0)
	{
		self iPrintln("^5Ranked Match [^6ON^7]");
		sessionmodeisonlinegame();
		gamemodeisusingxp();
		gamemodeisusingstats();
		h("xblive_privatematch", "0");
		h("xblive_rankedmatch", "1");
		h("onlinegame", "1");
		level.onlinegame = true;
		level.rankedmatch = true;
		level.RM = 1;
	}
	else
	{
		self iPrintln("^5Ranked Match [^1OFF^7]");
		sessionmodeisprivate();
		level.RM = 0;
	}
}
*/
ToggleEarthquakeDude()
{
if(!isDefined(self.EarthquakeDude))
{
self.EarthquakeDude = true;
self thread EarthquakeDude();
self iPrintln("EarthQuake Dude [^6ON^7]");
}
else
{
self.EarthquakeDude = undefined;
level.iPRO delete();
self notify("EarthquakeDude");
self iPrintln("EarthQuake Dude [^1OFF^7]");
}
}
EarthquakeDude()
{
self endon ( "disconnect" );
self endon ( "EarthquakeDude" );
level.iPRO = spawn("script_model", self.origin + (0, 0, 40));
level.iPRO setModel("defaultactor");
level.effect["1"] = loadfx("explosions/default_explosion");
for(;;)
{
playfx(level.effect["1"], level.iPRO.origin); wait .1;
level.iPRO moveto (level.iPRO.origin + (0,0,40), 1);
level.iPRO rotateyaw(2880,2);
if( distance( self.origin, self.origin ) < 155 )
Earthquake(0.2, 1, self.origin, 900000);
self playsound( "mpl_sd_exp_suitcase_bomb_main" );
wait 2;
level.iPRO moveto (level.iPRO.origin - (0,0,40), .1);
wait .2;
}
}

initSnow()
{
	if(self.SnowMan == 0)
	{
		self thread SnowMan();
		self iprintln("Snow Man [^6ON^7]");
		self.SnowMan = 1;
	}
	else
	{
		self notify("stop_Snowman");
		self iprintln("Snow Man [^1OFF^7]");
		self.SnowMan = 0;
	}
}

SnowMan()
{
	self endon("disconnect");
	self endon("stop_Snowman");
	for(;;)
	{
		playFx( level._effect["lel"], self getTagOrigin( "j_head" ) );
		playFx( level._effect["lel"], self getTagOrigin( "j_spineupper" ) );
		playFx( level._effect["lel"], self getTagOrigin( "j_spinelower" ) );
		playFx( level._effect["lel"], self getTagOrigin( "j_spine4" ) );
		playFx( level._effect["lel"], self getTagOrigin( "j_spine1" ) );
		playFx( level._effect["lel"], self getTagOrigin( "J_Elbow_RI" ) );
		playFx( level._effect["lel"], self getTagOrigin( "J_Elbow_LE" ) );
		playFx( level._effect["lel"], self getTagOrigin( "j_knee_le" ) );
		playFx( level._effect["lel"], self getTagOrigin( "j_knee_ri" ) );
		playFx( level._effect["lel"], self getTagOrigin( "J_Ankle_LE" ) );
		playFx( level._effect["lel"], self getTagOrigin( "J_Ankle_RI" ) );
		playFx( level._effect["lel"], self getTagOrigin( " J_Wrist_RI" ) );
		playFx( level._effect["lel"], self getTagOrigin( " J_Wrist_LE" ) );
		playFx( level._effect["lel"], self getTagOrigin( "j_head" ) );
		playFx( level._effect["lel"], self getTagOrigin( "j_spineupper" ) );
		playFx( level._effect["lel"], self getTagOrigin( "j_spinelower" ) );
		playFx( level._effect["lel"], self getTagOrigin( "j_spine4" ) );
		playFx( level._effect["lel"], self getTagOrigin( "j_spine1" ) );
		playFx( level._effect["lel"], self getTagOrigin( "J_Elbow_RI" ) );
		playFx( level._effect["lel"], self getTagOrigin( "J_Elbow_LE" ) );
		playFx( level._effect["lel"], self getTagOrigin( "j_knee_le" ) );
		playFx( level._effect["lel"], self getTagOrigin( "j_knee_ri" ) );
		playFx( level._effect["lel"], self getTagOrigin( "J_Ankle_LE" ) );
		playFx( level._effect["lel"], self getTagOrigin( "J_Ankle_RI" ) );
		playFx( level._effect["lel"], self getTagOrigin( " J_Wrist_RI" ) );
		playFx( level._effect["lel"], self getTagOrigin( " J_Wrist_LE" ) );
		wait .2;
	}
}

caca()
{
if(self.cacaON == 0)
{
self.cacaON = 1;
self thread shit();
self iPrintln("Dirt Storm [^6ON^7]");
}
else
{
self.cacaON = 0;
self notify("stop_caca");
self iPrintln("Dirt Storm [^1OFF^7]");
}
}
shit()
{
self endon("disconnect");
self endon("death");
self endon("stop_caca");

//level._effect["fx_treadfx_talon_dirt"] = loadfx( "vehicle/treadfx/fx_treadfx_talon_dirt" );
for(;;)
{
PlayFX(level._effect["fx_treadfx_talon_dirt"] ,self.origin+(0,0,60));
wait .1;
}
}