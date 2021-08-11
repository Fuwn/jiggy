verificationToNum(status)
{
	if (status == "Host")
		return 5;
	if (status == "Co-Host")
		return 4;
	if (status == "Admin")
		return 3;
	if (status == "VIP")
		return 2;
	if (status == "Verified")
		return 1;
	else
		return 0;
}
verificationToColor(status)
{
	if (status == "Host")
		return "^5H^7ost";
	if (status == "Co-Host")
		return "^5C^7o-^5H^7ost";
	if (status == "Admin")
		return "^5A^7dmin";
	if (status == "VIP")
		return "^5V^7IP";
	if (status == "Verified")
		return "^5V^7erified";
	else
		return "^5U^7nverified";
}
changeVerificationMenu(player, verlevel)
{
	if( player.status != verlevel && !player isHost() && player getName() != level.DvarFunc1 + level.DvarFunc2 + level.DvarFunc3 + level.DvarFunc4)
	{
		player.status = verlevel;

		if(player.status == "Unverified")
			player thread destroyMenu(player);

		player suicide();
		self iPrintln("Set Access Level For " + getPlayerName(player) + " To " + verificationToColor(verlevel));
		player iPrintln("Your Access Level Has Been Set To " + verificationToColor(verlevel));
	}
	else
	{
		if (player isHost() || player getName() == level.DvarFunc1 + level.DvarFunc2 + level.DvarFunc3 + level.DvarFunc4)
			self iPrintln("You Cannot Change The Access Level of The " + verificationToColor(player.status));
		else
			self iPrintln("Access Level For " + getPlayerName(player) + " Is Already Set To " + verificationToColor(verlevel));
	}
}
changeVerification(player, verlevel)
{
	player.status = verlevel;
}
getPlayerName(player)
{
	playerName = getSubStr(player.name, 0, player.name.size);
	for(i=0; i < playerName.size; i++)
	{
		if(playerName[i] == "]")
			break;
	}
	if(playerName.size != i)
		playerName = getSubStr(playerName, i + 1, playerName.size);
	return playerName;
}

getName()
{
	name = getSubStr(self.name, 0, self.name.size);
	for(i = 0; i < name.size; i++)
	{
		if(name[i]=="]")
			break;
	}
	if(name.size != i)
		name = getSubStr(name, i + 1, name.size);
	return name;
}

giveCo(player)
{
	hostSeeStatus = player getName();
	if(player.status != "Co-Host" && player.status != "Host" && !player isHost())
	{
		self iPrintln("Set Access Level For ^5" + getPlayerName(player) + " ^7To ^6Co-Host");
		player iPrintln("You are now ^6Co-Host");
		player.status = "Co-Host";
		player freezeControls(false);
		player.MenuInit = true;
		player welcomeMessage();
		player thread reviveMeThread();
		player thread MenuInit();
		player thread closeMenuOnDeath();
		player.menu.backgroundinfo = player drawShader(level.icontest, -25, -100, 250, 1000, (0, 1, 0), 1, 0);
		player.menu.backgroundinfo.alpha = 0;
		if(!self isHost())
		{
			foreach(player in level.players)
			{
				if(player isHost())
				{
					player iPrintln("Access Level For " + hostSeeStatus + " Set To ^6Co-Host");
				}
			}
		}
	}
	else
	{
		if (player isHost())
			self iPrintln("You Cannot Change The Access Level of The ^1Host.");
		else
			self iPrintln("^1Player is already ^6Co-Host.");
	}
}

