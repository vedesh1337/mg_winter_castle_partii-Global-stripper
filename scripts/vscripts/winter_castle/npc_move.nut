PI <- 3.14159;
TARGET <- null;
STOP_M <- false;
DEBUG <- false;
TRIG_PL_ARR <- [];
TRIGGER_TARGER <- true;
PathEnd_U <- false;
Boss_Start <- false;
BOSS_MOVE_S <- true;

npc_model <- EntityGroup[0];
npc_move <- EntityGroup[1];
npc_trigger <- EntityGroup[2];
npc_path <- EntityGroup[3];
npc_path_1 <- EntityGroup[4];

Reverse_Move <- false;
Retarget_Time <- 5.00;
Refire_Time <- 0.50;
Refire_Time_Base <- 0.01;
Time_N <- 0.00;
mode_movement <- 0; //0 default, 1 fly
percent_move <- 80;
speed_turning <- 3.00; // > 1, if 0 instant turning
// limit_move <- [Vector(0,0,0),Vector(0,0,128), false]; //true enable limit movement, false disable, //0 = max, 1 = min
trigger_chenter <- null;
lim_save <- [Vector(0,0,0),Vector(0,0,0)];
lm_ang <- 90;
ang_lim <- 5;
ang_dif_t <- 0;

function OnPostSpawn()
{
    EntFireByHandle(npc_move, "AddOutput", "angles 0 0 0", 0.15, null, null);
    if(npc_trigger != null && npc_trigger.IsValid())
    {
        // trigger_chenter = npc_trigger.GetOrigin();
        // local d_mc = npc_trigger.GetBoundingMaxs();
        // local d_mic = npc_trigger.GetBoundingMins();
        // limit_move[0].x = (trigger_chenter.x + d_mc.x).tointeger();
        // limit_move[0].y = (trigger_chenter.y + d_mc.y).tointeger();
        // limit_move[1].x = (trigger_chenter.x + d_mic.x).tointeger();
        // limit_move[1].y = (trigger_chenter.y + d_mic.y).tointeger();
        // lim_save[0].x = limit_move[0].x;
        // lim_save[0].y = limit_move[0].y;
        // lim_save[1].x = limit_move[1].x;
        // lim_save[1].y = limit_move[1].y;
        EntFireByHandle(npc_model, "ClearParent", "", 0.10, null, null);
        EntFireByHandle(npc_model, "SetParent", "!activator", 0.20, npc_move, null);
    }
}

function StartMove(ang_d=0, r=0, trig_tar=0)
{
    if(ang_d != 0){ang_dif_t = ang_d;}
    if(r != 0){Reverse_Move = true;}
    if(trig_tar != 0){TRIGGER_TARGER = false;}
    if(!BOSS_MOVE_S)return;
    EntFireByHandle(self, "RunScriptCode", "StartMove();", Refire_Time_Base, null, null);
    if(!Boss_Start)
    {
        Boss_Start = true;
        FindTarget();
    }
    if(!PathEnd_U)
    {
        EntFireByHandle(npc_move, "StartBackward", "", 0.00, null, null);
        PathEnd_U = true;
    }
    if(STOP_M)
    {
        EntFireByHandle(npc_move, "Stop", "", 0.00, null, null);
        return;
    }
    if(TARGET != null && TARGET.IsValid())
    {
        local gto = TARGET.GetOrigin();
        local npc_m_gto = npc_model.GetOrigin();
        local tm_ang = 0;
        Reverse_Move ? tm_ang = GetPithYawFVect3D(npc_path.GetOrigin(), npc_m_gto) : tm_ang = GetPithYawFVect3D(npc_m_gto, npc_path.GetOrigin())
        tm_ang += 90;
        local m_ang = npc_model.GetAngles();
        if(mode_movement == 0){npc_path.SetOrigin(Vector(gto.x,gto.y,npc_move.GetOrigin().z));}
        else if(mode_movement == 1){npc_path.SetOrigin(gto-Vector(0, 0, 10));}
        else if(mode_movement == 2){npc_path.SetOrigin(Vector(gto.x, gto.y, -10463));}
        local conv_pr_ang = tm_ang + 180;
        local conv_m_ang = (m_ang.y + 360) % 360;
        local ang_lim_p = conv_pr_ang - conv_m_ang;
        SetGraduallyAng(tm_ang, m_ang.y, ang_lim_p, npc_model);
        // if(conv_m_ang / conv_pr_ang * 100 >= percent_move){} 
        EntFireByHandle(npc_move, "StartForward", "", 0.00, null, null);
        // else{EntFireByHandle(npc_move, "Stop", "", 0.00, null, null);}
    }
    if(DEBUG)
    {
        ScriptPrintMessageCenterAll("Time_N: "+Time_N+"\nTarTrig: "+TRIGGER_TARGER+"\nPlinTrig: "+TRIG_PL_ARR.len());
        DrawBoxInPath();
    }
}

