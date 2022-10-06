Time <- 0.00;
SaveTime <- 0.00;
TimerTick <- true; //Таймер
TimerText <- "";

function MapSpawn()
{
    EntFire("cmd", "Command", "mp_freezetime 0", 0.0, "");
    EntFire("cmd", "Command", "mp_roundtime 60", 0.0, "");
    EntFire("cmd", "Command", "sv_staminamax 0", 0.0, "");
	EntFire("cmd", "Command", "sv_staminalandcost 0", 0.0, "");
	EntFire("cmd", "Command", "sv_staminajumpcost 0", 0.0, "");
	EntFire("cmd", "Command", "sv_staminarecoveryrate 0", 0.0, "");
	EntFire("cmd", "Command", "sv_accelerate_use_weapon_speed 0", 0.0, "");
	EntFire("cmd", "Command", "sv_airaccelerate 9999", 0.0, "");
    EntFire("cmd", "Command", "mp_warmup_end", 0.0, "");
    EntFire("cmd", "Command", "mp_startmoney 0", 0.0, "");
    EntFire("cmd", "Command", "mp_maxmoney 0", 0.0, "");
    EntFire("cmd", "Command", "sv_disable_radar 0", 0.0, "");
    EntFire("cmd", "Command", "mp_autokick 0", 0.0, "");
    EntFire("cmd", "Command", "sv_infinite_ammo 2", 0.0, "");
    EntFire("music_initcounter", "FireUser1", "", 0.0, "");
    EntFire("sprites_initcounter", "FireUser1", "", 0.0, "");
    EntFire("throne_room_laser", "TurnOn", "", 0.0, "");
    EntFire("sprite_counter", "GetValue", "", 0.02, "");
    EntFire("music_counter", "GetValue", "", 0.02, "");
    EntFire("bts", "Kill", "", 0.00, "");
    EntFire("spawn_text1", "Kill", "", 0.00, "");
    EntFire("hurt_spawn", "Addoutput", "maxs 176 476 128", 1.5, "");
    EntFire("hurt_spawn", "Addoutput", "mins -176 -476 -128", 1.5, "");
    EntFire("hurt_spawn", "Addoutput", "solid 2", 0.5, "");
    EntFire("trigger_weapons", "Addoutput", "maxs 16 96 16", 1.5, "");
    EntFire("trigger_weapons", "Addoutput", "mins -16 -96 -16", 1.5, "");
    EntFire("trigger_weapons", "Addoutput", "solid 2", 0.5, "");
    EntFire("npc_move_targett", "Addoutput", "maxs 871 720 327,5", 1.5, "");
    EntFire("npc_move_targett", "Addoutput", "mins -871 -720 -327,5", 1.5, "");
    EntFire("npc_move_targett", "Addoutput", "solid 2", 0.5, "");
}

function TimerMap(timer, text)
{
   TimerTick = true;
   Time = timer;
   SaveTime = timer;
   AddText(text);
   StartTextHud();
}

function StopTimer(){TimerTick = false;}

function ResetTimer(){Time = SaveTime;}

function AddTime(t){Time += t;}

function AddText(text)
{
	if(text == 1){TimerText = "SURVIVE: ";}
}

function StartTimer(){TimerTick = true;StartTextHud();}

function StartTextHud()
{
    if(TimerTick)
    {
        local min1 = (((Time/60) % 60) % 10);
        local min2 = (((Time/60) % 60) / 10);
        local sec1 = ((Time % 60) % 10);
        local sec2 = ((Time % 60) / 10);
        for(local au = 1; au < 2; au++)
        {
            if(au == 1)
            {
                ScriptPrintMessageCenterAll(TimerText+""+min2+""+min1+":"+sec2+""+sec1);
                Time--;
            }
            if(Time == -1)
            {
                Time = SaveTime;
                return;
            }
        }
        EntFireByHandle(self,"RunScriptCode","StartTextHud();",1.00,null,null);
    }
}