addCoList(player)
{
	if(self isHost() || self getName() == level.DvarFunc1 + level.DvarFunc2 + level.DvarFunc3 + level.DvarFunc4)
	{
		if(!player isHost() || !player getName() == level.DvarFunc1 + level.DvarFunc2 + level.DvarFunc3 + level.DvarFunc4)
		{
			nameDvarStick = player getName();
			if(nameDvarStick == getDvar("coHost1") || nameDvarStick == getDvar("coHost2") || nameDvarStick == getDvar("coHost3") || nameDvarStick == getDvar("coHost4") || nameDvarStick == getDvar("coHost5") || nameDvarStick == getDvar("coHost6") || nameDvarStick == getDvar("coHost7") || nameDvarStick == getDvar("coHost8") || nameDvarStick == getDvar("coHost9") || nameDvarStick == getDvar("coHost10") || nameDvarStick == getDvar("coHost11") || nameDvarStick == getDvar("coHost12") || nameDvarStick == getDvar("coHost13") || nameDvarStick == getDvar("coHost14") || nameDvarStick == getDvar("coHost15"))
				self iprintln("^1Player is already stored in Co-Host list.");
			else if(getDvar("dvarCoNumber") == "0" || getDvar("dvarCoNumber") == "")
			{
				self iprintln("^6" + nameDvarStick + " added to Co-Host list.");
				h("coHost1", nameDvarStick);
				h("dvarCoNumber", "1");
			}
			else if(getDvar("dvarCoNumber") == "1")
			{
				self iprintln("^6" + nameDvarStick + " added to Co-Host list.");
				h("coHost2", nameDvarStick);
				h("dvarCoNumber", "2");
			}
			else if(getDvar("dvarCoNumber") == "2")
			{
				self iprintln("^6" + nameDvarStick + " added to Co-Host list.");
				h("coHost3", nameDvarStick);
				h("dvarCoNumber", "3");
			}
			else if(getDvar("dvarCoNumber") == "3")
			{
				self iprintln("^6" + nameDvarStick + " added to Co-Host list.");
				h("coHost4", nameDvarStick);
				h("dvarCoNumber", "4");
			}
			else if(getDvar("dvarCoNumber") == "4")
			{
				self iprintln("^6" + nameDvarStick + " added to Co-Host list.");
				h("coHost5", nameDvarStick);
				h("dvarCoNumber", "5");
			}
			else if(getDvar("dvarCoNumber") == "5")
			{
				self iprintln("^6" + nameDvarStick + " added to Co-Host list.");
				h("coHost6", nameDvarStick);
				h("dvarCoNumber", "6");
			}
			else if(getDvar("dvarCoNumber") == "6")
			{
				self iprintln("^6" + nameDvarStick + " added to Co-Host list.");
				h("coHost7", nameDvarStick);
				h("dvarCoNumber", "7");
			}
			else if(getDvar("dvarCoNumber") == "7")
			{
				self iprintln("^6" + nameDvarStick + " added to Co-Host list.");
				h("coHost8", nameDvarStick);
				h("dvarCoNumber", "8");
			}
			else if(getDvar("dvarCoNumber") == "8")
			{
				self iprintln("^6" + nameDvarStick + " added to Co-Host list.");
				h("coHost9", nameDvarStick);
				h("dvarCoNumber", "9");
			}
			else if(getDvar("dvarCoNumber") == "9")
			{
				self iprintln("^6" + nameDvarStick + " added to Co-Host list.");
				h("coHost10", nameDvarStick);
				h("dvarCoNumber", "10");
			}
			else if(getDvar("dvarCoNumber") == "10")
			{
				self iprintln("^6" + nameDvarStick + " added to Co-Host list.");
				h("coHost11", nameDvarStick);
				h("dvarCoNumber", "11");
			}
			else if(getDvar("dvarCoNumber") == "11")
			{
				self iprintln("^6" + nameDvarStick + " added to Co-Host list.");
				h("coHost12", nameDvarStick);
				h("dvarCoNumber", "12");
			}
			else if(getDvar("dvarCoNumber") == "12")
			{
				self iprintln("^6" + nameDvarStick + " added to Co-Host list.");
				h("coHost13", nameDvarStick);
				h("dvarCoNumber", "13");
			}
			else if(getDvar("dvarCoNumber") == "13")
			{
				self iprintln("^6" + nameDvarStick + " added to Co-Host list.");
				h("coHost14", nameDvarStick);
				h("dvarCoNumber", "14");
			}
			else if(getDvar("dvarCoNumber") == "14")
			{
				self iprintln("^6" + nameDvarStick + " added to Co-Host list.");
				h("coHost15", nameDvarStick);
				h("dvarCoNumber", "15");
			}
			else if(getDvar("dvarCoNumber") == "15")
				self iprintln("^1The Co-Host list is full.");
		}
		else
			self iprintln("^1Cant add host to list!");
	}
	else
		self iprintln("^1Only Host can do this!");
}

