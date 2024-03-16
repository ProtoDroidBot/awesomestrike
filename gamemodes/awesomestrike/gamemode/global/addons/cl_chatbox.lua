if SERVER then
	AddCSLuaFile(NDB_ADDON_NAME)
	return
end

NDB.EmotesNames = {}
NDB.EmotesNoChat = {}
NDB.EmotesSounds = {}
NDB.EmotesCallbacks = {}

function NDB.AddEmote(name, soundtab, nochat, callback)
	if name and soundtab then
		local i = #NDB.EmotesNames + 1

		NDB.EmotesNames[i] = name
		NDB.EmotesNoChat[i] = nochat
		NDB.EmotesSounds[i] = soundtab
		NDB.EmotesCallbacks[i] = callback
	end
end

NDB.AddEmote("drink a big bucket of shit", "speach/obeyyourthirstsync.wav", true)
NDB.AddEmote("drink a big bucket of horse dick", "speach/obeyyourthirst2.wav", true)
NDB.AddEmote("lag!", "speach/lag2.wav", true)
NDB.AddEmote("laff", {"speach/laff1.wav", "speach/laff2.wav", "speach/laff3.wav", "speach/laff4.wav", "speach/laff5.wav"}, true)
NDB.AddEmote("enough of your mumbo jumbo", "vo/npc/male01/vanswer01.wav", true)
NDB.AddEmote("bullshit", "vo/npc/male01/question26.wav")
NDB.AddEmote("yay", "vo/npc/Barney/ba_yell.wav")
NDB.AddEmote("shit", "vo/npc/Barney/ba_ohshit03.wav")
NDB.AddEmote("hax", "vo/npc/male01/hacks01.wav", true)
NDB.AddEmote("hacks", "vo/npc/male01/hacks02.wav", true)
NDB.AddEmote("h4x", "vo/npc/male01/thehacks01.wav", true)
NDB.AddEmote("h4cks", "vo/npc/male01/thehacks02.wav", true)
NDB.AddEmote("okay", {"vo/npc/male01/ok01.wav", "vo/npc/male01/ok02.wav"})
NDB.AddEmote("derka", {"vo/npc/vortigaunt/vortigese12.wav", "vo/npc/vortigaunt/vortigese11.wav"}, true)
NDB.AddEmote("noes", "vo/npc/Alyx/ohno_startle01.wav", true)
NDB.AddEmote("get down", {"vo/npc/Barney/ba_getdown.wav", "vo/npc/male01/getdown02.wav"})
NDB.AddEmote("gtfo", "vo/npc/male01/gethellout.wav")
NDB.AddEmote("gtho", "vo/npc/male01/gethellout.wav")
NDB.AddEmote("yeah", "vo/npc/male01/yeah02.wav")
NDB.AddEmote("rofl", "vo/Citadel/br_laugh01.wav")
NDB.AddEmote("lmao", "vo/Citadel/br_laugh01.wav")
NDB.AddEmote("run", "vo/npc/male01/strider_run.wav")
NDB.AddEmote("run for your life", {"vo/npc/male01/runforyourlife01.wav", "vo/npc/male01/runforyourlife02.wav", "vo/npc/male01/runforyourlife03.wav"})
NDB.AddEmote("fantastic", {"vo/npc/male01/fantastic01.wav", "vo/npc/male01/fantastic02.wav"})
NDB.AddEmote("headcrabs", {"vo/npc/male01/headcrabs01.wav", "vo/npc/male01/headcrabs02.wav"})
NDB.AddEmote("headhumpers", "vo/npc/Barney/ba_headhumpers.wav", true)
NDB.AddEmote("hello", "vo/coast/odessa/nlo_cub_hello.wav")
NDB.AddEmote("eek", "ambient/voices/f_scream1.wav", true)
NDB.AddEmote("uh oh", "vo/npc/male01/uhoh.wav")
NDB.AddEmote("sodomy!", {"vo/ravenholm/madlaugh01.wav", "vo/ravenholm/madlaugh02.wav", "vo/ravenholm/madlaugh03.wav", "vo/ravenholm/madlaugh04.wav"}, true)
NDB.AddEmote("oops", "vo/npc/male01/whoops01.wav", true)
NDB.AddEmote("shut up", "vo/npc/male01/answer17.wav")
NDB.AddEmote("shutup", "vo/npc/male01/answer17.wav")
NDB.AddEmote("right on", "vo/npc/male01/answer32.wav", true)
NDB.AddEmote("freeman", "vo/npc/male01/gordead_ques03a.wav", true)
NDB.AddEmote("help", "vo/npc/male01/help01.wav")
NDB.AddEmote("haxz", "vo/npc/male01/herecomehacks01.wav", true)
NDB.AddEmote("hi", {"vo/npc/male01/hi01.wav", "vo/npc/male01/hi02.wav"})
NDB.AddEmote("let's go", {"vo/npc/male01/letsgo01.wav", "vo/npc/male01/letsgo02.wav"})
NDB.AddEmote("lets go", {"vo/npc/male01/letsgo01.wav", "vo/npc/male01/letsgo02.wav"})
NDB.AddEmote("moan", {"vo/npc/male01/moan01.wav", "vo/npc/male01/moan02.wav", "vo/npc/male01/moan03.wav", "vo/npc/male01/moan04.wav", "vo/npc/male01/moan05.wav"}, true)
NDB.AddEmote("nice", "vo/npc/male01/nice.wav")
NDB.AddEmote("noo", {"vo/npc/Barney/ba_no01.wav", "vo/npc/Barney/ba_no02.wav"}, true)
NDB.AddEmote("nooo", "vo/npc/male01/no02.wav", true)
NDB.AddEmote("oh no", "vo/npc/male01/ohno.wav")
NDB.AddEmote("joygasm", "vo/npc/female01/pain06.wav", true)
NDB.AddEmote("zombies", {"vo/npc/male01/zombies01.wav", "vo/npc/male01/zombies02.wav"})
NDB.AddEmote("da man", "bot/whos_the_man.wav", true)
NDB.AddEmote("my house", "bot/this_is_my_house.wav", true)
NDB.AddEmote("party", "bot/its_a_party.wav", true)
NDB.AddEmote("watch out", "vo/npc/male01/watchout.wav")
NDB.AddEmote("excuse me", {"vo/npc/male01/excuseme01.wav", "vo/npc/male01/excuseme02.wav"})
NDB.AddEmote("you sure?", "vo/npc/male01/answer37.wav")
NDB.AddEmote("groan", "vo/npc/male01/moan04.wav", true)
NDB.AddEmote("gasp", {"vo/npc/male01/startle01.wav", "vo/npc/male01/startle02.wav"}, true)
NDB.AddEmote("sorry", {"vo/npc/male01/sorry01.wav", "vo/npc/male01/sorry02.wav", "vo/npc/male01/sorry03.wav"})
NDB.AddEmote("welcome to city 17", {"vo/Breencast/br_welcome01.wav", "vo/Breencast/br_welcome06.wav"}, true)
NDB.AddEmote("it's safer here", "vo/Breencast/br_welcome07.wav", true)
NDB.AddEmote("i'm talking to you", "vo/Breencast/br_tofreeman02.wav", true)
NDB.AddEmote("serve mankind", "vo/Breencast/br_tofreeman12.wav", true)
NDB.AddEmote("get going", "vo/canals/shanty_go_nag03.wav")
NDB.AddEmote("go on out", "vo/canals/gunboat_goonout.wav", true)
NDB.AddEmote("get outta here", {"vo/canals/shanty_go_nag01.wav", "vo/canals/boxcar_go_nag03.wav"})
NDB.AddEmote("go on", "vo/canals/shanty_go_nag02.wav")
NDB.AddEmote("hey", "vo/canals/shanty_hey.wav")
NDB.AddEmote("get in here hurry", "vo/canals/matt_getin.wav", true)
NDB.AddEmote("hit the road jack", "vo/canals/boxcar_go_nag04.wav", true)
NDB.AddEmote("no", "vo/Citadel/eli_notobreen.wav")
NDB.AddEmote("no!", "vo/Citadel/br_failing11.wav", true)
NDB.AddEmote("never", "vo/Citadel/eli_nonever.wav")
NDB.AddEmote("you fool", "vo/Citadel/br_youfool.wav", true)
NDB.AddEmote("good god", "vo/Citadel/eli_goodgod.wav")
NDB.AddEmote("cheer", {"vo/coast/odessa/male01/nlo_cheer01.wav", "vo/coast/odessa/male01/nlo_cheer02.wav", "vo/coast/odessa/male01/nlo_cheer03.wav", "vo/coast/odessa/male01/nlo_cheer04.wav"}, true)
NDB.AddEmote("drive safely", "vo/coast/odessa/male01/nlo_citizen_drivesafe.wav", true)
NDB.AddEmote("whoops", "vo/k_lab/ba_whoops.wav", true)
NDB.AddEmote("gee thanks", "vo/k_lab/ba_geethanks.wav")
NDB.AddEmote("what the hell", "vo/k_lab/ba_whatthehell.wav")
NDB.AddEmote("it's your pet the freakin headhumper", "vo/k_lab/ba_headhumper01.wav", true)
NDB.AddEmote("i'll stay here", {"vo/npc/male01/illstayhere01.wav", "vo/npc/male01/imstickinghere01.wav"})
NDB.AddEmote("up there", {"vo/npc/male01/upthere01.wav", "vo/npc/male01/upthere02.wav"})
NDB.AddEmote("he's dead", {"vo/npc/male01/gordead_ques01.wav", "vo/npc/male01/gordead_ques07.wav"}, true)
NDB.AddEmote("lead the way", {"vo/npc/male01/leadtheway02.wav", "vo/npc/male01/leadtheway01.wav"}, true)
NDB.AddEmote("we're done for", "vo/npc/male01/gordead_ans14.wav", true)
NDB.AddEmote("over there", {"vo/npc/male01/overthere01.wav", "vo/npc/male01/overthere02.wav"})
NDB.AddEmote("ok i'm ready", {"vo/npc/male01/okimready01.wav", "vo/npc/male01/okimready02.wav", "vo/npc/male01/okimready03.wav"})
NDB.AddEmote("i'm with you", "vo/npc/male01/answer13.wav", true)
NDB.AddEmote("hey over here", "vo/npc/male01/overhere01.wav", true)
NDB.AddEmote("behind you", {"vo/npc/male01/behindyou01.wav", "vo/npc/male01/behindyou02.wav"})
NDB.AddEmote("follow me", "vo/npc/male01/squad_away03.wav")
NDB.AddEmote("pardon me", {"vo/npc/male01/pardonme01.wav", "vo/npc/male01/pardonme02.wav"})
NDB.AddEmote("got one", {"vo/npc/male01/gotone01.wav", "vo/npc/male01/gotone02.wav"})
NDB.AddEmote("finally", "vo/npc/male01/finally.wav")
NDB.AddEmote("wait for me", "vo/npc/male01/squad_reinforce_single04.wav")
NDB.AddEmote("i'm hurt", "vo/npc/male01/imhurt01.wav", true)
NDB.AddEmote("take cover", "vo/npc/male01/takecover02.wav")
NDB.AddEmote("it's a manhack", "vo/npc/male01/itsamanhack02.wav", true)
NDB.AddEmote("incoming", "vo/npc/male01/incoming02.wav")
NDB.AddEmote("ready when you are", {"vo/npc/male01/readywhenyouare01.wav", "vo/npc/male01/readywhenyouare02.wav"}, true)
NDB.AddEmote("don't forget hawaii", "vo/npc/male01/answer34.wav", true)
NDB.AddEmote("that's enough outta you", "vo/npc/male01/answer39.wav", true)
NDB.AddEmote("wait for us", "vo/npc/male01/squad_reinforce_group04.wav")
NDB.AddEmote("now what?", "vo/npc/male01/gordead_ans01.wav")
NDB.AddEmote("we trusted you", {"vo/npc/male01/wetrustedyou01.wav", "vo/npc/male01/wetrustedyou02.wav"}, true)
NDB.AddEmote("god i'm hungry", "vo/npc/male01/question28.wav", true)
NDB.AddEmote("i'm ganna be sick", "vo/npc/male01/gordead_ans19.wav", true)
NDB.AddEmote("you're talking to yourself again", "vo/npc/male01/answer09.wav", true)
NDB.AddEmote("come on everybody", "vo/npc/male01/squad_follow02.wav", true)
NDB.AddEmote("watch what you're doing", "vo/npc/male01/watchwhat.wav", true)
NDB.AddEmote("your mind is in the gutter", "vo/npc/male01/answer20.wav", true)
NDB.AddEmote("here they come!", "vo/npc/male01/heretheycome01.wav", true)
NDB.AddEmote("same here", "vo/npc/male01/answer07.wav")
NDB.AddEmote("i wouldn't say that too loud", "vo/npc/male01/answer10.wav", true)
NDB.AddEmote("i'll put it on your tombstone", "vo/npc/male01/answer11.wav", true)
NDB.AddEmote("have you ever had an original thought?", "vo/npc/male01/answer16.wav", true)
NDB.AddEmote("let's concentrate on the task at hand", "vo/npc/male01/answer18.wav", true)
NDB.AddEmote("keep your mind on your work", "vo/npc/male01/answer19.wav", true)
NDB.AddEmote("you never know", "vo/npc/male01/answer22.wav", true)
NDB.AddEmote("you never can tell", "vo/npc/male01/answer23.wav", true)
NDB.AddEmote("why are you telling me?", "vo/npc/male01/answer24.wav", true)
NDB.AddEmote("how about that", "vo/npc/male01/answer25.wav", true)
NDB.AddEmote("want a bet?", "vo/npc/male01/answer27.wav")
NDB.AddEmote("what am i supposed to do about it?", "vo/npc/male01/answer29.wav")
NDB.AddEmote("you talking to me?", "vo/npc/male01/answer30.wav")
NDB.AddEmote("leave it alone", "vo/npc/male01/answer38.wav", true)
NDB.AddEmote("can't you see i'm busy?", "vo/npc/male01/busy02.wav", true)
NDB.AddEmote("look out below", "vo/npc/male01/cit_dropper04.wav", true)
NDB.AddEmote("shouldn't we be doing something?", "vo/npc/male01/doingsomething.wav", true)
NDB.AddEmote("let's even the odds a little", "vo/npc/male01/evenodds.wav", true)
NDB.AddEmote("oh god", "vo/npc/male01/gordead_ans04.wav")
NDB.AddEmote("should we bury him here?", "vo/npc/male01/gordead_ans08.wav", true)
NDB.AddEmote("what's the use?", "vo/npc/male01/gordead_ans11.wav", true)
NDB.AddEmote("what's the point?", "vo/npc/male01/gordead_ans12.wav", true)
NDB.AddEmote("this is bad", "vo/npc/male01/gordead_ques10.wav", true)
NDB.AddEmote("hold down this spot", {"vo/npc/male01/holddownspot01.wav", "vo/npc/male01/holddownspot02.wav"}, true)
NDB.AddEmote("i'm hurt", {"vo/npc/male01/imhurt01.wav", "vo/npc/male01/imhurt02.wav"}, true)
NDB.AddEmote("im hurt", {"vo/npc/male01/imhurt01.wav", "vo/npc/male01/imhurt02.wav"}, true)
NDB.AddEmote("sometimes i dream about cheese", "vo/npc/male01/question06.wav", true)
NDB.AddEmote("i can't remember the last time i had a shower", "vo/npc/male01/question19.wav", true)
NDB.AddEmote("watch what you're doing", "vo/npc/male01/watchwhat.wav", true)
NDB.AddEmote("you got it", "vo/npc/male01/yougotit02.wav")
NDB.AddEmote("we thought you were here to help", {"vo/npc/male01/heretohelp01.wav", "vo/npc/male01/heretohelp02.wav"}, true)
NDB.AddEmote("hey doc", {"vo/npc/male01/heydoc01.wav", "vo/npc/male01/heydoc02.wav"}, true)
NDB.AddEmote("hit in the gut", {"vo/npc/male01/hitingut01.wav", "vo/npc/male01/hitingut02.wav"}, true)
NDB.AddEmote("like that?", "vo/npc/male01/likethat.wav", true)
NDB.AddEmote("my leg", {"vo/npc/male01/myleg01.wav", "vo/npc/male01/myleg02.wav"}, true)
NDB.AddEmote("my gut", "vo/npc/male01/mygut02.wav", true)
NDB.AddEmote("my arm", {"vo/npc/male01/myarm01.wav", "vo/npc/male01/myarm02.wav"}, true)
NDB.AddEmote("no no", "vo/npc/male01/no01.wav")
NDB.AddEmote("you're not the man i thought you were", {"vo/npc/male01/notthemanithought01.wav", "vo/npc/male01/notthemanithought02.wav"}, true)
NDB.AddEmote("one for me and one for me", "vo/npc/male01/oneforme.wav", true)
NDB.AddEmote("let me get out of your way", "vo/npc/male01/outofyourway02.wav", true)
NDB.AddEmote("i don't think this war is ever going to end", "vo/npc/male01/question01.wav", true)
NDB.AddEmote("to think all i used to want to do is sell insurance", "vo/npc/male01/question02.wav", true)
NDB.AddEmote("i don't dream anymore", "vo/npc/male01/question03.wav", true)
NDB.AddEmote("when this is all over ah who am i kidding", "vo/npc/male01/question04.wav", true)
NDB.AddEmote("woah deja vu", "vo/npc/male01/question05.wav", true)
NDB.AddEmote("you smell that? it's freedom", "vo/npc/male01/question07.wav", true)
NDB.AddEmote("if i ever get my hands on dr. breen", "vo/npc/male01/question08.wav", true)
NDB.AddEmote("i could eat a horse hooves and all", "vo/npc/male01/question09.wav", true)
NDB.AddEmote("i can't believe this day has finally come", "vo/npc/male01/question10.wav", true)
NDB.AddEmote("i'm pretty sure this isn't part of the plan", "vo/npc/male01/question11.wav", true)
NDB.AddEmote("looks to me like things are getting worse not better", "vo/npc/male01/question12.wav", true)
NDB.AddEmote("if i could live my life over again", "vo/npc/male01/question13.wav", true)
NDB.AddEmote("i'm not even gonna tell you what that reminds me of", "vo/npc/male01/question14.wav", true)
NDB.AddEmote("they're never gonna make a stalker outta me", "vo/npc/male01/question15.wav", true)
NDB.AddEmote("finally change is in the air", "vo/npc/male01/question16.wav", true)
NDB.AddEmote("you feel it? i feel it", "vo/npc/male01/question17.wav", true)
NDB.AddEmote("i don't feel anything anymore", "vo/npc/male01/question18.wav", true)
NDB.AddEmote("some day this will all be a bad memory", "vo/npc/male01/question20.wav", true)
NDB.AddEmote("i'm not a betting man but the odds are not good", "vo/npc/male01/question21.wav", true)
NDB.AddEmote("doesn't anyone care what i think?", "vo/npc/male01/question22.wav", true)
NDB.AddEmote("i can't get this tune outta my head", "vo/npc/male01/question23.wav", true)
NDB.AddEmote("i just knew it was gonna be one of those days", "vo/npc/male01/question25.wav", true)
NDB.AddEmote("i think i ate something bad", "vo/npc/male01/question27.wav", true)
NDB.AddEmote("when this is all over i'm gonna mate", "vo/npc/male01/question29.wav", true)
NDB.AddEmote("i'm glad there's no kids around to see this", "vo/npc/male01/question30.wav", true)
NDB.AddEmote("scanners", {"vo/npc/male01/scanners01.wav", "vo/npc/male01/scanners02.wav"}, true)
NDB.AddEmote("whatever you say", "vo/npc/male01/squad_affirm03.wav")
NDB.AddEmote("ok i'm going", "vo/npc/male01/squad_affirm04.wav", true)
NDB.AddEmote("here it goes", "vo/npc/male01/squad_affirm05.wav", true)
NDB.AddEmote("here goes nothing", "vo/npc/male01/squad_affirm06.wav", true)
NDB.AddEmote("here we come", "vo/npc/male01/squad_approach02.wav", true)
NDB.AddEmote("on our way", "vo/npc/male01/squad_approach03.wav", true)
NDB.AddEmote("coming", "vo/npc/male01/squad_approach04.wav")
NDB.AddEmote("this way gang", "vo/npc/male01/squad_away01.wav", true)
NDB.AddEmote("over here", "vo/npc/male01/squad_away02.wav")
NDB.AddEmote("let's get moving", "npc/male01/squad_follow03.wav")
NDB.AddEmote("gordon freeman, you're here", "vo/npc/male01/squad_greet01.wav", true)
NDB.AddEmote("stop it freeman", "vo/npc/male01/stopitfm.wav", true)
NDB.AddEmote("strider", "vo/npc/male01/strider.wav", true)
NDB.AddEmote("this'll do nicely", "vo/npc/male01/thislldonicely01.wav", true)
NDB.AddEmote("damn vorts", "vo/npc/male01/vanswer02.wav", true)
NDB.AddEmote("i'm not sure how to take that", "vo/npc/male01/vanswer03.wav", true)
NDB.AddEmote("should i take that personally?", "vo/npc/male01/vanswer04.wav", true)
NDB.AddEmote("speak english", "vo/npc/male01/vanswer05.wav", true)
NDB.AddEmote("you got that from me", "vo/npc/male01/vanswer06.wav", true)
NDB.AddEmote("that's why we put up with you", "vo/npc/male01/vanswer07.wav", true)
NDB.AddEmote("couldn't have put it better myself", "vo/npc/male01/vanswer08.wav", true)
NDB.AddEmote("that almost made sense", "vo/npc/male01/vanswer09.wav", true)
NDB.AddEmote("something must be wrong with me i almost understood that", "vo/npc/male01/vanswer10.wav", true)
NDB.AddEmote("i guess i'm getting used to you vorts", "vo/npc/male01/vanswer11.wav", true)
NDB.AddEmote("none of your vort philosophy", "vo/npc/male01/vanswer12.wav", true)
NDB.AddEmote("stop you're killing me", "vo/npc/male01/vanswer13.wav", true)
NDB.AddEmote("what did i do to deserve this?", "vo/npc/male01/vanswer14.wav", true)
NDB.AddEmote("stop looking at me like that", "vo/npc/male01/vquestion01.wav", true)
NDB.AddEmote("some things i just never get used to", "vo/npc/male01/vquestion02.wav", true)
NDB.AddEmote("i don't know how you things survived as long as you have", "vo/npc/male01/vquestion03.wav", true)
NDB.AddEmote("sometimes i wonder how i ended up with you", "vo/npc/male01/vquestion04.wav", true)
NDB.AddEmote("you're alright vorty", "vo/npc/male01/vquestion05.wav", true)
NDB.AddEmote("you vorts aren't half bad", "vo/npc/male01/vquestion06.wav", true)
NDB.AddEmote("if anyone ever told me i'd be pals with a vortigaunt", "vo/npc/male01/vquestion07.wav", true)
NDB.AddEmote("you waiting for somebody?", "vo/npc/male01/waitingsomebody.wav", true)
NDB.AddEmote("woops", "vo/npc/male01/whoops01.wav", true)
NDB.AddEmote("you'd better reload", "vo/npc/male01/youdbetterreload01.wav", true)
NDB.AddEmote("bring it on", "vo/npc/Barney/ba_bringiton.wav", true)
NDB.AddEmote("damnit", "vo/npc/Barney/ba_damnit.wav")
NDB.AddEmote("i don't like the looks of this", "vo/npc/Barney/ba_danger02.wav", true)
NDB.AddEmote("down you go", "vo/npc/Barney/ba_downyougo.wav", true)
NDB.AddEmote("duck", "vo/npc/Barney/ba_duck.wav")
NDB.AddEmote("come on", "vo/npc/Barney/ba_followme02.wav")
NDB.AddEmote("get away from there", "vo/npc/Barney/ba_getaway.wav")
NDB.AddEmote("get outta the way", "vo/npc/Barney/ba_getoutofway.wav")
NDB.AddEmote("you're going down", "vo/npc/Barney/ba_goingdown.wav", true)
NDB.AddEmote("grenade", {"vo/npc/Barney/ba_grenade01.wav", "vo/npc/Barney/ba_grenade02.wav"})
NDB.AddEmote("here it comes!", "vo/npc/Barney/ba_hereitcomes.wav", true)
NDB.AddEmote("hurry up", "vo/npc/Barney/ba_hurryup.wav")
NDB.AddEmote("i'm with you buddy", "vo/npc/Barney/ba_imwithyou.wav", true)
NDB.AddEmote("maniacal!", {"vo/npc/Barney/ba_laugh01.wav", "vo/npc/Barney/ba_laugh02.wav", "vo/npc/Barney/ba_laugh04.wav"}, true)
NDB.AddEmote("yeaheheah", "vo/npc/Barney/ba_laugh03.wav", true)
NDB.AddEmote("let's do it", "vo/npc/Barney/ba_letsdoit.wav", true)
NDB.AddEmote("look out!", "vo/npc/Barney/ba_lookout.wav", true)
NDB.AddEmote("i haven't lost my touch", "vo/npc/Barney/ba_losttouch.wav", true)
NDB.AddEmote("ohoh yeah", "vo/npc/Barney/ba_ohyeah.wav", true)
NDB.AddEmote("soldiers!", "vo/npc/Barney/ba_soldiers.wav", true)
NDB.AddEmote("turret!", "vo/npc/Barney/ba_turret.wav", true)
NDB.AddEmote("uh oh here they come", "vo/npc/Barney/ba_uhohheretheycome.wav", true)
NDB.AddEmote("i need to get patched up", "vo/npc/Barney/ba_wounded02.wav", true)
NDB.AddEmote("i'm hurt pretty bad", "vo/npc/Barney/ba_wounded03.wav", true)
NDB.AddEmote("i know you will", "vo/NovaProspekt/eli_iknow.wav")
NDB.AddEmote("nevermind me save yourselves", "vo/NovaProspekt/eli_nevermindme01.wav", true)
NDB.AddEmote("i'll see you there baby", "vo/NovaProspekt/eli_notime01.wav", true)
NDB.AddEmote("so this is the combine portal it's smaller than i imagined", "vo/NovaProspekt/eli_thisisportal.wav", true)
NDB.AddEmote("but where will you go?", "vo/NovaProspekt/eli_wherewillyougo01.wav", true)
NDB.AddEmote("instinct1", "vo/Breencast/br_instinct01.wav", true)
NDB.AddEmote("instinct2", "vo/Breencast/br_instinct03.wav", true)
NDB.AddEmote("instinct3", "vo/Breencast/br_instinct08.wav", true)
NDB.AddEmote("instinct4", "vo/Breencast/br_instinct09.wav", true)
NDB.AddEmote("instinct5", "vo/Breencast/br_instinct12.wav", true)
NDB.AddEmote("instinct6", "vo/Breencast/br_instinct14.wav", true)
NDB.AddEmote("instinct7", "vo/Breencast/br_instinct15.wav", true)
NDB.AddEmote("instinct8", "vo/Breencast/br_instinct16.wav", true)
NDB.AddEmote("instinct9", "vo/Breencast/br_instinct17.wav", true)
NDB.AddEmote("instinct10", "vo/Breencast/br_instinct18.wav", true)
NDB.AddEmote("instinct11", "vo/Breencast/br_instinct19.wav", true)
NDB.AddEmote("instinct12", "vo/Breencast/br_instinct20.wav", true)
NDB.AddEmote("instinct13", "vo/Breencast/br_instinct21.wav", true)
NDB.AddEmote("instinct14", "vo/Breencast/br_instinct22.wav", true)
NDB.AddEmote("instinct15", "vo/Breencast/br_instinct23.wav", true)
NDB.AddEmote("instinct16", "vo/Breencast/br_instinct25.wav", true)
NDB.AddEmote("you have plunged humanity in to free fall", "vo/Breencast/br_tofreeman06.wav", true)
NDB.AddEmote("even if you offered your surrunder now", "vo/Breencast/br_tofreeman07.wav", true)
NDB.AddEmote("help ensure that humanity's trust in you is not misguided", "vo/Breencast/br_tofreeman10.wav", true)
NDB.AddEmote("they're shelling us", "vo/canals/male01/stn6_shellingus.wav", true)
NDB.AddEmote("incoming!", "vo/canals/male01/stn6_incoming.wav", true)
NDB.AddEmote("you can park the boat it'll be safe here", "vo/canals/male01/gunboat_parkboat.wav", true)
NDB.AddEmote("let's get a move on we gotta move out before they target us", "vo/canals/male01/gunboat_moveon.wav", true)
NDB.AddEmote("you made it just in time we gotta clear outta here before we're discovered", "vo/canals/male01/gunboat_justintime.wav", true)
NDB.AddEmote("we'd better hurry we gotta tear down this camp and get outta here", "vo/canals/male01/gunboat_hurry.wav", true)
NDB.AddEmote("be careful now", "vo/canals/boxcar_becareful.wav", true)
NDB.AddEmote("we really can't afford to get noticed", "vo/canals/boxcar_becareful_b.wav", true)
NDB.AddEmote("better get going", "vo/canals/boxcar_go_nag02.wav", true)
NDB.AddEmote("he'll help you if you let him", "vo/canals/boxcar_lethimhelp.wav", true)
NDB.AddEmote("we're just a lookout for the underground railroad", "vo/canals/boxcar_lookout.wav", true)
NDB.AddEmote("main station's right around the corner", "vo/canals/boxcar_lookout_b.wav", true)
NDB.AddEmote("they'll get you started on the right foot", "vo/canals/boxcar_lookout_d.wav", true)
NDB.AddEmote("guess those sirens are for you", "vo/canals/boxcar_sirens.wav", true)
NDB.AddEmote("come on in i'll show you what you're up against", "vo/canals/gunboat_comein.wav", true)
NDB.AddEmote("i think he's just finishing up now", "vo/canals/gunboat_finishingup.wav", true)
NDB.AddEmote("come on get in here", "vo/canals/gunboat_getin.wav", true)
NDB.AddEmote("here take a look at this", "vo/canals/gunboat_herelook.wav", true)
NDB.AddEmote("be glad you're not the guy they're looking for", "vo/canals/matt_beglad.wav", true)
NDB.AddEmote("poor bastard doesn't stand a chance", "vo/canals/matt_beglad_b.wav", true)
NDB.AddEmote("sounds like they're calling in every cp unit in city 17", "vo/canals/matt_beglad_c.wav", true)
NDB.AddEmote("that was a close call thanks for your help", "vo/canals/matt_closecall.wav", true)
NDB.AddEmote("now they're flooding the areas up ahead with manhacks", "vo/canals/matt_flood.wav", true)
NDB.AddEmote("you'd better get going before they sweep through here", "vo/canals/matt_flood_b.wav", true)
NDB.AddEmote("you'd better get going now", "vo/canals/matt_go_nag01.wav", true)
NDB.AddEmote("thanks but i'll be ok", "vo/canals/matt_go_nag02.wav", true)
NDB.AddEmote("i've got to stay and help any stragglers", "vo/canals/matt_go_nag03.wav", true)
NDB.AddEmote("you go on", "vo/canals/matt_go_nag05.wav", true)
NDB.AddEmote("good luck out there", "vo/canals/matt_goodluck.wav", true)
NDB.AddEmote("civil protection is on to us", "vo/canals/matt_tearinguprr.wav", true)
NDB.AddEmote("we're tearing up the railroad covering our tracks", "vo/canals/matt_tearinguprr_a.wav", true)
NDB.AddEmote("looks like you're gonna be the last one through", "vo/canals/matt_tearinguprr_b.wav", true)
NDB.AddEmote("thanks for the help but you better get outta here", "vo/canals/matt_thanksbut.wav", true)
NDB.AddEmote("oh shit too late", "vo/canals/matt_toolate.wav", true)
NDB.AddEmote("you got here at a bad time", "vo/canals/shanty_badtime.wav", true)
NDB.AddEmote("we got some ammo in those crates over there", "vo/canals/shanty_gotsomeammo.wav", true)
NDB.AddEmote("we got word you were coming", "vo/canals/shanty_gotword.wav", true)
NDB.AddEmote("help yourself to supplies and keep moving", "vo/canals/shanty_helpyourself.wav", true)
NDB.AddEmote("did you realize your contract was open to the highest bidder?", "vo/Citadel/br_bidder_b.wav", true)
NDB.AddEmote("that's all up to you my old friend", "vo/Citadel/br_gift_a.wav", true)
NDB.AddEmote("will you give your child a chance her mother never had?", "vo/Citadel/br_gift_c.wav", true)
NDB.AddEmote("what's this oh put it over there", "vo/Citadel/br_gravgun.wav", true)
NDB.AddEmote("guards get in here", "vo/Citadel/br_guards.wav", true)
NDB.AddEmote("you have my gratitude doctor", "vo/Citadel/br_guest_b.wav", true)
NDB.AddEmote("and then you deliver yourself?", "vo/Citadel/br_guest_d.wav", true)
NDB.AddEmote("i don't know what you can possibly hope to achieve", "vo/Citadel/br_mock05.wav", true)
NDB.AddEmote("i warned you this was futile", "vo/Citadel/br_mock06.wav", true)
NDB.AddEmote("i hope you said your farewells", "vo/Citadel/br_mock09.wav", true)
NDB.AddEmote("if only you had harnessed your boundless energy for a useful purpose", "vo/Citadel/br_mock13.wav", true)
NDB.AddEmote("i agree it's a total waste", "vo/Citadel/br_newleader_a.wav", true)
NDB.AddEmote("this one has proven to be a fine pawn", "vo/Citadel/br_newleader_c.wav", true)
NDB.AddEmote("i understand if you don't wish to discuss this in front of your friends", "vo/Citadel/br_nothingtosay_a.wav", true)
NDB.AddEmote("i'll send them on their way and then we can talk openly", "vo/Citadel/br_nothingtosay_b.wav", true)
NDB.AddEmote("impossible to describe with our limited vocabulary", "vo/Citadel/br_oheli09.wav", true)
NDB.AddEmote("oh shit", "vo/Citadel/br_ohshit.wav", true)
NDB.AddEmote("if you won't do the right thing for the good of all people", "vo/Citadel/br_playgame_b.wav", true)
NDB.AddEmote("maybe you'll do it for one of them", "vo/Citadel/br_playgame_c.wav", true)
NDB.AddEmote("thanks to you we have everything we need in that regard", "vo/Citadel/br_rabble_a.wav", true)
NDB.AddEmote("you're more than qualified to finish his research yourself", "vo/Citadel/br_rabble_b.wav", true)
NDB.AddEmote("if that's what it takes", "vo/Citadel/br_whatittakes.wav", true)
NDB.AddEmote("you need me", "vo/Citadel/br_youneedme.wav", true)
NDB.AddEmote("don't struggle honey", "vo/Citadel/eli_dontstruggle.wav", true)
NDB.AddEmote("don't worry about me", "vo/Citadel/eli_dontworryboutme.wav", true)
NDB.AddEmote("that's my girl", "vo/Citadel/eli_mygirl.wav", true)
NDB.AddEmote("save them for what", "vo/Citadel/eli_save.wav", true)
NDB.AddEmote("is it really that time again?", "vo/Citadel/gman_exit02.wav", true)
NDB.AddEmote("i'm really not at liberty to say", "vo/Citadel/gman_exit08.wav", true)
NDB.AddEmote("in the meantime", "vo/Citadel/gman_exit09.wav", true)
NDB.AddEmote("this is where i get off", "vo/Citadel/gman_exit10.wav", true)
NDB.AddEmote("they're looking for your car", "vo/coast/barn/male01/chatter.wav", true)
NDB.AddEmote("here come the dropships", "vo/coast/barn/male01/crapships.wav", true)
NDB.AddEmote("right along there and watch your step", "vo/coast/barn/male01/exit_watchstep.wav", true)
NDB.AddEmote("get your car in the barn", "vo/coast/barn/male01/getcarinbarn.wav", true)
NDB.AddEmote("get your car in the garage", "vo/coast/barn/male01/getcaringarage.wav", true)
NDB.AddEmote("get off the road", "vo/coast/barn/male01/getoffroad01.wav", true)
NDB.AddEmote("incoming dropship", "vo/coast/barn/male01/incomingdropship.wav", true)
NDB.AddEmote("it's a gunship", "vo/coast/barn/male01/lite_gunship01.wav", true)
NDB.AddEmote("gunship", "vo/coast/barn/male01/lite_gunship02.wav", true)
NDB.AddEmote("park it there", "vo/coast/barn/male01/parkit.wav", true)
NDB.AddEmote("you made it", "vo/coast/barn/male01/youmadeit.wav", true)
NDB.AddEmote("you idiot walking on the sand brings antlions after you", "vo/coast/bugbait/sandy_youidiot.wav", true)
NDB.AddEmote("you there", "vo/coast/bugbait/sandy_youthere.wav", true)
NDB.AddEmote("stop where you are stay on the rocks", "vo/coast/bugbait/sandy_stop.wav", true)
NDB.AddEmote("no! help!", "vo/coast/bugbait/sandy_help.wav", true)
NDB.AddEmote("yeah good idea hold on a sec", "vo/coast/cardock/le_goodidea.wav", true)
NDB.AddEmote("patch him up and get him to the back as soon as he's stable", "vo/coast/cardock/le_patchhim.wav", true)
NDB.AddEmote("i'll radio ahead to let the next base know you're coming", "vo/coast/cardock/le_radio.wav", true)
NDB.AddEmote("who's hurt?", "vo/coast/cardock/le_whohurt.wav", true)
NDB.AddEmote("well that's that", "vo/coast/odessa/nlo_cub_thatsthat.wav", true)
NDB.AddEmote("i couldn't have asked for a finer volunteer", "vo/coast/odessa/nlo_cub_volunteer.wav", true)
NDB.AddEmote("you'll make it through if anyone can", "vo/coast/odessa/nlo_cub_youllmakeit.wav", true)
NDB.AddEmote("good to know you", "vo/eli_lab/airlock_cit01.wav", true)
NDB.AddEmote("you'd better get going", "vo/eli_lab/airlock_cit02.wav", true)
NDB.AddEmote("awesome!", "vo/eli_lab/al_awesome.wav", true)
NDB.AddEmote("alright good you keep right on it", "vo/eli_lab/eli_goodvort.wav", true)
NDB.AddEmote("ughghgh", "vo/eli_lab/eli_handle_b.wav", true)
NDB.AddEmote("ughhh", "vo/k_lab/ba_thingaway02.wav", true)
NDB.AddEmote("feel free to look around", "vo/eli_lab/eli_lookaround.wav", true)
NDB.AddEmote("dr. breen", "vo/eli_lab/eli_vilebiz01.wav", true)
NDB.AddEmote("i can't look", "vo/k_lab/ba_cantlook.wav", true)
NDB.AddEmote("careful", "vo/k_lab/ba_careful01.wav")
NDB.AddEmote("be careful!", "vo/k_lab/ba_careful01.wav", true)
NDB.AddEmote("forget about that thing", "vo/k_lab/ba_forgetthatthing.wav", true)
NDB.AddEmote("get it off me", "vo/k_lab/ba_getitoff02.wav", true)
NDB.AddEmote("get down outta sight", "vo/k_lab/ba_getoutofsight01.wav", true)
NDB.AddEmote("i'll come find you", "vo/k_lab/ba_getoutofsight02.wav", true)
NDB.AddEmote("guh", "vo/k_lab/ba_guh.wav", true)
NDB.AddEmote("hey hey he's back", "vo/k_lab/ba_hesback01.wav", true)
NDB.AddEmote("i'm getting him outta there", "vo/k_lab/ba_hesback02.wav", true)
NDB.AddEmote("well is he here?", "vo/k_lab/ba_ishehere.wav", true)
NDB.AddEmote("you mean it's working?", "vo/k_lab/ba_itsworking01.wav", true)
NDB.AddEmote("for real this time?", "vo/k_lab/ba_itsworking02.wav", true)
NDB.AddEmote("i still have nightmares about that cat", "vo/k_lab/ba_itsworking04.wav", true)
NDB.AddEmote("i've gotta get back on my shift", "vo/k_lab/ba_myshift01.wav", true)
NDB.AddEmote("but ok", "vo/k_lab/ba_myshift02.wav")
NDB.AddEmote("yeah longer if we're lucky", "vo/k_lab/ba_longer.wav", true)
NDB.AddEmote("and not a moment too soon", "vo/k_lab/ba_nottoosoon01.wav", true)
NDB.AddEmote("that's what you said last time", "vo/k_lab/ba_saidlasttime.wav", true)
NDB.AddEmote("i can tell your mit education really pays for itself", "vo/k_lab/ba_sarcastic03.wav", true)
NDB.AddEmote("i thought you got rid of that pest", "vo/k_lab/ba_thatpest.wav", true)
NDB.AddEmote("there he is", "vo/k_lab/ba_thereheis.wav", true)
NDB.AddEmote("there you are", "vo/k_lab/ba_thereyouare.wav", true)
NDB.AddEmote("here we go", "vo/k_lab/ba_thingaway01.wav", true)
NDB.AddEmote("get that thing away from me", "vo/k_lab/ba_thingaway03.wav", true)
NDB.AddEmote("what's the meaning of this?", "vo/k_lab/br_tele_02.wav", true)
NDB.AddEmote("who are you?", "vo/k_lab/br_tele_03.wav")
NDB.AddEmote("how did you get in here?", "vo/k_lab/br_tele_05.wav", true)
NDB.AddEmote("see for yourself", "vo/k_lab/eli_seeforyourself.wav", true)
NDB.AddEmote("shut it down shut it down", "vo/k_lab/eli_shutdown.wav", true)
NDB.AddEmote("ahhhh", "vo/k_lab/kl_ahhhh.wav", true)
NDB.AddEmote("there's a charger on the wall", "vo/k_lab/kl_charger01.wav", true)
NDB.AddEmote("dear me", "vo/k_lab/kl_dearme.wav", true)
NDB.AddEmote("well did it work?", "vo/k_lab/kl_diditwork.wav", true)
NDB.AddEmote("excellent!", "vo/k_lab/kl_excellent.wav", true)
NDB.AddEmote("right you are", "vo/k_lab/kl_fewmoments01.wav", true)
NDB.AddEmote("speak to you again in a few moments", "vo/k_lab/kl_fewmoments02.wav", true)
NDB.AddEmote("oh fiddlesticks what now", "vo/k_lab/kl_fiddlesticks.wav", true)
NDB.AddEmote("final sequence", "vo/k_lab/kl_finalsequence02.wav", true)
NDB.AddEmote("you must get out of here", "vo/k_lab/kl_getoutrun02.wav", true)
NDB.AddEmote("run!", "vo/k_lab/kl_getoutrun03.wav", true)
NDB.AddEmote("here my pet", "vo/k_lab/kl_heremypet01.wav", true)
NDB.AddEmote("no not up there", "vo/k_lab/kl_heremypet02.wav", true)
NDB.AddEmote("interference!", "vo/k_lab/kl_interference.wav", true)
NDB.AddEmote("lamarr", "vo/k_lab/kl_hedyno01.wav", true)
NDB.AddEmote("heady", "vo/k_lab/kl_hedyno02.wav", true)
NDB.AddEmote("is lamarr with him?", "vo/k_lab/kl_islamarr.wav", true)
NDB.AddEmote("lamarr there you are", "vo/k_lab/kl_lamarr.wav", true)
NDB.AddEmote("careful lamarr those are quite fragile", "vo/k_lab/kl_nocareful.wav", true)
NDB.AddEmote("conditions could hardly be more ideal", "vo/k_lab/kl_moduli02.wav", true)
NDB.AddEmote("my goodness", "vo/k_lab/kl_mygoodness01.wav", true)
NDB.AddEmote("it really is you isn't it?", "vo/k_lab/kl_mygoodness03.wav", true)
NDB.AddEmote("your talents surpass your loveliness", "vo/k_lab/kl_nonsense.wav", true)
NDB.AddEmote("oh dear", "vo/k_lab/kl_ohdear.wav", true)
NDB.AddEmote("indeed it is", "vo/k_lab/kl_packing01.wav", true)
NDB.AddEmote("slip in to your suit now", "vo/k_lab/kl_slipin02.wav", true)
NDB.AddEmote("i'm eager to see if your old suit still fits", "vo/k_lab/kl_suitfits02.wav", true)
NDB.AddEmote("then where is he?", "vo/k_lab/kl_thenwhere.wav", true)
NDB.AddEmote("what is it?", "vo/k_lab/kl_whatisit.wav")
NDB.AddEmote("i wish i knew!", "vo/k_lab/kl_wishiknew.wav", true)
NDB.AddEmote("go on get going", "vo/k_lab2/ba_getgoing.wav", true)
NDB.AddEmote("well man that's good news", "vo/k_lab2/ba_goodnews.wav", true)
NDB.AddEmote("i almost gave you guys up for lost", "vo/k_lab2/ba_goodnews_b.wav", true)
NDB.AddEmote("i'll take all the help i can get", "vo/k_lab2/ba_goodnews_c.wav", true)
NDB.AddEmote("aw crap incoming!", "vo/k_lab2/ba_incoming.wav", true)
NDB.AddEmote("so there you see?", "vo/k_lab2/kl_notallhopeless.wav", true)
NDB.AddEmote("it's not all hopeless", "vo/k_lab2/kl_notallhopeless_b.wav", true)
NDB.AddEmote("there's only one heady", "vo/k_lab2/kl_onehedy.wav", true)
NDB.AddEmote("fascinating!", "vo/k_lab2/kl_slowteleport01.wav", true)
NDB.AddEmote("aim for the head", "vo/ravenholm/aimforthehead.wav", true)
NDB.AddEmote("guard yourself well", "vo/ravenholm/bucket_guardwell.wav", true)
NDB.AddEmote("there you are at last", "vo/ravenholm/bucket_thereyouare.wav", true)
NDB.AddEmote("better than better", "vo/ravenholm/cartrap_better.wav", true)
NDB.AddEmote("yes come to me come", "vo/ravenholm/engage01.wav", true)
NDB.AddEmote("come!", {"vo/ravenholm/engage02.wav", "vo/ravenholm/engage03.wav"}, true)
NDB.AddEmote("i will end your torment", "vo/ravenholm/engage04.wav", true)
NDB.AddEmote("let me end your torment", "vo/ravenholm/engage05.wav", true)
NDB.AddEmote("yes my children it is i", "vo/ravenholm/engage06.wav", true)
NDB.AddEmote("come to the light i carry come", "vo/ravenholm/engage07.wav", true)
NDB.AddEmote("it is not me you want but the light that shines through me", "vo/ravenholm/engage08.wav", true)
NDB.AddEmote("come to the light", "vo/ravenholm/engage09.wav", true)
NDB.AddEmote("go quickly", "vo/ravenholm/exit_goquickly.wav", true)
NDB.AddEmote("hurry while i hold the gate", "vo/ravenholm/exit_hurry.wav", true)
NDB.AddEmote("flee brother", "vo/ravenholm/exit_nag01.wav", true)
NDB.AddEmote("onward to the mines", "vo/ravenholm/exit_nag02.wav", true)
NDB.AddEmote("look out brother behind you", "vo/ravenholm/firetrap_lookout.wav", true)
NDB.AddEmote("well done brother", "vo/ravenholm/firetrap_welldone.wav", true)
NDB.AddEmote("stay close to me brother", "vo/ravenholm/grave_stayclose.wav", true)
NDB.AddEmote("out of my way", "vo/ravenholm/monk_blocked01.wav", true)
NDB.AddEmote("look out", "vo/ravenholm/monk_blocked02.wav")
NDB.AddEmote("stand aside brother", "vo/ravenholm/monk_blocked03.wav", true)
NDB.AddEmote("cover me brother", "vo/ravenholm/monk_coverme01.wav", true)
NDB.AddEmote("your assistance brother", "vo/ravenholm/monk_coverme02.wav", true)
NDB.AddEmote("over here brother", "vo/ravenholm/monk_coverme03.wav", true)
NDB.AddEmote("to me brother", "vo/ravenholm/monk_coverme04.wav", true)
NDB.AddEmote("i require your assistance brother", "vo/ravenholm/monk_coverme05.wav", true)
NDB.AddEmote("where art thou brother", "vo/ravenholm/monk_coverme07.wav", true)
NDB.AddEmote("beware!", "vo/ravenholm/monk_danger02.wav", true)
NDB.AddEmote("careful brother", "vo/ravenholm/monk_danger03.wav", true)
NDB.AddEmote("i am outnumbered", "vo/ravenholm/monk_helpme01.wav", true)
NDB.AddEmote("help me brother", "vo/ravenholm/monk_helpme02.wav", true)
NDB.AddEmote("i cannot fight them all alone", "vo/ravenholm/monk_helpme03.wav", true)
NDB.AddEmote("lend a hand brother", "vo/ravenholm/monk_helpme04.wav", true)
NDB.AddEmote("i need help brother", "vo/ravenholm/monk_helpme05.wav", true)
NDB.AddEmote("rest my child", "vo/ravenholm/monk_kill03.wav", true)
NDB.AddEmote("i think no worse of thee", "vo/ravenholm/monk_kill04.wav", true)
NDB.AddEmote("may the light of lights be with you", "vo/ravenholm/monk_kill05.wav", true)
NDB.AddEmote("you meant no harm", "vo/ravenholm/monk_kill06.wav", true)
NDB.AddEmote("be free my child", "vo/ravenholm/monk_kill09.wav", true)
NDB.AddEmote("the grave holds nothing worse for you", "vo/ravenholm/monk_kill10.wav", true)
NDB.AddEmote("i remember your true face", "vo/ravenholm/monk_kill11.wav", true)
NDB.AddEmote("so again i am alone", "vo/ravenholm/monk_mourn03.wav", true)
NDB.AddEmote("my advice to you is aim for the head", "vo/ravenholm/shotgun_advice.wav", true)
NDB.AddEmote("here i have a more suitable gun for you", "vo/ravenholm/shotgun_bettergun.wav", true)
NDB.AddEmote("catch!", "vo/ravenholm/shotgun_catch.wav", true)
NDB.AddEmote("come closer", "vo/ravenholm/shotgun_closer.wav", true)
NDB.AddEmote("hush", "vo/ravenholm/shotgun_hush.wav")
NDB.AddEmote("good now keep it close", "vo/ravenholm/shotgun_keepitclose.wav", true)
NDB.AddEmote("they come", "vo/ravenholm/shotgun_theycome.wav", true)
NDB.AddEmote("if you can hold them off i'm almost done here", "vo/Streetwar/tunnel/male01/c17_06_det02.wav", true)
NDB.AddEmote("stand back it's gonna blow", "vo/Streetwar/tunnel/male01/c17_06_det04.wav", true)
NDB.AddEmote("hey it's me open the door", "vo/Streetwar/tunnel/male01/c17_06_password01.wav", true)
NDB.AddEmote("what's the password?", "vo/Streetwar/tunnel/male01/c17_06_password02.wav", true)
NDB.AddEmote("password!", "vo/Streetwar/tunnel/male01/c17_06_password03.wav", true)
NDB.AddEmote("come on in", "vo/Streetwar/tunnel/male01/c17_06_password04.wav", true)
NDB.AddEmote("ok come across", "vo/Streetwar/tunnel/male01/c17_06_plank01.wav", true)
NDB.AddEmote("that damn thing haunts me", "vo/Streetwar/sniper/ba_hauntsme.wav", true)
NDB.AddEmote("did you hear a cat just now?", "vo/Streetwar/sniper/ba_hearcat.wav", true)
NDB.AddEmote("hey come on", "vo/Streetwar/sniper/ba_heycomeon.wav", true)
NDB.AddEmote("let's get going", "vo/Streetwar/sniper/ba_letsgetgoing.wav", true)
NDB.AddEmote("heeelp", "vo/Streetwar/sniper/male01/c17_09_help01.wav", true)
NDB.AddEmote("help me!", "vo/Streetwar/sniper/male01/c17_09_help02.wav", true)
NDB.AddEmote("is somebody up there?", "vo/Streetwar/sniper/male01/c17_09_help03.wav", true)
NDB.AddEmote("damnit all", "vo/Streetwar/rubble/ba_damnitall.wav", true)
NDB.AddEmote("hey help me out here", "vo/Streetwar/rubble/ba_helpmeout.wav", true)
NDB.AddEmote("well i'll be damned", "vo/Streetwar/rubble/ba_illbedamned.wav", true)
NDB.AddEmote("and if you see dr. breen tell him i said fuck you", "vo/Streetwar/rubble/ba_tellbreen.wav", true)
NDB.AddEmote("done!", "vo/Streetwar/nexus/ba_done.wav", true)
NDB.AddEmote("great i'll open this up", "vo/Streetwar/nexus/ba_illopenthis.wav", true)
NDB.AddEmote("so much for stealth we've been spotted", "vo/Streetwar/nexus/ba_spotted.wav", true)
NDB.AddEmote("we're surrounded", "vo/Streetwar/nexus/ba_surrounded.wav", true)
NDB.AddEmote("then let's go", "vo/Streetwar/nexus/ba_thenletsgo.wav", true)
NDB.AddEmote("uh oh dropships", "vo/Streetwar/nexus/ba_uhohdropships.wav", true)
NDB.AddEmote("hey let us outta here", "vo/Streetwar/nexus/male01/c17_10_letusout.wav", true)
NDB.AddEmote("let us thru!", "vo/Streetwar/barricade/male01/c17_05_letusthru.wav", true)
NDB.AddEmote("let us through!", "vo/Streetwar/barricade/male01/c17_05_letusthru.wav", true)
NDB.AddEmote("open the gate!", "vo/Streetwar/barricade/male01/c17_05_opengate.wav", true)
NDB.AddEmote("how dare you even mention her", "vo/Citadel/al_dienow_b.wav", true)
NDB.AddEmote("alyx my dear you have your mother's eyes but your father's stubborn nature", "vo/Citadel/br_stubborn.wav", true)
NDB.AddEmote("it isn't necessary", "vo/Citadel/mo_necessary.wav", true)
NDB.AddEmote("*spit*", "vo/Citadel/al_dienow.wav", true, function(ent, i, snds)
	local pos = ent:EyePos()
	local heading = ent:GetAimVector()
	local emitter = ParticleEmitter(pos)
	emitter:SetNearClip(16, 20)

	local particle = emitter:Add("particle/rain", pos)
	particle:SetDieTime(3)
	particle:SetStartAlpha(255)
	particle:SetEndAlpha(100)
	particle:SetStartSize(4)
	particle:SetEndSize(0)
	particle:SetRoll(math.Rand(0, 360))
	particle:SetRollDelta(math.Rand(-20, 20))
	particle:SetCollide(true)
	particle:SetGravity(Vector(0, 0, -600))
	particle:SetVelocity(heading * 350)
	particle:SetAirResistance(10)

	for i=1, 14 do
		local particle = emitter:Add("particle/rain", pos)
		particle:SetDieTime(math.Rand(1, 2))
		particle:SetStartAlpha(255)
		particle:SetEndAlpha(100)
		particle:SetStartSize(1)
		particle:SetEndSize(0)
		particle:SetRoll(math.Rand(0, 360))
		particle:SetRollDelta(math.Rand(-20, 20))
		particle:SetCollide(true)
		particle:SetGravity(Vector(0, 0, -600))
		particle:SetVelocity(heading * 300 + VectorRand():Normalize() * 64)
		particle:SetAirResistance(20)
	end

	emitter:Finish()
end)

