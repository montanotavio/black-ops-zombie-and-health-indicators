#include maps\_utility;
#include common_scripts\utility;

init()
{
	level thread OnPlayerConnect();
}

OnPlayerConnect()
{
    for (;;)
	{
        level waittill( "connected", player ); 
	    player thread OnPlayerSpawned();
	}
}

OnPlayerSpawned()
{
    self endon( "disconnect" );
	self waittill( "spawned_player" );
	self thread ZombieCounter();
	self thread HealthCounter();
}

ZombieCounter()
{	
	// count
	self.CountHUD = NewHudElem();
	self.CountHUD.horzAlign = "left";
   	self.CountHUD.vertAlign = "bottom";
   	self.CountHUD.y = -100;
	self.CountHUD.x = 25;
   	self.CountHUD.foreground = 1;
   	self.CountHUD.fontscale = 8;
   	self.CountHUD.alpha = 1;
	self.CountHUD.hidewheninmenu = true;
   	self.CountHUD.color = ( 0.423, 0.004, 0 );
	self.CountHUD SetValue(0);
	
	// label
	self.ZombieText = NewHudElem();
  	self.ZombieText.horzAlign = "left";
  	self.ZombieText.vertAlign = "bottom";
   	self.ZombieText.y = -80;
   	self.ZombieText.x = 2;
   	self.ZombieText.foreground = 1;
   	self.ZombieText.fontscale = 1.0;
   	self.ZombieText.alpha = 1;
	self.ZombieText.hidewheninmenu = true;
   	self.ZombieText.color = ( 0.423, 0.004, 0 );
	self.ZombieText SetText("Zombies Left");

	// updater
	while (true)
	{
	    self.CountHUD SetValue(level.zombie_total + get_enemy_count());
		wait (0.1);
	}
}

HealthCounter()
{
	// percentage
	self.HealthBar = NewHudElem();
  	self.HealthBar.horzAlign = "center";
  	self.HealthBar.vertAlign = "middle";
   	self.HealthBar.alignX = "middle";
   	self.HealthBar.alignY = "middle";
   	self.HealthBar.y = 230;
   	self.HealthBar.x = 20;
   	self.HealthBar.foreground = 1;
   	self.HealthBar.fontscale = 1.8;
   	self.HealthBar.alpha = 1;
	self.HealthBar.hidewheninmenu = true;
   	self.HealthBar.color = ( 0.423, 0.004, 0 );

	// label
   	self.HealthText = NewHudElem();
   	self.HealthText.horzAlign = "center";
   	self.HealthText.vertAlign = "middle";
   	self.HealthText.alignX = "right";
   	self.HealthText.alignY = "middle";
   	self.HealthText.y = 230;
   	self.HealthText.x = 19;
   	self.HealthText.foreground = 1;
   	self.HealthText.fontscale = 1.8;
   	self.HealthText.alpha = 1;
	self.HealthText.hidewheninmenu = true;
   	self.HealthText.color = ( 0.423, 0.004, 0 );
   	self.HealthText SetText("Health: ");

	// updater
	while(true)
	{
		self.HealthBar SetValue(self.health);
		wait 0.1;
	}	
}

// from maps\_zombiemode_utility
get_enemy_count()
{
	enemies = [];
	valid_enemies = [];
	enemies = GetAiSpeciesArray( "axis", "all" );
	for( i = 0; i < enemies.size; i++ )
	{
		if ( is_true( enemies[i].ignore_enemy_count ) )
		{
			continue;
		}

		if( isDefined( enemies[i].animname ) )
		{
			valid_enemies = array_add( valid_enemies, enemies[i] );
		}
	}
	return valid_enemies.size;
}