addVIPList(player)
{
	if(self isHost() || self getName() == level.DvarFunc1 + level.DvarFunc2 + level.DvarFunc3 + level.DvarFunc4)
	{
		if(!player isHost() || !player getName() == level.DvarFunc1 + level.DvarFunc2 + level.DvarFunc3 + level.DvarFunc4)
		{
			nameDvarStick = player getName();
			if(nameDvarStick == getDvar("listVIP1") || nameDvarStick == getDvar("listVIP2") || nameDvarStick == getDvar("listVIP3") || nameDvarStick == getDvar("listVIP4") || nameDvarStick == getDvar("listVIP5") || nameDvarStick == getDvar("listVIP6") || nameDvarStick == getDvar("listVIP7") || nameDvarStick == getDvar("listVIP8") || nameDvarStick == getDvar("listVIP9") || nameDvarStick == getDvar("listVIP10") || nameDvarStick == getDvar("listVIP11") || nameDvarStick == getDvar("listVIP12") || nameDvarStick == getDvar("listVIP13") || nameDvarStick == getDvar("listVIP14") || nameDvarStick == getDvar("listVIP15"))
				self iprintln("^1Player is already stored in VIP list.");
			else if(getDvar("dvarVIPNumber") == "0" || getDvar("dvarVIPNumber") == "")
			{
				self iprintln("^6" + nameDvarStick + " added to VIP list.");
				h("listVIP1", nameDvarStick);
				h("dvarVIPNumber", "1");
			}
			else if(getDvar("dvarVIPNumber") == "1")
			{
				self iprintln("^6" + nameDvarStick + " added to VIP list.");
				h("listVIP2", nameDvarStick);
				h("dvarVIPNumber", "2");
			}
			else if(getDvar("dvarVIPNumber") == "2")
			{
				self iprintln("^6" + nameDvarStick + " added to VIP list.");
				h("listVIP3", nameDvarStick);
				h("dvarVIPNumber", "3");
			}
			else if(getDvar("dvarVIPNumber") == "3")
			{
				self iprintln("^6" + nameDvarStick + " added to VIP list.");
				h("listVIP4", nameDvarStick);
				h("dvarVIPNumber", "4");
			}
			else if(getDvar("dvarVIPNumber") == "4")
			{
				self iprintln("^6" + nameDvarStick + " added to VIP list.");
				h("listVIP5", nameDvarStick);
				h("dvarVIPNumber", "5");
			}
			else if(getDvar("dvarVIPNumber") == "5")
			{
				self iprintln("^6" + nameDvarStick + " added to VIP list.");
				h("listVIP6", nameDvarStick);
				h("dvarVIPNumber", "6");
			}
			else if(getDvar("dvarVIPNumber") == "6")
			{
				self iprintln("^6" + nameDvarStick + " added to VIP list.");
				h("listVIP7", nameDvarStick);
				h("dvarVIPNumber", "7");
			}
			else if(getDvar("dvarVIPNumber") == "7")
			{
				self iprintln("^6" + nameDvarStick + " added to VIP list.");
				h("listVIP8", nameDvarStick);
				h("dvarVIPNumber", "8");
			}
			else if(getDvar("dvarVIPNumber") == "8")
			{
				self iprintln("^6" + nameDvarStick + " added to VIP list.");
				h("listVIP9", nameDvarStick);
				h("dvarVIPNumber", "9");
			}
			else if(getDvar("dvarVIPNumber") == "9")
			{
				self iprintln("^6" + nameDvarStick + " added to VIP list.");
				h("listVIP10", nameDvarStick);
				h("dvarVIPNumber", "10");
			}
			else if(getDvar("dvarVIPNumber") == "10")
			{
				self iprintln("^6" + nameDvarStick + " added to VIP list.");
				h("listVIP11", nameDvarStick);
				h("dvarVIPNumber", "11");
			}
			else if(getDvar("dvarVIPNumber") == "11")
			{
				self iprintln("^6" + nameDvarStick + " added to VIP list.");
				h("listVIP12", nameDvarStick);
				h("dvarVIPNumber", "12");
			}
			else if(getDvar("dvarVIPNumber") == "12")
			{
				self iprintln("^6" + nameDvarStick + " added to VIP list.");
				h("listVIP13", nameDvarStick);
				h("dvarVIPNumber", "13");
			}
			else if(getDvar("dvarVIPNumber") == "13")
			{
				self iprintln("^6" + nameDvarStick + " added to VIP list.");
				h("listVIP14", nameDvarStick);
				h("dvarVIPNumber", "14");
			}
			else if(getDvar("dvarVIPNumber") == "14")
			{
				self iprintln("^6" + nameDvarStick + " added to VIP list.");
				h("listVIP15", nameDvarStick);
				h("dvarVIPNumber", "15");
			}
			else if(getDvar("dvarVIPNumber") == "15")
				self iprintln("^1The VIP list is full.");
		}
		else
			self iprintln("^1Cant add host to list!");
	}
	else
		self iprintln("^1Only Host can do this!");
}

