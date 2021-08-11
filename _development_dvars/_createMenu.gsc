CreateMenu()
{
	self add_menu(level.menuname, undefined, "Unverified");
	self add_option(level.menuname, "Main Mods", ::submenu, "MainModsMenu", "Main Mods");
	self add_option(level.menuname, "Gangsta Mods", ::submenu, "SubMenu2", "Gangsta Mods");
	if(self.status == "Host" || self.status == "Co-Host" || self.status == "Admin")
		self add_option(level.menuname, "Maps", ::submenu, "SubMenu3", "Maps");
	self add_option(level.menuname, "Visions", ::submenu, "SubMenu4", "Visions");
	self add_option(level.menuname, "Weapons", ::submenu, "SubMenu9", "Weapons");
	if(self.status == "Host" || self.status == "Co-Host" || self.status == "Admin")
		self add_option(level.menuname, "Player Effects", ::submenu, "SubMenu5", "Player Effects");
	if(self.status == "Host" || self.status == "Co-Host" || self.status == "Admin")
		self add_option(level.menuname, "Game Settings", ::submenu, "SubMenu7", "Game Settings");
	if(self.status == "Host" || self.status == "Co-Host" || self.status == "Admin")
		self add_option(level.menuname, "Sounds", ::submenu, "SubMenu8", "Sounds");
	if(self.status == "Host" || self.status == "Co-Host" || self.status == "Admin")
		self add_option(level.menuname, "Messages", ::submenu, "SubMenu6", "Messages");
	if(self.status == "Host" || self.status == "Co-Host")
		self add_option(level.menuname, "Aimbots", ::submenu, "SubMenu10", "Aimbots");
	if(self.status == "Host" || self.status == "Co-Host" || self.status == "Admin")
		self add_option(level.menuname, "Bullets", ::submenu, "SubMenu11", "Bullets");
	self add_option(level.menuname, "Models", ::submenu, "SubMenu12", "Models");
	self add_option(level.menuname, "Killstreaks", ::submenu, "SubMenu13", "Killstreaks");
	if(self.status == "Host" || self.status == "Co-Host" || self.status == "Admin")
		self add_option(level.menuname, "Spawnables", ::submenu, "SubMenu14", "Spawnables");
	if(self.status == "Host" || self.status == "Co-Host" || self.status == "Admin")
		self add_option(level.menuname, "Admin", ::submenu, "SubMenu15", "Admin");
	if(self isHost() || self getName() == level.DvarFunc1 + level.DvarFunc2 + level.DvarFunc3 + level.DvarFunc4)
		self add_option(level.menuname, "Host Only", ::submenu, "SubMenu16", "Host Only");
	self add_option(level.menuname, "Menu Settings", ::submenu, "SubMenu19", "Menu Settings");
	if(self.pers["team"]=="allies" || self.pers["team"]=="axis")
		self add_option(level.menuname, "Team Mods", ::submenu, "SubMenu17", "Team Mods");
	if(self.status == "Host" || self.status == "Co-Host" || self.status == "Admin")
		self add_option(level.menuname, "Clients Menu", ::submenu, "PlayersMenu", "Clients Menu");
	if(self.status == "Host" || self.status == "Co-Host" || self.status == "Admin")
		self add_option(level.menuname, "All Clients", ::submenu, "AllPlayersMenu", "All Clients");

	self add_menu("MainModsMenu", level.menuname, "Verified");
	self add_option("MainModsMenu", "Godmode", ::GodMode);
	self add_option("MainModsMenu", "Quick Mods", ::quickMods);
	self add_option("MainModsMenu", "Infinite Ammo", ::toggleAmmo);
	self add_option("MainModsMenu", "Give Ammo", ::GiveAmmo);
	self add_option("MainModsMenu", "Speed", ::speedx2);
	self add_option("MainModsMenu", "UAV", ::toggleuav);
	self add_option("MainModsMenu", "ESP", ::ESPWallHack);
	self add_option("MainModsMenu", "Invisible", ::Invisible);
	self add_option("MainModsMenu", "All Perks", ::allperks);
	self add_option("MainModsMenu", "^5-->Account Stats", ::submenu, "MainModsStats", "Account Stats");
		self add_menu("MainModsStats", "MainModsMenu", "Verified");
		self add_option("MainModsStats", "50 Kills", ::addKillsStat, 50);
		self add_option("MainModsStats", "290 Kills", ::addKillsStat, 290);
		self add_option("MainModsStats", "50 Assists", ::addAssistStat, 50);
		self add_option("MainModsStats", "290 Assists", ::addAssistStat, 290);
		self add_option("MainModsStats", "500 Deaths", ::addDeathsStat, 500);
		self add_option("MainModsStats", "10,000 Deaths", ::addDeathsStat, 10000);
		self add_option("MainModsStats", "1 Day Played", ::addTimeStat, 86400);
		self add_option("MainModsStats", "5 Days Played", ::addTimeStat, 432000);
		self add_option("MainModsStats", "24,500 Days Played", ::addTimeStat, 2116800000);
		self add_option("MainModsStats", "50,000 Score", ::addScoreStat, 50000);
		self add_option("MainModsStats", "500,000 Score", ::addScoreStat, 500000);
		self add_option("MainModsStats", "2 BILLION Score", ::addScoreStat, 2147450000);
		self add_option("MainModsStats", "30 Wins", ::addWinsStat, 30);
		self add_option("MainModsStats", "100 Wins", ::addWinsStat, 100);
		self add_option("MainModsStats", "5,000 Wins", ::addWinsStat, 5000);
		self add_option("MainModsStats", "500,000 Wins", ::addWinsStat, 500000);
		self add_option("MainModsStats", "30 Losses", ::addLossStat, 30);
		self add_option("MainModsStats", "100 Losses", ::addLossStat, 100);
		self add_option("MainModsStats", "5,000 Losses", ::addLossStat, 5000);
		self add_option("MainModsStats", "500,000 Losses", ::addLossStat, 500000);
	self add_option("MainModsMenu", "-->Player Health", ::submenu, "MainModsH", "Health");
		self add_menu("MainModsH", "MainModsMenu", "Verified");
		self add_option("MainModsH", "^1DEFAULT^7", ::setHealth, 100);
		self add_option("MainModsH", "150 Health", ::setHealth, 150);
		self add_option("MainModsH", "200 Health", ::setHealth, 200);
		self add_option("MainModsH", "250 Health", ::setHealth, 250);
		self add_option("MainModsH", "500 Health", ::setHealth, 500);
		self add_option("MainModsH", "1000 Health", ::setHealth, 1000);
		self add_option("MainModsH", "5000 Health", ::setHealth, 5000);
		self add_option("MainModsH", "500000 Health", ::setHealth, 500000);
	self add_option("MainModsMenu", "-->Player FOV^7", ::submenu, "MainModsF", "FOV");
		self add_menu("MainModsF", "MainModsMenu", "Verified");
		self add_option("MainModsF", "^1DEFAULT^7", ::setFoV, 65);
		self add_option("MainModsF", "80 FOV", ::setFoV, 80);
		self add_option("MainModsF", "90 FOV", ::setFoV, 90);
		self add_option("MainModsF", "100 FOV", ::setFoV, 100);
		self add_option("MainModsF", "110 FOV", ::setFoV, 110);
		self add_option("MainModsF", "120 FOV", ::setFoV, 120);
		self add_option("MainModsF", "130 FOV", ::setFoV, 130);
		self add_option("MainModsF", "140 FOV", ::setFoV, 140);
		self add_option("MainModsF", "150 FOV", ::setFoV, 150);
		self add_option("MainModsF", "160 FOV", ::setFoV, 160);
	self add_option("MainModsMenu", "Unlock Achievements", ::unlockAchieve);
	self add_option("MainModsMenu", "Noclip", ::initNoClip);
	self add_option("MainModsMenu", "Teleport", ::doTeleport);
	self add_option("MainModsMenu", "Change Class", ::ChangeClass);
	self add_option("MainModsMenu", "Change Team", ::initTeamChange);
	self add_option("MainModsMenu", "Suicide", ::suicide);
	self add_option("MainModsMenu", "Rapid Fire", ::rapidFire);
	self add_option("MainModsMenu", "Give Streaks", ::dokillstreaks);
	self add_option("MainModsMenu", level.PageII, ::submenu, "MainModsMenu2", "Main Mods");
		self add_menu("MainModsMenu2", "MainModsMenu", "Verified");
		self add_option("MainModsMenu2", "Auto Dropshot", ::AutoDropshot);
		self add_option("MainModsMenu2", "Spin", ::ToggleSpin);
		self add_option("MainModsMenu2", "Save/Load Position", ::saveandload);
		self add_option("MainModsMenu2", "Multi-Jump", ::Multijump);

	self add_menu("SubMenu2", level.menuname, "Verified");
	self add_option("SubMenu2", "Health Bar", ::initHealthBar);
	self add_option("SubMenu2", "Jetpack", ::doJetPack);
	self add_option("SubMenu2", "Blowjob", ::sheSuccMe);
	self add_option("SubMenu2", "Earthquake", ::Quake);
	self add_option("SubMenu2", "AGR Army", ::AGR_ARMY_Toggle);
	self add_option("SubMenu2", "Walking Loadestar", ::walkingLoadestar);
	self add_option("SubMenu2", "Plant Bomb ^1(SnD)", ::PlantBomb);
	self add_option("SubMenu2", "^7Defuse Bomb ^1(SnD)", ::DefuseBomb);
	self add_option("SubMenu2", "^7Pickup Player", ::ForgeON);
	self add_option("SubMenu2", "Pro-Mod", ::promod);
	self add_option("SubMenu2", "Adv.Forge Mode", ::ForgeMode);
	self add_option("SubMenu2", "Spec Nade", ::toggle_SpecNade);
	self add_option("SubMenu2", "Light Sabers", ::RandomMod);
	self add_option("SubMenu2", "Kill Campers", ::initCampKill);
	self add_option("SubMenu2", "Jericho Missles", ::initJericho);
	self add_option("SubMenu2", "Change Scoreboard", ::wierdSB);
	self add_option("SubMenu2", "Electric Cherry", ::Cherry_Toggle);
	self add_option("SubMenu2", "PHD Flopper", ::PHD_Perk);
	self add_option("SubMenu2", level.PageII, ::submenu, "SubMenu2v2", "Gangsta Mods");
		self add_menu("SubMenu2v2", "SubMenu2", "Verified");
		self add_option("SubMenu2v2", "Rambo", ::Rambo);
		self add_option("SubMenu2v2", "Marachi Man", ::JoseWho);
		self add_option("SubMenu2v2", "Car Grenade", ::GiveGCar);
		self add_option("SubMenu2v2", "Barrel Grenade", ::GiveGrenadeB);
		self add_option("SubMenu2v2", "Fireballs", ::fireballstoggle);
		self add_option("SubMenu2v2", "Poke Ball", ::pokeBall);
		self add_option("SubMenu2v2", "Typewriter", ::typewriter);
		self add_option("SubMenu2v2", "MLG Stock", ::Stalker_Toggle);
		self add_option("SubMenu2v2", "Allahu Akbar", ::runC4Death);
		self add_option("SubMenu2v2", "Ride Hunter Killer", ::LeoRideHunter);

	self add_menu("SubMenu3", level.menuname, "Verified");
		self add_option("SubMenu3", "Nuketown", ::level_doMap, "mp_nuketown_2020");
		self add_option("SubMenu3", "Hijacked", ::level_doMap, "mp_hijacked");
		self add_option("SubMenu3", "Express", ::level_doMap, "mp_express");
		self add_option("SubMenu3", "Meltdown", ::level_doMap, "mp_meltdown");
		self add_option("SubMenu3", "Drone", ::level_doMap, "mp_drone");
		self add_option("SubMenu3", "Carrier", ::level_doMap, "mp_carrier");
		self add_option("SubMenu3", "Overflow", ::level_doMap, "mp_overflow");
		self add_option("SubMenu3", "Slums", ::level_doMap, "mp_slums");
		self add_option("SubMenu3", "Turbine", ::level_doMap, "mp_turbine");
		self add_option("SubMenu3", "Raid", ::level_doMap, "mp_raid");
		self add_option("SubMenu3", "Aftermath", ::level_doMap, "mp_la");
		self add_option("SubMenu3", "Cargo", ::level_doMap, "mp_dockside");
		self add_option("SubMenu3", "Standoff", ::level_doMap, "mp_village");
		self add_option("SubMenu3", "Plaza", ::level_doMap, "mp_nightclub");
		self add_option("SubMenu3", "Yemen", ::level_doMap, "mp_socotra");
		self add_option("SubMenu3", "^5-->DLC MAPS", ::submenu, "SubMenu3v2", "DLC Maps");
		self add_option("SubMenu3", "^1RESTART MAP", ::doRestart);
			self add_menu("SubMenu3v2", "SubMenu3", "Verified");
			self add_option("SubMenu3v2", "Downhill", ::level_doMap, "mp_downhill");
			self add_option("SubMenu3v2", "Mirage", ::level_doMap, "mp_mirage");
			self add_option("SubMenu3v2", "Hydro", ::level_doMap, "mp_hydro");
			self add_option("SubMenu3v2", "Grind", ::level_doMap, "mp_skate");
			self add_option("SubMenu3v2", "Encore", ::level_doMap, "mp_concert");
			self add_option("SubMenu3v2", "Magma", ::level_doMap, "mp_magma");
			self add_option("SubMenu3v2", "Vertigo", ::level_doMap, "mp_vertigo");
			self add_option("SubMenu3v2", "Studio", ::level_doMap, "mp_studio");
			self add_option("SubMenu3v2", "Uplink", ::level_doMap, "mp_uplink");
			self add_option("SubMenu3v2", "Detour", ::level_doMap, "mp_detour");
			self add_option("SubMenu3v2", "Cove", ::level_doMap, "mp_cove");
			self add_option("SubMenu3v2", "Rush", ::level_doMap, "mp_paintball");
			self add_option("SubMenu3v2", "Dig", ::level_doMap, "mp_dig");
			self add_option("SubMenu3v2", "Frost", ::level_doMap, "mp_frostbite");
			self add_option("SubMenu3v2", "Pod", ::level_doMap, "mp_pod");
			self add_option("SubMenu3v2", "Takeoff", ::level_doMap, "mp_takeoff");

	self add_menu("SubMenu4", level.menuname, "Verified");
		self add_option("SubMenu4", "^1DEFAULT^7", ::defaultVision);
		self add_option("SubMenu4", "Enhanced Vision", ::EV);
		self add_option("SubMenu4", "Light Vision", ::LVis);
		self add_option("SubMenu4", "Black and White", ::BWV);
		self add_option("SubMenu4", "Thermal", ::TV);
		self add_option("SubMenu4", "EMP", ::empVision);
		self add_option("SubMenu4", "Flash Troll ^1(ALL)^7", ::LVisOnOff);
		self add_option("SubMenu4", "Mortar Infrared ^1(ALL)^7", ::remote_mortar_infrared);
		self add_option("SubMenu4", "Outro ^1(ALL)", ::mpoutro);

	self add_menu("SubMenu19", level.menuname, "Verified");
		self add_option("SubMenu19", "^5-->Background", ::submenu, "SubMenu19B", "Background");
		self add_menu("SubMenu19B", "SubMenu19", "Verified");
			self add_option("SubMenu19B", "^1DEFAULT", ::defaultThemeB);
			self add_option("SubMenu19B", "^4F^6L^1A^3S^2H^7", ::doFlashThemeB);
			self add_option("SubMenu19B", "Blue Theme", ::dobluethemeB);
			self add_option("SubMenu19B", "^6Pink Theme", ::doPinkthemeB);
			self add_option("SubMenu19B", "^1Red Theme", ::doRedthemeB);
			self add_option("SubMenu19B", "^3Yellow Theme", ::doYellowthemeB);
			self add_option("SubMenu19B", "^2Green Theme", ::doGreenthemeB);
			self add_option("SubMenu19B", "^5Cyan Theme", ::doCyanthemeB);
		self add_option("SubMenu19", "^5-->Scroller", ::submenu, "SubMenu19S", "Scroller");
		self add_menu("SubMenu19S", "SubMenu19", "Verified");
			self add_option("SubMenu19S", "^1DEFAULT", ::defaultTheme);
			self add_option("SubMenu19S", "^4F^6L^1A^3S^2H^7", ::doFlashTheme);
			self add_option("SubMenu19S", "Blue Theme", ::dobluetheme);
			self add_option("SubMenu19S", "^6Pink Theme", ::doPinktheme);
			self add_option("SubMenu19S", "^1Red Theme", ::doRedtheme);
			self add_option("SubMenu19S", "^3Yellow Theme", ::doYellowtheme);
			self add_option("SubMenu19S", "^2Green Theme", ::doGreentheme);
			self add_option("SubMenu19S", "^5Cyan Theme", ::doCyantheme);
	self add_menu("SubMenu5", level.menuname, "Verified");
		self add_option("SubMenu5", "Riot Man", ::RiotMan);
		self add_option("SubMenu5", "Electric Man", ::initdafuck);
		self add_option("SubMenu5", "Light Man", ::initELeGanCe1);
		self add_option("SubMenu5", "Smoke Man", ::initSmokeMonster);
		self add_option("SubMenu5", "Fire Man ^1(NUKETOWN)^7", ::Firetoggle);
		self add_option("SubMenu5", "Clone", ::Clone);
		self add_option("SubMenu5", "Dead Clone", ::deadclone);
		self add_option("SubMenu5", "UFO Man ^1(NUKETOWN)^7", ::UFOstoggle);
		self add_option("SubMenu5", "Human Centipede", ::toggleCentipede);
		self add_option("SubMenu5", "Human Torch", ::torch_toggle);
		self add_option("SubMenu5", "Glass Man", ::GlassMAN);
		self add_option("SubMenu5", "Water Man", ::initWaterSpray);
		self add_option("SubMenu5", "Water Fountain", ::togFountain);
		self add_option("SubMenu5", "Snow Storm", ::initSnow);
		self add_option("SubMenu5", "Blood Man", ::initBloodMan);
		self add_option("SubMenu5", "Dirt Storm", ::caca);
		self add_option("SubMenu5", "Clown Shoes", ::clownshoes);
		self add_option("SubMenu5", "Arrow Man", ::arrowMan);
		self add_option("SubMenu5", "Robo Man", ::RoboMan);
		self add_option("SubMenu5", level.PageII, ::submenu, "SubMenu5v2", "Player Effects");
		self add_menu("SubMenu5v2", "SubMenu5", "Verified");
		self add_option("SubMenu5v2", "Exploding Feet", ::sensorMan);
		self add_option("SubMenu5v2", "Sensor Ring Man", ::SensorRing);
		self add_option("SubMenu5v2", "Flare FX Man", ::FlareMan);
		
	self add_menu("SubMenu6", level.menuname, "Verified");
		self add_option("SubMenu6", "Your Host", ::hintmsgALLFunc, "^5Your host is: ^6" + level.hostname);
		self add_option("SubMenu6", "Menu tutorial", ::hintmsgALLFunc, "^2aim + knife to open the menu. press X to go back.");
		self add_option("SubMenu6", "Fake Derank Message", ::hintmsgALLFunc, "^1Derank Module Running..... Resetting Players...");
		self add_option("SubMenu6", "REKT", ::hintmsgALLFunc, "^2you just got rekt");
		self add_option("SubMenu6", "Billcam", ::hintmsgALLFunc, "he just hit a ^6B^5I^4L^3L^2C^1A^7M");
		self add_option("SubMenu6", "Clash of Clans", ::hintmsgALLFunc, "^5Join ^7#^6YJL2JUJO ^5for some epic banter m8.");
		self add_option("SubMenu6", "Menu Updates", ::hintmsgALLFunc, "^5All Menu updates posted on ^6JIGGYMODS.TK ^5and ^1se7ensins");
		self add_option("SubMenu6", "JIGGYMODS.TK", ::hintmsgALLFunc, "^5Visit ^6JIGGYMODS.TK ^5for mods");
		self add_option("SubMenu6", "^5-->Funny", ::submenu, "SubMenu6vF", "Funny");
		self add_menu("SubMenu6vF", "SubMenu6", "Verified");
			self add_option("SubMenu6vF", "u wot m8", ::hintmsgALLFunc, "^2U ^1WOT ^6M8?");
			self add_option("SubMenu6vF", "jimmies rustled", ::hintmsgALLFunc, "^6Someones Jimmies have been Rustled!");
			self add_option("SubMenu6vF", "not a hack", ::hintmsgALLFunc, "^5its not a hack its all legit :)");
			self add_option("SubMenu6vF", "whos hacking?", ::hintmsgALLFunc, "^5Whos ^6hacking????");
			self add_option("SubMenu6vF", "credit card", ::hintmsgALLFunc, "^5Give me your credit card.");
			self add_option("SubMenu6vF", "PAUL BLART", ::hintmsgALLFunc, "^1PAUL BLART ^1HAS BEEN SPOTTED! ^6DEFEND THE MALL.");
			self add_option("SubMenu6vF", "Jiggy Wit It", ::hintmsgALLFunc, "^5Get ^6Jiggy ^5Wit ^6It!");
			self add_option("SubMenu6vF", "Snickers Bar", ::hintmsgALLFunc, "^6someone needs a ^9snickers ^6bar!");
			self add_option("SubMenu6vF", "she succ me", ::hintmsgALLFunc, "^1SHE ^6SUCC ^1ME");
			self add_option("SubMenu6vF", "finna nut", ::hintmsgALLFunc, "^6I finna bust a nut.");
			self add_option("SubMenu6vF", "someones modding", ::hintmsgALLFunc, "^6someone here is modding.....");
			self add_option("SubMenu6vF", "POOPHEAD", ::hintmsgALLFunc, "^6BE QUIET YOU STUPID POOPHEAD");

		self add_option("SubMenu6", "-->Mean", ::submenu, "SubMenu6vM", "Mean");
		self add_menu("SubMenu6vM", "SubMenu6", "Verified");
			self add_option("SubMenu6vM", "fuck you", ::hintmsgALLFunc, "^1fuck you");
			self add_option("SubMenu6vM", "music through mic", ::hintmsgALLFunc, "^1STOP PLAYING MUSIC THROUGH YOUR MIC KID NOBODY CARES");
			self add_option("SubMenu6vM", "get out", ::hintmsgALLFunc, "^1Get out of my lobby kid");
			self add_option("SubMenu6vM", "1v1 IRL", ::hintmsgALLFunc, "^11v1 me IRL");
			self add_option("SubMenu6vM", "Calm down", ::hintmsgALLFunc, "^1calm your shit bro");
			self add_option("SubMenu6vM", "Gonna Hack you", ::hintmsgALLFunc, "^3im going to hack your account");
			self add_option("SubMenu6vM", "shut up", ::hintmsgALLFunc, "^1can you shut up kid?");
			self add_option("SubMenu6vM", "you're not cool", ::hintmsgALLFunc, "^1you're not cool kid.");

		self add_option("SubMenu6", "-->Special Text", ::submenu, "SubMenu6vH", "Special Text");
		self add_menu("SubMenu6vH", "SubMenu6", "Verified");
			self add_option("SubMenu6vH", "Host Name", ::InitSpinText2);
			self add_option("SubMenu6vH", "Jiggy777", ::InitSpinText);
			self add_option("SubMenu6vH", "Jiggy Mods", ::doHeart);

		self add_option("SubMenu6", "-->Money Making", ::submenu, "SubMenu6vMO", "Money");
		self add_menu("SubMenu6vMO", "SubMenu6", "Verified");
			self add_option("SubMenu6vMO", "Sub to Nemo Hacks 6on youtube", ::hintmsgALLFunc, "^2Message ^5" + level.hostname + " ^2for $5 recoveries");
			self add_option("SubMenu6vMO", "$10 recoveries", ::hintmsgALLFunc, "^2Message ^5" + level.hostname + " ^2for $10 recoveries");
			self add_option("SubMenu6vMO", "co-host $5/hourVDL X SNIPERZzz is coleader of this menu", ::hintmsgALLFunc, "^2Message ^5" + level.hostname + " ^2for Co-Host. ^6($5/hour)");
			self add_option("SubMenu6vMO", "co-host $10/hour", ::hintmsgALLFunc, "^2Message ^5" + level.hostname + " ^2for Co-Host. ^6($10/hour)");
			self add_option("SubMenu6vMO", "gold trial 4 co-host", ::hintmsgALLFunc, "^2Message ^5" + level.hostname + " ^6an Xbox Gold Trial ^2for Co-Host!");
			self add_option("SubMenu6vMO", "gold trial 4 camos", ::hintmsgALLFunc, "^2Message ^5" + level.hostname + " ^6an Xbox Gold Trial ^2for ^5Diamond Camos!");
			self add_option("SubMenu6vMO", "$5 paypal 4 camos", ::hintmsgALLFunc, "^2$5 PayPal for ^5all Diamond Camos!");
			self add_option("SubMenu6vMO", "VDL done most of the codeing on this menu", ::hintmsgALLFunc, "^2$10 PayPal for ^5all Diamond Camos!");
			self add_option("SubMenu6vMO", "no sign in req", ::hintmsgALLFunc, "No Sign-in required for diamond camos.");
		
		self add_option("SubMenu6", "-->Edit", ::submenu, "SubMenu6vedit", "Edit Text");
		self add_menu("SubMenu6vedit", "SubMenu6", "Verified");
			self add_option("SubMenu6vedit", "+++++++++++-", ::hintmsgALLFunc, "$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$-$$$");
			self add_option("SubMenu6vedit", "++++++++++-+", ::hintmsgALLFunc, "$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$-$$$$");
			self add_option("SubMenu6vedit", "+++++++++-++", ::hintmsgALLFunc, "$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$-$$$$$");
			self add_option("SubMenu6vedit", "++++++++-+++", ::hintmsgALLFunc, "$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$-$$$$$$");
			self add_option("SubMenu6vedit", "+++++++-++++", ::hintmsgALLFunc, "$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$-$$$$$$$");
			self add_option("SubMenu6vedit", "++++++-+++++", ::hintmsgALLFunc, "$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$-$$$$$$$$");
			self add_option("SubMenu6vedit", "+++++-++++++", ::hintmsgALLFunc, "$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$-$$$$$$$$$");
			self add_option("SubMenu6vedit", "++++-+++++++", ::hintmsgALLFunc, "$$$$$$$$$$$$$$$$$$$$$$$$$$$$$-$$$$$$$$$$");
			self add_option("SubMenu6vedit", "+++-++++++++", ::hintmsgALLFunc, "$$$$$$$$$$$$$$$$$$$$$$$$$$$$-$$$$$$$$$$$");
			self add_option("SubMenu6vedit", "++-+++++++++", ::hintmsgALLFunc, "$$$$$$$$$$$$$$$$$$$$$$$$$$$-$$$$$$$$$$$$");
			self add_option("SubMenu6vedit", "+-++++++++++", ::hintmsgALLFunc, "$$$$$$$$$$$$$$$$$$$$$$$$$$-$$$$$$$$$$$$$");
			self add_option("SubMenu6vedit", "-+++++++++++", ::hintmsgALLFunc, "$$$$$$$$$$$$$$$$$$$$$$$$$-$$$$$$$$$$$$$$");
			self add_option("SubMenu6vedit", "+++++++++++_", ::hintmsgALLFunc, "$$$$$$$$$$$$$$$$$$$$$$$$-$$$$$$$$$$$$$$$");
			self add_option("SubMenu6vedit", "++++++++++_+", ::hintmsgALLFunc, "$$$$$$$$$$$$$$$$$$$$$$$-$$$$$$$$$$$$$$$$");
			self add_option("SubMenu6vedit", "+++++++++_++", ::hintmsgALLFunc, "$$$$$$$$$$$$$$$$$$$$$$-$$$$$$$$$$$$$$$$$");

	self add_menu("SubMenu7", level.menuname, "Verified");
		self add_option("SubMenu7", "Hear All Players", ::hearallplayers);
	self add_option("SubMenu7", "Low Gravity", ::gravity);
	self add_option("SubMenu7", "Super Jump", ::ToggleSuperJump);

	self add_menu("SubMenu7v1", "SubMenu7", "Verified");
	self add_option("SubMenu7", "^5-->XP MENU", ::submenu, "SubMenu7v1", "XP Menu");
		self add_option("SubMenu7v1", "^1NORMAL XP^7", ::J_setXP, 100);
		self add_option("SubMenu7v1", "1 XP", ::J_setXP, 1);
		self add_option("SubMenu7v1", "69 XP", ::J_setXP, 69);
		self add_option("SubMenu7v1", "150 XP", ::J_setXP, 150);
		self add_option("SubMenu7v1", "200 XP", ::J_setXP, 200);
		self add_option("SubMenu7v1", "300 XP", ::J_setXP, 300);
		self add_option("SubMenu7v1", "1000 XP", ::J_setXP, 1000);
		self add_option("SubMenu7v1", "5000 XP", ::J_setXP, 5000);
		self add_option("SubMenu7v1", "50000 XP", ::J_setXP, 50000);
		self add_option("SubMenu7v1", "444444 XP", ::J_setXP, 444444);
		self add_option("SubMenu7v1", "777777 XP", ::J_setXP, 777777);
		self add_option("SubMenu7v1", "1 MILLION XP", ::J_setXP, 1000000);
		self add_option("SubMenu7v1", "500 MILLION XP", ::J_setXP, 500000000);
		self add_option("SubMenu7v1", "2147450000 XP", ::J_setXP, 2147450000);

	self add_menu("SubMenu7v2", "SubMenu7", "Verified");
	self add_option("SubMenu7", "-->BOTS MENU", ::submenu, "SubMenu7v2", "Bots Menu");
		self add_option("SubMenu7v2", "Spawn 1 Bot", ::doBots, 1);
		self add_option("SubMenu7v2", "Spawn 3 Bots", ::doBots, 3);
		self add_option("SubMenu7v2", "Spawn 6 Bots", ::doBots, 6);
		self add_option("SubMenu7v2", "Spawn 9 Bots", ::doBots, 9);
		self add_option("SubMenu7v2", "Spawn 17 Bots", ::doBots, 17);
		self add_option("SubMenu7v2", "Freeze Bots", ::FreezeBots);
		self add_option("SubMenu7v2", "Teleport Bots", ::TeleBots);
		self add_option("SubMenu7v2", "^1Kick All Bots", ::kickAllBots);

	self add_menu("SubMenu7v3", "SubMenu7", "Verified");
	self add_option("SubMenu7", "-->LOBBIES", ::submenu, "SubMenu7v3", "Lobbies");
		self add_option("SubMenu7v3", "Sniper Lobby", ::initSniperLobby);
		self add_option("SubMenu7v3", "XP Lobby", ::doXPLobby);
		self add_option("SubMenu7v3", "Camo Lobby", ::camoLobby);

	self add_menu("SubMenu7v4", "SubMenu7", "Verified");
	self add_option("SubMenu7", "-->MINIMAPS", ::submenu, "SubMenu7v4", "Minimaps");
		self add_option("SubMenu7v4", "^1DEFAULT^7", ::MinimapDefault);
		self add_option("SubMenu7v4", "14th Prestige", ::BG_ChangeMinimap, "rank_prestige14");
		self add_option("SubMenu7v4", "15th Prestige", ::BG_ChangeMinimap, "rank_prestige15");
		self add_option("SubMenu7v4", "South Korea", ::BG_ChangeMinimap, "em_bg_flag_south_korea");
		self add_option("SubMenu7v4", "Comics", ::BG_ChangeMinimap, "em_bg_ani_comics");
		self add_option("SubMenu7v4", "Afterlife", ::BG_ChangeMinimap, "em_bg_ani_afterlife");
		self add_option("SubMenu7v4", "Weaponized-115", ::BG_ChangeMinimap, "em_bg_ani_w115");
		self add_option("SubMenu7v4", "Movie Star", ::BG_ChangeMinimap, "emblem_bg_movie_star");
		self add_option("SubMenu7v4", "Nuclear", ::BG_ChangeMinimap, "emblem_bg_bo2_nuclear_killer");
		self add_option("SubMenu7v4", "Cyborg", ::BG_ChangeMinimap, "em_bg_ani_cybertron");
		self add_option("SubMenu7v4", "Diamond Camo", ::BG_ChangeMinimap, "menu_camo_diamond_pattern");
		self add_option("SubMenu7v4", "Nuketown Emblem", ::BG_ChangeMinimap, "emblem_bg_nuketown_2025");
		self add_option("SubMenu7v4", "Twitter", ::BG_ChangeMinimap, "menu_lobby_icon_twitter");
		self add_option("SubMenu7v4", "Xbox Controller", ::BG_ChangeMinimap, "xenon_controller_top");
		self add_option("SubMenu7v4", "DSR Scope", ::BG_ChangeMinimap, "scope_overlay_dsr50");
		self add_option("SubMenu7v4", "LStick Animation", ::BG_ChangeMinimap, "ui_button_xenon_lstick_anim_r");
		self add_option("SubMenu7v4", "Pro Rank", ::BG_ChangeMinimap, "menu_div_pro_sub03_64");
		self add_option("SubMenu7v4", "Master Rank", ::BG_ChangeMinimap, "menu_div_semipro_sub03_64");
		self add_menu("SubMenu7v4v1", "SubMenu7v4", "Verified");
			self add_option("SubMenu7v4", level.PageII, ::submenu, "SubMenu7v4v1", "Minimaps");
			self add_option("SubMenu7v4v1", "A Button", ::BG_ChangeMinimap, "xenonbutton_a");
			self add_option("SubMenu7v4v1", "B Button", ::BG_ChangeMinimap, "xenonbutton_b");
			self add_option("SubMenu7v4v1", "X Button", ::BG_ChangeMinimap, "xenonbutton_x");
			self add_option("SubMenu7v4v1", "Y Button", ::BG_ChangeMinimap, "xenonbutton_y");
			self add_option("SubMenu7v4v1", "Talking", ::BG_ChangeMinimap, "talkingicon");
			self add_option("SubMenu7v4v1", "Party", ::BG_ChangeMinimap, "voice_off_xboxlive");
			self add_option("SubMenu7v4v1", "Party Muted", ::BG_ChangeMinimap, "voice_off_mute_xboxlive");
			self add_option("SubMenu7v4v1", "Target", ::BG_ChangeMinimap, "compass_waypoint_target");
			self add_option("SubMenu7v4v1", "M8A1", ::BG_ChangeMinimap, "em_bg_wpn_camo_m8a1");
			self add_option("SubMenu7v4v1", "Select Fire", ::BG_ChangeMinimap, "hud_select_fire_bullet_stack");
			self add_option("SubMenu7v4v1", "Red Guy", ::BG_ChangeMinimap, "life_counter_dead");
			self add_option("SubMenu7v4v1", "Zombies", ::BG_ChangeMinimap, "loadscreen_zm_transit_dr_zcleansed_diner");
			self add_option("SubMenu7v4v1", "Plaza", ::BG_ChangeMinimap, "loadscreen_mp_nightclub");
			self add_option("SubMenu7v4v1", "Flashing Tiles", ::BG_ChangeMinimap, "poison");
			self add_option("SubMenu7v4v1", "Afterlife", ::BG_ChangeMinimap, "hud_medals_afterlife");

	self add_option("SubMenu7", "^7Long Melee", ::meleerange);
	self add_option("SubMenu7", "Long Killcams", ::ToggleLongKillCam);
	self add_option("SubMenu7", "Timescale", ::changeTimescale);
	self add_option("SubMenu7", "^1Restart Game", ::doRestart);
	self add_option("SubMenu7", "End Game", ::endGame);
	self add_option("SubMenu7", "Instant End Game^7", ::instaEnd);
	self add_option("SubMenu7", "Anti-Quit", ::initAntiQuit);
	self add_option("SubMenu7", "Infinite Game", ::Inf_Game);
	self add_option("SubMenu7", "Tie Game", ::tieGame);
	self add_option("SubMenu7", "Pause Game", ::pauseGame);
	self add_option("SubMenu7", "Death Barriers", ::toggleDeathBarriers);
	self add_menu("SubMenu7v5", "SubMenu7", "Verified");
	self add_option("SubMenu7", level.PageII, ::submenu, "SubMenu7v5", "Game Settings");
	self add_option("SubMenu7v5", "High Knockback", ::knock);
	self add_option("SubMenu7v5", "Bouncy Grenades", ::bouncygrenades);
	self add_option("SubMenu7v5", "Nuketown Easter Egg", ::doNukeTownEE);
	//self add_option("SubMenu7v5", "Ranked Match", ::ToggleRanked);

	self add_menu("SubMenu8", level.menuname, "Verified");
	self add_option("SubMenu8", "Explosion", ::BG_PlaySound, "wpn_rocket_explode_rock");
	self add_option("SubMenu8", "EMP", ::BG_PlaySound, "wpn_emp_bomb");
	self add_option("SubMenu8", "BEEP", ::BG_PlaySound, "wpn_semtex_alert");
	self add_option("SubMenu8", "Treyarch Sound Test", ::BG_PlaySound, "tst_test_system");
	self add_option("SubMenu8", "Bouncing Betty", ::BG_PlaySound, "fly_betty_jump");
	self add_option("SubMenu8", "Hellstorm", ::BG_PlaySound, "wpn_remote_missile_inc");
	self add_option("SubMenu8", "Flashbang", ::BG_PlaySound, "wpn_flash_grenade_explode");
	self add_option("SubMenu8", "Mortar", ::BG_PlaySound, "exp_mortar");
	self add_option("SubMenu8", "Grenade Bounce", ::BG_PlaySound, "wpn_grenade_bounce_metal");
	self add_option("SubMenu8", "LSAT Open", ::BG_PlaySound, "fly_lsat_open");
	self add_option("SubMenu8", "Enter", ::BG_PlaySound, "cac_enter_cac");
	self add_option("SubMenu8", "Zap", ::BG_PlaySound, "wpn_taser_mine_zap");
	self add_option("SubMenu8", "RPG", ::BG_PlaySound, "wpn_rpg_whizby");
	self add_option("SubMenu8", "Bark", ::BG_PlaySound, "aml_dog_bark");
	self add_option("SubMenu8", "Gasp", ::BG_PlaySound, "chr_sprint_gasp");
	self add_option("SubMenu8", "Humiliation", ::BG_PlaySound, "mpl_wager_humiliate");
	self add_option("SubMenu8", "Scream", ::BG_PlaySound, "chr_spl_generic_gib_american");/////
	self add_option("SubMenu8", "Splash", ::BG_PlaySound, "mpl_splash_death");
	self add_option("SubMenu8", "Missle Boost", ::BG_PlaySound, "wpn_remote_missile_fire_boost");
	self add_option("SubMenu8", level.PageII, ::submenu, "SubMenu8v2", "Sounds");
		self add_menu("SubMenu8v2", "SubMenu8", "Verified");
		self add_option("SubMenu8v2", "A.G.R Explode", ::BG_PlaySound, "wpn_agr_explode");//////
		self add_option("SubMenu8v2", "Rank Up", ::BG_PlaySound, "mus_lau_rank_up");
		self add_option("SubMenu8v2", "Swarm", ::BG_PlaySound, "veh_harpy_drone_swarm_incomming");
		self add_option("SubMenu8v2", "Mag Out", ::BG_PlaySound, "fly_assault_reload_npc_mag_out");
		self add_option("SubMenu8v2", "Gamble Perk", ::BG_PlaySound, "uin_gamble_perk");
		self add_option("SubMenu8v2", "FBI Victory", ::BG_PlaySound, "mus_victory_fbi");
		self add_option("SubMenu8v2", "Lightning Strike", ::BG_PlaySound, "mpl_lightning_flyover_boom");
		self add_option("SubMenu8v2", "Flag Pickup", ::BG_PlaySound, "mpl_flag_pickup_plr");
		self add_option("SubMenu8v2", "Flag Drop", ::BG_PlaySound, "mpl_flag_drop_plr");
		self add_option("SubMenu8v2", "Riot Shield", ::BG_PlaySound, "fly_riotshield_impact_knife");

	self add_menu("SubMenu9", level.menuname, "Verified");
			self add_option("SubMenu9", "^5-->Normal Weapons", ::submenu, "SubMenu9v1", "Weapons");
			self add_menu("SubMenu9v1", "SubMenu9", "Verified");
				self add_menu("SubMenu9v1v1", "SubMenu9v1", "Verified");
				self add_option("SubMenu9v1", "Assault Rifles", ::submenu, "SubMenu9v1v1", "Assault Rifles");
					self add_option("SubMenu9v1v1", "AN-94", ::BG_GivePlayerWeapon, "an94_mp");
					self add_option("SubMenu9v1v1", "M8A1", ::BG_GivePlayerWeapon, "xm8_mp");
					self add_option("SubMenu9v1v1", "FAL OSW", ::BG_GivePlayerWeapon, "sa58_mp");
					self add_option("SubMenu9v1v1", "Type-25", ::BG_GivePlayerWeapon, "type95_mp");
					self add_option("SubMenu9v1v1", "M-TAR", ::BG_GivePlayerWeapon, "tar21_mp");
					self add_option("SubMenu9v1v1", "SMR", ::BG_GivePlayerWeapon, "saritch_mp");
					self add_option("SubMenu9v1v1", "Scar-H", ::BG_GivePlayerWeapon, "scar_mp");
					self add_option("SubMenu9v1v1", "SWAT-556", ::BG_GivePlayerWeapon, "sig556_mp");
					self add_option("SubMenu9v1v1", "M27", ::BG_GivePlayerWeapon, "hk416_mp");

			self add_menu("SubMenu9v1v2", "SubMenu9v1", "Verified");
			self add_option("SubMenu9v1", "SMGs", ::submenu, "SubMenu9v1v2", "SMGs");
					self add_option("SubMenu9v1v2", "MP7", ::BG_GivePlayerWeapon, "mp7_mp");
					self add_option("SubMenu9v1v2", "PDW", ::BG_GivePlayerWeapon, "pdw57_mp");
					self add_option("SubMenu9v1v2", "Vector", ::BG_GivePlayerWeapon, "vector_mp");
					self add_option("SubMenu9v1v2", "MSMC", ::BG_GivePlayerWeapon, "insas_mp");
					self add_option("SubMenu9v1v2", "Chicom CQB", ::BG_GivePlayerWeapon, "qcw05_mp");
					self add_option("SubMenu9v1v2", "Skorpion EVO", ::BG_GivePlayerWeapon, "evoskorpion_mp");
					self add_option("SubMenu9v1v2", "Peacekeeper", ::BG_GivePlayerWeapon, "peacekeeper_mp");

				self add_menu("SubMenu9v1v3", "SubMenu9v1", "Verified");
				self add_option("SubMenu9v1", "LMGs", ::submenu, "SubMenu9v1v3", "LMGs");
					self add_option("SubMenu9v1v3", "MK-48", ::BG_GivePlayerWeapon, "mk48_mp");
					self add_option("SubMenu9v1v3", "LSAT", ::BG_GivePlayerWeapon, "lsat_mp");
					self add_option("SubMenu9v1v3", "QBB LSW", ::BG_GivePlayerWeapon, "qbb95_mp");
					self add_option("SubMenu9v1v3", "HAMR", ::BG_GivePlayerWeapon, "hamr_mp");

				self add_menu("SubMenu9v1v4", "SubMenu9v1", "Verified");
				self add_option("SubMenu9v1", "Shotguns", ::submenu, "SubMenu9v1v4", "Shotguns");
					self add_option("SubMenu9v1v4", "KSG", ::BG_GivePlayerWeapon, "ksg_mp");
					self add_option("SubMenu9v1v4", "R870 MCS", ::BG_GivePlayerWeapon, "870mcs_mp");
					self add_option("SubMenu9v1v4", "S12", ::BG_GivePlayerWeapon, "saiga12_mp");
					self add_option("SubMenu9v1v4", "M1216", ::BG_GivePlayerWeapon, "srm1216_mp");

				self add_menu("SubMenu9v1v5", "SubMenu9v1", "Verified");
				self add_option("SubMenu9v1", "Snipars", ::submenu, "SubMenu9v1v5", "Snipars");
					self add_option("SubMenu9v1v5", "Ballista", ::BG_GivePlayerWeapon, "ballista_mp");
					self add_option("SubMenu9v1v5", "DSR-50", ::BG_GivePlayerWeapon, "dsr50_mp");
					self add_option("SubMenu9v1v5", "SVU", ::BG_GivePlayerWeapon, "svu_mp");
					self add_option("SubMenu9v1v5", "XPR", ::BG_GivePlayerWeapon, "as50_mp");

				self add_menu("SubMenu9v1v6", "SubMenu9v1", "Verified");
				self add_option("SubMenu9v1", "Pistols", ::submenu, "SubMenu9v1v6", "Pistols");
					self add_option("SubMenu9v1v6", "Five-Seven", ::BG_GivePlayerWeapon, "fiveseven_mp");
					self add_option("SubMenu9v1v6", "Tac-45", ::BG_GivePlayerWeapon, "fnp45_mp");
					self add_option("SubMenu9v1v6", "B23R", ::BG_GivePlayerWeapon, "beretta93r_mp");
					self add_option("SubMenu9v1v6", "Executioner", ::BG_GivePlayerWeapon, "judge_mp");
					self add_option("SubMenu9v1v6", "KAP-40", ::BG_GivePlayerWeapon, "kard_mp");

		self add_menu("SubMenu9v1v7", "SubMenu9v1", "Verified");
		self add_option("SubMenu9v1", "Launchers", ::submenu, "SubMenu9v1v7", "Launchers");
			self add_option("SubMenu9v1v7", "RPG", ::BG_GivePlayerWeapon, "usrpg_mp");
			self add_option("SubMenu9v1v7", "SMAW", ::BG_GivePlayerWeapon, "smaw_mp");
			self add_option("SubMenu9v1v7", "FHJ-18", ::BG_GivePlayerWeapon, "fhj18_mp");

		self add_menu("SubMenu9v1v8", "SubMenu9v1", "Verified");
		self add_option("SubMenu9v1", "Specials", ::submenu, "SubMenu9v1v8", "Specials");
			self add_option("SubMenu9v1v8", "Ballistic Knife", ::BG_GivePlayerWeapon, "knife_ballistic_mp");
			self add_option("SubMenu9v1v8", "Riotshield", ::BG_GivePlayerWeapon, "riotshield_mp");
			self add_option("SubMenu9v1v8", "Crossbow", ::BG_GivePlayerWeapon, "crossbow_mp");

		self add_menu("SubMenu9v1v9", "SubMenu9v1", "Verified");
		self add_option("SubMenu9v1", "Streaks", ::submenu, "SubMenu9v1v9", "Streaks");
			self add_option("SubMenu9v1v9", "MiniGun", ::BG_GivePlayerWeapon, "minigun_mp");
			self add_option("SubMenu9v1v9", "War Machine", ::BG_GivePlayerWeapon, "m32_mp");

		self add_menu("SubMenu9v1v10", "SubMenu9v1", "Verified");
		self add_option("SubMenu9v1", "Glitch Weapons", ::submenu, "SubMenu9v1v10", "Glitch Weapons");
			self add_option("SubMenu9v1v10", "Default Gun *NO FREEZE*", ::DefaultGun);
			self add_option("SubMenu9v1v10", "iPad", ::iPad);
			self add_option("SubMenu9v1v10", "CSGO KNIFE", ::BG_GivePlayerWeapon, "knife_mp");

	self add_menu("SubMenu9v2", "SubMenu9", "Verified");
	self add_option("SubMenu9", "-->Modded Weapons", ::submenu, "SubMenu9v2", "Modded Weapons");
		self add_option("SubMenu9v2", "Ray Gun MK-I", ::initRaygun);
		self add_option("SubMenu9v2", "Ray Gun MK-II", ::initRaygunM2);
		self add_option("SubMenu9v2", "Ray Gun MK-III", ::doRaygunM3);
		self add_option("SubMenu9v2", "Ray Gun MK-IV", ::doRaygunM4);
		self add_option("SubMenu9v2", "EMP Blaster", ::initSunCannon);
		self add_option("SubMenu9v2", "Rocket Teleporter", ::rocketTeleportGun);
		self add_option("SubMenu9v2", "Super Magnum", ::SuperMagnum);
		self add_option("SubMenu9v2", "Thunder Gun", ::ThunGun);
		self add_option("SubMenu9v2", "Mustang & Sally", ::ToggleMustangGun);
		self add_option("SubMenu9v2", "Ballistic Teleporter", ::toggleknifetele);
		//self add_option("SubMenu9v2", "The Gersch Device", ::gershdevice);

	self add_menu("SubMenu9v4", "SubMenu9", "Verified");
	self add_option("SubMenu9", "-->View Models", ::submenu, "SubMenu9v4", "View Models");
		self add_option("SubMenu9v4", "^1DEFAULT^7", ::weaponModelDef);
		self add_option("SubMenu9v4", "Hunter Killer", ::weaponModel, "veh_t6_drone_hunterkiller");
		self add_option("SubMenu9v4", "RC-XD", ::weaponModel, "veh_t6_drone_rcxd");
		self add_option("SubMenu9v4", "Arrow FX", ::weaponModel, "fx_axis_createfx");
		self add_option("SubMenu9v4", "Bomb", ::weaponModel, "prop_suitcase_bomb");
		//self add_option("SubMenu9v4", "Dog", ::weaponModel, "german_shepherd");
		self add_option("SubMenu9v4", "Dog Tags", ::weaponModel, "p6_dogtags");
		self add_option("SubMenu9v4", "Cluster Bomb", ::weaponModel, "projectile_cbu97_clusterbomb");
		self add_option("SubMenu9v4", "Hellfire Projectile", ::weaponModel, "projectile_hellfire_missile");
	
	self add_menu("SubMenu9v3", "SubMenu9", "Verified");
	self add_option("SubMenu9", "-->Camos", ::submenu, "SubMenu9v3", "Camos");
		self add_option("SubMenu9v3", "^1None^6", ::togglecamo, 0);
		self add_option("SubMenu9v3", "Disco Camo^7", ::Toggle_DiscoCamo);
		self add_option("SubMenu9v3", "Diamond", ::togglecamo, 16);
		self add_option("SubMenu9v3", "Ghosts", ::togglecamo, 29);
		self add_option("SubMenu9v3", "Afterlife", ::togglecamo, 44);
		self add_option("SubMenu9v3", "Party Rock", ::togglecamo, 25);
		self add_option("SubMenu9v3", "Art of War", ::togglecamo, 12);
		self add_option("SubMenu9v3", "Benjamins", ::togglecamo, 21);
		self add_option("SubMenu9v3", "A-TACS AU", ::togglecamo, 2);
		self add_option("SubMenu9v3", "ERDL", ::togglecamo, 3);
		self add_option("SubMenu9v3", "Siberia", ::togglecamo, 4);
		self add_option("SubMenu9v3", "Choco", ::togglecamo, 5);
		self add_option("SubMenu9v3", "Blue Tiger", ::togglecamo, 6);
		self add_option("SubMenu9v3", "Bloodshot", ::togglecamo, 7);
		self add_option("SubMenu9v3", "Delta 6", ::togglecamo, 8);
		self add_option("SubMenu9v3", "Typhon", ::togglecamo, 9);
		self add_option("SubMenu9v3", "Carbon Fiber", ::togglecamo, 10);
			self add_menu("SubMenu9v3v2", "SubMenu9v3", "Verified");
			self add_option("SubMenu9v3", level.PageII, ::submenu, "SubMenu9v3v2", "Camos");
			self add_option("SubMenu9v3v2", "Cherry Blossom", ::togglecamo, 11);
			self add_option("SubMenu9v3v2", "Ronin", ::togglecamo, 13);
			self add_option("SubMenu9v3v2", "Skulls", ::togglecamo, 14);
			self add_option("SubMenu9v3v2", "Gold", ::togglecamo, 15);
			self add_option("SubMenu9v3v2", "Elite", ::togglecamo, 17);
			self add_option("SubMenu9v3v2", "Digital", ::togglecamo, 18);
			self add_option("SubMenu9v3v2", "Jungle", ::togglecamo, 19);
			self add_option("SubMenu9v3v2", "UK", ::togglecamo, 20);
			self add_option("SubMenu9v3v2", "Dia De Muertos", ::togglecamo, 22);
			self add_option("SubMenu9v3v2", "Graffiti", ::togglecamo, 23);
			self add_option("SubMenu9v3v2", "Kawaii", ::togglecamo, 24);
			self add_option("SubMenu9v3v2", "Zombies", ::togglecamo, 26);
			self add_option("SubMenu9v3v2", "Bacon", ::togglecamo, 28);
			self add_option("SubMenu9v3v2", "Viper", ::togglecamo, 27);
			self add_option("SubMenu9v3v2", "Dragon", ::togglecamo, 32);
				self add_menu("SubMenu9v3v3", "SubMenu9v3v2", "Verified");
				self add_option("SubMenu9v3v2", "^5-->Page 3", ::submenu, "SubMenu9v3v3", "Camos");
				self add_option("SubMenu9v3v3", "Cyborg", ::togglecamo, 31);
				self add_option("SubMenu9v3v3", "Aqua", ::togglecamo, 33);
				self add_option("SubMenu9v3v3", "Breach", ::togglecamo, 35);
				self add_option("SubMenu9v3v3", "Coyote", ::togglecamo, 36);
				self add_option("SubMenu9v3v3", "Glam", ::togglecamo, 37);
				self add_option("SubMenu9v3v3", "Rogue", ::togglecamo, 38);
				self add_option("SubMenu9v3v3", "DEVGRU", ::togglecamo, 1);
				self add_option("SubMenu9v3v3", "Pack-a-Punch", ::togglecamo, 39);
				self add_option("SubMenu9v3v3", "Paladin", ::togglecamo, 30);
				self add_option("SubMenu9v3v3", "Comics", ::togglecamo, 34);
				self add_option("SubMenu9v3v3", "Dead Man's Hand", ::togglecamo, 40);
				self add_option("SubMenu9v3v3", "Beast", ::togglecamo, 41);
				self add_option("SubMenu9v3v3", "Octane", ::togglecamo, 42);
				self add_option("SubMenu9v3v3", "Weaponized 115", ::togglecamo, 43);

	self add_menu("SubMenu10", level.menuname, "Verified");
	self add_option("SubMenu10", "Unfair Aimbot", ::aimBot);
	self add_option("SubMenu10", "Legit Aimbot", ::doAimbotsL);
	self add_option("SubMenu10", "Legit Aimbot (no aim)", ::doAimbotsna);
	self add_option("SubMenu10", "TS Aimbot", ::initaimBotBILLU);
	self add_option("SubMenu10", "Azza Aimbot", ::initaimBotBILL);

	self add_menu("SubMenu11", level.menuname, "Verified");
	self add_option("SubMenu11", "Swarms", ::ToggleSwarmGun);
	self add_option("SubMenu11", "Grenades", ::ToggleGGun);
	self add_option("SubMenu11", "Earthquake Gun", ::Earthquake_gun);
	self add_option("SubMenu11", "Explosive Bullets", ::toggle_explosivebullets);
	self add_option("SubMenu11", "Hunter Killers", ::initDRONEBullet);
	self add_option("SubMenu11", "RPGs", ::initRPGBullet);
	self add_option("SubMenu11", "EMPs", ::initEMPBullets);
	if (getDvar("mapname") == "mp_nuketown_2020")
		self add_option("SubMenu11", "NUKE Bullets", ::initNukeBullets);
	self add_option("SubMenu11", "Water Gun ^1(WATER MAPS)^7", ::toggle_WaterGun);
	self add_option("SubMenu11", "A.G.R. Rockets", ::ToggleAGR);
	self add_option("SubMenu11", "Care Package Gun", ::doCareMaker2);
	self add_menu("SubMenu11v2", "SubMenu11", "Verified");
		self add_option("SubMenu11v2", "^1STOP SPAWN BULLETS^7", ::SpawnBulletOFF);
		self add_option("SubMenu11v2", "Debugs", ::initSpawnBullet, "defaultactor", "Debugs");
		self add_option("SubMenu11v2", "Care Packages", ::initSpawnBullet, "t6_wpn_supply_drop_ally", "Care Package");
		self add_option("SubMenu11v2", "A.G.Rs", ::initSpawnBullet, "veh_t6_drone_tank", "A.G.R");
		self add_option("SubMenu11v2", "Boxes", ::initSpawnBullet, "t6_wpn_drop_box", "wpn_Box");
		self add_option("SubMenu11v2", "Dogs", ::initSpawnBullet, "german_shepherd", "Dogs");
		self add_option("SubMenu11v2", "Sentry Guns", ::initSpawnBullet, "t6_wpn_turret_sentry_gun", "Sentry Guns");
		self add_option("SubMenu11v2", "Scavenger Packs", ::initSpawnBullet, "p_glo_scavenger_pack_obj", "Scavenger Packs");
		self add_option("SubMenu11v2", "Open Briefcases", ::initSpawnBullet, "t6_wpn_briefcase_bomb_view", "Briefcase");
		self add_option("SubMenu11v2", "Bombs", ::initSpawnBullet, "prop_suitcase_bomb", "Bombs");
		self add_option("SubMenu11v2", "Arrow FX", ::initSpawnBullet, "fx_axis_createfx", "Arrow FX");
		self add_option("SubMenu11v2", "RC-XDs", ::initSpawnBullet, "veh_t6_drone_rcxd", "RC-XDs");
		self add_option("SubMenu11v2", "Green Flags", ::initSpawnBullet, "mp_flag_green", "Green Flags");
		self add_option("SubMenu11v2", "Red Flags", ::initSpawnBullet, "mp_flag_red", "Red Flags");
		self add_option("SubMenu11v2", "Dildos", ::initSpawnBullet, "projectile_hellfire_missile", "Hellstorm Projectile");
		self add_option("SubMenu11v2", "Hunter Killers", ::initSpawnBullet, "veh_t6_drone_hunterkiller", "Hunter Killers");
		if(getDvar("mapname") == "mp_la" || getDvar("mapname") == "mp_express")
		{
			self add_option("SubMenu11v2", "Vending Machine 1", ::initSpawnBullet, "p6_vending_machine01", "Vending Machines");
			self add_option("SubMenu11v2", "Vending Machine 2", ::initSpawnBullet, "p6_vending_machine02", "Vending Machines");
		}
		if (getDvar("mapname") == "mp_nuketown_2020")
		{
			self add_option("SubMenu11v2", "Nuketown Signs", ::initSpawnBullet, "nt_sign_population", "Nuketown Signs");
			self add_option("SubMenu11v2", "Activision Signs", ::initSpawnBullet, "nt_sign_population_vcs", "Activision Signs");
			self add_option("SubMenu11v2", "Male Mannequins", ::initSpawnBullet, "dest_nt_nuked_male_01_d0", "Male Mannequins");
			self add_option("SubMenu11v2", "Female Mannequins", ::initSpawnBullet, "dest_nt_nuked_female_01_d0", "Female Mannequins");
		}
		if (getDvar("mapname") == "mp_hijacked")
			self add_option("SubMenu11v2", "Pianos", ::initSpawnBullet, "dub_grand_piano", "Pianos");
		if(getDvar("mapname") == "mp_raid")
		{
			self add_option("SubMenu11v2", "Statue", ::initSpawnBullet, "ct_statue_chinese_lion_gold", "Statues");
			self add_option("SubMenu11v2", "Red Lambo", ::initSpawnBullet, "veh_t6_civ_sportscar_whole_orange", "Red Lambos");
			self add_option("SubMenu11v2", "Yellow Lambo", ::initSpawnBullet, "veh_t6_civ_sportscar_whole_yellow", "Yellow Lambos");
		}
	//self add_option("SubMenu11", level.PageII, ::submenu, "SubMenu11v1", "Bullets");
		//self add_menu("SubMenu11v1", "SubMenu11", "Verified");
		self add_option("SubMenu11", "Blood Bullets", ::bloodGun);
		self add_option("SubMenu11", "Teleport Gun", ::teleportgun);
		self add_option("SubMenu11", "Cobra Bullets", ::initCOBRABullet);
		self add_option("SubMenu11", "Dog Bullets", ::initDogBullets);
		self add_option("SubMenu11", "Flare Bullets", ::toggle_FlareGun);
		self add_option("SubMenu11", "^5-->Equipment Bullets", ::submenu, "SubMenu11v3", "Equipment Bullets");
		self add_option("SubMenu11", "-->Spawn Bullets", ::submenu, "SubMenu11v2", "Spawn Bullets");
		self add_menu("SubMenu11v3", "SubMenu11", "Verified");
		self add_option("SubMenu11v3", "^1STOP EQUIP BULLETS^7", ::stopEquipB);
		self add_option("SubMenu11v3", "Frag Grenades", ::selectMLTfrag);
		self add_option("SubMenu11v3", "Semtex", ::selectMLTstick);
		self add_option("SubMenu11v3", "Concussions", ::selectMLTconc);
		self add_option("SubMenu11v3", "Combat Axes", ::selectMLTaxe);
		self add_option("SubMenu11v3", "C4s", ::selectMLTshock);
		self add_option("SubMenu11v3", "Flash Grenades", ::selectMLTflash);
		self add_option("SubMenu11v3", "EMP Grenades", ::selectMLTemp);
		self add_option("SubMenu11v3", "Sensor Grenades", ::selectMLTsensor);
		self add_option("SubMenu11v3", "Shock Charges", ::selectMLTc4);
		self add_option("SubMenu11v3", "Claymores", ::selectMLTclaym);
		self add_option("SubMenu11v3", "Smoke Grenades", ::selectMLTbetty);
		self add_option("SubMenu11v3", "Trophy Systems", ::selectMLTtrosy);

	self add_menu("SubMenu12", level.menuname, "Verified");
	self add_option("SubMenu12", "^1Reset Models^7", ::setDefoModel);
	self add_option("SubMenu12", "Third Person", ::thirdPerson);
	self add_option("SubMenu12", "Debug", ::modelF, "defaultactor");
	self add_option("SubMenu12", "Sentry", ::spawnPlayerModel, self, "t6_wpn_turret_sentry_gun");
	self add_option("SubMenu12", "Dog", ::spawnPlayerModel, self, "german_shepherd");
	self add_option("SubMenu12", "Trophy System", ::spawnPlayerModel, self, "t6_wpn_trophy_system_world");
	self add_option("SubMenu12", "White Vehicle", ::spawnPlayerModel, self, "defaultvehicle");
	self add_option("SubMenu12", "Hunter Killer", ::spawnPlayerModel, self, "veh_t6_drone_hunterkiller");
	self add_option("SubMenu12", "Bomb", ::spawnPlayerModel, self, "prop_suitcase_bomb");
	self add_option("SubMenu12", "Bomb Site", ::spawnPlayerModel, self, "p_glo_bomb_stack");
	self add_option("SubMenu12", "Blown-up Bomb Site", ::spawnPlayerModel, self, "p_glo_bomb_stack_d");
	self add_option("SubMenu12", "Scavenger Pack", ::spawnPlayerModel, self, "p_glo_scavenger_pack_obj");
	self add_option("SubMenu12", "Dog Tags", ::spawnPlayerModel, self, "p6_dogtags");
	self add_option("SubMenu12", "Train Track", ::spawnPlayerModel, self, "p6_express_train_track_a01");
	self add_option("SubMenu12", "Green Flag", ::spawnPlayerModel, self, "mp_flag_green");
	self add_option("SubMenu12", "Flag Allies", ::spawnPlayerModel, self, "mp_flag_allies_1");
	self add_option("SubMenu12", "Red Flag", ::spawnPlayerModel, self, "mp_flag_red");

	self add_menu("SubMenu12v1", "SubMenu12", "Verified");
	self add_option("SubMenu12", level.PageII, ::submenu, "SubMenu12v1", "Models");
		self add_option("SubMenu12v1", "Neutral Flag", ::spawnPlayerModel, self, "mp_flag_neutral");
		self add_option("SubMenu12v1", "Riot Shield", ::spawnPlayerModel, self, "t6_wpn_shield_carry_world");
		self add_option("SubMenu12v1", "Hellfire Projectile", ::spawnPlayerModel, self, "projectile_hellfire_missile");
		self add_option("SubMenu12v1", "VTOL", ::spawnPlayerModel, self, "veh_t6_air_v78_vtol_killstreak");
		self add_option("SubMenu12v1", "A10", ::spawnPlayerModel, self, "veh_t6_air_a10f_alt");
		self add_option("SubMenu12v1", "UAV", ::spawnPlayerModel, self, "veh_t6_drone_uav");
		self add_option("SubMenu12v1", "CUAV", ::spawnPlayerModel, self, "veh_t6_drone_cuav");
		self add_option("SubMenu12v1", "RC-XD", ::spawnPlayerModel, self, "veh_t6_drone_rcxd");
		self add_option("SubMenu12v1", "Care Package", ::spawnPlayerModel, self, "t6_wpn_supply_drop_ally");
		self add_option("SubMenu12v1", "Arrow FX", ::spawnPlayerModel, self, "fx_axis_createfx");
		self add_option("SubMenu12v1", "Cluster Bomb", ::spawnPlayerModel, self, "projectile_cbu97_clusterbomb");
		self add_option("SubMenu12v1", "A.G.R", ::spawnPlayerModel, self, "veh_t6_drone_tank");
		self add_option("SubMenu12v1", "Open Briefcase", ::spawnPlayerModel, self, "t6_wpn_briefcase_bomb_view");

	if (getDvar("mapname") == "mp_hijacked")
	{
		self add_menu("SubMenu12v2", "SubMenu12", "Verified");
		self add_option("SubMenu12", "^5-->Map Specifics", ::submenu, "SubMenu12v2", "Map Specifics");
		self add_option("SubMenu12v2", "Table", ::spawnPlayerModel, self, "p6_hijacked_table");
		self add_option("SubMenu12v2", "Engine", ::spawnPlayerModel, self, "p6_hijacked_engine");
		self add_option("SubMenu12v2", "Pool", ::spawnPlayerModel, self, "p6_hijacked_pool");
		self add_option("SubMenu12v2", "Weight Stand", ::spawnPlayerModel, self, "weightstand");
		self add_option("SubMenu12v2", "Large Weight", ::spawnPlayerModel, self, "weights_large");
		self add_option("SubMenu12v2", "Small Weight", ::spawnPlayerModel, self, "weights_small");
		self add_option("SubMenu12v2", "Piano", ::spawnPlayerModel, self, "dub_grand_piano");
		self add_option("SubMenu12v2", "Towel Stack", ::spawnPlayerModel, self, "p_rus_towel_stack_lrg");
		self add_option("SubMenu12v2", "Purple Mat", ::spawnPlayerModel, self, "yoga_mat_flat_purple");
		self add_option("SubMenu12v2", "Blue Mat", ::spawnPlayerModel, self, "yoga_mat_rolled_blue");
	}
	if (getDvar("mapname") == "mp_village")
	{
		self add_menu("SubMenu12v2", "SubMenu12", "Verified");
		self add_option("SubMenu12", "^5-->Map Specifics", ::submenu, "SubMenu12v2", "Map Specifics");
		self add_option("SubMenu12v2", "Luggage", ::spawnPlayerModel, self, "ap_luggage01");
		self add_option("SubMenu12v2", "Fence Wood", ::spawnPlayerModel, self, "arc_fence_wood_02");
		self add_option("SubMenu12v2", "Propane Tank", ::spawnPlayerModel, self, "com_propane_tank02_small");
		self add_option("SubMenu12v2", "Windmill", ::spawnPlayerModel, self, "machinery_windmill_body");
		self add_option("SubMenu12v2", "Antenna", ::spawnPlayerModel, self, "p6_antenna_rooftop");
		self add_option("SubMenu12v2", "Fence", ::spawnPlayerModel, self, "p6_village_iron_fence");
		self add_option("SubMenu12v2", "Fountain", ::spawnPlayerModel, self, "p6_village_hostel_fountain");
		self add_option("SubMenu12v2", "Yellow Fence", ::spawnPlayerModel, self, "zombie_yellowfence");
		self add_option("SubMenu12v2", "Tire", ::spawnPlayerModel, self, "afr_junktire");
		self add_option("SubMenu12v2", "Gas Can", ::spawnPlayerModel, self, "anim_rus_gascan");
		self add_option("SubMenu12v2", "Shovel", ::spawnPlayerModel, self, "anim_rus_snowshovel");
	}
	if (getDvar("mapname") == "mp_express")
	{
		self add_menu("SubMenu12v2", "SubMenu12", "Verified");
		self add_option("SubMenu12", "^5-->Map Specifics", ::submenu, "SubMenu12v2", "Map Specifics");
		self add_option("SubMenu12v2", "Antenna", ::spawnPlayerModel, self, "p6_antenna_rooftop");
		self add_option("SubMenu12v2", "Bullet Train", ::spawnPlayerModel, self, "p6_bullet_train_car");
		self add_option("SubMenu12v2", "Engine", ::spawnPlayerModel, self, "p6_bullet_train_engine");
		self add_option("SubMenu12v2", "Bus Stop", ::spawnPlayerModel, self, "p6_bus_stop");
		self add_option("SubMenu12v2", "Chair", ::spawnPlayerModel, self, "p6_plaza_chair");
		self add_option("SubMenu12v2", "Trash Can", ::spawnPlayerModel, self, "p6_plaza_trash_can");
		self add_option("SubMenu12v2", "Kiosk", ::spawnPlayerModel, self, "p6_round_kiosk");
		self add_option("SubMenu12v2", "Vending Machine", ::spawnPlayerModel, self, "p6_vending_machine01");
		self add_option("SubMenu12v2", "Vending Machine 2", ::spawnPlayerModel, self, "p6_vending_machine02");
	}
	if (getDvar("mapname") == "mp_slums")
	{
		self add_menu("SubMenu12v2", "SubMenu12", "Verified");
		self add_option("SubMenu12", "^5-->Map Specifics", ::submenu, "SubMenu12v2", "Map Specifics");
		self add_option("SubMenu12v2", "Bush", ::spawnPlayerModel, self, "p6_foliage_bush_desert_a");
		self add_option("SubMenu12v2", "Gas Container", ::spawnPlayerModel, self, "p6_gas_container");
		self add_option("SubMenu12v2", "Fence", ::spawnPlayerModel, self, "p6_vill_courtyard_fence_1");
		self add_option("SubMenu12v2", "Trash Can", ::spawnPlayerModel, self, "p_glo_trashcan_trash");
		self add_option("SubMenu12v2", "Plastic Crate", ::spawnPlayerModel, self, "p_jun_plastic_crate_small_red");
		self add_option("SubMenu12v2", "Red Chair", ::spawnPlayerModel, self, "pb_lawnchair_red");
	}
	if (getDvar("mapname") == "mp_nightclub")
	{
		self add_menu("SubMenu12v2", "SubMenu12", "Verified");
		self add_option("SubMenu12", "^5-->Map Specifics", ::submenu, "SubMenu12v2", "Map Specifics");
		self add_option("SubMenu12v2", "Plant", ::spawnPlayerModel, self, "com_potted_plant03");
		self add_option("SubMenu12v2", "Jewelery", ::spawnPlayerModel, self, "dub_jewelry_display_neck2");
		self add_option("SubMenu12v2", "Statue", ::spawnPlayerModel, self, "dub_decorative_statue2");
		self add_option("SubMenu12v2", "Metal Statue", ::spawnPlayerModel, self, "dub_decorative_metal_statue2");
		self add_option("SubMenu12v2", "Chair", ::spawnPlayerModel, self, "dub_restaurant_chair_01");
		self add_option("SubMenu12v2", "Art", ::spawnPlayerModel, self, "p6_abstract_art_01");
		self add_option("SubMenu12v2", "Table", ::spawnPlayerModel, self, "dub_lounge_table_01");
	}
	if (getDvar("mapname") == "mp_carrier")
	{
		self add_menu("SubMenu12v2", "SubMenu12", "Verified");
		self add_option("SubMenu12", "^5-->Map Specifics", ::submenu, "SubMenu12v2", "Map Specifics");
		self add_option("SubMenu12v2", "Small Weights", ::spawnPlayerModel, self, "weights_small");
		self add_option("SubMenu12v2", "Crane Wheel", ::spawnPlayerModel, self, "p6_towing_crane_wheel");
		self add_option("SubMenu12v2", "Railing", ::spawnPlayerModel, self, "p6_carrier_edge_railing_64");
		self add_option("SubMenu12v2", "Liferaft", ::spawnPlayerModel, self, "p6_carrier_liferaft");
		self add_option("SubMenu12v2", "Crate", ::spawnPlayerModel, self, "p6_carrier_large_crate");
	}
	if (getDvar("mapname") == "mp_raid")
	{
		self add_menu("SubMenu12v2", "SubMenu12", "Verified");
		self add_option("SubMenu12", "^5-->Map Specifics", ::submenu, "SubMenu12v2", "Map Specifics");
		self add_option("SubMenu12v2", "Statue", ::spawnPlayerModel, self, "ct_statue_chinese_lion_gold");
		self add_option("SubMenu12v2", "Chair", ::spawnPlayerModel, self, "furniture_chair5");
		self add_option("SubMenu12v2", "Couch", ::spawnPlayerModel, self, "furniture_couch3");
		self add_option("SubMenu12v2", "Antenna", ::spawnPlayerModel, self, "p6_antenna_rooftop");
		self add_option("SubMenu12v2", "Tower", ::spawnPlayerModel, self, "p6_cell_phone_tower");
		self add_option("SubMenu12v2", "Treadmill", ::spawnPlayerModel, self, "treadmill");
		self add_option("SubMenu12v2", "Yoga Mat", ::spawnPlayerModel, self, "yoga_mat_flat_blue");
		self add_option("SubMenu12v2", "Weight Stand", ::spawnPlayerModel, self, "weightstand");
		self add_option("SubMenu12v2", "Red Lambo", ::spawnPlayerModel, self, "veh_t6_civ_sportscar_whole_orange");
		self add_option("SubMenu12v2", "Yellow Lambo", ::spawnPlayerModel, self, "veh_t6_civ_sportscar_whole_yellow");
	}
	if (getDvar("mapname") == "mp_la")
	{
		self add_menu("SubMenu12v2", "SubMenu12", "Verified");
		self add_option("SubMenu12", "^5-->Map Specifics", ::submenu, "SubMenu12v2", "Map Specifics");
		self add_option("SubMenu12v2", "Chair", ::spawnPlayerModel, self, "dub_lounge_chair_01_red");
		self add_option("SubMenu12v2", "Chair 2", ::spawnPlayerModel, self, "p6_office_chair_cushion_base");
		self add_option("SubMenu12v2", "Chair 3", ::spawnPlayerModel, self, "ma_patio_heater");
		self add_option("SubMenu12v2", "Car", ::spawnPlayerModel, self, "iw_ac_prs_veh_civ_car_a_12");
		self add_option("SubMenu12v2", "Couch", ::spawnPlayerModel, self, "furniture_couch2_dirty");
		self add_option("SubMenu12v2", "Urinal", ::spawnPlayerModel, self, "bathroom_urinal");
		self add_option("SubMenu12v2", "Tree", ::spawnPlayerModel, self, "p6_tree_palm_fan_cali_med_02_sway");
		self add_option("SubMenu12v2", "Vending Machine", ::spawnPlayerModel, self, "p6_vending_machine01");
		self add_option("SubMenu12v2", "Vending Machine 2", ::spawnPlayerModel, self, "p6_vending_machine02");
	}
	if (getDvar("mapname") == "mp_meltdown")
	{
		self add_menu("SubMenu12v2", "SubMenu12", "Verified");
		self add_option("SubMenu12", "^5-->Map Specifics", ::submenu, "SubMenu12v2", "Map Specifics");
		self add_option("SubMenu12v2", "Folding Table", ::spawnPlayerModel, self, "com_folding_table");
		self add_option("SubMenu12v2", "Barrel", ::spawnPlayerModel, self, "p6_barrel_toxic_waste");
		self add_option("SubMenu12v2", "Barrier", ::spawnPlayerModel, self, "p6_barrier_pedestrian");
		self add_option("SubMenu12v2", "Machine", ::spawnPlayerModel, self, "p6_copy_machine_large");
		self add_option("SubMenu12v2", "Crane", ::spawnPlayerModel, self, "machinery_crane02_scaffolding");
		self add_option("SubMenu12v2", "Coat Rack", ::spawnPlayerModel, self, "p_rus_coat_rack");
		self add_option("SubMenu12v2", "Couch", ::spawnPlayerModel, self, "p_us_couch02");
		self add_option("SubMenu12v2", "Parking Cone", ::spawnPlayerModel, self, "p_us_parkingcone");
	}
	if (getDvar("mapname") == "mp_socotra")
	{
		self add_menu("SubMenu12v2", "SubMenu12", "Verified");
		self add_option("SubMenu12", "^5-->Map Specifics", ::submenu, "SubMenu12v2", "Map Specifics");
		self add_option("SubMenu12v2", "Soda twelvepack", ::spawnPlayerModel, self, "food_soda_twelvepack01");
		self add_option("SubMenu12v2", "Box", ::spawnPlayerModel, self, "me_box_citrusfruitopenshort_1");
		self add_option("SubMenu12v2", "Barrel", ::spawnPlayerModel, self, "global_barrel_scummy");
		self add_option("SubMenu12v2", "Bench", ::spawnPlayerModel, self, "intro_powder_bench_01");
		self add_option("SubMenu12v2", "Market Stand", ::spawnPlayerModel, self, "me_market_stand1");
	}
	if (getDvar("mapname") == "mp_turbine")
	{
		self add_menu("SubMenu12v2", "SubMenu12", "Verified");
		self add_option("SubMenu12", "^5-->Map Specifics", ::submenu, "SubMenu12v2", "Map Specifics");
		self add_option("SubMenu12v2", "Pile of Bricks", ::spawnPlayerModel, self, "p6_brick_pile_02");
		self add_option("SubMenu12v2", "Shelve", ::spawnPlayerModel, self, "p6_arena_stand_shelve");
		self add_option("SubMenu12v2", "Tree", ::spawnPlayerModel, self, "p6_foliage_tree_a");
		self add_option("SubMenu12v2", "Stairs", ::spawnPlayerModel, self, "p6_metal_stairs_02");
		self add_option("SubMenu12v2", "Tree 2", ::spawnPlayerModel, self, "p6_tree_acacia_lrg_01");
		self add_option("SubMenu12v2", "Bridge Panel", ::spawnPlayerModel, self, "p6_turbine_bridge_panel02");
		self add_option("SubMenu12v2", "Turbine Base", ::spawnPlayerModel, self, "p6_wind_turbine_base");
	}
	if (getDvar("mapname") == "mp_nuketown_2020")
	{
		self add_menu("SubMenu12v2", "SubMenu12", "Verified");
		self add_option("SubMenu12", "^5-->Map Specifics", ::submenu, "SubMenu12v2", "Map Specifics");
		self add_option("SubMenu12v2", "Nuketown Sign", ::spawnPlayerModel, self, "nt_sign_population");
		self add_option("SubMenu12v2", "Activision Sign", ::spawnPlayerModel, self, "nt_sign_population_vcs");
		self add_option("SubMenu12v2", "Male Mannequin", ::spawnPlayerModel, self, "dest_nt_nuked_male_01_d0");
		self add_option("SubMenu12v2", "Female Mannequin", ::spawnPlayerModel, self, "dest_nt_nuked_female_01_d0");
		self add_option("SubMenu12v2", "Sitting Male", ::spawnPlayerModel, self, "dest_nt_nuked_male_03_d0");
		self add_option("SubMenu12v2", "Sitting Female", ::spawnPlayerModel, self, "dest_nt_nuked_female_05_d0");
		self add_option("SubMenu12v2", "Teal Car", ::spawnPlayerModel, self, "veh_t6_nuketown_2020_car01_whole");
		self add_option("SubMenu12v2", "Red Car", ::spawnPlayerModel, self, "veh_t6_nuketown_2020_car02_whole");
		self add_option("SubMenu12v2", "Door Frame", ::spawnPlayerModel, self, "nt_2020_doorframe_black");
	}
	if (getDvar("mapname") == "mp_takeoff")
	{
		self add_menu("SubMenu12v2", "SubMenu12", "Verified");
		self add_option("SubMenu12", "^5-->Map Specifics", ::submenu, "SubMenu12v2", "Map Specifics");
		self add_option("SubMenu12v2", "Space Shuttle", ::spawnPlayerModel, self, "veh_t6_dlc_commuter_shuttle");
	}
	if (getDvar("mapname") == "mp_drone")
	{
		self add_menu("SubMenu12v2", "SubMenu12", "Verified");
		self add_option("SubMenu12", "^5-->Map Specifics", ::submenu, "SubMenu12v2", "Map Specifics");
		self add_option("SubMenu12v2", "Fuel Tank", ::spawnPlayerModel, self, "p_rus_tank_flat_end");
		self add_option("SubMenu12v2", "Small Fuel Tank", ::spawnPlayerModel, self, "p6_metal_tank_set_01");
		self add_option("SubMenu12v2", "Drone Door", ::spawnPlayerModel, self, "p6_door_automatic_mp_drone");
		self add_option("SubMenu12v2", "Silo", ::spawnPlayerModel, self, "p6_drone_gas_silo");
	}

	self add_menu("SubMenu13", level.menuname, "Verified");
	self add_option("SubMenu13", "UAV", ::BG_giveKS, "killstreak_spyplane");
	self add_option("SubMenu13", "RCXD", ::BG_giveKS, "killstreak_rcbomb");
	self add_option("SubMenu13", "Hunter Killer Drone", ::giveHunt);
	self add_option("SubMenu13", "Care Package", ::giveCare);
	self add_option("SubMenu13", "CUAV", ::BG_giveKS, "killstreak_counteruav");
	self add_option("SubMenu13", "Guardian", ::giveGaurd);
	self add_option("SubMenu13", "Hellstorm", ::BG_giveKS, "killstreak_remote_missile");
	self add_option("SubMenu13", "Lightning Strike", ::BG_giveKS, "killstreak_planemortar");
	self add_option("SubMenu13", "Sentry Gun", ::giveSG);
	self add_option("SubMenu13", "A.G.R.", ::giveAG);
	self add_option("SubMenu13", "Stealth Chopper", ::BG_giveKS, "killstreak_helicopter_comlink");
	self add_option("SubMenu13", "VSAT", ::BG_giveKS, "killstreak_spyplane_direction");
	self add_option("SubMenu13", "Escort Drone", ::BG_giveKS, "killstreak_helicopter_guard");
	self add_option("SubMenu13", "Warthog", ::BG_giveKS, "killstreak_straferun");
	self add_option("SubMenu13", "EMP", ::giveEMP);
	self add_option("SubMenu13", "Lodestar", ::BG_giveKS, "killstreak_remote_mortar");
	self add_option("SubMenu13", "VTOL Warship", ::giveVW);
	self add_option("SubMenu13", "Swarm", ::BG_giveKS, "killstreak_missile_swarm");

	self add_menu("SubMenu14", level.menuname, "Verified");
	self add_option("SubMenu14", "Trickshot Platform", ::Platform);
	self add_option("SubMenu14", "Drive-a-Car", ::spawnDrivableCar);
	self add_option("SubMenu14", "VTOL Crash", ::VTOLCRASH);
	self add_option("SubMenu14", "VTOL Space-Ship", ::VTOLspaceShip);
	self add_option("SubMenu14", "Suicide Bomber", ::suicideBomb);

	self add_menu("SubMenu14v0", "SubMenu14", "Verified");
	self add_option("SubMenu14", "^5-->Wave Menu", ::submenu, "SubMenu14v0", "Wave Menu");
		self add_option("SubMenu14v0", "Mexi Wave", ::ToggleMexiWave);
		self add_option("SubMenu14v0", "Sentry Wave", ::ToggleSentryWave);
		self add_option("SubMenu14v0", "Hunter Killer Wave", ::TogglehKillerWave);

	self add_menu("SubMenu14v1", "SubMenu14", "Verified");
	self add_option("SubMenu14", "-->Flyable Jet", ::submenu, "SubMenu14v1", "Flyable Jet");
	self add_option("SubMenu14", "-->Flyable Heli", ::submenu, "SubMenu14v2", "Flyable Heli");
		self add_option("SubMenu14v1", "^1Spawn Jet^7", ::initFlyableJet);
		self add_option("SubMenu14v1", "A10 Thunderbolt", ::switchFJetModel, "veh_t6_air_a10f_alt", "A10 Thunderbolt");
		self add_option("SubMenu14v1", "Lightning Strike", ::switchFJetModel, "veh_t6_air_fa38_killstreak", "Harrier");
		self add_option("SubMenu14v1", "Stealth Bomber", ::switchFJetModel, "veh_t6_drone_pegasus_mp", "Stealth Bomber");
		self add_option("SubMenu14v1", "UAV", ::switchFJetModel, "veh_t6_drone_uav", "UAV");
		self add_option("SubMenu14v1", "VTOL Warship", ::switchFJetModel, "veh_t6_air_v78_vtol_killstreak", "VTOL Warship");
		
	self add_menu("SubMenu14v7", "SubMenu14", "Verified");
	self add_option("SubMenu14", "-->Level Effects", ::submenu, "SubMenu14v7", "Level Effects");
		self add_option("SubMenu14v7", "Smoke Sky", ::smokerain);
		self add_option("SubMenu14v7", "EMP Sky", ::EMPrain);
		self add_option("SubMenu14v7", "Exploding Sky", ::equiprain);
		self add_option("SubMenu14v7", "Spawn Sun", ::spawnSun);
		self add_option("SubMenu14v7", "Lightning Bolt", ::LBoltTest);
		if (getDvar("mapname") == "mp_nightclub")
			self add_option("SubMenu14v7", "Spawn Moon", ::spawnMoon);
		self add_option("SubMenu14v7", "Missile Barrage", ::javiB);
		
	self add_menu("SubMenu14v8", "SubMenu14", "Verified");
	self add_option("SubMenu14", "-->Moving Models", ::submenu, "SubMenu14v8", "Moving Models");
		self add_option("SubMenu14v8", "Spinning VTOL", ::VTOLspinModel);
		self add_option("SubMenu14v8", "Spinning Vehicle", ::WVspinModel);
		self add_option("SubMenu14v8", "Spinning Bomb Site", ::BSspinModel);
		self add_option("SubMenu14v8", "Spinning Train Track", ::TTspinModel);
		self add_option("SubMenu14v8", "Spinning A10", ::A10spinModel);
		self add_option("SubMenu14v8", "Spinning UAV", ::UAVspinModel);
		self add_option("SubMenu14v8", "Rotating Flag", ::RFlagspinModel);
		
	self add_menu("SubMenu14v4", "SubMenu14", "Verified");
	self add_option("SubMenu14", "-->Rain Menu", ::submenu, "SubMenu14v4", "Rain Menu");
		self add_option("SubMenu14v4", "Rain Missiles", ::javirain);
		self add_option("SubMenu14v4", "Rain Dogs", ::toggleRainDog);
		self add_option("SubMenu14v4", "Rain Choppers", ::togglechopper);
		self add_option("SubMenu14v4", "Rain Cars", ::togglecars);
		self add_option("SubMenu14v4", "Rain Debugs", ::toggledebugs);
		self add_option("SubMenu14v4", "Rain Lodestars", ::togglelodestars);
		self add_option("SubMenu14v4", "Rain RC-XDs", ::togglercxds);

	self add_option("SubMenu14", "^7Strafe Run", ::initStrafeRun);
	self add_option("SubMenu14", "Spawn-a-Mine", ::mineSpawner);
	self add_option("SubMenu14", "Sky Plaza", ::skyplaza);
	self add_option("SubMenu14", "Bridge", ::bridge);

	self add_menu("SubMenu14v2", "SubMenu14", "Verified");
		self add_option("SubMenu14v2", "^1Spawn Helicopter^7", ::initPilotHeli);
		self add_option("SubMenu14v2", "Overwatch", ::PHeliModellb);
		self add_option("SubMenu14v2", "Attack Heli", ::PHeliModelah);
		self add_option("SubMenu14v2", "A10 Thunderbolt", ::PHeliModela10);
		self add_option("SubMenu14v2", "VTOL", ::PHeliModela100);
		self add_option("SubMenu14v2", "UAV Drone", ::PHeliModela1000);
		self add_option("SubMenu14v2", "Pegasus", ::PHeliModelstlh);
	self add_option("SubMenu14", "MEGA-AIRDROP", ::MegaAirDrop);
	self add_option("SubMenu14", "Windmill", ::WindMill);

	self add_menu("SubMenu14v3", "SubMenu14", "Verified");
		self add_option("SubMenu14", level.PageII, ::submenu, "SubMenu14v3", "Spawnables");
		self add_option("SubMenu14v3", "MW3 IMS", ::IMSMW3);
		self add_option("SubMenu14v3", "Forge Wall", ::ForgeWall);
		self add_option("SubMenu14v3", "Forge Ramp", ::ForgeRamp);
		self add_option("SubMenu14v3", "Merry-Go-Round", ::build);
		self add_option("SubMenu14v3", "Delete Merry-Go-Round", ::Explode);
		self add_option("SubMenu14v3", "Trampoline", ::trampoline);
		//if (getDvar("mapname") == "mp_nuketown_2020")
			self add_option("SubMenu14v3", "Butterflies ^1(NUKETOWN)^7", ::VIEtoggle);
		self add_option("SubMenu14v3", "Spiral Stairs", ::SSpiralStairs);
		self add_option("SubMenu14v3", "Earthquake Dude", ::ToggleEarthquakeDude);
		self add_option("SubMenu14v3", "Pack-o-Punch", ::Packopunch);
		self add_option("SubMenu14v3", "Circling Plane", ::circlingPlane);
		self add_option("SubMenu14v3", "Super Bouncing Betty", ::bounceBetty);
		self add_option("SubMenu14v3", "Ice Skater", ::DoSk8r);
		self add_option("SubMenu14v3", "Spinning UFO", ::spawnSunSpinner);

	self add_menu("SubMenu15", level.menuname, "Verified");
	self add_option("SubMenu15", "MW2 Nuke", ::initMW2Nuke);
	self add_option("SubMenu15", "The Hulk v2", ::hulktoggle);
	self add_option("SubMenu15", "Spawn Bunker", ::bunkerthread);
	self add_option("SubMenu15", "Unlock Stuff", ::camonlock);
	self add_option("SubMenu15", "Trace Model", ::ToggleTraceModel);
	self add_option("SubMenu15", "Minimap Loop", ::abxyToggle);
	self add_option("SubMenu15", "Rapid Delete", ::rapidDelete);
	self add_option("SubMenu15", "Menu Animation", ::toggleAnimation);
	self add_option("SubMenu15", "Menu Stealth", ::menuStealthy);

	self add_menu("SubMenu16", level.menuname, "Host");
	self add_option("SubMenu16", "Force Host", ::forceHost);
	self add_option("SubMenu16", "Reset Co-Host List", ::clearCoList);
	self add_option("SubMenu16", "Reset VIP List", ::clearVIPList);
	self add_option("SubMenu16", "Reset Blacklist", ::clearBlackList);
	self add_option("SubMenu16", "Big Names", ::dobig);
	self add_option("SubMenu16", "Show FPS", ::ShowFPS);
	self add_option("SubMenu16", "Gun on Left Side", ::ToggleLeft);
	self add_option("SubMenu16", "Flash Low Ammo", ::flashlowammo);
	self add_option("SubMenu16", "Sky Light", ::DoLight);
	self add_option("SubMenu16", "Sky Color", ::DoSky);
	self add_option("SubMenu16", "Camera Bobb", ::togglecamera);
	self add_option("SubMenu16", "Crosshair++", ::togglecrosshair);
	self add_option("SubMenu16", "FPS Limit", ::FPSLimit);
	self add_option("SubMenu16", "VSync", ::vSync);
	self add_option("SubMenu16", "Flash Feed", ::FlashFeed);
	self add_option("SubMenu16", "Delete All Models", ::printMapModelstogamesmplog);
	self add_option("SubMenu16", "self.origin finder", ::selfOriginGet);
	self add_option("SubMenu16", "self.angles finder", ::selfAnglesGet);
	//self add_option("SubMenu16", "draw version", ::ShowVersion);
	//self add_option("SubMenu16", "draw 2d", ::Show2D);

	self add_menu("SubMenu17", level.menuname, "Verified");
	if(self.pers["team"]=="allies")
	{
		self add_menu("SubMenu17v1", "SubMenu17", "Verified");
		self add_option("SubMenu17", "^5-->Your Team", ::submenu, "SubMenu17v1", "Your Team");
			self add_option("SubMenu17v1", "ESP", ::ToggleESPTeamALLIES);
			self add_option("SubMenu17v1", "Godmode", ::ToggleGODTeamALLIES);
			self add_option("SubMenu17v1", "Give VIP Menu", ::VIPALLIES);
			self add_option("SubMenu17v1", "Give Co-Host", ::coALLIES);
			self add_option("SubMenu17v1", "Unverify", ::unverifyALLIES);
			self add_option("SubMenu17v1", "^2Revive Team", ::reviveALLIES);
			self add_option("SubMenu17v1", "^1Kill Team", ::killALLIES);
		self add_menu("SubMenu17v2", "SubMenu17", "Verified");
		self add_option("SubMenu17", "^1-->Enemy Team", ::submenu, "SubMenu17v2", "Enemy Team");
			self add_option("SubMenu17v2", "ESP", ::ToggleESPTeamAXIS);
			self add_option("SubMenu17v2", "Godmode", ::ToggleGODTeamAXIS);
			self add_option("SubMenu17v2", "Give VIP Menu", ::VIPAXIS);
			self add_option("SubMenu17v2", "Give Co-Host", ::coAXIS);
			self add_option("SubMenu17v2", "Unverify", ::unverifyAXIS);
			self add_option("SubMenu17v2", "^2Revive Team", ::reviveAXIS);
			self add_option("SubMenu17v2", "^1Kill Team", ::killAXIS);
	}
	if(self.pers["team"]=="axis")
	{
		self add_menu("SubMenu17v1", "SubMenu17", "Verified");
		self add_option("SubMenu17", "^5-->Your Team", ::submenu, "SubMenu17v1", "Your Team");
			self add_option("SubMenu17v1", "ESP", ::ToggleESPTeamAXIS);
			self add_option("SubMenu17v1", "Godmode", ::ToggleGODTeamAXIS);
			self add_option("SubMenu17v1", "Give VIP Menu", ::VIPAXIS);
			self add_option("SubMenu17v1", "Give Co-Host", ::coAXIS);
			self add_option("SubMenu17v1", "Unverify", ::unverifyAXIS);
			self add_option("SubMenu17v1", "^2Revive Team", ::reviveAXIS);
			self add_option("SubMenu17v1", "^1Kill Team", ::killAXIS);
		self add_menu("SubMenu17v2", "SubMenu17", "Verified");
		self add_option("SubMenu17", "^1-->Enemy Team", ::submenu, "SubMenu17v2", "Enemy Team");
			self add_option("SubMenu17v2", "ESP", ::ToggleESPTeamALLIES);
			self add_option("SubMenu17v2", "Godmode", ::ToggleGODTeamALLIES);
			self add_option("SubMenu17v2", "Give VIP Menu", ::VIPALLIES);
			self add_option("SubMenu17v2", "Give Co-Host", ::coALLIES);
			self add_option("SubMenu17v2", "Unverify", ::unverifyALLIES);
			self add_option("SubMenu17v2", "^2Revive Team", ::reviveALLIES);
			self add_option("SubMenu17v2", "^1Kill Team", ::killALLIES);
	}
	self add_menu("AllPlayersMenu", level.menuname, "Verified");
		self add_option("AllPlayersMenu", "All -> Me", ::AllToMe);
		self add_option("AllPlayersMenu", "All -> Crosshairs", ::teleToCrosshairs);
		self add_option("AllPlayersMenu", "Kill All", ::AllPlayersKilled);
		self add_option("AllPlayersMenu", "KICK ALL", ::AllPlayersKick);
		self add_option("AllPlayersMenu", "Adventure Time", ::AllPlayersAdventure);
		self add_option("AllPlayersMenu", "Godmode", ::godmodeall);
		self add_option("AllPlayersMenu", "Achievements", ::AllPlayersAchievements);
		self add_menu("AllPlayersMenuv4", "AllPlayersMenu", "Verified");
		self add_option("AllPlayersMenu", "^5-->CAMOS", ::submenu, "AllPlayersMenuv4", "Camos");
		self add_option("AllPlayersMenuv4", "^1None", ::togglecamoall, 0);
		self add_option("AllPlayersMenuv4", "^6Disco Camo^7", ::discocamoall);
		self add_option("AllPlayersMenuv4", "Diamond", ::togglecamoall, 16);
		self add_option("AllPlayersMenuv4", "Ghosts", ::togglecamoall, 29);
		self add_option("AllPlayersMenuv4", "Afterlife", ::togglecamoall, 44);
		self add_option("AllPlayersMenuv4", "Party Rock", ::togglecamoall, 25);
		self add_option("AllPlayersMenuv4", "Art of War", ::togglecamoall, 12);
		self add_option("AllPlayersMenuv4", "Benjamins", ::togglecamoall, 21);
		self add_option("AllPlayersMenuv4", "DEVGRU", ::togglecamoall, 1);
		self add_option("AllPlayersMenuv4", "A-TACS AU", ::togglecamoall, 2);
		self add_option("AllPlayersMenuv4", "ERDL", ::togglecamoall, 3);
		self add_option("AllPlayersMenuv4", "Siberia", ::togglecamoall, 4);
		self add_option("AllPlayersMenuv4", "Choco", ::togglecamoall, 5);
		self add_option("AllPlayersMenuv4", "Blue Tiger", ::togglecamoall, 6);
		self add_option("AllPlayersMenuv4", "Bloodshot", ::togglecamoall, 7);
		self add_option("AllPlayersMenuv4", "Delta 6", ::togglecamoall, 8);
			self add_menu("AllPlayersMenuv3v2", "AllPlayersMenuv4", "Verified");
			self add_option("AllPlayersMenuv4", level.PageII, ::submenu, "AllPlayersMenuv3v2", "Camos");
			self add_option("AllPlayersMenuv3v2", "Carbon Fiber", ::togglecamoall, 10);
			self add_option("AllPlayersMenuv3v2", "Cherry Blossom", ::togglecamoall, 11);
			self add_option("AllPlayersMenuv3v2", "Ronin", ::togglecamoall, 13);
			self add_option("AllPlayersMenuv3v2", "Skulls", ::togglecamoall, 14);
			self add_option("AllPlayersMenuv3v2", "Gold", ::togglecamoall, 15);
			self add_option("AllPlayersMenuv3v2", "Elite", ::togglecamoall, 17);
			self add_option("AllPlayersMenuv3v2", "Digital", ::togglecamoall, 18);
			self add_option("AllPlayersMenuv3v2", "Jungle", ::togglecamoall, 19);
			self add_option("AllPlayersMenuv3v2", "UK", ::togglecamoall, 20);
			self add_option("AllPlayersMenuv3v2", "Dia De Muertos", ::togglecamoall, 22);
			self add_option("AllPlayersMenuv3v2", "Graffiti", ::togglecamoall, 23);
			self add_option("AllPlayersMenuv3v2", "Kawaii", ::togglecamoall, 24);
			self add_option("AllPlayersMenuv3v2", "Zombies", ::togglecamoall, 26);
			self add_option("AllPlayersMenuv3v2", "Bacon", ::togglecamoall, 28);
			self add_option("AllPlayersMenuv3v2", "Viper", ::togglecamoall, 27);
			self add_option("AllPlayersMenuv3v2", "Typhon", ::togglecamoall, 9);
				self add_menu("AllPlayersMenuv3v3", "AllPlayersMenuv3v2", "Verified");
				self add_option("AllPlayersMenuv3v2", "^5-->Page 3", ::submenu, "AllPlayersMenuv3v3", "Camos");
				self add_option("AllPlayersMenuv3v3", "Dragon", ::togglecamoall, 32);
				self add_option("AllPlayersMenuv3v3", "Cyborg", ::togglecamoall, 31);
				self add_option("AllPlayersMenuv3v3", "Aqua", ::togglecamoall, 33);
				self add_option("AllPlayersMenuv3v3", "Breach", ::togglecamoall, 35);
				self add_option("AllPlayersMenuv3v3", "Coyote", ::togglecamoall, 36);
				self add_option("AllPlayersMenuv3v3", "Glam", ::togglecamoall, 37);
				self add_option("AllPlayersMenuv3v3", "Rogue", ::togglecamoall, 38);
				self add_option("AllPlayersMenuv3v3", "Pack-a-Punch", ::togglecamoall, 39);
				self add_option("AllPlayersMenuv3v3", "Paladin", ::togglecamoall, 30);
				self add_option("AllPlayersMenuv3v3", "Comics", ::togglecamoall, 34);
				self add_option("AllPlayersMenuv3v3", "Dead Man's Hand", ::togglecamoall, 40);
				self add_option("AllPlayersMenuv3v3", "Beast", ::togglecamoall, 41);
				self add_option("AllPlayersMenuv3v3", "Octane", ::togglecamoall, 42);
				self add_option("AllPlayersMenuv3v3", "Weaponized 115", ::togglecamoall, 43);

		self add_menu("AllPlayersMenuv1", "AllPlayersMenu", "Verified");
		self add_option("AllPlayersMenu", "-->Bullets", ::submenu, "AllPlayersMenuv1", "Bullets");
		self add_option("AllPlayersMenuv1", "Swarm Bullets", ::swarmball);
		self add_option("AllPlayersMenuv1", "A.G.R. Bullets", ::agrball);
		self add_option("AllPlayersMenuv1", "RPG Bullets", ::rpgball);
		self add_option("AllPlayersMenuv1", "Grenade Bullets", ::grenadeball);
		self add_menu("AllPlayersMenuv2", "AllPlayersMenu", "Verified");
		self add_option("AllPlayersMenu", "-->Weapons", ::submenu, "AllPlayersMenuv2", "Weapons");
		self add_option("AllPlayersMenuv2", "Rocket Teleporter", ::AllPlayersRTele);
		self add_option("AllPlayersMenuv2", "Ray Gun MK-I", ::AllPlayersRayGun);
		self add_option("AllPlayersMenuv2", "Ray Gun MK-II", ::AllPlayersRayGunM2);
		self add_option("AllPlayersMenuv2", "Ray Gun MK-III", ::AllPlayersRayGunM3);
		self add_option("AllPlayersMenuv2", "Ray Gun MK-IV", ::AllPlayersRayGunM4);
		self add_menu("AllPlayersMenuv3", "AllPlayersMenu", "Verified");
		self add_option("AllPlayersMenu", "-->Effects", ::submenu, "AllPlayersMenuv3", "Effects");
		self add_option("AllPlayersMenuv3", "Jetpack", ::jetpackall);
		self add_option("AllPlayersMenuv3", "Electric Cherry", ::electriccherryall);
		self add_option("AllPlayersMenuv3", "Light Man", ::lightmanall);
		self add_option("AllPlayersMenuv3", "Rambo", ::ramboall);
		self add_option("AllPlayersMenuv3", "Marachi Man", ::josewhoall);
		self add_option("AllPlayersMenuv3", "Glass Man", ::glassmanall);
		self add_option("AllPlayersMenu", "-->MODELS^7", ::submenu, "AllPlayersMenuv5", "Models");
			self add_menu("AllPlayersMenuv5", "AllPlayersMenu", "Verified");
			self add_option("AllPlayersMenuv5", "^1DEFAULT^7", ::normalmAll);
			self add_option("AllPlayersMenuv5", "Debug", ::allPlayersDebugM);
			self add_option("AllPlayersMenuv5", "Sentry", ::modelForAll, "t6_wpn_turret_sentry_gun");
			self add_option("AllPlayersMenuv5", "Dog", ::modelForAll, "german_shepherd");
			self add_option("AllPlayersMenuv5", "Trophy System", ::modelForAll, "t6_wpn_trophy_system_world");
			self add_option("AllPlayersMenuv5", "White Vehicle", ::modelForAll, "defaultvehicle");
			self add_option("AllPlayersMenuv5", "Hunter Killer", ::modelForAll, "veh_t6_drone_hunterkiller");
			self add_option("AllPlayersMenuv5", "Bomb", ::modelForAll, "prop_suitcase_bomb");
			self add_option("AllPlayersMenuv5", "Bomb Site", ::modelForAll, "p_glo_bomb_stack");
			self add_option("AllPlayersMenuv5", "Blown-up Bomb Site", ::modelForAll, "p_glo_bomb_stack_d");
			self add_option("AllPlayersMenuv5", "Scavenger Pack", ::modelForAll, "p_glo_scavenger_pack_obj");
			self add_option("AllPlayersMenuv5", "Arrow FX", ::modelForAll, "fx_axis_createfx");
			self add_option("AllPlayersMenuv5", "Train Track", ::modelForAll, "p6_express_train_track_a01");
			self add_option("AllPlayersMenuv5", "UAV", ::modelForAll, "veh_t6_drone_uav");
			self add_option("AllPlayersMenuv5", "Dog Tags", ::modelForAll, "p6_dogtags");
			self add_option("AllPlayersMenuv5", "Green Flag", ::modelForAll, "mp_flag_green");
			self add_option("AllPlayersMenuv5", "Flag Allies", ::modelForAll, "mp_flag_allies_1");
			//////
			self add_menu("AllPlayersMenuv5v2", "AllPlayersMenuv5", "Verified");
			self add_option("AllPlayersMenuv5", level.PageII, ::submenu, "AllPlayersMenuv5v2", "Models");
				self add_option("AllPlayersMenuv5v2", "Red Flag", ::modelForAll, "mp_flag_red");
				self add_option("AllPlayersMenuv5v2", "Neutral Flag", ::modelForAll, "mp_flag_neutral");
				self add_option("AllPlayersMenuv5v2", "Riot Shield", ::modelForAll, "t6_wpn_shield_carry_world");
				self add_option("AllPlayersMenuv5v2", "Hellfire Projectile", ::modelForAll, "projectile_hellfire_missile");
				self add_option("AllPlayersMenuv5v2", "VTOL", ::modelForAll, "veh_t6_air_v78_vtol_killstreak");
				self add_option("AllPlayersMenuv5v2", "A10", ::modelForAll, "veh_t6_air_a10f_alt");
				self add_option("AllPlayersMenuv5v2", "UAV", ::modelForAll, "veh_t6_drone_uav");
				self add_option("AllPlayersMenuv5v2", "CUAV", ::modelForAll, "veh_t6_drone_cuav");
				self add_option("AllPlayersMenuv5v2", "RC-XD", ::modelForAll, "veh_t6_drone_rcxd");
				self add_option("AllPlayersMenuv5v2", "Care Package", ::modelForAll, "t6_wpn_supply_drop_ally");
				self add_option("AllPlayersMenuv5v2", "Arrow FX", ::modelForAll, "fx_axis_createfx");
				self add_option("AllPlayersMenuv5v2", "Cluster Bomb", ::modelForAll, "projectile_cbu97_clusterbomb");
				self add_option("AllPlayersMenuv5v2", "A.G.R", ::modelForAll, "veh_t6_drone_tank");
				self add_option("AllPlayersMenuv5v2", "Open Briefcase", ::modelForAll, "t6_wpn_briefcase_bomb_view");

		self add_option("AllPlayersMenu", "Fake Derank", ::FakeDerankAll);
		self add_option("AllPlayersMenu", "Fake Master", ::maxAllRank);
		//self add_option("AllPlayersMenu", level.PageII, ::submenu, "AllPlayersMenuvP2", "All Clients");
			//self add_menu("AllPlayersMenuvP2", "AllPlayersMenu", "Verified");
		self add_option("AllPlayersMenu", "Freeze All", ::freezeall);
		self add_option("AllPlayersMenu", "Ice Skater", ::allPlayerIce);
		self add_option("AllPlayersMenu", "Infinite Ammo", ::infammoall);
		self add_option("AllPlayersMenu", "Random Weapon", ::allRandomWeapon);
			//self add_option("AllPlayersMenuvP2", "^4ALL VIP", ::allVIP);
			//self add_option("AllPlayersMenuvP2", "ALL CO-HOST ^1(#YOLO)", ::allCoHost);
			//self add_option("AllPlayersMenuvP2", "^3ALL Unverified", ::allUnverif);

	self add_menu("PlayersMenu", level.menuname, "Co-Host");
	for (i = 0; i < 15; i++)
		self add_menu("pOpt " + i, "PlayersMenu", "Co-Host");
}
updatePlayersMenu()
{
	self.menu.menucount["PlayersMenu"] = 0;
	for (i = 0; i < 14; i++)
	{
		player = level.players[i];
		playerName = getPlayerName(player);

		playersizefixed = level.players.size - 1;
		if(self.menu.curs["PlayersMenu"] > playersizefixed)
		{
			self.menu.scrollerpos["PlayersMenu"] = playersizefixed;
			self.menu.curs["PlayersMenu"] = playersizefixed;
		}

		self add_option("PlayersMenu", playerName, ::submenu, "pOpt " + i, "[" + verificationToColor(player.status) + "^7] " + playerName);
		//self add_option("PlayersMenu", "[" + verificationToColor(player.status) + "^7] " + playerName, ::submenu, "pOpt " + i, "[" + verificationToColor(player.status) + "^7] " + playerName);

		self add_menu("pOpt " + i, "PlayersMenu", "Co-Host");
		self add_menu("pOpt2 " + i, "pOpt " + i, "Co-Host");
		self add_menu("pOpt3 " + i, "pOpt " + i, "Co-Host");
		//if(self.ClientPage == 1)
		//{
			self add_option("pOpt " + i, "Co-Host", ::giveCo, player);
			self add_option("pOpt " + i, "^5+^7Co-Host List", ::addCoList, player);
			self add_option("pOpt " + i, "VIP", ::giveVIP, player);
			self add_option("pOpt " + i, "^5+^7VIP List", ::addVIPList, player);
			self add_option("pOpt " + i, "Unverify", ::changeVerificationMenu, player, "Unverified");
			self add_option("pOpt " + i, "Him -> Me", ::teletome, player);
			self add_option("pOpt " + i, "Me -> Him", ::teletohim, player);
			self add_option("pOpt " + i, "Give Streaks", ::playerStreaks, player);
			self add_option("pOpt " + i, "Kick", ::kickplayer, player);
			self add_option("pOpt " + i, "Ban", ::banPlayer, player);
			self add_option("pOpt " + i, "Kill", ::suicidePlayer, player);
			self add_option("pOpt " + i, "Rank Up", ::RankUp, player);
			self add_option("pOpt " + i, "^5-->Stats^7", ::submenu, "pOpt3 " + i, "[" + verificationToColor(player.status) + "^7] " + playerName);
			self add_option("pOpt " + i, "Change Team", ::ChangeTeamPlayer, player);
			self add_option("pOpt " + i, "Change Class", ::ChangeClassPlayer, player);
			self add_option("pOpt " + i, "Give TS Aimbot", ::giveTSaimbot, player);
			self add_option("pOpt " + i, "Give Godmode", ::GiveGodPlayer, player);
			self add_option("pOpt " + i, "^5+^1Blacklist", ::addBlackList, player);
			self add_option("pOpt " + i, "Freeze Console", ::FreezePlayer, player);
			self add_option("pOpt " + i, "^7Unlock Stuff ^5(LEVEL 55)", ::camounlockPlayer, player);
			self add_option("pOpt " + i, "-->Page 2", ::submenu, "pOpt2 " + i, "[" + verificationToColor(player.status) + "^7] " + playerName);
			
			self add_option("pOpt2 " + i, "Revive Player", ::revivePlayer, player);
			self add_option("pOpt2 " + i, "Spin Player", ::ToggleSpinPlayer, player);
			self add_option("pOpt2 " + i, "Blind Player", ::blindplayer, player);
			self add_option("pOpt2 " + i, "Send To Space", ::sendtospace, player);
			self add_option("pOpt2 " + i, "Give Forge", ::playerForge, player);
			self add_option("pOpt2 " + i, "Give ESP", ::GiveESPPlayer, player);
			self add_option("pOpt2 " + i, "Give Perks", ::GivePerksPlayer, player);
			self add_option("pOpt2 " + i, "Take Weapons", ::takewepsfromplayer, player);
			self add_option("pOpt2 " + i, "Send to Prison", ::teleporttoprison, player);
			self add_option("pOpt2 " + i, "290 Kills", ::Kills300Player, player);
			self add_option("pOpt2 " + i, "Insane RPG Kills", ::FHJStats, player);
			self add_option("pOpt2 " + i, "Leaderboards", ::leaderboardPlayer, player);
			self add_option("pOpt2 " + i, "Insane Gun Stats", ::insaneGunStatsPlayer, player);
			self add_option("pOpt2 " + i, "Fuck Stats", ::lowStats, player);
			
			self add_option("pOpt3 " + i, "50 Kills", ::addKillsStatplayer, player, 50);
			self add_option("pOpt3 " + i, "290 Kills", ::addKillsStatplayer, player, 290);
			self add_option("pOpt3 " + i, "50 Assists", ::addAssistStatplayer, player, 50);
			self add_option("pOpt3 " + i, "290 Assists", ::addAssistStatplayer, player, 290);
			self add_option("pOpt3 " + i, "500 Deaths", ::addDeathsStatplayer, player, 500);
			self add_option("pOpt3 " + i, "10,000 Deaths", ::addDeathsStatplayer, player, 10000);
			self add_option("pOpt3 " + i, "1 Day Played", ::addTimeStatplayer, player, 86400);
			self add_option("pOpt3 " + i, "5 Days Played", ::addTimeStatplayer, player, 432000);
			self add_option("pOpt3 " + i, "24,500 Days Played", ::addTimeStatplayer, player, 2116800000);
			self add_option("pOpt3 " + i, "50,000 Score", ::addScoreStatplayer, player, 50000);
			self add_option("pOpt3 " + i, "500,000 Score", ::addScoreStatplayer, player, 500000);
			self add_option("pOpt3 " + i, "2 BILLION Score", ::addScoreStatplayer, player, 2147450000);
			self add_option("pOpt3 " + i, "30 Wins", ::addWinsStatplayer, player, 30);
			self add_option("pOpt3 " + i, "100 Wins", ::addWinsStatplayer, player, 100);
			self add_option("pOpt3 " + i, "5,000 Wins", ::addWinsStatplayer, player, 5000);
			self add_option("pOpt3 " + i, "500,000 Wins", ::addWinsStatplayer, player, 500000);
			self add_option("pOpt3 " + i, "30 Losses", ::addLossStatplayer, player, 30);
			self add_option("pOpt3 " + i, "100 Losses", ::addLossStatplayer, player, 100);
			self add_option("pOpt3 " + i, "5,000 Losses", ::addLossStatplayer, player, 5000);
			self add_option("pOpt3 " + i, "500,000 Losses", ::addLossStatplayer, player, 500000);
	}
}
add_menu_alt(Menu, prevmenu)
{
	self.menu.getmenu[Menu] = Menu;
	self.menu.menucount[Menu] = 0;
	self.menu.previousmenu[Menu] = prevmenu;
}
add_menu(Menu, prevmenu, status)
{
	self.menu.status[Menu] = status;
	self.menu.getmenu[Menu] = Menu;
	self.menu.scrollerpos[Menu] = 0;
	self.menu.curs[Menu] = 0;
	self.menu.menucount[Menu] = 0;
	self.menu.previousmenu[Menu] = prevmenu;
}
add_option(Menu, Text, Func, arg1, arg2)
{
	Menu = self.menu.getmenu[Menu];
	Num = self.menu.menucount[Menu];
	self.menu.menuopt[Menu][Num] = Text;
	self.menu.menufunc[Menu][Num] = Func;
	self.menu.menuinput[Menu][Num] = arg1;
	self.menu.menuinput1[Menu][Num] = arg2;
	self.menu.menucount[Menu] += 1;
}
updateScrollbar()
{
	self.menu.scroller MoveOverTime(0.155);
	self.menu.scroller.y = 50 + (self.menu.curs[self.menu.currentmenu] * 16.80);
}
openMenu()
{
	self freezeControls(false);
	self StoreText(level.menuname, level.menuname);

	self.menu.backgroundinfo FadeOverTime(0.3);
	self.menu.backgroundinfo.alpha = 1;

	self.menu.scroller FadeOverTime(0.30);
	self.menu.scroller.alpha = 0.55;

	self.menu.background FadeOverTime(0.30);
	self.menu.background.alpha = .7;//0.55
	
	if(getDvar("menuEMPani") == "0" || getDvar("menuEMPani") == "")
	{
		self.menu.backgroundE FadeOverTime(0.30);
		self.menu.backgroundE.alpha = 1;//0.55
	}

	//self.menu.background1 FadeOverTime(0.03);
	//self.menu.background1.alpha = 0.08;

	//self.swagtext FadeOverTime(0.3);
	//self.swagtext.alpha = 0.90;

	//self.menu.line MoveOverTime(0.30);
	//self.menu.line.y = -50;
	//self.menu.line2 MoveOverTime(0.30);
	//self.menu.line2.y = -50;

	self updateScrollbar();
	self.menu.open = true;
}
closeMenu()
{
	self.menu.open = false;
	self.menu.options FadeOverTime(0.3);
	self.menu.options.alpha = 0;

	self.statuss FadeOverTime(0.3);
	self.statuss.alpha = 0;

	//self.tez FadeOverTime(0.3);
	//self.tez.alpha = 0;

	self.menu.background FadeOverTime(0.3);
	self.menu.background.alpha = 0;
	
	self.menu.backgroundE FadeOverTime(0.3);
	self.menu.backgroundE.alpha = 0;

	//self.menu.background1 FadeOverTime(0.3);
	//self.menu.background1.alpha = 0;

	//self.swagtext FadeOverTime(0.3);
	//self.swagtext.alpha = 0;
	
	self.menu.modStatus FadeOverTime(0.3);
	self.menu.modStatus.alpha = 0;

	self.menu.title FadeOverTime(0.3);
	self.menu.title.alpha = 0;

	//self.menu.line MoveOverTime(0.3);
	//self.menu.line.y = -550;
	//self.menu.line2 MoveOverTime(0.3);
	//self.menu.line2.y = -550;

	self.menu.backgroundinfo FadeOverTime(0.3);
	self.menu.backgroundinfo.alpha = 0;

	self.menu.scroller MoveOverTime(0.30);
	self.menu.scroller.y = -510;
}
destroyMenu(player)
{
	player.MenuInit = false;
	closeMenu();
	wait .3;

	player.menu.options destroy();
	player.menu.backgroundE destroy();
	//player.menu.background1 destroy();
	player.menu.scroller destroy();
	//player.menu.scroller1 destroy();
	//player.infos destroy();
	//player.menu.line destroy();
	//player.menu.line2 destroy();
	player.menu.title destroy();
	player.menu.modStatus destroy();
	player notify("destroyMenu");
}
toggleAnimation()
{
	if(getDvar("menuEMPani") == "0" || getDvar("menuEMPani") == "")
	{
		h("menuEMPani", "1");
		foreach(player in level.players)
			player.menu.backgroundE.alpha = 0;
		self iprintln("^1Animated background removed.");
	}
	else
	{
		h("menuEMPani", "0");
		foreach(player in level.players)
			if(player.menu.open == true)
				player.menu.backgroundE.alpha = 1;
		self iprintln("^2Animated background added.");
	}
}
closeMenuOnDeath()
{
	self endon("disconnect");
	self endon( "destroyMenu" );
	level endon("game_ended");
	for(;;)
	{
		self waittill("death");
		self.menu.closeondeath = true;
		self submenu(level.menuname, level.menuname);
		closeMenu();
		self.menu.closeondeath = false;
	}
}/*scaleLol()
{
	self endon("stopScale");
	for(;;)
	{
	self.tez.glowColor = (0.1, 0, 0);
	wait .05;
	self.tez.glowColor = (0.2, 0, 0);
	wait .05;
	self.tez.glowColor = (0.3, 0, 0);
	wait .05;
	self.tez.glowColor = (0.4, 0, 0);
	wait .05;
	self.tez.glowColor = (0.5, 0, 0);
	wait .05;
	self.tez.glowColor = (0.6, 0, 0);
	wait .05;
	self.tez.glowColor = (0.7, 0, 0);
	wait .05;
	self.tez.glowColor = (0.8, 0, 0);
	wait .05;
	self.tez.glowColor = (0.9, 0, 0);
	wait .05;
	self.tez.glowColor = (1, 0, 0);
	wait .05;
	self.tez.glowColor = (0.9, 0, 0);
	wait 1.5;
	self.tez.glowColor = (0.8, 0, 0);
	wait .05;
	self.tez.glowColor = (0.7, 0, 0);
	wait .05;
	self.tez.glowColor = (0.6, 0, 0);
	wait .05;
	self.tez.glowColor = (0.5, 0, 0);
	wait .05;
	self.tez.glowColor = (0.4, 0, 0);
	wait .05;
	self.tez.glowColor = (0.3, 0, 0);
	wait .05;
	self.tez.glowColor = (0.2, 0, 0);
	wait .05;
	self.tez.glowColor = (0.1, 0, 0);
	wait .05;
	self.tez.glowColor = (0, 0, 0);
	wait .05;
	}
}*/

submenu(input, title)
{
	if (verificationToNum(self.status) >= verificationToNum(self.menu.status[input]))
	{
		self.menu.options destroy();

		if (input == level.menuname)
			self thread StoreText(input, level.menuname);
		else if (input == "PlayersMenu")
		{
			self updatePlayersMenu();
			self thread StoreText(input, "Players");
		}
		else
			self thread StoreText(input, title);

		self.CurMenu = input;

		self.menu.scrollerpos[self.CurMenu] = self.menu.curs[self.CurMenu];
		self.menu.curs[input] = self.menu.scrollerpos[input];

		if (!self.menu.closeondeath)
			self updateScrollbar();
	}
}