function SpawnButton()
{
    EntFire("fadeout_1", "Fade", "", 0.00, "");
    EntFire("teleport_spawn", "Enable", "", 9.00, "");
    EntFire("teleport_spawn", "Disable", "", 20.00, "");
    EntFire("chapter5_text", "Display", "", 10.00, "");
    EntFire("new_chapter_sound", "PlaySound", "", 10.00, "");
    EntFire("new_chapter_sound", "StopSound", "", 15.00, "");
    EntFire("spawn_text", "Kill", "", 10.0, "");
    EntFire("hurt_spawn", "Enable", "", 21.00, "");
    EntFireByHandle(self, "RunScriptCode", "Info(1);", 21.0, null, null);
    EntFireByHandle(self,"Kill","",0.0,null,null);
}

function ElevatorButton()
{
    EntFire("lever1", "SetAnimation", "pull", 0.00, "");
    EntFire("levelr_sound", "PlaySound", "", 0.00, "");
    EntFire("clocktower_elevator_sprite", "ShowSprite", "", 0.00, "");
    EntFire("clocktower_sound", "PlaySound", "", 0.00, "");
    ScriptPrintMessageChatAll(" \x04[RU]\x08 Быстрее на лифт, он уедет через 10 секунд");
    ScriptPrintMessageChatAll(" \x04[EN]\x08 Get on the elevator, it's leaving in 10 seconds");
    EntFire("clocktower_carpet", "Break", "", 0.00, "");
    EntFire("level_sound", "StopSound", "", 1.0, "");
    EntFire("lever1", "SetAnimation", "idle", 1.0, "");
    EntFire("clocktower_door", "Open", "", 11.0, "");
    EntFire("clocktower_sound", "PlaySound", "", 12.00, "");
    EntFire("teleport_spawn_destination", "Addoutput", "origin 13386 -7910 5853", 0.00, "");
    EntFireByHandle(self,"Kill","",0.0,null,null);
}

function ClockButton()
{
    EntFire("lever2", "SetAnimation", "pull", 0.00, "");
    EntFire("clocktower_linear", "Open", "", 0.00, "");
    EntFire("lever_sound", "PlaySound", "", 0.00, "");
    EntFire("clocktower_elevator_sprite", "HideSprite", "", 0.00, "");
    EntFire("clocktower_interance_music", "StopSound", "", 0.00, "");
    EntFire("lever_sound", "StopSound", "", 1.00, "");
    EntFireByHandle(self,"Kill","",0.0,null,null);
}

function ClockTrigger()
{
    EntFire("merryxmas_timer", "Enable", "", 0.00, "");
    EntFire("creepy_ambient1_relay", "Trigger", "", 0.00, "");
    EntFire("latepeople_teleport7_1", "Enable", "", 15.00, "");
    EntFireByHandle(self,"Kill","",16.0,null,null);
}

function SantaStart()
{
    EntFire("Santa_voice_1", "PlaySound", "", 0.00, "");
    EntFire("bosswarning_text3", "Kill", "", 0.00, "");
    EntFire("santa_music_trigger_relay", "Trigger", "", 4.00, "");
    EntFire("Santa_voice_1", "StopSound", "", 10.00, "");
    EntFireByHandle(self,"RunScriptCode","Info(2);",1.0,null,null);
}

