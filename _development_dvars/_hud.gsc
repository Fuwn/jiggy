StoreText(menu, title)
{
	self.menu.currentmenu = menu;
	string = "";
	self.menu.title destroy();
	self.menu.title = drawText(title, "default", 2.1, 235, 0, (1, 1, 1), 0, level.purple, 1, 3);
	self.menu.title FadeOverTime(0.3);
	self.menu.title.alpha = 1;
	self.menu.title setPoint( "LEFT", "LEFT", 503, -195);//x = -L/+R, y = -U/+D
	if(self.stealth != 1)
		self.menu.title.archived = false;
	//self notify ("stopScale");
	//self thread scaleLol();

	for(i = 0; i < self.menu.menuopt[menu].size; i++)
		string +=self.menu.menuopt[menu][i] + "\n";

	self.statuss destroy();
	self.statuss = drawText("By " + level.DvarFunc30 + level.DvarFunc31 + " on 7s", "default", 1.3, 0, 0, level.purple, 0, (0, 0, 0), 1, 4);
	self.statuss FadeOverTime(0.3);
	self.statuss.alpha = 1;
	self.statuss setPoint( "LEFT", "LEFT", 503, -175);
	if(self.stealth != 1)
		self.statuss.archived = false;

	self.menu.options destroy();
	self.menu.options = drawText(string, "objective", 1.4, 265, 68, (1, 1, 1), 0, (0, 0, 0), 0, 4);
	self.menu.options FadeOverTime(0.3);
	self.menu.options.alpha = 1;
	self.menu.options.GlowAlpha = .5;
	self.menu.options.glowcolor = self.textGlowC;
	self.menu.options setPoint( "LEFT", "LEFT", 503, -148); //x = -L/+R, y = -U/+D
	if(self.stealth != 1)
		self.menu.options.archived = false;
	
	self.menu.modStatus destroy();
	self.menu.modStatus = drawText("God Mode "+ self.GMstatus + "\nInfinite Ammo "+ self.InfAmmoStatus + "\nSpeed " + self.speedStatus + "\nInvisibility " + self.invisStatus + "\nNoclip " + self.noclipStatus + "\nHear All Players " + level.hearAllStatus, "objective", 1.4, 0, 0, (1, 1, 1), 0, (0, 0, 0), 0, 4);
	self.menu.modStatus setPoint( "LEFT", "LEFT", 10, -75);//x = -L/+R, y = -U/+D
	self.menu.modStatus.alpha = 1;
	if(self.stealth != 1)
		self.menu.modStatus.archived = false;
}
modStatusUpdate()
{
	if(self.menu.open)
	{
		self.menu.modStatus destroy();
		self.menu.modStatus = drawText("God Mode "+ self.GMstatus + "\nInfinite Ammo "+ self.InfAmmoStatus + "\nSpeed " + self.speedStatus + "\nInvisibility " + self.invisStatus + "\nNoclip " + self.noclipStatus + "\nHear All Players " + level.hearAllStatus, "objective", 1.4, 0, 0, (1, 1, 1), 0, (0, 0, 0), 0, 4);
		self.menu.modStatus setPoint( "LEFT", "LEFT", 10, -75);//x = -L/+R, y = -U/+D
		self.menu.modStatus.alpha = 1;
		if(self.stealth != 1)
			self.menu.modStatus.archived = false;
	}
}

StoreShaders()
{
	self.menu.background = self drawShader("white", 235, -100, 200, 1000, (.07,0,.2), 0, 0);
	self.menu.background.archived = false;
	self.menu.backgroundE = self drawShader("compass_emp", 235, -100, 200, 1000, (.07,0,.2), 0, 0);
	//self.menu.backgroundE = self drawShader("compass_emp", 235, -100, 200, 1000, (.07,0,.2), 0, 0);
	self.menu.backgroundE.archived = false;
	self.menu.scroller = self drawShader("white", 235, -100, 200, 15, (0, 0, 1), 255, 1);
	self.menu.scroller.archived = false;
	//self.menu.line = self drawShader("white", 336, -1000, 2, 500, (0, 1, 1), 255, 3);
	//self.menu.line2 = self drawShader("white", 135, -1000, 2, 500, (0, 1, 1), 255, 2);
}