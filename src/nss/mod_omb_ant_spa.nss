//This var is how often the check for hiding is made per second
const float CHECK_HIDE_DELAY = 0.25;

void ThinkChecks(float nTimeLeft,object oPlayer);

/*******************************************************************************
--------------------------------------------------------------------------------
|||||||||||||||||||||||     MAIN ROUTINES DOWN HERE      |||||||||||||||||||||||
--------------------------------------------------------------------------------
*******************************************************************************/
void DoHideCheck(object oPC, int nCurrentTime)
{
    if (!GetHasFeat(FEAT_HIDE_IN_PLAIN_SIGHT, oPC))
        return;
    string VAR_NEXT_HIDE = "HIDE_NEXTAVAIL";
    string VAR_LAST_HIDDEN = "TIME_LAST_HIDDEN";
    string VAR_LAST_VIS = "TIME_LAST_VISIBLE";
    int nHideDelay = 6; //you can only hide once per round
    int nLastHide = GetLocalInt(oPC, VAR_LAST_HIDDEN);
    int nNextHide = GetLocalInt(oPC, VAR_NEXT_HIDE);
    int nHideMe = FALSE;
    if (!GetActionMode(oPC, ACTION_MODE_STEALTH))
    {
        SetLocalInt(oPC, VAR_LAST_VIS, TRUE);
    }
    else if (GetLocalInt(oPC, VAR_LAST_VIS) && nLastHide > nCurrentTime)
    {
        string sHideTime = IntToString(nLastHide-nCurrentTime);
        SetActionMode(oPC, ACTION_MODE_STEALTH, FALSE);
        SetLocalInt(oPC, VAR_NEXT_HIDE, TRUE);
        object oPC2 = GetFirstPC();
        while(oPC2!=OBJECT_INVALID){
            if(oPC2!=oPC&&GetIsReactionTypeHostile(oPC,oPC2)==TRUE)
                ApplyEffectToObject(DURATION_TYPE_TEMPORARY,EffectTrueSeeing(),oPC2,IntToFloat(nLastHide-nCurrentTime));
            oPC2 = GetNextPC();
        }
        FloatingTextStringOnCreature("*You will hide in "+sHideTime+" seconds*", oPC, FALSE);
    }
    else
        nHideMe = TRUE;
    //if they lag, they can still send the command and itll happen once they're ready
    if (nHideMe || nNextHide && nLastHide<=nCurrentTime)
    {
        // *if they are in combat, it autohides, and quickly attacks
        if (GetIsInCombat(oPC))
        {
            object oTarget = GetAttackTarget(oPC);
            SetActionMode(oPC, ACTION_MODE_STEALTH, TRUE);
            AssignCommand(oPC, ActionAttack(oTarget));
        }
        else
            SetActionMode(oPC, ACTION_MODE_STEALTH, TRUE);
        SetLocalInt(oPC, VAR_NEXT_HIDE, FALSE);
        SetLocalInt(oPC, VAR_LAST_VIS, FALSE);
        SetLocalInt(oPC, VAR_LAST_HIDDEN, nCurrentTime + nHideDelay);
    }
}
void ThinkChecks(float nTimeLeft,object oPlayer)
{
    //We're done here
    if (nTimeLeft<0.5)
        return;
    //We'll pass this into deeper functions
    int nCurrentTime =  (GetCalendarYear())*12*28*24*60*60 +
                        (GetCalendarMonth()-1)*28*24*60*60 +
                        (GetCalendarDay()-1)*24*60*60 +
                        GetTimeHour()*60*60 +
                        GetTimeMinute()*60 +
                        GetTimeSecond();
    DoHideCheck(oPlayer, nCurrentTime);
    //Check again you ***
    DelayCommand(CHECK_HIDE_DELAY, ThinkChecks(nTimeLeft-CHECK_HIDE_DELAY,oPlayer));
}