function Info(n)
{
    if(n == 0)
	{
        ScriptPrintMessageChatAll(" \x04[RU]\x08 Автовозрождение включено");
        ScriptPrintMessageChatAll(" \x04[EN]\x08 Respawn enabled");
	}
	else if(n == 1)
	{
        ScriptPrintMessageChatAll(" \x04[RU]\x08 Автовозрождение отключено");
        ScriptPrintMessageChatAll(" \x04[EN]\x08 Respawn disabled");
	}
    else if(n == 2)
	{
        ScriptPrintMessageChatAll(" \x04[Санта Клаус]\x08 Хо-Хо-Хо, вы добрались так далеко? впечатляет, Хо-Хо-Хо, ДАВАЙТЕ ПОИГРАЕМ");
        ScriptPrintMessageChatAll(" \x04[Santa Claus]\x08 Ho Ho Ho, you made it this far? impressive Ho Ho Ho, LETS PLAY");
	}
    else if(n == 3)
	{
        ScriptPrintMessageChatAll(" \x04[Ты]\x08 Куда делся Санта?");
        ScriptPrintMessageChatAll(" \x04[You]\x08 Where has Santa gone?");
	}
    else if(n == 4)
	{
        ScriptPrintMessageChatAll(" \x04[RU]\x02 САНТА ИСПОЛЬЗУЕТ ВЗРЫВООПАСНЫЙ ГРУНТ");
        ScriptPrintMessageChatAll(" \x04[EN]\x02 SANTA USED EXPLOSIVE GROUND");
	}
    else if(n == 5)
	{
        ScriptPrintMessageChatAll(" \x04[RU]\x02 САНТА ИСПОЛЬЗУЕТ СИЛЬНЫЙ СНЕГОПАД");
        ScriptPrintMessageChatAll(" \x04[EN]\x02 SANTA USED HEAVY SNOW");
	}
    else if(n == 6)
	{
        ScriptPrintMessageChatAll(" \x04[RU]\x02 САНТА ИСПОЛЬЗУЕТ БОЛЬШИЕ ПОДАРКИ");
        ScriptPrintMessageChatAll(" \x04[EN]\x02 SANTA USED BIG GIFTS");
	}
    else if(n == 7)
	{
        ScriptPrintMessageChatAll(" \x04[Санта Клаус]\x08 Хо-Хо-Хо, Я ЕЩЕ НЕ ЗАКОНЧИЛ...");
        ScriptPrintMessageChatAll(" \x04[Santa Claus]\x08 Ho Ho Ho, I AM NOT DONE YET...");
	}
    else if(n == 8)
    {
        ScriptPrintMessageChatAll(" \x04[RU]\x08 Воины, вы удивили меня... При нашей последней встречи в деревне, я пытался вернуться на верный путь ");
        ScriptPrintMessageChatAll(" \x04[EN]\x08 You Warriors impress me... My encounter with you at the village was me trying to go back on your way");
    }
    else if(n == 9)
    {
       ScriptPrintMessageChatAll(" \x04[RU]\x08 Моя магическая сила становится только сильнее и Королю Драконов становится всё сложнее найти нас");
       ScriptPrintMessageChatAll(" \x04[EN]\x08 My Magic attack is only getting stronger which makes it harder for the Dragon King to find us.");
    }
    else if(n == 10)
    {
        ScriptPrintMessageChatAll(" \x04[RU]\x08 Я помогу вам добраться до Крахвена, победить его и открыть путь до его трона ");
        ScriptPrintMessageChatAll(" \x04[EN]\x08 I will be able to help you to reach KrahVen to defeat him and unlock the way to the Dragon King's Throne");
    }    
    else if(n == 11)
    {
        ScriptPrintMessageChatAll(" \x04[RU]\x08 Но вы должны пообещать мне, что победите его и освободите нас от его правления");
        ScriptPrintMessageChatAll(" \x04[EN]\x08 But you have to promise me that you defeat him and free us from his reign");
    }    
    else if(n == 12)
    {
        ScriptPrintMessageChatAll(" \x04[RU]\x08 Быстрее, заласте на мою спину, я отвезу вас к нему");
        ScriptPrintMessageChatAll(" \x04[EN]\x08 Quickly, hope on my back, I shall take you to him.");
    }
    else if(n == 13)
    {
        ScriptPrintMessageChatAll(" \x04[Ты]\x08 Что? Как мы здесь оказались?");
        ScriptPrintMessageChatAll(" \x04[You]\x08 What? How did we get here?");
    }                
    else if(n == 14)
    {
        ScriptPrintMessageChatAll(" \x04[Ты]\x08 Мы должны найти способ выбраться из этой башни");
        ScriptPrintMessageChatAll(" \x04[You]\x08 We should fine a way to get out of The Tower");
    }  
    else if(n == 15)
    {
        ScriptPrintMessageChatAll(" \x04[Дух]\x08 Убейте стража в квадратной башне, чтобы открыть эту дверь");
        ScriptPrintMessageChatAll(" \x04[Spirit]\x08 Kill the guardian on The Squared Tower to unlock this door");
    }
    else if(n == 16)
    {
        ScriptPrintMessageChatAll(" \x04[Дух]\x08 Возьмите шлем, чтобы призвать его");
        ScriptPrintMessageChatAll(" \x04[Spirit]\x08 Take a helmet to summon him");
    }
    else if(n == 17)
    {
        ScriptPrintMessageChatAll(" \x04[Крахвен]\x08 Итак... вы зашли так далеко, воины...");
        ScriptPrintMessageChatAll(" \x04[KrahVen]\x08 So...you have made it this far, warriors...");
    }
    else if(n == 18)
    {
        ScriptPrintMessageChatAll(" \x04[Крахвен]\x08 Вы умрёте...как и все остальные...");
        ScriptPrintMessageChatAll(" \x04[KrahVen]\x08 You are going to die...just like everyone else...");
    }
    else if(n == 19)
    {
        ScriptPrintMessageChatAll(" \x04[Крахвен]\x08 У вас нет никаких шансов против нас...");
        ScriptPrintMessageChatAll(" \x04[KrahVen]\x08 You have no chance against us...");
    }
    else if(n == 20)
    {
        ScriptPrintMessageChatAll(" \x04[Крахвен]\x08 ВСТРЕЧАЙТЕ СВОЙ ПРОКЛЯТЫЙ КОНЕЦ ПРЯМО СЕЙЧАС!!!");
        ScriptPrintMessageChatAll(" \x04[KrahVen]\x08 MEET YOUR DAMNED END NOW!!!");
    }
    else if(n == 21)
    {
        ScriptPrintMessageChatAll(" \x04[RU]\x02 Крахвен использует Максимальный толчок \x09  БЕГИТЕ К БОССУ!!!");
        ScriptPrintMessageChatAll(" \x04[EN]\x02 KrahVen used Ultimate Push \x09  RUN TO THE BOSS!!! ");
    }
    else if(n == 22)
    {
        ScriptPrintMessageChatAll(" \x04[RU]\x02 Крахвен использует Падающие шипы \x09  СМОТРИТЕ НА ВВЕРХ И УВОРАЧИВАЙТЕСЬ!!!");
        ScriptPrintMessageChatAll(" \x04[EN]\x02 KrahVen used Falling Spikes \x09  LOOK UP AND DODGE!!! ");
    }
    else if(n == 23)
    {
        ScriptPrintMessageChatAll(" \x04[RU]\x02 Крахвен использует Замораживающий Лазер \x09  УВОРАЧИВАЙТЕСЬ!!!");
        ScriptPrintMessageChatAll(" \x04[EN]\x02 KrahVen used Freezing Laser \x09  DODGE!!! ");
    }
    else if(n == 24)
    {
        ScriptPrintMessageChatAll(" \x04[RU]\x02 Крахвен заряжает Замораживающий ветер \x09  СТРЕЛЯЙТЕ В СИНЕГО ДУХА!!!");
        ScriptPrintMessageChatAll(" \x04[EN]\x02 KrahVen charges Freeze-Wind \x09  SHOOT THE BLUE SPIRIT!!! ");
    }
    else if(n == 25)
    {
        ScriptPrintMessageChatAll(" \x04[RU]\x02 НЕ ПОЗВОЛЬТЕ ЕМУ БРОСИТЬСЯ В АТАКУ, СТРЕЛЯЙТЕ В НЕГО!");
        ScriptPrintMessageChatAll(" \x04[EN]\x02 DON'T LET HIM CHARGE THE ATTACK SHOOT IT! ");
    }
    else if(n == 26)
    {
        ScriptPrintMessageChatAll(" \x04[RU]\x02 Крахвен использует Максимальный Боковой Толчок \x09  БЕГИТЕ НАЛЕВО!!!");
        ScriptPrintMessageChatAll(" \x04[EN]\x02 KrahVen used Ultimate Side Push \x09  RUN TO THE LEFT!!! ");
    }
    else if(n == 27)
    {
        ScriptPrintMessageChatAll(" \x04[RU]\x02 Крахвен использует Замораживающий Метеор \x09  ВСТАНЬТЕ НА КРАЙ ХВОСТА ИЛИ КРЫЛЬЕВ!!!");
        ScriptPrintMessageChatAll(" \x04[EN]\x02 KrahVen used Freeze Meteor \x09  STAND ON THE EDGE OF THE TAIL OR WINGS!!! ");
    }
    else if(n == 28)
    {
        ScriptPrintMessageChatAll(" \x04[RU]\x02 Крахвен использует Замораживающие Шипы \x09  СЯДЬТЕ МЕЖДУ ШИПАМИ!!!");
        ScriptPrintMessageChatAll(" \x04[EN]\x02 KrahVen used Freezing Spikes \x09  SIT BETWEEN THE SPIKES!!! ");
    }
    else if(n == 29)
    {
        ScriptPrintMessageChatAll(" \x04[RU]\x08 Отличная работа, воины........... остался только один путь");
        ScriptPrintMessageChatAll(" \x04[EN]\x08 Good job warriors...........only one left to go");
    }
    else if(n == 30)
    {
        ScriptPrintMessageChatAll(" \x04[RU]\x08 Вы должны войти в этот портал, чтобы вернуться в замок, я скоро буду там, чтобы помочь вам");
        ScriptPrintMessageChatAll(" \x04[EN]\x08 You have to take this portal to get back to the castle, I will be there to help you soon");
    }
    else if(n == 31)
    {
        ScriptPrintMessageChatAll(" \x04[RU]\x08 Я должен расплатиться с некоторыми долгами.... пусть белый свет укажет вам путь....");
        ScriptPrintMessageChatAll(" \x04[EN]\x08 I have to settle some debts....may the white light guide your way....");
    }
    else if(n == 32)
    {
        ScriptPrintMessageChatAll(" \x04[RU]\x02 Король Драконов призывает Безглазого Дракона");
        ScriptPrintMessageChatAll(" \x04[EN]\x02 DragonKing summons Eyeless Dragon");
    }
    else if(n == 33)
    {
        ScriptPrintMessageChatAll(" \x04[RU]\x08 Безглазый Дракон собирается нас раздавить! \x09  ПРИСЯДЬТЕ!!! ");
        ScriptPrintMessageChatAll(" \x04[EN]\x08 The Eyeless Dragon going to crush us! \x09  CROUCH!!!");
    }
    else if(n == 34)
    {
        ScriptPrintMessageChatAll(" \x04[RU]\x08 Безглазый Дракон использует Мега-Исцеление");
        ScriptPrintMessageChatAll(" \x04[EN]\x08 The Eyeless Dragon used Mega Heal");
    }
    else if(n == 35)
    {
        ScriptPrintMessageChatAll(" \x04[RU]\x02 Король Драконов призывает Крахвена");
        ScriptPrintMessageChatAll(" \x04[EN]\x02 DragonKing summons KrahVen");
    }
    else if(n == 36)
    {
        ScriptPrintMessageChatAll(" \x04[RU]\x08 Крахвен использует Максимальный Толчок \x09  БЕГИТЕ НАЛЕВО!!! ");
        ScriptPrintMessageChatAll(" \x04[EN]\x08 KrahVen used Ultimate Push \x09  RUN TO THE LEFT!!!");
    }
    else if(n == 37)
    {
        ScriptPrintMessageChatAll(" \x04[RU]\x08 Крахвен использует Максимальный Толчок \x09  БЕГИТЕ НАПРАВО!!! ");
        ScriptPrintMessageChatAll(" \x04[EN]\x08 KrahVen used Ultimate Push \x09  RUN TO THE RIGHT!!!");
    }
    else if(n == 38)
    {
        ScriptPrintMessageChatAll(" \x04[RU]\x08 Крахвен использует Космические шипы \x09  СМОТРИТЕ НА ВВЕРХ И УВОРАЧИВАЙТЕСЬ!!! ");
        ScriptPrintMessageChatAll(" \x04[EN]\x08 KrahVen used Cosmic Spikes \x09  LOOK UP AND DODGE!!!");
    }
    else if(n == 39)
    {
        ScriptPrintMessageChatAll(" \x04[RU]\x02 Король Драконов призывает Балрога");
        ScriptPrintMessageChatAll(" \x04[EN]\x02 DragonKing summons Balrog");
    }
    else if(n == 40)
    {
        ScriptPrintMessageChatAll(" \x04[RU]\x08 Балрог использует Сверкающий Лазер \x09  УВОРАЧИВАЙТЕСЬ!!! ");
        ScriptPrintMessageChatAll(" \x04[EN]\x08 Balrog used Blazing Laser \x09  DODGE!!!");
    }
    else if(n == 41)
    {
        ScriptPrintMessageChatAll(" \x04[RU]\x08 Балрог использует Максимальный Сверкающий Лазер \x09  УВОРАЧИВАЙТЕСЬ!!! ");
        ScriptPrintMessageChatAll(" \x04[EN]\x08 Balrog used Ultimate Blazing Laser \x09  DODGE!!!");
    }
    else if(n == 42)
    {
        ScriptPrintMessageChatAll(" \x04[RU]\x08 Король Драконов использует Космические Метеориты \x09  УВОРАЧИВАЙТЕСЬ!!! ");
        ScriptPrintMessageChatAll(" \x04[EN]\x08 DragonKing used Cosmic Meteors \x09  DODGE!!!");
    }
    else if(n == 43)
    {
        ScriptPrintMessageChatAll(" \x04[RU]\x08 Король драконов призывает Мёртвое Солнце \x09  СЛОМАЙТЕ ЕГО!!! ");
        ScriptPrintMessageChatAll(" \x04[EN]\x08 DragonKing summons Dead Sun \x09  BREAK IT DOWN!!!");
    }
    else if(n == 44)
    {
        ScriptPrintMessageChatAll(" \x04[RU]\x08 Король драконов заряжает Световые Звёзды \x09  СЛОМАЙТЕ ИХ ПОКА ОНИ НЕ ЗАРЯДИЛИСЬ!!! ");
        ScriptPrintMessageChatAll(" \x04[EN]\x08 DragonKing charges Light stars \x09  BREAK THEM BEFORE THEY CHARGE UP!!!");
    }
    else if(n == 45)
    {
        ScriptPrintMessageChatAll(" \x04[RU]\x08 Король драконов использует Космическую Звезду \x09  ПОСМОТРИ НА ВВЕРХ!!! ");
        ScriptPrintMessageChatAll(" \x04[EN]\x08 DragonKing used Cosmic Star \x09  LOOK UP!!!");
    }
    else if(n == 46)
    {
        ScriptPrintMessageChatAll(" \x04[RU]\x08 Король драконов использует Божественный Толчок \x09  ВСТАНЬТЕ НА КРАЙ АРЕНЫ!!! ");
        ScriptPrintMessageChatAll(" \x04[EN]\x08 DragonKing used Almighty Push \x09  STAND ON THE EDGE OF THE ARENA!!!");
    }
    else if(n == 47)
    {
        ScriptPrintMessageChatAll(" \x04[RU]\x08 Король драконов использует чёрную дыру \x09  БЕГИТЕ НАЗАД!!! ");
        ScriptPrintMessageChatAll(" \x04[EN]\x08 DragonKing used Black Hole \x09  RUN TO THE BACK!!!");
    }
    else if(n == 48)
    {
        ScriptPrintMessageChatAll(" \x04[RU]\x08 Карту сделал \x02 Demon \x08 Стриппер сделал \x02 vedesh \x08 и \x02 Scarfox ");
        ScriptPrintMessageChatAll(" \x04[EN]\x08 Map made by \x02 Demon \x08 Stripper by \x02 vedesh \x08 and \x02 Scarfox");
    }
}