function FindTarget()
{
    if(!BOSS_MOVE_S)return;
    EntFireByHandle(self, "RunScriptCode", "FindTarget();", Refire_Time, null, null);
    Time_N += Refire_Time;
    if(!TRIGGER_TARGER)
    {
        if(!GetTargetV() || Time_N >= Retarget_Time)
        {
            if("PLAYERS" in getroottable())
            {
                Time_N = 0.00;
                TARGET = null;
                if(PLAYERS.len() > 0)
                {
                    local pl_s = [];
                    for(local i = 0; i < PLAYERS.len(); i++)
                    {
                        if(PLAYERS[i].handle != null && PLAYERS[i].handle.IsValid() && PLAYERS[i].handle.GetTeam() == 3 && CheckPosPl(PLAYERS[i].handle))
                        {
                            pl_s.push(PLAYERS[i].handle);
                        }
                    }
                    if(pl_s.len() < 1)return;
                    return TARGET = pl_s[RandomInt(0,pl_s.len()-1)];
                }
            }
        }
    }
    else
    {
        if(!GetTargetVTrig() || Time_N >= Retarget_Time)
        {
            if(TRIG_PL_ARR.len() > 0){TRIG_PL_ARR.clear();}
            Time_N = 0.00;
            TARGET = null;
            RestartTrigger();
            return;
        }
    }
}

function RestartTrigger()
{
    if(!BOSS_MOVE_S)return;
    EntFireByHandle(npc_trigger, "Disable", "", 0.00, null, null);
    EntFireByHandle(npc_trigger, "Enable", "", 0.03, null, null);
    EntFireByHandle(self, "RunScriptCode", "SetTargetInTrigger();", 0.05, null, null);
}

function SetTargetInTrigger()
{
    if(TRIG_PL_ARR.len() > 0)
    {
        local target_t = TRIG_PL_ARR[RandomInt(0,TRIG_PL_ARR.len()-1)];
        if(DEBUG){ScriptPrintMessageChatAll("TARGET: "+target_t);}
        return TARGET = target_t;
    }
    else
    {
        return TARGET = null;
    }
}

function AddPlayers()
{
    TRIG_PL_ARR.push(activator);
}

function CheckEndTouch()
{
    if(TRIG_PL_ARR.len() > 0 && TARGET != null && activator == TARGET){TARGET = null;}
}

function CheckPosPl(h)
{
    if(npc_trigger == null)return true;
    local gto_pl = h.GetOrigin();
    local max_x = trigger_chenter.x + npc_trigger.GetBoundingMaxs().x;
    local min_x = trigger_chenter.x + npc_trigger.GetBoundingMins().x;
    local max_y = trigger_chenter.y + npc_trigger.GetBoundingMaxs().y;
    local min_y = trigger_chenter.y + npc_trigger.GetBoundingMins().y;
    if(gto_pl.x <= max_x && gto_pl.x >= min_x && gto_pl.y <= max_y && gto_pl.y >= min_y)
    {
        return true;
    }
    return false;
}

function GetTargetV()
{
    if(TARGET == null || !TARGET.IsValid() || TARGET.GetHealth() <= 0 || !CheckPosPl(TARGET))
    {
        return false; 
    }
    return true;
}

function GetTargetVTrig()
{
    if(TARGET == null || !TARGET.IsValid() || TARGET.GetHealth() <= 0)
    {
        return false; 
    }
    return true;
}

function SetRetargetTime(n){Retarget_Time = n;}

function ToggleMove()
{
    if(STOP_M){return STOP_M = false;}
    return STOP_M = true;
}

function CheckTM()
{
    if(STOP_M){return;}
    EntFireByHandle(caller, "FireUser1", "", 0.00, null, null);
}

function SetGraduallyAng(ang_t, get_mang, ang_lim_p, ent) //ang_t to tar ang //get_mang ang model
{
    local ang_c = 0.00 + get_mang;
    if(speed_turning == 0){return npc_model.SetAngles(0,ang_t.tointeger(),0);}
	local ang = abs((ang_c - ang_t + 360) % 360);
    if(ang_c >= 355){ang_c = 0;}
    if(ang_c <= -355){ang_c = 0;}
    if(ang_lim_p > ang_lim || ang_lim_p < -ang_lim)
    {
        if(ang <= 180){ang_c += speed_turning;}
        else{ang_c -= speed_turning;}
        ent.SetAngles(0,ang_c,0);
    }
}

function SetLimDist(x_max, x_min, y_max, y_min)
{
    limit_move[0].x = lim_save[0].x;
    limit_move[0].y = lim_save[0].y;
    limit_move[1].x = lim_save[1].x;
    limit_move[1].y = lim_save[1].y;
    limit_move[0].x -= x_max;
    limit_move[0].y -= y_max;
    limit_move[1].x += x_min;
    limit_move[1].y += y_min;
    if(!limit_move[2]){limit_move[2] = true;}
}

