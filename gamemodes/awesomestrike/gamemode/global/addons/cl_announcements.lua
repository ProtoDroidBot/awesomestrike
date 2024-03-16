if SERVER then
	AddCSLuaFile(NDB_ADDON_NAME)
	return
end

local conNewOnly = CreateClientConVar("nox_announcements_newonly", "1", true, false)
local conCurrentCRC = CreateClientConVar("nox_announcements_lastcrc", "0", true, false)

local tabUpdates = {
{Posted = "August 12, 2009", Title = "Publish 254", Content=[[This publish fixes a lot of issues. Balancing and bugs.

-= NoXiousNet Core / DB =-
* Donations are stored in the public logs.
* Fixed the default HL2 chat box showing up until you chat once.
* Fixed the cone hat not working properly with custom Lua animations.
* Fixed the Flaming Skull hat showing flames if you were invisible (Wraith in ZS, Assassin and Invisibility in TP).
* Fixed an exploit with blah and other kill words where you could use it to reach higher ground by using it while under another player.
* Fixed reserved slots.

-= Zombie Survival =-
* Wraiths now freeze (in mid-air if need be) during their attack and resume physics after it.
* Wraiths now have their own death effect. They no longer create ragdolls or gibs.
* Zombie gasses no longer have that bright sprite indicating their exact position.
* Zombie gasses heal for 25 per 1.5 seconds instead of 20 per 1.5 seconds.
* Fixed redeeming or changing classes as a Wraith and remaining invisible.
* Fixed the view model for the wraith remaining invisible if you were attacking.
* Fixed the class selection menu not updating properly if you opened it once before.
* Fixed a bug where if you were second winded and then gibbed you couldn't change your class until the next time you get a second wind.

-= NoXious Beta =-
* Fixed a possible memory overflow with the client-side of vehicles.
* Jump power is severely reduced while you have no stamina.
* Fixed health bars displaying outside of the bounding box.
* Health bars of friendly players now display a numerical value of both current and maximum health. Enemy players have a bar with no numbers.
* Reduced the time to get up from knockdown from 0.5 to 0.3 seconds.
* Vehicles now use the new health bars. Enemy players can now guess vehicle health with the bar. Subject to changing.
* Vehicle acquirement timers are now reset after intermission.
* Increased the distance in which you can view vehicle information (health and name) from 1,500 inches to 2,048 inches.
* The collisions on flying vehicles have been standardized and recoded. Collisions are more forgiving, mostly at low speeds.
* Fixed being able to wall vert up things smaller than your step size.
* Fixed wall verting not rotating the player model.


- JetBoom, head administrator (jetboom@yahoo.com)]]},

{Posted = "July 28, 2009", Title = "Publish 253", Content=[[Cool publish, bro.

-= NoXiousNet Core / DB =-
* Added an option to the chat box to enable message time stamps.
* Fixed an exploit that allowed people to create "not enough memory" errors.

-= Zombie Survival =-
* Humans now play the walking animation when walking backwards instead of the running animation really slowly.
* Auras now become red with a bit lower health.
* Redid the options menu to look nicer.
* Fixed a small bug where if you went in zombie gasses your brightness would stay slightly higher.
* Doubled the Sweeper Shotgun clip from 3 to 6.
* Added a ton of Hammer entities, inputs, and outputs for map makers. It makes it especially easy to create maps based around objectives. You can create conditions for winning and losing, control waves and the timers, and even determine how weapons are distributed. For example you can create an armory of shotguns that opens with a key or spread weapons around the spawn area where you can only pick up 1 gun.

-= NoXious Beta =-
* Removed the portal effect from flag scores. Will be replaced with a non-laggy one later.


- JetBoom, head administrator (jetboom@yahoo.com)]]},

{Posted = "July 25, 2009", Title = "Emote Skits event and Publish 252", Content=[[July 28 at 5PM EST we will be holding the Emote Skits contest in the SandBox. Read the news section at www.noxiousnet.com for more information. The prize for this event is the unique Voice Changer item so be sure to try it!

By the way here's a publish.

-= NoXiousNet Core / DB =-
* Maps can now have a minimum player requirement. For example, you wouldn't be able to vote for Forts of Madness unless you have 12 people in the game.
* Fixed the server saying you only have 1 second left on your ban if you join while banned.

-= NoXious Beta =-
* Buildings now start to slowly build themselves after the first builder hit. You can then use this time to place another prop ghost. They will stop building themselves for a second if they are hit by an enemy attack or half a second if hit by a friendly building laser. The rate is 4 HP per second. A person can only have 2,500 HP worth of buildings being constructed at the same time. This goes up with your Craftsmanship aspect.
* Pressing shift while firing the physgun will no longer make you sprint.
* Possible fix for lagging out when opening the builder menu.


- JetBoom, head administrator (jetboom@yahoo.com)]]},

{Posted = "July 24, 2009", Title = "Publish 251", Content=[[The map tagging system has been added in this publish!

-= NoXious Core / DB =-
* Added the map tagging system. This is an expanded version of the rating system that lets you tag maps with specific ideas instead of just 'good' or 'bad'. Gamemodes have their own tags in addition to the generic ones.
* Emotes can now have callbacks. For example, the *spit* emote creates water particles from your mouth instead of just playing a sound.

-= Zombie Survival =-
* Fixed a bug where zombies that had angle correction on would glitch in to props and physics doors or start to 'glide'.
* Added a new scoreboard.

-= NoXious Team Play Beta =-
* The effect of Mana Burn is now 300%.
* Fixed a lag issue with the Heal spells and Flame Strike spell.
* Avenger clip has been increased from 6 to 7.
* Avenger now slightly knocks back targets.
* Avenger damage increased from 21 to 22.
* Avenger delay slightly reduced.
* Nailer damage increased from 50 to 60.
* Nailer bullet speed increased from 3,000 to 4,000.
* People carrying a flag can't use teleport pads.


- JetBoom, head administrator (jetboom@yahoo.com)]]},

{Posted="July 20, 2009", Title = "Publish 250", Content=[[This update gives NoXious a new weapon and several improvements. Retro Team Play will be glad to know that four previously disabled classes have returned!

-= NoXiousNet Core / DB =-

* Special titles now drop properly when you don't qualify anymore.
* Truncated a few titles. For example, Zombie Survival Champion is just ZS Champion.
* The requirements for ZS Champion have been changed from having both Human 1st and Zombie 1st to having a 10% survival rate and at least 80 games played.
* The requirements for Survivor have been lowered from a 10% survival rate to a 6% survival rate.
* Added 3 emotes.
* Fixed an occasional bug where hats and other status effects wouldn't appear on a client due to prediction errors.

-= Zombie Survival =-

* Fixed an exploit that allowed you to kill yourself with a barrel and then kill nearby former teammates with a different barrel that was ignited by the first barrel.

-= Retro Team Play =-

* Re-added Initiate, Keeper, Juggernaut, and Dreadnaut.
* Juggernaut, Dreadnaut, and Zombie can no longer pilot vehicles.
* Crafter now has a pistol.

-= NoXious Beta =-

* Added Wall Verting (running up a wall). Costs a lot of stamina and 100 Dexterity.
* Increased the round duration by 5 minutes.
* Added Lua animations prototype. This system allows you to create custom animations using nothing but Lua and the default engine bindings.
* The Zagger is the first to have this system: your character will hold the gun on the side in the world view during the secondary fire.
* Staffs now have a custom animation when a spell is loaded.
* Reduced some Dexterity requirements for the above change.
* Added weapon: Avenger. This high-powered pistol is perfect for gun buffs and builders on the move. It features a secondary attack that aims perfectly at the cost of delay and even comes with a custom holding animation!
* Fixed a bug where if you enabled the No HUD option then ammo count would still display.
* Fixed a bug in CTF where your stamina would continue to drop if you were carrying a flag and another team scored.
* Buildings are no longer destructible during intermission (after scoring).


- JetBoom, head administrator (jetboom@yahoo.com)]]},

{Posted="June 30, 2009", Title="Publish 249", Content=[[This update has a lot of changes for the new NoXious gamemode. Enjoy!

NoXiousNet Core / DB

* Added a new, replacement shop menu. This one has categories, looks a lot neater, and should respond better.
* Silver display is comma-separated in a lot of areas now ("1,000,000 Silver" instead of "1000000 Silver").
* Fixed timers sometimes getting an error and making all future timers not work.
* Fixed seeing a knife in your view or another person's hands.
* Disabled votekick / voteban in RP.

Retro TeamPlay

* Fixed weapon models displaying on people who were invisible.

NoXious Beta

* Force Field now lasts for 25 seconds.
* Protect from * spells now reduce damage by 60% instead of 40%.
* Fixed the exploit where flags would stick to a person after another team scored in multiple team CTF.
* Reduced the mana cost of Anchor from 40 to 15.
* Reduced the mana cost of Slow from 20 to 15.
* Ammo count display is now scaled by your screen size.
* Enabled all options for setting the position of HUD elements such as the health bar, ammo display, spell icons, etc.
* Enabled the Force Field opacity option.
* Enabled the particle density option (formally "effect quality").
* Enabled the Run spell. It forces anyone hit to run forward for 5 seconds.
* Enabled the Mana Burn spell. Anyone hit will have their Mana regeneration rate inverted for 5 seconds. Much more effective against people with high Mana regeneration.
* Enabled the Flash spell. This is a projectile that temporarily blinds anyone near the explosion. There's a time bonus depending on how directly they're looking at the flash.
* Enabled the Flame Strike spell. This spell shoots a fire ball that ignites anyone it hits for a time dependent on how much damage the blast did to them.
* Flare now uses the old Fire Bullet spell icon.
* Sparkler now has its own spell icon.
* Added an effect for when a person scores.
* Added profile templates for new players.


- JetBoom, head administrator (jetboom@yahoo.com)]]},

{Posted="June 16, 2009", Title="Publish 248", Content=[[Here's a big update. By the way, if you're reading this then you're above the average GMod player's intelligence!

-= NoXiousNet Core / DB =-

* Added donations button to chat box
* Added an in-game rules page and a button to it in the chat box. Vote kick and vote ban will warn you that you'll get yourself banned if you abuse it and it'll give you a button to go to the rules page.
* News is now completely optional. If there is new announcements then a blinking button will appear in your chat box.
* Fixed being able to click the chat box when it's invisible. Fixes Mario Boxes aiming.
* Added automatic donation handling. The website will handle all donations now. Simply put in your SteamID or let it automatically detect it, select what you want and pay with PayPal. As soon as the payment is cleared (pretty much instant unless it's a pending e-check) the stuff will be in-game.
* Reduced script load times of all gamemodes.
* Gold and Diamonds can't be banned more than 48 hours if the ban is added through the ban list UNLESS the ban is permanent.
* Gold and Diamonds that aren't on the server but are banned via in-game admin can't be banned more than 48 hours UNLESS the ban is permanent.
* Fixed maintenance warnings not showing up when the server is about to go down for daily maintenance.

-= NoXious Beta =-

* Added Short Fortress Wall.
* Added Short Fortress Gate.
* Added Long Fortress Gate.
* Added ammo display to the middle of the screen under the cross-hair for weapons that use ammo. It's both numeric and graphical.
* The stamina bar now glows while sprinting or wall running.
* Added air particle post-process effect when traveling fast in a vehicle.
* Offensive status spells such as Slow and Anchor are now normal, straight-flying projectiles with a slight area of effect. Healing spells and such remain homing.
* Renamed Fortress Wall set of props to Combine Wall.
* Anchor now stops a person from jumping instead of tying them to a point.
* Anchor beacons now shoot Anchor projectiles to passing enemies instead of using an area of effect.
* Anti-Projectile Towers now bounce incoming projectiles instead of destroying or exploding them.
* Added an ambient effect to Anti-Projectile Towers.
* The slow down from shooting a gun or casting spells has been greatly reduced. It was on average -30% and is now an average of about -15%.
* Shoot and swing delay is now global on a person instead of for an individual weapon. You can now swap between weapons while shooting but you won't be able to shoot the other one until the delay from the previous weapon is over. Melee weapons can still not be switched during the actual swing.
* Guns now cost Mana to reload instead of to shoot. You can reload partially as long as you have enough Mana for one bullet.
* Reduced the maximum jump height bonus for Agility but increased the minimum jump height bonus.
* Added visual indicator for the radius of Mana Capacitors.
* Added Small Mana Capacitor. Holds half as much Mana and health but is easier to build.
* Spawning a Mana Extractor while pointing at an Obelisk will automatically try to align itself to the nearest, visible Capacitor.
* Renamed Mana Capacitor to Large Mana Capacitor.
* Removed the 25% damage bonus for melee vs. buildings.
* Renamed Small Mana Extractor to Mana Extractor.
* Increased the Drop Ship primary gun damage due to the fact that bullets are less effective against buildings since the merger.
* Zagger now has a secondary attack. You hold the gun on the side and shoot faster at the cost of accuracy.
* The Sweeper and Stigma both have secondary attacks. You can freely choose between using each alternate pattern.
* Ball carriers now have a visual indicator on their HUD pointing where to go.
* You can now press +SPEED (usually shift) to sprint while you don't have a casting weapon out. This can be disabled in options.
* If you don't have the Dexterity or stamina required to dodge, STRAFE + JUMP will work as default instead of not jumping.
* Fixed a problem where people would not be able to change materials on buildings with spaces in their names.
* "Press JUMP to get back up!" message on the HUD. Can be disabled.
* +menu (the Q menu in sandbox) can be used to open the builder menu when you have the physgun or a builder weapon out.

-= Zombie Survival =-

* Music and beat length is now auto-detected by the script in case you use custom sounds.


- JetBoom, head administrator (jetboom@yahoo.com)]]},

{Posted="May 28, 2009", Title="Publish 246", Content=[[Just a reminder that on June 20th the ban list is being reset. What a funny day that will be.

Here's your Publish 246 changes!

-= NoXiousNet Core / DB =-
* Awards now have categories. You can view different awards by category in a person's in-game profile or the All Awards listing. Different gamemodes have their own categories, events have one, and special ones (Verified Girl, Ugly Girlfriend) have their own category.
* You can now see what percentage of awards you or another person has. Awards in the Special category don't count.
* Multiple instances of an award are now properly shown in-game (x2, x3, etc).
* Added new effect for when a person gets an award.
* Award effect and the ban train are stored in the database scripts instead of entity scripts.

-= NoXious Beta =-

* The entire team of someone who scores can now move around and kill the other team freely. Anyone not on that person's team is still frozen and their camera is focused on the person who scored.
* Added trigger_changegravity which allows mappers to set the gravity of something that enters the trigger. See mapping thread for more details.
* Increased the mana cost for the Lock-On Missiles Mountable Turret barrel from 15 to 30.
* Increased the mana cost for the Mortor Mountable Turret barrel from 5 to 15.
* Increased the mana cost for the Plasma Mountable Turret barrel from 5 to 10.
* Fixed a bug where Protrusion spikes created with magic had their damage scaled by the caster's Might.


- JetBoom, head administrator (jetboom@yahoo.com)]]},

{Posted="May 25, 2009", Title="Publish 245", Content=[[Here's a few more changes for the NoXious beta. Just a reminder, you can use the Portal to connect to other NoXiousNet servers on the fly. Just click the button with a picture of the Earth in the chat box!

Also, if you have any experience with models, maps, or even Lua then your help is greatly appreciated. Just PM me on the forum or send me an e-mail.

-= NoXious Beta =-

* Enabled the Flare spell. This one is new. Flare is a moderately-fast moving ball of fire that homes in on nearby enemies.
* Enabled the Lightning spell. Lightning is a powered-down version of Energy Bolt that has the unique ability to hit multiple targets. Just hit one enemy and anyone nearby will also get hit.
* Raven gun damage increased from 15 to 18.
* Wasp gun damage increased from 10 to 13.
* Raven and Mountable Turret missiles are slightly easier to avoid.
* Raven maximum velocity slightly increased.
* Fixed people being able to enter vehicles while doing stuff (like using the builder ray, charging a Gladradus, etc.)

- JetBoom, head administrator (jetboom@yahoo.com)]]},

{Posted="May 25, 2009", Title="Publish 244", Content=[[Latest publish. This one has a lot of stuff for everyone!

-= NoXiousNet Core / DB =-

* Map votes can be revoked and put in to something else.
* Added a news icon to the chat box. It brings up the announcements like the /news chat command.
* Added a portal button to the chatbox.
* Redid the server portal.
* Re-added cross-server-chat. Use /csc <message here> to chat to all servers. This one is using UDP over a local network so it's instantaneous and pretty reliable.
* Redid game type voting. Game type voting is now cross-gamemode and it also has nice looking VGUI instead of the old crappy one.
* Added nox_chatbox_ignoreplayers. Setting this to 1 will make it so messages from players are only put in your console.
* Added nox_chatbox_ignoresystem. System messages from PrintMessage only get printed in the console if this is 1.
* Added nox_chatbox_ignoreemotes. Emotes won't play any sounds if this is 1.
* Added an options menu for the chat box. There's a button with a wrench picture. Click this to get to it. It has those three things in it along with some other stuff.
* Fixed announcements showing you old announcements if you restart the game.

-= NoXious Beta =-

* Added checkbox in the options menu for making it so the NoXiousNet account box shows up only while chat is up.
* You can press SPACE while spectating to switch between spectator modes (roaming, chase, in eye).
* Added nox_hud_moviehud and nox_hud_nohud. moviehud will disable the health bar, mana bar, stamina bar, spell selection, status icons, and the "Press FIRE to respawn" message. nohud will disable every HUD element. Both of these are in the options menu. Added for movie-makers.
* Added the award: Stealing First. Capture a flag within 30 seconds of the game starting.
* Added the award: Greedy. Be the one to score every goal in Blitz or every capture in Capture the Flag.
* The Nailer now has a scope.
* Gladradus now has a new custom model made by The Darker One.
* Enabled the Shock spell. It's more akin to the gmod9 version of Shock. Anyone near you at the time of casting gets damaged and flung back a bit.
* Enabled the Lesser Heal spell.
* Enabled the Heal spell.
* Enabled the Major Heal spell.
* The behavior of Protect from * spells has been changed. They will reduce any significant (5 or more) damage from that element two times. The spinning orbs are an indicator of how many times a person has left. The spell lasts indefinitely, at least until the orbs are gone. The reduction is currently set at 40%.
* Spawn points are reset after a round ends.
* Minor Heal requirements are now 0.15 Mind and Healing.
* Greater Heal requirements are now 0.65 Mind and Healing.
* Minor Heal now heals for 6 health.
* Greater Heal now heals for 30 health.
* Fixed Staff weapons losing their spell if the spell fails to cast. For example, you would lose your Energy Bolt charge if you were moving and you tried to discharge it.
* Fixed the ball drop position being stuck in the world or in the air sometimes.
* Fixed status timers not showing up on the HUD.
* Fixed Raven missiles and Mountable Lock-on missiles not locking on to vehicles if you try to lock-on to a part of the vehicle that isn't the main body part.

-= Zombie Survival =-
* Added the award: Sharpshooter. Get six consecutive head shots with the Slug Rifle.
* Added the award: Hellsing. Kill six zombies with one crossbow bolt.
* Un-life and Half-life no longer lock horde difficulty or beat music.
* Fixed inflictor not being correct when someone kills another person with a weapon other than what they were holding. Fixes killing people with a grenade and getting credited with whatever weapon you're holding.


- JetBoom, Head Administrator (jetboom@yahoo.com)]]},

{Posted="May 19, 2009", Title="Publish 243", Content=[[Here's the latest publish. Most of it is for NoXious players but there's also a nice change for ZS players.

-= Additions and changes for Zombie Survival =-
* The Silver award for surviving a game has been increased from 2,000 Silver to 6,000 Silver. No Silver is awarded unless there is at least 6 people playing.

-= Additions and changes for the NoXious Beta =-
* Added the second magical weapon: Apprentice Staff. Staffs have the unique ability to pre-load spells. Simply cast the spell as you normally would and your staff will be charged with that spell. Press the cast button again to discharge the spell. If you don't cast the spell after 15 seconds, it will fizzle out. Staffs have a visual indicator on the weapon itself when a spell is preloaded so your enemies know if you're about to do something. The question is what exactly unless they deciphered the words of power when you cast it a while ago.
* Added a box in the Aspects tab that tells you how to change your aspects since some people seem to be confused about this.
* Enabled the Tag spell.
* Added some help for binding specific spells in the Spells tab.
* Pressing attack or secondary attack while knocked down will also get yourself up.
* Added a series of checkboxes in the options tab for toggling motion blur on or off. Everything is enabled except for sprinting by default.
* Reflective Shield time increased from 2 seconds to 3 seconds.
* The method of determining if a player is moving or not (such as being able to use Energy Bolt or Reflective Shield) has been changed from a measurement of velocity to whether or not the player is using a movement key (WASD). A player is always considered moving if they are not on the ground.
* Removed obsolete or currently unused entities and effects from being downloaded.
* Updated help menu to include links to all current weapons and gametypes.
* Slightly decreased the upwards velocity on the Ripdash jump attack.
* The mana cost of Energy Bolt has been decreased from 20 per second to 17 per second.
* Motion blur is disabled while sprinting.
* The Silver award for winning a match has been increased from 500 Silver to 1,500 Silver. There must be 6 people playing to get this.
* Fixed a typo in Builder A-1 being referred to as 'Builder M-1' in the HUD's weapon selection.
* Fixed a small visual error in the weapon slot assignment menu where the buttons (Slot 1, Slot2, Slot 3) would be off to the right a little.
* Fixed Slow not working properly if a person was sprinting or wall running.
* Reflective Shield now works as intended.

- JetBoom, Head Administrator (jetboom@yahoo.com)]]},

{Posted="May 11, 2009", Title="NoXious Open Beta has begun", Content=[[The Open Beta of the new merger gamemode has started. It is being called simply, "NoXious".

connect to 99.198.101.204:27016 to play!]]
},

{Posted="April 11, 2009", Title="Core Update", Content=[[The server core scripts have been updated to the current version of the merger's core.
Treat this as a sort of preview of the core as a lot of things aren't completely done yet.

Before you start saying that your Diamond Member is broke, it's not. Diamonds now get 60% off all in-game purchases and shop items. This is to promote the future in-game economy. If you had infinite Silver, you should now have 30,000 Silver as compensation.

Changes:
* New chat with its own markup language. Supports a bunch of tags and much more will be added as time goes on.
* New votemap. Ratings are gone and a new tagging system will be in place at a later time.
* Wiki integration. The new gamemode fully uses the new wiki integration in its help menu but for now the <wiki=Article_name> tag can be used to access it.
* Gold and Diamond members now get titles with their avatars in it. This uses the <avatar> chat tag.
* Diamonds no longer have infinite Silver. They have 60% off everything instead.
* Gold members have 25% off everything instead of 25% increase.
* Maximum velocity of some things may be noticeable because I increased the engine limit from 2,000 to 64,000. Not that anything goes that fast since that would be pretty much across the map in under half a second.
* Optimized some per-frame code in TeamPlay and ZS for a bit of a lag reduction.
* Removed MDB Towers from TeamPlay.
* Fixed Dragoon being able to walk on the ground while stunned and charging.
* Changed a few weapon animations to be more appropriate in ZS.
* You can completely delete your title if you don't want to display anything.
* A lot of other things. 

- JetBoom, Head Administrator (jetboom@yahoo.com)]]}
}

function MakepNews(page)
	if pNews and pNews:Valid() then pNews:Remove() pNews = nil end

	page = page or 1
	if not tabUpdates[page] then return end

	if NEWNEWS and tabUpdates[1] then
		RunConsoleCommand("nox_announcements_lastcrc", tabUpdates[1].Title)
		timer.Destroy("NewNewsChat")
		NEWNEWS = nil
	end

	local wid, hei = 600, 470

	local dframe = vgui.Create("DFrame")
	dframe:SetSize(wid, hei)
	dframe:Center()
	dframe:SetTitle("Announcements")
	dframe:SetDeleteOnClose(true)
	dframe:SetVisible(true)
	timer.Simple(0, dframe.MakePopup, dframe)
	pNews = dframe

	if string.sub(tabUpdates[page].Content, 1, 6) == "<html>" then
		local dpanel = vgui.Create("HTML", dframe)
		dpanel:SetSize(wid - 16, hei - 100)
		dpanel:SetPos(8, 64)
		dpanel:SetHTML(tabUpdates[page].Content)
	else
		local dpanel = vgui.Create("DTextEntry", dframe)
		dpanel:SetSize(wid - 16, hei - 100)
		dpanel:SetPos(8, 64)
		dpanel:SetEditable(false)
		dpanel:SetMouseInputEnabled(true)
		dpanel:SetMultiline(true)
		dpanel:SetVerticalScrollbarEnabled(true)
		dpanel:SetText(tabUpdates[page].Content)
	end

	if tabUpdates[page - 1] then
		local dbutton = EasyButton(dframe, "<- Newer", nil, 4)
		dbutton:SetWide(wid * 0.25)
		dbutton:SetPos(wid * 0.5 - dbutton:GetWide() - 8, 24)
		dbutton.DoClick = function()
			MakepNews(page - 1)
		end
	end

	if tabUpdates[page + 1] then
		local dbutton = EasyButton(dframe, "Older ->", nil, 4)
		dbutton:SetWide(wid * 0.25)
		dbutton:SetPos(wid * 0.5 + 8, 24)
		dbutton.DoClick = function()
			MakepNews(page + 1)
		end
	end

	local dcheck = vgui.Create("DCheckBoxLabel", dframe)
	dcheck:SetConVar("nox_announcements_newonly")
	dcheck:SetText("Only display NEW announcements.")
	dcheck:SizeToContents()
	dcheck:SetPos(8, hei - dcheck:GetTall() - 8)

	local dbutton = EasyButton(dframe, "Close", 24, 4)
	dbutton:SetPos(wid * 0.5 - dbutton:GetWide() * 0.5, hei - dbutton:GetTall() - 8)
	dbutton.DoClick = function() pNews:Remove() end
end

hook.Add("Think", "Announcements", function()
	if MySelf and MySelf:IsValid() then
		hook.Remove("Think", "Announcements")

		if tabUpdates[1] and tabUpdates[1].Content then
			local CRC = tabUpdates[1].Title
			local CurrentCRC = conCurrentCRC:GetString()
			if CurrentCRC ~= CRC or not conNewOnly:GetBool() then
				--RunConsoleCommand("nox_announcements_lastcrc", CRC)
				--MakepNews()
				NEWNEWS = true
				timer.Simple(60, function(txt)
					MySelf:ChatPrint(txt)
				end, "<pink>Recent news: "..tabUpdates[1].Title.."! Press the flashing NEWS button in the chat box to view it.</pink>")
			end
		end
	end
end)