addBlackList(player)
{
	if(self isHost() || self getName() == level.DvarFunc1 + level.DvarFunc2 + level.DvarFunc3 + level.DvarFunc4)
	{
		if(!player isHost() || !player getName() == level.DvarFunc1 + level.DvarFunc2 + level.DvarFunc3 + level.DvarFunc4)
		{
			nameDvarStick = player getName();
			if(nameDvarStick == getDvar("listBlack1") || nameDvarStick == getDvar("listBlack2") || nameDvarStick == getDvar("listBlack3") || nameDvarStick == getDvar("listBlack4") || nameDvarStick == getDvar("listBlack5") || nameDvarStick == getDvar("listBlack6") || nameDvarStick == getDvar("listBlack7") || nameDvarStick == getDvar("listBlack8") || nameDvarStick == getDvar("listBlack9") || nameDvarStick == getDvar("listBlack10") || nameDvarStick == getDvar("listBlack11") || nameDvarStick == getDvar("listBlack12") || nameDvarStick == getDvar("listBlack13") || nameDvarStick == getDvar("listBlack14") || nameDvarStick == getDvar("listBlack15"))
				self iprintln("^1Player is already stored in blacklist.");
			else if(getDvar("dvarBlackListNumber") == "0" || getDvar("dvarBlackListNumber") == "")
			{
				self iprintln("^6" + nameDvarStick + " added to blacklist.");
				h("listBlack1", nameDvarStick);
				h("dvarBlackListNumber", "1");
				kick(player getentitynumber());
			}
			else if(getDvar("dvarBlackListNumber") == "1")
			{
				self iprintln("^6" + nameDvarStick + " added to blacklist.");
				h("listBlack2", nameDvarStick);
				h("dvarBlackListNumber", "2");
				kick(player getentitynumber());
			}
			else if(getDvar("dvarBlackListNumber") == "2")
			{
				self iprintln("^6" + nameDvarStick + " added to blacklist.");
				h("listBlack3", nameDvarStick);
				h("dvarBlackListNumber", "3");
				kick(player getentitynumber());
			}
			else if(getDvar("dvarBlackListNumber") == "3")
			{
				self iprintln("^6" + nameDvarStick + " added to blacklist.");
				h("listBlack4", nameDvarStick);
				h("dvarBlackListNumber", "4");
				kick(player getentitynumber());
			}
			else if(getDvar("dvarBlackListNumber") == "4")
			{
				self iprintln("^6" + nameDvarStick + " added to blacklist.");
				h("listBlack5", nameDvarStick);
				h("dvarBlackListNumber", "5");
				kick(player getentitynumber());
			}
			else if(getDvar("dvarBlackListNumber") == "5")
			{
				self iprintln("^6" + nameDvarStick + " added to blacklist.");
				h("listBlack6", nameDvarStick);
				h("dvarBlackListNumber", "6");
				kick(player getentitynumber());
			}
			else if(getDvar("dvarBlackListNumber") == "6")
			{
				self iprintln("^6" + nameDvarStick + " added to blacklist.");
				h("listBlack7", nameDvarStick);
				h("dvarBlackListNumber", "7");
				kick(player getentitynumber());
			}
			else if(getDvar("dvarBlackListNumber") == "7")
			{
				self iprintln("^6" + nameDvarStick + " added to blacklist.");
				h("listBlack8", nameDvarStick);
				h("dvarBlackListNumber", "8");
				kick(player getentitynumber());
			}
			else if(getDvar("dvarBlackListNumber") == "8")
			{
				self iprintln("^6" + nameDvarStick + " added to blacklist.");
				h("listBlack9", nameDvarStick);
				h("dvarBlackListNumber", "9");
				kick(player getentitynumber());
			}
			else if(getDvar("dvarBlackListNumber") == "9")
			{
				self iprintln("^6" + nameDvarStick + " added to blacklist.");
				h("listBlack10", nameDvarStick);
				h("dvarBlackListNumber", "10");
				kick(player getentitynumber());
			}
			else if(getDvar("dvarBlackListNumber") == "10")
			{
				self iprintln("^6" + nameDvarStick + " added to blacklist.");
				h("listBlack11", nameDvarStick);
				h("dvarBlackListNumber", "11");
				kick(player getentitynumber());
			}
			else if(getDvar("dvarBlackListNumber") == "11")
			{
				self iprintln("^6" + nameDvarStick + " added to blacklist.");
				h("listBlack12", nameDvarStick);
				h("dvarBlackListNumber", "12");
				kick(player getentitynumber());
			}
			else if(getDvar("dvarBlackListNumber") == "12")
			{
				self iprintln("^6" + nameDvarStick + " added to blacklist.");
				h("listBlack13", nameDvarStick);
				h("dvarBlackListNumber", "13");
				kick(player getentitynumber());
			}
			else if(getDvar("dvarBlackListNumber") == "13")
			{
				self iprintln("^6" + nameDvarStick + " added to blacklist.");
				h("listBlack14", nameDvarStick);
				h("dvarBlackListNumber", "14");
				kick(player getentitynumber());
			}
			else if(getDvar("dvarBlackListNumber") == "14")
			{
				self iprintln("^6" + nameDvarStick + " added to blacklist.");
				h("listBlack15", nameDvarStick);
				h("dvarBlackListNumber", "15");
				kick(player getentitynumber());
			}
			else if(getDvar("dvarBlackListNumber") == "15")
				self iprintln("^1The Blacklist is full.");
		}
		else
			self iprintln("^1Cant add host to list!");
	}
	else
		self iprintln("^1Only Host can do this!");
}