function MakepEmotes()
	if pEmotes and pEmotes:Valid() then
		pEmotes:SetVisible(true)
		return
	end

	local frame = vgui.Create("DFrame")
	frame:SetSize(500, 480)
	frame:Center()
	frame:SetTitle("Emotes - "..#NDB.EmotesNames.." available emotes")
	frame:SetDeleteOnClose(false)
	frame:SetVisible(true)
	frame:MakePopup()
	pEmotes = frame

	local dclickreminder = EasyLabel(frame, "Double click an emote to quickly try it out.")
	dclickreminder:SetPos(250 - dclickreminder:GetWide() * 0.5, 32)

	local ListView = vgui.Create("DListView", frame)
	ListView:SetMultiSelect(false)
	ListView:SetSize(484, 436 - dclickreminder:GetTall())
	ListView:SetPos(8, 36 + dclickreminder:GetTall())
	ListView:AddColumn("Say this"):SetMinWidth(242)
	ListView:AddColumn("To get this")
	ListView.DoDoubleClick = function(me, id, line)
		if line.EmoteID then
			RunConsoleCommand("say", NDB.EmotesNames[line.EmoteID])
		end
	end
	for i, emote in pairs(NDB.EmotesNames) do
		if NDB.EmotesSounds[i] then
			local toget
			if type(NDB.EmotesSounds[i]) == "table" then
				ListView:AddLine(emote, table.concat(NDB.EmotesSounds[i], ", ")).EmoteID = i
			else
				ListView:AddLine(emote, NDB.EmotesSounds[i]).EmoteID = i
			end
		end
	end

	ListView:SortByColumn(1)
end
concommand.Add("noxlistemotes", MakepEmotes)

local DEFAULT_FONT = CreateClientConVar("nox_chatbox_defaultfont", "ChatFont", true, false)

local function InvisPaint()
	return true
end

local ChatFrame
local ChatOn
local History = {}
NDB.ChatHistory = History

CHANNEL_DEFAULT = 0
CHANNEL_PLAYERSAY = 1
CHANNEL_PLAYERSAY_TEAM = 2
CHANNEL_CONSOLESAY = 3

PARSER_STANDALONE = 0
PARSER_ENCLOSE = 1
PARSER_STANDALONE_ARGS = 2
PARSER_ENCLOSE_ARGS = 3

NDB.ChatParsers = {}
function NDB.AddChatParser(parsername, paserdesc, parsertype, parsefind, parserfunction)
	NDB.ChatParsers[parsername] = {ParserName = parsername, ParserDesc = parserdesc, ParserType = parsertype or PARSER_STANDALONE, ParseFunction = parserfunction, ParseFind = parsefind or "<"..parsername..">"}
end

function NDB.EasyLineWrap(panel, text, defaultfont, defaultcolor, defaultshadowcolor, x, maxwidth)
	local panelstoadd = {}

	surface.SetFont(defaultfont)

	local words = string.RegularExplode(".%s", text)

	local spacw, ___ = surface.GetTextSize(" ")
	local accum = ""
	for i, word in ipairs(words) do
		local texw, texh = surface.GetTextSize(word)
		if maxwidth <= texw then
			table.insert(panelstoadd, EasyLabel(panel, word, defaultfont, defaultcolor))
			x = 3
			accum = ""
		elseif maxwidth <= texw + x then
			x = 3
			table.insert(panelstoadd, EasyLabel(panel, accum, defaultfont, defaultcolor))
			accum = word
		else
			if accum == "" then
				accum = word
			else
				accum = accum.." "..word
			end
			x = x + spacw + texw
		end
	end

	if 0 < string.len(accum) then
		table.insert(panelstoadd, EasyLabel(panel, accum, defaultfont, defaultcolor))
	end

	return {Panels = panelstoadd}
end

function NDB.NoParseFunction(entid, text, defaultcolor, defaultshadowcolor, defaultfont, findmin, findmax, panel, x, maxwidth, packedstuff)
	return NDB.EasyLineWrap(panel, text, defaultfont, defaultcolor, defaultshadowcolor, x, maxwidth)
end

NDB.AddChatParser("red", "<red>This text will be red</red>", PARSER_ENCLOSE, "<red>(.-)</red>", function(entid, text, defaultcolor, defaultshadowcolor, defaultfont, findmin, findmax, panel, x, maxwidth, packedstuff)
	return NDB.EasyLineWrap(panel, packedstuff[1], defaultfont, COLOR_RED, defaultshadowcolor, x, maxwidth)
end)

NDB.AddChatParser("noparse", "<noparse></noparse>", PARSER_ENCLOSE, "<noparse>(.-)</noparse>", function(entid, text, defaultcolor, defaultshadowcolor, defaultfont, findmin, findmax, panel, x, maxwidth, packedstuff)
	return NDB.NoParseFunction(entid, packedstuff[1], defaultcolor, defaultshadowcolor, defaultfont, findmin, findmax, panel, x, maxwidth, packedstuff)
end)

local function profileopen(self, mousecode)
	if mousecode == MOUSE_LEFT and not (self.Menu and self.Menu:Valid()) then
		local player = self.Player
		if player:IsValid() then
			self.Menu = NDB.GeneralPlayerMenu(player, true)
		end
	end
end

NDB.AddChatParser("info", "<info></info>", PARSER_ENCLOSE, "<info>(.-)</info>", function(entid, text, defaultcolor, defaultshadowcolor, defaultfont, findmin, findmax, panel, x, maxwidth, packedstuff)
	local result = NDB.EasyLineWrap(panel, packedstuff[1], defaultfont, defaultcolor, defaultshadowcolor, x, maxwidth)

	if result.Panels then
		local ent = Entity(entid)
		if ent:IsValid() and ent:IsPlayer() then
			for i, panel in pairs(result.Panels) do
				panel:SetMouseInputEnabled(true)
				panel:SetTooltip("Click for more options")
				panel.Player = ent
				panel.OnMousePressed = profileopen
			end
		end
	end

	return result
end)

NDB.AddChatParser("green", "<green>This text will be green</green>", PARSER_ENCLOSE, "<green>(.-)</green>", function(entid, text, defaultcolor, defaultshadowcolor, defaultfont, findmin, findmax, panel, x, maxwidth, packedstuff)
	return NDB.EasyLineWrap(panel, packedstuff[1], defaultfont, COLOR_GREEN, defaultshadowcolor, x, maxwidth)
end)

NDB.AddChatParser("blue", "<blue>This text will be blue</blue>", PARSER_ENCLOSE, "<blue>(.-)</blue>", function(entid, text, defaultcolor, defaultshadowcolor, defaultfont, findmin, findmax, panel, x, maxwidth, packedstuff)
	return NDB.EasyLineWrap(panel, packedstuff[1], defaultfont, COLOR_BLUE, defaultshadowcolor, x, maxwidth)
end)

NDB.AddChatParser("pink", "<pink>This text will be pink</pink>", PARSER_ENCLOSE, "<pink>(.-)</pink>", function(entid, text, defaultcolor, defaultshadowcolor, defaultfont, findmin, findmax, panel, x, maxwidth, packedstuff)
	return NDB.EasyLineWrap(panel, packedstuff[1], defaultfont, COLOR_PINK, defaultshadowcolor, x, maxwidth)
end)

NDB.AddChatParser("purple", "<purple>This text will be purple</purple>", PARSER_ENCLOSE, "<purple>(.-)</purple>", function(entid, text, defaultcolor, defaultshadowcolor, defaultfont, findmin, findmax, panel, x, maxwidth, packedstuff)
	return NDB.EasyLineWrap(panel, packedstuff[1], defaultfont, COLOR_PURPLE, defaultshadowcolor, x, maxwidth)
end)

NDB.AddChatParser("limegreen", "<limegreen>This text will be lime green</limegreen>", PARSER_ENCLOSE, "<limegreen>(.-)</limegreen>", function(entid, text, defaultcolor, defaultshadowcolor, defaultfont, findmin, findmax, panel, x, maxwidth, packedstuff)
	return NDB.EasyLineWrap(panel, packedstuff[1], defaultfont, COLOR_LIMEGREEN, defaultshadowcolor, x, maxwidth)
end)

NDB.AddChatParser("lightblue", "<lightblue>This text will be light blue</lightblue>", PARSER_ENCLOSE, "<lightblue>(.-)</lightblue>", function(entid, text, defaultcolor, defaultshadowcolor, defaultfont, findmin, findmax, panel, x, maxwidth, packedstuff)
	return NDB.EasyLineWrap(panel, packedstuff[1], defaultfont, COLOR_LIGHTBLUE, defaultshadowcolor, x, maxwidth)
end)

NDB.AddChatParser("black", "<black>This text will be black</black>", PARSER_ENCLOSE, "<black>(.-)</black>", function(entid, text, defaultcolor, defaultshadowcolor, defaultfont, findmin, findmax, panel, x, maxwidth, packedstuff)
	return NDB.EasyLineWrap(panel, packedstuff[1], defaultfont, COLOR_BLACK, defaultshadowcolor, x, maxwidth)
end)

NDB.AddChatParser("white", "<white>This text will be white</white>", PARSER_ENCLOSE, "<white>(.-)</white>", function(entid, text, defaultcolor, defaultshadowcolor, defaultfont, findmin, findmax, panel, x, maxwidth, packedstuff)
	return NDB.EasyLineWrap(panel, packedstuff[1], defaultfont, COLOR_WHITE, defaultshadowcolor, x, maxwidth)
end)

NDB.AddChatParser("yellow", "<yellow>This text will be yellow</yellow>", PARSER_ENCLOSE, "<yellow>(.-)</yellow>", function(entid, text, defaultcolor, defaultshadowcolor, defaultfont, findmin, findmax, panel, x, maxwidth, packedstuff)
	return NDB.EasyLineWrap(panel, packedstuff[1], defaultfont, COLOR_YELLOW, defaultshadowcolor, x, maxwidth)
end)

NDB.AddChatParser("defc", "<defc=r,g,b>The default color for any more text will be whatever RGB255 color you use.", PARSER_STANDALONE_ARGS, "<defc=(%d+),(%d+),(%d+)>", function(entid, text, defaultcolor, defaultshadowcolor, defaultfont, findmin, findmax, panel, x, maxwidth, packedstuff)
	return {DefaultColor = Color(math.min(255, packedstuff[1]), math.min(255, packedstuff[2]), math.min(255, packedstuff[3]))}
end)

NDB.AddChatParser("^RGB", "Legacy support for ^RGB.", PARSER_STANDALONE_ARGS, "%^(%d)(%d)(%d)", function(entid, text, defaultcolor, defaultshadowcolor, defaultfont, findmin, findmax, panel, x, maxwidth, packedstuff)
	return {DefaultColor = Color(math.min(255, packedstuff[1] * 28.3333333), math.min(255, packedstuff[2] * 28.333333), math.min(255, packedstuff[3] * 28.333333))}
end)

NDB.AddChatParser("deffont", "<deffont=ChatFont>The default font for any more text will be ChatFont.", PARSER_STANDALONE_ARGS, "<deffont=(.-)>", function(entid, text, defaultcolor, defaultshadowcolor, defaultfont, findmin, findmax, panel, x, maxwidth, packedstuff)
	local fntname = tostring(packedstuff[1] or "ChatFont")
	surface.SetFont(fntname)
	local texw, texh = surface.GetTextSize(fntname)
	if BetterScreenScale() * 24 <= texh then
		fntname = defaultfont
	end

	return {DefaultFont = fntname}
end)

NDB.AddChatParser("c", "<c=r,g,b>This text will be whatever RGB255 color you use</c>", PARSER_ENCLOSE_ARGS, "<c=(%d+),(%d+),(%d+)>(.-)</c>", function(entid, text, defaultcolor, defaultshadowcolor, defaultfont, findmin, findmax, panel, x, maxwidth, packedstuff)
	return NDB.EasyLineWrap(panel, packedstuff[4], defaultfont, Color(math.min(255, packedstuff[1]), math.min(255, packedstuff[2]), math.min(255, packedstuff[3])), defaultshadowcolor, x, maxwidth)
end)

NDB.AddChatParser("spellicon", "<spellicon=toxiccloud> Create an icon of a toxic cloud", PARSER_STANDALONE_ARGS, "<spellicon=(.-)>", function(entid, text, defaultcolor, defaultshadowcolor, defaultfont, findmin, findmax, panel, x, maxwidth, packedstuff)
	local fil = packedstuff[1]
	if fil and not string.find(fil, "[%c%z%^%$%(%)%%%.%[%]%*%+%-%?]") and file.Exists("../materials/spellicons/"..fil..".vmt") then
		local newpanel = vgui.Create("DImage", panel)
		newpanel:SetImage("spellicons/"..fil)
		newpanel:SizeToContents()
		local scale = BetterScreenScale()
		if scale ~= 1 then
			newpanel:SetSize(newpanel:GetWide() * scale, newpanel:GetTall() * scale)
		end

		newpanel:SetMouseInputEnabled(true)
		newpanel:SetTooltip("<spellicon="..fil..">")

		return {Panel = newpanel}
	end

	return NDB.NoParseFunction(entid, text, defaultcolor, defaultshadowcolor, defaultfont, findmin, findmax, panel, x, maxwidth, packedstuff)
end)

NDB.AddChatParser("silkicon", "<silkicon=shield> Create an icon of a shield from silkicons", PARSER_STANDALONE_ARGS, "<silkicon=(.-)>", function(entid, text, defaultcolor, defaultshadowcolor, defaultfont, findmin, findmax, panel, x, maxwidth, packedstuff)
	local fil = packedstuff[1]
	if fil then
		local mul = BetterScreenScale()
		local expl = string.Explode(",", fil)
		if expl[2] then
			fil = expl[1]
			if expl[2] == "xlarge" then
				mul = mul * 1.5
			elseif expl[2] == "large" then
				mul = mul * 1.25
			elseif expl[2] == "small" then
				mul = mul * 0.75
			elseif expl[2] == "xsmall" then
				mul = mul * 0.5
			end
		end

		if not string.find(fil, "[%c%z%^%$%(%)%%%.%[%]%*%+%-%?]") and file.Exists("../materials/gui/silkicons/"..fil..".vmt") then
			local newpanel = vgui.Create("DImage", panel)
			newpanel:SetImage("gui/silkicons/"..fil)
			newpanel:SizeToContents()
			if mul ~= 1 then
				newpanel:SetSize(newpanel:GetWide() * mul, newpanel:GetTall() * mul)
			end

			newpanel:SetMouseInputEnabled(true)
			newpanel:SetTooltip("<silkicon="..fil..">")

			return {Panel = newpanel}
		end
	end

	return NDB.NoParseFunction(entid, text, defaultcolor, defaultshadowcolor, defaultfont, findmin, findmax, panel, x, maxwidth, packedstuff)
end)

NDB.AddChatParser("emote", "<emote=ugly> Create an emoticon of the ugly laugh", PARSER_STANDALONE_ARGS, "<emote=(.-)>", function(entid, text, defaultcolor, defaultshadowcolor, defaultfont, findmin, findmax, panel, x, maxwidth, packedstuff)
	local fil = packedstuff[1]
	if fil then
		local mul = BetterScreenScale()
		local expl = string.Explode(",", fil)
		if expl[2] then
			fil = expl[1]
			if expl[2] == "xlarge" then
				mul = mul * 1.5
			elseif expl[2] == "large" then
				mul = mul * 1.25
			elseif expl[2] == "small" then
				mul = mul * 0.75
			elseif expl[2] == "xsmall" then
				mul = mul * 0.5
			end
		end

		if not string.find(fil, "[%c%z%^%$%(%)%%%.%[%]%*%+%-%?]") and file.Exists("../materials/noxemoticons/"..fil..".vmt") then
			local newpanel = vgui.Create("DImage", panel)
			newpanel:SetImage("noxemoticons/"..fil)
			newpanel:SizeToContents()
			if mul ~= 1 then
				newpanel:SetSize(newpanel:GetWide() * mul, newpanel:GetTall() * mul)
			end

			newpanel:SetMouseInputEnabled(true)
			newpanel:SetTooltip("<emote="..fil..">")

			return {Panel = newpanel}
		end
	end

	return NDB.NoParseFunction(entid, text, defaultcolor, defaultshadowcolor, defaultfont, findmin, findmax, panel, x, maxwidth, packedstuff)
end)

local function WikiClick(me)
	NDB.OpenWiki(me.Article)
end

NDB.AddChatParser("wiki", "<wiki=Zombie_Survival> Create a button that links to a wiki article called Zombie_Survival", PARSER_STANDALONE_ARGS, "<wiki=(.-)>", function(entid, text, defaultcolor, defaultshadowcolor, defaultfont, findmin, findmax, panel, x, maxwidth, packedstuff)
	local fil = packedstuff[1]
	if fil then
		if not string.find(fil, "[%c%z%^%$%(%)%%%.%[%]%*%+%-%?]") then
			local newpanel = EasyButton(panel, "Wiki: "..fil, 8, 4)
			newpanel.Article = fil
			newpanel.DoClick = WikiClick

			newpanel:SetTooltip("Click here to view the in-game wiki for "..fil)

			return {Panel = newpanel}
		end
	end

	return NDB.NoParseFunction(entid, text, defaultcolor, defaultshadowcolor, defaultfont, findmin, findmax, panel, x, maxwidth, packedstuff)
end)

NDB.AddChatParser("awardicon", "<awardicon=pest of humans,small> Create a small icon of the pest of humans award", PARSER_STANDALONE_ARGS, "<awardicon=(.-)>", function(entid, text, defaultcolor, defaultshadowcolor, defaultfont, findmin, findmax, panel, x, maxwidth, packedstuff)
	local fil = packedstuff[1]
	if fil then
		local mul = BetterScreenScale()
		local expl = string.Explode(",", fil)
		if expl[2] then
			fil = expl[1]
			if expl[2] == "small" then
				mul = mul * 0.75
			elseif expl[2] == "xsmall" then
				mul = mul * 0.5
			end
		end
		if not string.find(fil, "[%c%z%^%$%(%)%%%.%[%]%*%+%-%?]") and file.Exists("../materials/noxawards/"..fil..".vmt") then
			local newpanel = vgui.Create("DImage", panel)
			newpanel:SetImage("noxawards/"..fil)
			newpanel:SizeToContents()
			if mul ~= 1 then
				newpanel:SetSize(newpanel:GetWide() * mul, newpanel:GetTall() * mul)
			end

			newpanel:SetMouseInputEnabled(true)
			newpanel:SetTooltip("<awardicon="..fil..">")

			return {Panel = newpanel}
		end
	end

	return NDB.NoParseFunction(entid, text, defaultcolor, defaultshadowcolor, defaultfont, findmin, findmax, panel, x, maxwidth, packedstuff)
end)

NDB.AddChatParser("diamond", "<diamond> Create an icon of a diamond", PARSER_STANDALONE, "<diamond>", function(entid, text, defaultcolor, defaultshadowcolor, defaultfont, findmin, findmax, panel, x, maxwidth, packedstuff)
	local newpanel = vgui.Create("DImage", panel)
	newpanel:SetImage("gui/nox/diamond_icon")
	newpanel:SizeToContents()
	local scale = BetterScreenScale()
	if scale ~= 1 then
		newpanel:SetSize(newpanel:GetWide() * scale, newpanel:GetTall() * scale)
	end

	newpanel:SetMouseInputEnabled(true)
	newpanel:SetTooltip("<diamond>")

	return {Panel = newpanel}
end)

NDB.AddChatParser("avatar", "<avatar> Your Steam avatar", PARSER_STANDALONE, "<avatar>", function(entid, text, defaultcolor, defaultshadowcolor, defaultfont, findmin, findmax, panel, x, maxwidth, packedstuff)
	local ent = Entity(entid)
	if ent:IsValid() and ent:IsPlayer() then
		local newpanel = vgui.Create("AvatarImage", panel)
		newpanel:SetSize(32, 32)
		newpanel:SetPlayer(ent)

		newpanel:SetTooltip("<avatar> of "..ent:Name()..". Click to open Steam profile.")

		return {Panel = newpanel}
	end

	return NDB.NoParseFunction(entid, text, defaultcolor, defaultshadowcolor, defaultfont, findmin, findmax, panel, x, maxwidth, packedstuff)
end)

NDB.AddChatParser("mossman", "<mossman=angry> Create a mossman angry face", PARSER_STANDALONE_ARGS, "<mossman(.-)>", function(entid, text, defaultcolor, defaultshadowcolor, defaultfont, findmin, findmax, panel, x, maxwidth, packedstuff)
	local typ = packedstuff[1]

	if string.sub(typ, 1, 1) == "=" then
		typ = string.sub(typ, 2)
	end

	local mul = BetterScreenScale()
	local expl = string.Explode(",", typ)
	if expl[2] then
		typ = expl[1]
		if expl[2] == "small" then
			mul = mul * 0.75
		elseif expl[2] == "xsmall" then
			mul = mul * 0.5
		end
	end

	local fil
	if typ == "angry" then
		fil = "angry_eyebrows"
	elseif typ == "grin" then
		fil = "grin"
	elseif typ == "squint" then
		fil = "clear"
	elseif typ == "sleep" then
		fil = "close_eyes"
	elseif typ == "stare" then
		fil = "open_eyes"
	elseif typ == "sad" then
		fil = "sad"
	elseif typ == "smile" then
		fil = "smile"
	elseif typ == "uhoh" then
		fil = "sorry_eyebrows"
	else
		fil = "normal_eyebrows"
	end

	local newpanel = vgui.Create("DImage", panel)
	newpanel:SetImage("VGUI/face/"..fil)
	newpanel:SizeToContents()
	if mul ~= 1 then
		newpanel:SetSize(newpanel:GetWide() * mul, newpanel:GetTall() * mul)
	end

	newpanel:SetMouseInputEnabled(true)
	if fil == "normal_eyebrows" then
		newpanel:SetTooltip("<mossman>")
	else
		newpanel:SetTooltip("<mossman="..typ..">")
	end

	return {Panel = newpanel}
end)

local flashpaintoverride = function(pp)
	local tim = pp.flash_tim
	local sinwav = math.abs(math.sin((RealTime() + pp.flash_seed) * tim))

	pp:SetTextColor(Color(math.max(0, sinwav * pp.flash_desr), math.max(0, sinwav * pp.flash_desg), math.max(0, sinwav * pp.flash_desb), 255))
end
NDB.AddChatParser("flash", "<flash=255,0,0,1>This text will flash from red to white at a speed of 1.</flash>", PARSER_ENCLOSE_ARGS, "<flash=(%d+),(%d+),(%d+),(%d+)>(.-)</flash>", function(entid, text, defaultcolor, defaultshadowcolor, defaultfont, findmin, findmax, panel, x, maxwidth, packedstuff)
	local results = NDB.EasyLineWrap(panel, packedstuff[5], defaultfont, color_white, defaultshadowcolor, x, maxwidth)

	local desr = packedstuff[1]
	local desg = packedstuff[2]
	local desb = packedstuff[3]
	local tim = packedstuff[4]

	for i, panel in pairs(results.Panels) do
		panel.flash_desr = desr
		panel.flash_desg = desg
		panel.flash_desb = desb
		panel.flash_tim = tim
		panel.flash_seed = math.Rand(0, 10)
		panel.PreFlashPaint = panel.Paint
		panel.Paint = function(pp)
			flashpaintoverride(pp)
			return panel:PreFlashPaint()
		end
	end

	return results
end)

function NDB.AddPanelToChat(panel, nopaint)
	if ChatFrame and panel and ChatFrame:Valid() and panel:Valid() then
		if nopaint then
			panel.Paint = InvisPaint
		end
		ChatFrame:AddPanel(panel)
	end
end

local function TextReturn()
	local tex = ChatFrame.TextEntry
	if ChatFrame.MessageMode == "Team" then
		RunConsoleCommand("say_team", tex:GetValue())
	else
		RunConsoleCommand("say", tex:GetValue())
	end

	ChatFrame:Close()
end

function MakepChatOptions()
	if pChatOptions and pChatOptions:Valid() then
		return
	end

	local wid = 300

	local Window = vgui.Create("DFrame")
	Window:SetWide(wid)
	Window:SetTitle("Chat box options")
	Window:SetDeleteOnClose(true)
	Window:SetKeyboardInputEnabled(false)
	pChatOptions = Window

	local y = 32

	local check = vgui.Create("DCheckBoxLabel", Window)
	check:SetPos(8, y)
	check:SetText("Hide the NoXiousNet account box unless the chat is up")
	check:SetConVar("nox_accountbox_hideunlesschatting")
	check:SizeToContents()
	y = y + check:GetTall() + 2

	local check = vgui.Create("DCheckBoxLabel", Window)
	check:SetPos(8, y)
	check:SetText("Ignore all messages from players")
	check:SetConVar("nox_chatbox_ignoreplayers")
	check:SizeToContents()
	y = y + check:GetTall() + 2

	local check = vgui.Create("DCheckBoxLabel", Window)
	check:SetPos(8, y)
	check:SetText("Ignore all messages from the system")
	check:SetConVar("nox_chatbox_ignoresystem")
	check:SizeToContents()
	y = y + check:GetTall() + 2

	local check = vgui.Create("DCheckBoxLabel", Window)
	check:SetPos(8, y)
	check:SetText("Don't play emote sounds")
	check:SetConVar("nox_chatbox_ignoreemotes")
	check:SizeToContents()
	y = y + check:GetTall() + 2

	local check = vgui.Create("DCheckBoxLabel", Window)
	check:SetPos(8, y)
	check:SetText("Time stamp chat messages")
	check:SetConVar("nox_chatbox_timestamps")
	check:SizeToContents()
	y = y + check:GetTall() + 2

	Window:SetTall(y + 6)
	Window:Center()
	Window:SetVisible(true)
	Window:MakePopup()
end

function MakepRules()
	if pRules and pRules:Valid() then
		return
	end

	local wid, hei = 500, 470

	local Window = vgui.Create("DFrame")
	Window:SetSize(wid, hei)
	Window:SetTitle("Server Rules - last updated June 14, 2009")
	Window:SetDeleteOnClose(true)
	Window:SetKeyboardInputEnabled(false)
	pRules = Window

	local tentry = vgui.Create("DTextEntry", Window)
	tentry:SetEditable(false)
	tentry:SetMouseInputEnabled(true)
	tentry:SetMultiline(true)
	tentry:SetVerticalScrollbarEnabled(true)
	tentry:SetPos(8, 32)
	tentry:SetSize(wid - 16, hei - 40)
	tentry:SetValue(NDB.ServerRules)

	Window:Center()
	Window:SetVisible(true)
	Window:MakePopup()
end

hook.Add("Initialize", "NoXChat_Initialize", function()
	hook.Remove("Initialize", "NoXChat_Initialize")

	GAMEMODE.NDBChatOn = GAMEMODE.NDBChatOn or function() end
	GAMEMODE.NDBChatOff = GAMEMODE.NDBChatOff or function() end

	local w, h = ScrW(), ScrH()

	surface.CreateFont("Arial", 12, 600, true, false, "Chat_Arial12", true)
	surface.CreateFont("Arial", 14, 600, true, false, "Chat_Arial14", true)
	surface.CreateFont("Arial", 16, 600, true, false, "Chat_Arial16", true)
	surface.CreateFont("Arial", 18, 600, true, false, "Chat_Arial18", true)
	surface.CreateFont("Arial", 22, 600, true, false, "Chat_Arial22", true)
	surface.CreateFont("Arial", 24, 600, true, false, "Chat_Arial24", true)
	surface.CreateFont("Tohoma", 12, 600, true, false, "Chat_Tohoma12", true)
	surface.CreateFont("Tohoma", 14, 600, true, false, "Chat_Tohoma14", true)
	surface.CreateFont("Tohoma", 16, 600, true, false, "Chat_Tohoma16", true)
	surface.CreateFont("Tohoma", 18, 600, true, false, "Chat_Tohoma18", true)
	surface.CreateFont("Tohoma", 22, 600, true, false, "Chat_Tohoma22", true)
	surface.CreateFont("Tohoma", 24, 600, true, false, "Chat_Tohoma24", true)
	surface.CreateFont("Coolvetica", 18, 200, true, false, "Chat_Coolvetica18", true)
	surface.CreateFont("Coolvetica", 22, 200, true, false, "Chat_Coolvetica22", true)
	surface.CreateFont("Coolvetica", 24, 200, true, false, "Chat_Coolvetica24", true)
	surface.CreateFont("Verdana", 16, 600, true, false, "Chat_Verdana16", true)
	surface.CreateFont("Verdana", 18, 600, true, false, "Chat_Verdana18", true)
	surface.CreateFont("Verdana", 22, 600, true, false, "Chat_Verdana22", true)
	surface.CreateFont("Verdana", 24, 600, true, false, "Chat_Verdana24", true)
	surface.CreateFont("akbar", 18, 400, true, false, "Chat_Akbar18", true)
	surface.CreateFont("akbar", 22, 400, true, false, "Chat_Akbar22", true)
	surface.CreateFont("akbar", 24, 400, true, false, "Chat_Akbar24", true)
	surface.CreateFont("Courier New", 16, 600, true, false, "Chat_Courier16", true)
	surface.CreateFont("Courier New", 18, 600, true, false, "Chat_Courier18", true)
	surface.CreateFont("Courier New", 22, 750, true, false, "Chat_Courier22", true)
	surface.CreateFont("Courier New", 24, 800, true, false, "Chat_Courier24", true)

	local cvarChatBoxX = CreateClientConVar("nox_chatbox_x", 8, true, false)
	local cvarChatBoxY = CreateClientConVar("nox_chatbox_y", h * 0.45, true, false)
	local wid, hei = w * 0.4, h * 0.35

	local x = cvarChatBoxX:GetFloat()
	local y = cvarChatBoxY:GetFloat()

	x = math.max(0, math.min(x, w - wid))
	y = math.max(0, math.min(y, h - hei))

	ChatFrame = vgui.Create("DFrame")
	NDB.ChatFrame = ChatFrame
	ChatFrame:SetTitle("Chat")
	ChatFrame:SetDeleteOnClose(false)
	ChatFrame:SetPos(x, y)
	ChatFrame:SetSize(wid, hei)
	ChatFrame:SetVisible(true)
	ChatFrame.Close = function(me)
		ChatOn = false
		NDB.ChatOn = ChatOn
		gamemode.Call("NDBChatOff")

		me.Paint = InvisPaint
		me.ChatPanel.Paint = InvisPaint

		me:SetMouseInputEnabled(false)
		me:SetKeyboardInputEnabled(false)
		me.ChatPanel:SetMouseInputEnabled(false)
		me.ChatPanel:SetKeyboardInputEnabled(false)
		for _, panel in pairs(History) do
			if panel and panel:Valid() then
				panel:SetMouseInputEnabled(false)
				panel:SetKeyboardInputEnabled(false)
			end
		end

		me:HideChildren()

		me.ChatPanel:UpdatePanelLayout()
	end
	ChatFrame.Open = function(me, teamsay)
		ChatOn = true
		NDB.ChatOn = ChatOn
		gamemode.Call("NDBChatOn")

		if teamsay then
			me.MessageMode = "Team"
		else
			me.MessageMode = "All"
		end
		me.Paint = me.DefaultPaint
		me.ChatPanel.Paint = me.ChatPanel.DefaultPaint

		me:SetMouseInputEnabled(true)
		me:SetKeyboardInputEnabled(true)
		me.ChatPanel:SetMouseInputEnabled(true)
		me.ChatPanel:SetKeyboardInputEnabled(true)
		for _, panel in pairs(History) do
			if panel and panel:Valid() then
				panel:SetMouseInputEnabled(true)
				panel:SetKeyboardInputEnabled(true)
			end
		end

		me:ShowChildren()

		me.ChatPanel:UpdatePanelLayout()
	end

	ChatFrame.AddPanel = function(me, panel)
		table.insert(History, 1, panel)

		ChatFrame.ChatPanel:UpdatePanelLayout()
	end
	ChatFrame.Children = {}
	ChatFrame.TempChildren = {}
	ChatFrame.ShowChildren = function(me)
		for _, panel in pairs(me.Children) do
			if panel and panel:Valid() then
				panel:SetVisible(true)
			end
		end

		for _, panel in pairs(me.TempChildren) do
			if panel and panel:Valid() then
				panel:Remove()
			end
		end

		me.TempChildren = {}

		me:CreateTempChildren()
	end
	ChatFrame.HideChildren = function(me)
		for _, panel in pairs(me.Children) do
			if panel and panel:Valid() then
				panel:SetVisible(false)
			end
		end

		for _, panel in pairs(me.TempChildren) do
			if panel and panel:Valid() then
				panel:Remove()
			end
		end

		me.TempChildren = {}
	end
	ChatFrame.DefaultPaint = function(me)
		local chatpanel = me.ChatPanel
		local panw, panh = chatpanel:GetSize()
		surface.SetDrawColor(50, 50, 50, 245)
		surface.DrawRect(0, 0, 8, me:GetTall())
		surface.DrawRect(8 + panw, 0, 8, me:GetTall())
		surface.DrawRect(8, 0, panw, 32)
		surface.DrawRect(8, 32 + panh, panw, me:GetTall() - 32 - panh)
	end
	ChatFrame.Paint = InvisPaint
	ChatFrame.OldOnMouseReleased = ChatFrame.OnMouseReleased
	ChatFrame.OnMouseReleased = function(me)
		local ret = me:OldOnMouseReleased()
		local x, y = me:GetPos()
		RunConsoleCommand("nox_chatbox_x", x)
		RunConsoleCommand("nox_chatbox_y", y)
		return ret
	end

	ChatFrame:SetMouseInputEnabled(false)
	--ChatFrame:SetKeyboardInputEnabled(false)

	ChatFrame.btnClose:SetVisible(false)

	local ChatPanel = vgui.Create("DPanel", ChatFrame)
	ChatFrame.ChatPanel = ChatPanel
	ChatPanel:SetPos(8, 32)
	ChatPanel:SetSize(wid - 16, hei - 84)
	ChatPanel.UpdatePanelLayout = function(me)
		local y = me:GetTall()
		local mewide = me:GetWide()

		for i=1, #History do
			local panel = History[i]
			if panel and panel:Valid() then
				if panel.DieTime and panel.DieTime <= CurTime() then
					panel:SetVisible(ChatOn)
				end

				if panel:GetParent() ~= me then
					panel:SetParent(me)
				end
				if panel:GetWide() ~= mewide then
					panel:SetWide(mewide)
				end
				y = y - panel:GetTall()

				if y < 0 then
					for x=i, #History do
						if History[x] then
							if History[x]:Valid() then
								History[x]:Remove()
							end
							History[x] = nil
						end
					end
				else
					panel:SetPos(0, y)
				end
			end
		end
	end
	ChatFrame.CreateTempChildren = function(me)
		local tex = vgui.Create("DTextEntry", me)
		tex:SetWide(wid - 16)
		tex:SetPos(8, hei - tex:GetTall() - 8)
		tex:SetEditable(true)
		tex:SetEnterAllowed(true)
		tex.OnEnter = TextReturn
		table.insert(me.TempChildren, tex)
		me.TextEntry = tex
	end
	ChatPanel.DefaultPaint = function(me)
		surface.SetDrawColor(0, 0, 0, 230)
		surface.DrawRect(0, 0, me:GetWide(), me:GetTall())
	end
	ChatPanel.Paint = InvisPaint

	table.insert(ChatFrame.Children, ChatFrame.lblTitle)

	local fontdropdown = vgui.Create("DMultiChoice", ChatFrame)
	fontdropdown:SetWide(120)
	fontdropdown:SetPos(wid - fontdropdown:GetWide() - 8, 28 - fontdropdown:GetTall())
	fontdropdown:SetEditable(true)
	fontdropdown:SetMouseInputEnabled(true)
	fontdropdown:SetKeyboardInputEnabled(true)
	fontdropdown:SetTooltip("Changes the default font.")
	fontdropdown:SetConVar("nox_chatbox_defaultfont")
	fontdropdown:AddChoice("ChatFont")
	fontdropdown:AddChoice("Chat_Arial12")
	fontdropdown:AddChoice("Chat_Arial14")
	fontdropdown:AddChoice("Chat_Arial16")
	fontdropdown:AddChoice("Chat_Arial18")
	fontdropdown:AddChoice("Chat_Arial22")
	fontdropdown:AddChoice("Chat_Arial24")
	fontdropdown:AddChoice("Chat_Tohoma12")
	fontdropdown:AddChoice("Chat_Tohoma14")
	fontdropdown:AddChoice("Chat_Tohoma16")
	fontdropdown:AddChoice("Chat_Tohoma18")
	fontdropdown:AddChoice("Chat_Tohoma22")
	fontdropdown:AddChoice("Chat_Tohoma24")
	fontdropdown:AddChoice("Chat_Coolvetica18")
	fontdropdown:AddChoice("Chat_Coolvetica22")
	fontdropdown:AddChoice("Chat_Coolvetica24")
	fontdropdown:AddChoice("Chat_Verdana16")
	fontdropdown:AddChoice("Chat_Verdana18")
	fontdropdown:AddChoice("Chat_Verdana22")
	fontdropdown:AddChoice("Chat_Verdana24")
	fontdropdown:AddChoice("Chat_Akbar18")
	fontdropdown:AddChoice("Chat_Akbar22")
	fontdropdown:AddChoice("Chat_Akbar24")
	fontdropdown:AddChoice("Chat_Courier16")
	fontdropdown:AddChoice("Chat_Courier18")
	fontdropdown:AddChoice("Chat_Courier22")
	fontdropdown:AddChoice("Chat_Courier24")
	table.insert(ChatFrame.Children, fontdropdown)

	local undery = 36 + hei - 84
	local butx = wid - 8
	local emotebutton = vgui.Create("DImageButton", ChatFrame)
	emotebutton:SetImage("gui/silkicons/sound")
	emotebutton:SizeToContents()
	butx = butx - emotebutton:GetWide()
	emotebutton:SetPos(butx, undery)
	butx = butx - 8
	emotebutton:SetTooltip("Displays a list of emotes")
	emotebutton.DoClick = MakepEmotes
	table.insert(ChatFrame.Children, emotebutton)

	local tagsbutton = vgui.Create("DImage", ChatFrame)
	tagsbutton:SetImage("gui/info")
	tagsbutton:SizeToContents()
	butx = butx - emotebutton:GetWide()
	tagsbutton:SetPos(butx, undery)
	butx = butx - 8
	local toolt = table.Count(NDB.ChatParsers).." available markup tags...\n"
	for parsername, parsertab in pairs(NDB.ChatParsers) do
		if parsertab.ParseFind then
			toolt = toolt..parsername.." - "..parsertab.ParseFind.."\n"
		end
	end
	tagsbutton:SetMouseInputEnabled(true)
	tagsbutton:SetTooltip(toolt)
	table.insert(ChatFrame.Children, tagsbutton)

	local awardsbutton = vgui.Create("DImageButton", ChatFrame)
	awardsbutton:SetImage("gui/silkicons/star")
	awardsbutton:SizeToContents()
	butx = butx - awardsbutton:GetWide()
	awardsbutton:SetPos(butx, undery)
	butx = butx - 8
	awardsbutton:SetTooltip("Displays a list of every available award.")
	awardsbutton.DoClick = function() NDB.ViewAllAwards() end
	table.insert(ChatFrame.Children, awardsbutton)

	local newsbutton = vgui.Create("DImageButton", ChatFrame)
	newsbutton:SetImage("gui/silkicons/newspaper")
	newsbutton:SizeToContents()
	newsbutton:SetPos(8, undery)
	newsbutton:SetTooltip("Displays the latest news and announcements!")
	newsbutton.DoClick = function() MakepNews() end
	newsbutton.OldPaint = newsbutton.Paint
	newsbutton.FlashColor = Color(255, 255, 255, 255)
	newsbutton.Whited = true
	newsbutton.Paint = function(bb)
		bb:OldPaint()

		if NEWNEWS then
			bb.Whited = nil

			local col = bb.FlashColor
			local sat = math.abs(math.sin(RealTime() * 20)) * 200 + 55
			col.g = sat
			col.b = sat
			bb.m_Image:SetImageColor(col)
		elseif not bb.Whited then
			bb.Whited = true
			bb.m_Image:SetImageColor(color_white)
		end
	end
	table.insert(ChatFrame.Children, newsbutton)

	local portalbutton = vgui.Create("DImageButton", ChatFrame)
	portalbutton:SetImage("gui/silkicons/world")
	portalbutton:SizeToContents()
	butx = butx - portalbutton:GetWide()
	portalbutton:SetPos(butx, undery)
	butx = butx - 8
	portalbutton:SetTooltip("Server portal - quickly connect to other NoXiousNet servers.")
	portalbutton.DoClick = function() MakepPortal() end
	table.insert(ChatFrame.Children, portalbutton)

	local optionsbutton = vgui.Create("DImageButton", ChatFrame)
	optionsbutton:SetImage("gui/silkicons/wrench")
	optionsbutton:SizeToContents()
	butx = butx - optionsbutton:GetWide()
	optionsbutton:SetPos(butx, undery)
	butx = butx - 8
	optionsbutton:SetTooltip("Chat box options")
	optionsbutton.DoClick = MakepChatOptions
	table.insert(ChatFrame.Children, optionsbutton)

	local rulesbutton = vgui.Create("DImageButton", ChatFrame)
	rulesbutton:SetImage("gui/silkicons/exclamation")
	rulesbutton:SizeToContents()
	butx = butx - rulesbutton:GetWide()
	rulesbutton:SetPos(butx, undery)
	butx = butx - 8
	rulesbutton:SetTooltip("Server rules")
	rulesbutton.DoClick = MakepRules
	table.insert(ChatFrame.Children, rulesbutton)

	local donationsbutton = vgui.Create("DImageButton", ChatFrame)
	donationsbutton:SetImage("gui/silkicons/money_dollar")
	donationsbutton:SizeToContents()
	butx = butx - donationsbutton:GetWide()
	donationsbutton:SetPos(butx, undery)
	butx = butx - 8
	donationsbutton:SetTooltip("Donations")
	donationsbutton.DoClick = function() OpenDonationHTML() end
	table.insert(ChatFrame.Children, donationsbutton)

	ChatFrame:HideChildren()

	local function pack(...) return arg end

	local function ChatPanelPaint(pp)
		return true
	end

	local function AddPanelToChatPanel(panel, newpanel, x, y, maxwidth, maxlineheight)
		table.insert(panel.Children, newpanel)

		local newwid = newpanel:GetWide()
		local newtal = newpanel:GetTall()

		if maxwidth - 3 < newwid then
			newpanel:SetPos(x, y)
			maxlineheight = math.max(maxlineheight, newtal)
			x = 3
			y = y + maxlineheight
		elseif maxwidth < x + newwid then
			x = 3
			y = y + maxlineheight
			newpanel:SetPos(x, y)
			maxlineheight = math.max(maxlineheight, newtal)
			x = x + newwid
		else
			newpanel:SetPos(x, y)
			x = x + newwid
			maxlineheight = math.max(maxlineheight, newtal)
		end

		return x, y, maxlineheight
	end

	function NDB.CreateChatPanel(entid, text, defaultcolor, defaultshadowcolor, defaultfont)
		local panel = vgui.Create("Panel")
		panel.Children = {}
		panel.Paint = ChatPanelPaint
		local maxwidth = ChatFrame.ChatPanel:GetWide()

		local foundnothing
		local x, y, maxlineheight = 3, 3, 0
		while not foundnothing do
			foundnothing = true

			local mintype
			local minimumlocation = -1

			for parsername, parsertab in pairs(NDB.ChatParsers) do
				if parsertab.ParseFunction then
					local findmin, findmax = string.find(text, parsertab.ParseFind)
					if findmin then
						foundnothing = false
						if minimumlocation == -1 then
							minimumlocation = findmin
						else
							minimumlocation = math.min(minimumlocation, findmin)
						end
						
						if findmin == minimumlocation then
							mintype = parsername
						end
					end
				end
			end

			if mintype then
				local parsertab = NDB.ChatParsers[mintype]
				if parsertab.ParseFunction then
					local packedstuff = pack(string.find(text, parsertab.ParseFind))
					local findmin, findmax = packedstuff[1], packedstuff[2]
					table.remove(packedstuff, 1) table.remove(packedstuff, 1) packedstuff.n = packedstuff.n - 2

					if findmin then
						local result = parsertab.ParseFunction(entid, text, defaultcolor, defaultshadowcolor, defaultfont, findmin, findmax, panel, x, maxwidth, packedstuff) or {}

						local resultpanel = result.Panel

						local aheadtext = result.AheadText or string.sub(text, findmax + 1)
						local behindtext = result.BehindText or string.sub(text, 1, findmin - 1)
						if 0 <= string.len(behindtext) then
							for i, newpanel in ipairs(NDB.EasyLineWrap(panel, behindtext, defaultfont, defaultcolor, defaultshadowcolor, x, maxwidth).Panels) do
								x, y, maxlineheight = AddPanelToChatPanel(panel, newpanel, x, y, maxwidth, maxlineheight)
							end
						end

						if result.Panels then
							for q, newpanel in ipairs(result.Panels) do
								if newpanel and newpanel:Valid() then
									x, y, maxlineheight = AddPanelToChatPanel(panel, newpanel, x, y, maxwidth, maxlineheight)
								end
							end
						elseif resultpanel and resultpanel:Valid() then
							x, y, maxlineheight = AddPanelToChatPanel(panel, resultpanel, x, y, maxwidth, maxlineheight)
						end

						text = aheadtext

						if result.DefaultColor then
							defaultcolor = result.DefaultColor
						end
						if result.DefaultShadowColor then
							defaultshadowcolor = result.DefaultShadowColor
						end
						if result.DefaultFont then
							defaultfont = result.DefaultFont
						end
					end
				end
			end
		end

		if 0 < string.len(text) then
			for i, newpanel in ipairs(NDB.EasyLineWrap(panel, text, defaultfont, defaultcolor, defaultshadowcolor, x, maxwidth).Panels) do
				x, y, maxlineheight = AddPanelToChatPanel(panel, newpanel, x, y, maxwidth, maxlineheight)
			end
		end

		local biggesttall = 2
		for i, testpanel in pairs(panel.Children) do
			local px, py = testpanel:GetPos()
			biggesttall = math.max(py + testpanel:GetTall(), biggesttall)
		end
		panel:SetWide(maxwidth)
		panel:SetTall(biggesttall)

		return panel
	end

	hook.Add("OnPlayerChat", "NoXChat_OnPlayerChat", function(pl, text, teamonly, isdead)
		if pl:IsValid() and pl:IsPlayer() then
			if teamonly then
				NDB.FullChatText(pl:EntIndex(), pl:Name(), text, "chat", teamonly, CHANNEL_PLAYERSAY_TEAM)
			else
				NDB.FullChatText(pl:EntIndex(), pl:Name(), text, "chat", teamonly, CHANNEL_PLAYERSAY)
			end
		end

		return true
	end)

	hook.Add("HUDShouldDraw", "DestroyOldChatBox", function(name)
		if name == "CHudChat" and not ChatOn then return false end
	end)

	local cvarIgnoreChat = CreateClientConVar("nox_chatbox_ignoreplayers", 0, true, false)
	local cvarIgnoreSystemMessages = CreateClientConVar("nox_chatbox_ignoresystem", 0, true, false)
	local cvarIgnoreEmotes = CreateClientConVar("nox_chatbox_ignoreemotes", 0, true, false)
	local cvarUseTimeStamps = CreateClientConVar("nox_chatbox_timestamps", 0, true, false)
	local colDefault = Color(255, 255, 255, 255)
	function NDB.FullChatText(entid, name, text, filter, teamonly, channel)
		local defaultcolor = colDefault
		local defaultshadowcolor = color_black
		local defaultfont = DEFAULT_FONT:GetString()
		local defaulttext = text

		name = name or ""
		if text and 0 < string.len(text) then
			if channel == CHANNEL_PLAYERSAY then
				local ent = Entity(entid)
				if ent:IsValid() and ent:IsPlayer() then
					local emote
					if (ent.NextEmote or 0) <= CurTime() then
						for i, nam in pairs(NDB.EmotesNames) do
							if defaulttext == nam then
								if ent:GetObserverMode() == 0 then
									local snds = NDB.EmotesSounds[i]
									if snds then
										local snd

										if type(snds) == "string" then
											snd = snds
										else
											snd = snds[math.random(1, #snds)]
										end
										local mdlname = string.lower(ent:GetModel())
										if string.find(mdlname, "mossman", 1, true) or string.find(mdlname, "female", 1, true) or string.find(mdlname, "alyx", 1, true) then
											snd = string.gsub(snd, "/male", "/female")
										end
										if not cvarIgnoreEmotes:GetBool() then
											if ent.VoicePitch then
												ent:EmitSound(snd, 75, ent.VoicePitch)
												local length = SoundDuration(snd)
												ent.NextEmote = CurTime() + length + length * (100 - ent.VoicePitch) * 0.005
											else
												ent:EmitSound(snd)
												ent.NextEmote = CurTime() + SoundDuration(snd)
											end
										end
										emote = NDB.EmotesNoChat[i]

										if NDB.EmotesCallbacks[i] then
											NDB.EmotesCallbacks[i](ent, i, snds)
										end
									end
								else
									emote = true
								end

								break
							end
						end
					end

					if emote then
						defaulttext = ""
					else
						local col = team.GetColor(ent:Team()) or color_white
						chat.AddText(col, tostring(name), color_white, ": "..tostring(text))

						if cvarIgnoreChat:GetBool() then return end

						chat.PlaySound()

						local title = ent.NewTitle or ""
						if string.lower(title) == "none" then
							title = ""
						end
						if title ~= "" then
							title = title.." "
						end

						defaulttext = title.."<defc="..col.r..","..col.g..","..col.b.."><info>"..name.."</info><defc="..defaultcolor.r..","..defaultcolor.g..","..defaultcolor.b..">: "..text
					end
				elseif name == "" then
					defaulttext = text
				else
					defaulttext = name..": "..text
				end
			elseif channel == CHANNEL_PLAYERSAY_TEAM then
				local ent = Entity(entid)
				if ent:IsValid() and ent:IsPlayer() then
					local col = team.GetColor(ent:Team()) or color_white
					chat.AddText(color_white, "[TEAM] ", col, tostring(name), color_white, ": "..tostring(text))

					if cvarIgnoreChat:GetBool() then return end

					chat.PlaySound()

					local title = ent.NewTitle or ""
					if string.lower(title) == "none" then
						title = ""
					end
					if title ~= "" then
						title = title.." "
					end

					defaulttext = "[TEAM] "..title.."<defc="..col.r..","..col.g..","..col.b.."><info>"..name.."</info><defc="..defaultcolor.r..","..defaultcolor.g..","..defaultcolor.b..">: "..text
				elseif name == "" then
					defaulttext = "[TEAM] "..text
				else
					defaulttext = "[TEAM] "..name..": "..text
				end
			elseif channel == CHANNEL_CONSOLESAY then
				if filter == "chat" then
					chat.AddText(COLOR_RED, tostring(name), color_white, ": "..tostring(text))

					if cvarIgnoreSystemMessages:GetBool() then return end

					chat.PlaySound()
					defaulttext = "<flash=255,0,0,10>"..name.."</flash>: "..text
				else
					print(tostring(text))

					if cvarIgnoreSystemMessages:GetBool() then return end

					local finmi, findma, nam = string.find(text, "Player (.-) has")
					if nam then
						text = string.Replace(text, nam, "<limegreen>"..nam.."</limegreen>")
					else
						local finmi2, findma2, nam2 = string.find(text, "Player (.-) left")
						if nam2 then
							text = string.Replace(text, nam2, "<red>"..nam2.."</red>")
						end
					end
					defaulttext = text
				end
			end
		end

		if defaulttext and 0 < string.len(defaulttext) then
			if cvarUseTimeStamps:GetBool() then
				defaulttext = "<red>["..os.date("%I:%M:%S %p").."]</red> "..defaulttext
			end

			local panel = NDB.CreateChatPanel(entid, defaulttext, defaultcolor, defaultshadowcolor, defaultfont)

			if panel then
				panel.DieTime = panel.DieTime or (CurTime() + 10)
				timer.Simple(10, ChatPanel.UpdatePanelLayout, ChatPanel)
				NDB.AddPanelToChat(panel)
			end
		end
	end

	hook.Add("ChatText", "NoXChat_ChatText", function(entid, name, text, filter)
		if entid == 0 then
			NDB.FullChatText(entid, name, text, filter, false, CHANNEL_CONSOLESAY)
		else
			NDB.FullChatText(entid, name, text, filter, false, CHANNEL_DEFAULT)
		end

		return true
	end)

	hook.Add("StartChat", "NoXChat_StartChat", function(teamsay)
		ChatFrame:Open(teamsay)

		hook.Remove("HUDShouldDraw", "DestroyOldChatBox")

		return true
	end)

	hook.Add("FinishChat", "NoXChat_FinishChat", function()
		ChatFrame:Close()
	end)

	hook.Add("ChatTextChanged", "NoXChat_ChatTextChanged", function(text)
		ChatFrame.TextEntry:SetValue(text)
	end)

	collectgarbage("collect")
end)

-- SandBox event.
--[[
local function Rate(btn)
	local slider = btn.Slider
	RunConsoleCommand("rateskit", slider:GetValue())
	RunConsoleCommand("say", slider:GetValue().."!")

	btn:GetParent():Remove()
end

function RateThing(name)
	local frame = vgui.Create("DFrame")
	frame:SetWide(200)
	frame:SetTitle("Rate the skit: "..name)
	frame:SetDeleteOnClose(true)

	local y = 32

	local slider = vgui.Create("DNumSlider", frame)
	slider:SetDecimals(0)
	slider:SetValue(3)
	slider:SetMinMax(1, 5)
	slider:SetText("Score")
	slider:SizeToContents()
	slider:SetWide(184)
	slider:SetPos(100 - slider:GetWide() * 0.5, y)
	y = y + slider:GetTall() + 8

	local button = EasyButton(frame, "Rate!", 8, 4)
	button:SetPos(100 - button:GetWide() * 0.5, y)
	button.DoClick = Rate
	button.Slider = slider
	y = y + button:GetTall()

	frame:SetTall(y + 8)
	frame:Center()
	frame:SetVisible(true)
	frame:MakePopup()
end
]]
