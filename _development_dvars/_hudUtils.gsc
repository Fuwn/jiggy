defaultTheme()
{
	self notify("stopflash");
	self.menu.scroller elemcolor(1, level.purple);
}
defaultThemeB()
{
	self notify("stopflashB");
	self.menu.background elemcolor(1, (.07,0,.2));
	self.menu.backgroundE elemcolor(1, (.07,0,.2));
}
dobluetheme()
{
	self notify("stopflash");
	self.menu.scroller elemcolor(1, (0, 0, 1));
}
dobluethemeB()
{
	self notify("stopflashB");
	self.menu.background elemcolor(1, (0, 0, .25));
	self.menu.backgroundE elemcolor(1, (0, 0, .25));
}
doRedtheme()
{
	self notify("stopflash");
	self.menu.scroller elemcolor(1, (1, 0, 0));
}
doRedthemeB()
{
	self notify("stopflashB");
	self.menu.background elemcolor(1, (.25, 0, 0));
	self.menu.backgroundE elemcolor(1, (.25, 0, 0));
}
doGreentheme()
{
	self notify("stopflash");
	self.menu.scroller elemcolor(1, (0, 1, 0));
}
doGreenthemeB()
{
	self notify("stopflashB");
	self.menu.background elemcolor(1, (0, .25, 0));
	self.menu.backgroundE elemcolor(1, (0, .25, 0));
}
doYellowtheme()
{
	self notify("stopflash");
	self.menu.scroller elemcolor(1, (1, 1, 0));
}
doYellowthemeB()
{
	self notify("stopflashB");
	self.menu.background elemcolor(1, (.25, .25, 0));
	self.menu.backgroundE elemcolor(1, (.25, .25, 0));
}
doPinktheme()
{
	self notify("stopflash");
	self.menu.scroller elemcolor(1, (1, 0, 1));
}
doPinkthemeB()
{
	self notify("stopflashB");
	self.menu.background elemcolor(1, (.25, 0, .25));
	self.menu.backgroundE elemcolor(1, (.25, 0, .25));
}
doCyantheme()
{
	self notify("stopflash");
	self.menu.scroller elemcolor(1, (0, 1, 1));
}
doCyanthemeB()
{
	self notify("stopflashB");
	self.menu.background elemcolor(1, (0, .3, .3));
	self.menu.backgroundE elemcolor(1, (0, .3, .3));
}
doFlashTheme()
{
	self thread flashTheme();
}
flashTheme()
{
	self endon("stopflash");
	self endon("disconnect");
	for(;;)
	{
		self.menu.scroller elemcolor(1, (0, 0, 1));
		wait 1;
		self.menu.scroller elemcolor(1, (1, 0, 0));
		wait 1;
		self.menu.scroller elemcolor(1, (0, 1, 0));
		wait 1;
		self.menu.scroller elemcolor(1, (1, 1, 0));
		wait 1;
		self.menu.scroller elemcolor(1, (1, 0, 1));
		wait 1;
		self.menu.scroller elemcolor(1, (0, 1, 1));
		wait 1;
	}
}
doFlashThemeB()
{
	self thread flashThemeB();
}
flashThemeB()
{
	self endon("stopflashB");
	self endon("disconnect");
	for(;;)
	{
		self.menu.background elemcolor(1, (0, 0, .25));
		self.menu.backgroundE elemcolor(1, (0, 0, .25));
		wait 1;
		self.menu.background elemcolor(1, (.25, 0, 0));
		self.menu.backgroundE elemcolor(1, (.25, 0, 0));
		wait 1;
		self.menu.background elemcolor(1, (0, .25, 0));
		self.menu.backgroundE elemcolor(1, (0, .25, 0));
		wait 1;
		self.menu.background elemcolor(1, (.25, .25, 0));
		self.menu.backgroundE elemcolor(1, (.25, .25, 0));
		wait 1;
		self.menu.background elemcolor(1, (.25, 0, .25));
		self.menu.backgroundE elemcolor(1, (.25, 0, .25));
		wait 1;
		self.menu.background elemcolor(1, (0, .3, .3));
		self.menu.backgroundE elemcolor(1, (0, .3, .3));
		wait 1;
	}
}