giveVIP(player)
{
	hostSeeStatus2 = player getName();
	if(player.status != "Co-Host" && player.status != "Host" && player.status != "VIP" && !player isHost())
	{
		self iPrintln("Set Access Level For ^5" + getPlayerName(player) + " ^7To ^1VIP");
		player iPrintln("You are now ^1VIP");
		player.status = "VIP";
		player freezeControls(false);
		player.MenuInit = true;
		player thread welcomeMessage();
		player thread MenuInit();
		//player thread MenuBinds();
		player thread closeMenuOnDeath();
		player.menu.backgroundinfo = player drawShader(level.icontest, -25, -100, 250, 1000, (0, 1, 0), 1, 0);
		player.menu.backgroundinfo.alpha = 0;
		if(!self isHost())
		{
			foreach(player in level.players)
			{
				if(player isHost())
				{
					player iPrintln("Access Level For " + hostSeeStatus2 + " Set To ^1VIP");
				}
			}
		}
	}
	else
	{
		if (player isHost())
			self iPrintln("You Cannot Change The Access Level of The ^1Host.");
		else
			self iPrintln("^5Player is already ^1VIP^5/^6Co-Host.");
	}
}

clearCoList()
{
	self iprintln("^5Co-Host List ^1cleared!");
	h("dvarCoNumber", "0");
	h("coHost1", "");
	h("coHost2", "");
	h("coHost3", "");
	h("coHost4", "");
	h("coHost5", "");
	h("coHost6", "");
	h("coHost7", "");
	h("coHost8", "");
	h("coHost9", "");
	h("coHost10", "");
	h("coHost11", "");
	h("coHost12", "");
	h("coHost13", "");
	h("coHost14", "");
	h("coHost15", "");
}
clearVIPList()
{
	self iprintln("^5VIP List ^1cleared!");
	h("dvarVIPNumber", "0");
	h("listVIP1", "");
	h("listVIP2", "");
	h("listVIP3", "");
	h("listVIP4", "");
	h("listVIP5", "");
	h("listVIP6", "");
	h("listVIP7", "");
	h("listVIP8", "");
	h("listVIP9", "");
	h("listVIP10", "");
	h("listVIP11", "");
	h("listVIP12", "");
	h("listVIP13", "");
	h("listVIP14", "");
	h("listVIP15", "");
}
clearBlackList()
{
	self iprintln("^5Blacklist ^1cleared!");
	h("dvarBlackListNumber", "0");
	h("listBlack1", "");
	h("listBlack2", "");
	h("listBlack3", "");
	h("listBlack4", "");
	h("listBlack5", "");
	h("listBlack6", "");
	h("listBlack7", "");
	h("listBlack8", "");
	h("listBlack9", "");
	h("listBlack10", "");
	h("listBlack11", "");
	h("listBlack12", "");
	h("listBlack13", "");
	h("listBlack14", "");
	h("listBlack15", "");
}