function LimitMovement(c, fly=false)
{
    local lim_coord_x = c.x;
    local lim_coord_y = c.y;
    if(c.x > limit_move[0].x)
    {
        lim_coord_x = limit_move[0].x - 40;
    }
    if(c.x < limit_move[1].x && c.x < 0) // min
    {
        lim_coord_x = limit_move[1].x + 40;
    }
    else if(c.x < limit_move[1].x && c.x > 0)
    {
        lim_coord_x = limit_move[1].x + 40;
    }
    if(c.y > limit_move[0].y)
    {
        lim_coord_y = limit_move[0].y - 40;
    }
    if(c.y < limit_move[1].y && c.y < 0) //min
    {
        lim_coord_y = limit_move[1].y + 40;
    }
    else if(c.y < limit_move[1].y && c.y > 0)
    {
        lim_coord_y = limit_move[1].y + 40;
    }
    if(!fly)
    {
        if(CheckLimPos(c))
        {
            return Vector(c.x, c.y, npc_path.GetOrigin().z);
        }
        return Vector(lim_coord_x, lim_coord_y, npc_path.GetOrigin().z);
    }
    else
    {
        if(CheckLimPos(c))
        {
            return Vector(c.x, c.y, c.z);
        }
        return Vector(lim_coord_x, lim_coord_y, c.z);
    }
}

function CheckLimPos(c)
{
    if(c.x <= limit_move[0].x && c.x >= limit_move[1].x && c.y <= limit_move[0].y && c.y >= limit_move[1].y)
    {
        return true;
    }
    return false;
}

function GetPithYawFVect3D(a, b)
{
    local deltaX = a.x - b.x;
    local deltaY = a.y - b.y;
    local yaw = (atan2(deltaY,deltaX) * 180 / PI);
    return yaw.tointeger();
}

function SetSpeedTurning(n)
{
    speed_turning = n.tofloat();
}

function SetPercentMove(n)
{
    percent_move = n.tointeger();
}

function SetMoveSpeed(n)
{
    EntFireByHandle(npc_move, "AddOutput", "startspeed "+n, 0.00, null, null);
}

function SetModMove(n)
{
    mode_movement = n;
}

function LimitMoveToggle()
{
    if(limit_move[2])
    {
        return limit_move[2] = false
    }
    limit_move[2] = true;
}

function DisableMove(sec, delay)
{
    for(local i = 0.00; i < sec; i+=delay){EntFireByHandle(self, "RunScriptCode", "STOP_M = true;", i, null, null);}
    EntFireByHandle(self, "RunScriptCode", "STOP_M = false;", sec, null, null);
}

function EnableMove(){STOP_M = false;}

function DistanceCheck2D(obj, path_c)
{
    local dist = (obj.x-path_c.x)*(obj.x-path_c.x)+(obj.y-path_c.y)*(obj.y-path_c.y);
    return sqrt(dist).tointeger();
}

function PassPathEnd(){PathEnd_U = false;}

function BossKill()
{
    npc_move.Destroy();
    BOSS_MOVE_S = false;
    EntFireByHandle(npc_trigger, "Kill", "", 0.50, null, null);
    EntFireByHandle(npc_path, "Kill", "", 0.50, null, null);
    EntFireByHandle(npc_path_1, "Kill", "", 0.50, null, null);
    EntFireByHandle(self, "Kill", "", 0.50, null, null);
}

function DrawBoxInPath()
{
    if(DEBUG)
    {
        if(npc_path != null)
        {
            local gto_p = npc_path.GetOrigin();
            DebugDrawBox(npc_move.GetOrigin(), Vector(-16,-16,0), Vector(16, 16, 32), 255, 0, 0, 100, 0.20);    
            DebugDrawBox(gto_p, Vector(-16,-16,0), Vector(16, 16, 32), 255, 0, 0, 100, 0.20);            
        }
    }
}
////////////////////////////////////////////////////////
////////////////////////////////////////////////////////
//////////////////////////////////////////////////////// V0u0V

MAKER_BATTACK <- Entities.FindByName(null, "s25boss_atkmaker2");
TEMPLATE_BATTACK <- Entities.FindByName(null, "s5_boss_beam_temp");

Hit <- 0;
Dist <- 0;

function SpawnAttackB()
{
    if(MAKER_BATTACK == null || !MAKER_BATTACK.IsValid())return;
    if(TEMPLATE_BATTACK == null || !TEMPLATE_BATTACK.IsValid())return;
    TraceDir(npc_model.GetOrigin(), Vector(0,0,-1), 32768.00, null);
    MAKER_BATTACK.__KeyValueFromString("EntityTemplate", TEMPLATE_BATTACK.GetName().tostring());
    DebugDrawLine(npc_model.GetOrigin(), Hit+Vector(0, 0, 110), 0, 255, 0, true, 5.00);
    DebugDrawBox(Hit+Vector(0, 0, 110), Vector(-8, -8, -8), Vector(8, 8, 8), 255, 0, 0, 200, 5.00);
    MAKER_BATTACK.SpawnEntityAtLocation(Hit+Vector(0, 0, 110), Vector(0, RandomInt(0, 360), 0));
}

function TraceDir(orig, dir, maxd, filter)
{
	local frac = TraceLine(orig,orig+dir*maxd,filter);
	if(frac == 1.0){return Hit = orig+(dir*maxd), Dist = 0.0;}
	return Hit = orig+(dir*(maxd*frac)), Dist = maxd*frac;
}