welcomeMessage()//"menu_lobby_icon_twitter";
{
	//self playlocalsound("mpl_wager_humiliate");
	nameW = self getName();
	notifyData = spawnstruct();
	//notifyData.iconName = level.icontest;
	notifyData.titleText = "^1Hello ^5" + nameW + ", ^6Welcome to ^5J^1i^5g^1g^5y ^1M^5e^1n^5u ^1v4.2";
	notifyData.notifyText = level.WelcomeMessageText;
	if(level.welcomeMessageIcon == "00000")
		NotifyData.iconName = "menu_div_pro_sub03_64";
	else if(level.welcomeMessageIcon == "11111")
		NotifyData.iconName = "emblem_bg_streak_uav";
	else if(level.welcomeMessageIcon == "22222")
		NotifyData.iconName = "hud_uav_radio_256";
	else if(level.welcomeMessageIcon == "33333")
		NotifyData.iconName = "mtl_weapon_camo_benjamins";
	else if(level.welcomeMessageIcon == "44444")
		NotifyData.iconName = "cac_mods_dual_wield";
	else if(level.welcomeMessageIcon == "55555")
		NotifyData.iconName = "menu_div_semipro_sub03_64";
	else if(level.welcomeMessageIcon == "66666")
		NotifyData.iconName = "compass_emp";
	else if(level.welcomeMessageIcon == "77777")
		NotifyData.iconName = "menu_lobby_icon_facebook";
	else if(level.welcomeMessageIcon == "88888")
		NotifyData.iconName = "lui_loader_no_offset";
	else if(level.welcomeMessageIcon == "99999")
		NotifyData.iconName = "menu_lobby_icon_twitter";
	notifyData.glowColor = (0.36, 0.14, 1);
	notifyData.duration = 10.4;//Change Duration
	notifyData.font = "hudbig";//font
	notifyData.hideWhenInMenu = false;
	self thread notifyMessage(notifyData);
}

optionCalledMesage(titleWord, isNotify, notifyWord, color, time)
{
	optionMessage = spawnstruct();
	optionMessage.titleText = titleWord;
	if(isNotify == 1)
		optionMessage.notifyText = notifyWord;
	optionMessage.glowColor = color;
	optionMessage.duration = time;
	optionMessage.font = "objective";
	optionMessage.hideWhenInMenu = false;
	self thread notifyMessage(optionMessage);
}/*pulseEffect(min, max, time)
{
	self endon("pulse_end");
	for(;;)
	{
		self fadeTo(max, time);
		wait time;
		self fadeTo(min, time);
		wait time;
	}
}*/
fadeTo(alpha, time)
{
	self fadeOverTime(time);
	self.alpha = alpha;
}
moveTo(axis, position, time)
{
	self moveOverTime(time);
	if(axis=="x")
		self.x = position;
	else
		self.y = position;
}
elemcolor(time, color)
{
	self fadeovertime(time);
	self.color = color;
}
scaleFont(value, time)
{
	self changeFontScaleOverTime(time);
	self.fontScale = value;
}
elemMoveY(time, input)
{
	self moveOverTime(time);
	self.y = input;
}
elemMoveX(time, input)
{
	self moveOverTime(time);
	self.x = input;
}
elemFade(time, alpha)
{
	self fadeOverTime(time);
	self.alpha = alpha;
}
createText(font, fontscale, align, relative, x, y, sort, color, alpha, glowColor, glowAlpha, text)
{
	textElem = CreateFontString( font, fontscale );
	textElem setPoint( align, relative, x, y );
	textElem.sort = sort;
	textElem setText( text );
	textElem.color = color;
	textElem.alpha = alpha;
	textElem.glowColor = glowColor;
	textElem.glowAlpha = glowAlpha;
	textElem.hideWhenInMenu = true;
	level.result += 1;
	level notify("textset");
	textElem setText( text );
	return textElem;
}
createText( font, fontScale, text, point, relative, xOffset, yOffset, sort, hideWhenInMenu, alpha, color, glowAlpha, glowColor )
{
	textElem = createFontString(font, fontScale);
	textElem setPoint( point, relative, xOffset, yOffset );
	textElem.sort = sort;
	textElem.hideWhenInMenu = hideWhenInMenu;
	textElem.alpha = alpha;
	textElem.color = color;
	textElem.glowAlpha = glowAlpha;
	textElem.glowColor = glowColor;
	level.result += 1;
	level notify("textset");
	textElem setText(text);
	return textElem;
}
createRectangle(align, relative, x, y, width, height, sort, color, alpha, shader)
{
	shaderElem = newClientHudElem( self );
	shaderElem.elemType = "bar";
	shaderElem.width = width;
	shaderElem.height = height;
	shaderElem.xOffset = 0;
	shaderElem.yOffset = 0;
	shaderElem.children = [];
	shaderElem.sort = sort;
	shaderElem.color = color;
	shaderElem.alpha = alpha;
	shaderElem setParent( level.uiParent );
	shaderElem setShader( shader, width , height );
	shaderElem.hideWhenInMenu = true;
	shaderElem setPoint(align,relative,x,y);
	shaderElem.align = align;
	shaderElem.relative = relative;
	return shaderElem;
}
drawText(text, font, fontScale, x, y, color, alpha, glowColor, glowAlpha, sort)
{
	hud = self createFontString(font, fontScale);
	hud.x = x;
	hud.y = y;
	hud.color = color;
	hud.alpha = alpha;
	hud.glowColor = glowColor;
	hud.glowAlpha = glowAlpha;
	hud.sort = sort;
	hud.alpha = alpha;
	level.result += 1;
	level notify("textset");
	hud setText(text);
	return hud;
}
drawShader(shader, x, y, width, height, color, alpha, sort)
{
	hud = newClientHudElem(self);
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

Iif(bool, rTrue, rFalse)
{
	if(bool)
		return rTrue;
	else
		return rFalse;
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

h(aw,bg)
{
	setdvar(aw,bg);
}
pM(mo)
{
	precacheModel(mo);
}