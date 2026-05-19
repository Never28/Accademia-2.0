/************************ [On Rested] ******************************************
    Filename: j_ai_onrest or nw_c2_defaulta
************************* [On Rested] ******************************************
    This will play the sitting animation for 6 seconds, just something for resting.
    Also, walks waypoints (as resting would stop this) :-) and signals event (if so be)
    Feel free to edit.

    It does have the spell trigger information resetting, however. This can
    only be removed if they have no spell triggers, although it is hardly worth it.
************************* [History] ********************************************
    1.3 - Added sitting.
************************* [Workings] *******************************************
    This fires once, at the END of resting.

    If ClearAllActions is added, the resting is actually stopped, or so it seems.

    It doesn't fire more then once.
************************* [Arguments] ******************************************
    Arguments: None, it seems.
************************* [On Rested] *****************************************/

#include "j_inc_constants"
#include "j_ai_remove"

// Resets all spell triggers used for sString
void LoopResetTriggers(string sString, object oTrigger);

void main()
{
            DeleteLocalFloat(OBJECT_SELF,"AuraDiEntangle_POSITION1");
            DeleteLocalFloat(OBJECT_SELF,"AuraDiEntangle_POSITION2");
            DeleteLocalFloat(OBJECT_SELF,"AuraDiEntangle_POSITION3");
            DeleteLocalFloat(OBJECT_SELF,"AuraDiSpike_POSITION1");
            DeleteLocalFloat(OBJECT_SELF,"AuraDiSpike_POSITION2");
            DeleteLocalFloat(OBJECT_SELF,"AuraDiSpike_POSITION3");
            DeleteLocalFloat(OBJECT_SELF,"AuraDiVine1_POSITION1");
            DeleteLocalFloat(OBJECT_SELF,"AuraDiVine1_POSITION2");
            DeleteLocalFloat(OBJECT_SELF,"AuraDiVine1_POSITION3");
            DeleteLocalFloat(OBJECT_SELF,"AuraDiVine2_POSITION1");
            DeleteLocalFloat(OBJECT_SELF,"AuraDiVine2_POSITION2");
            DeleteLocalFloat(OBJECT_SELF,"AuraDiVine2_POSITION3");
            DeleteLocalFloat(OBJECT_SELF,"AuraDiVine3_POSITION1");
            DeleteLocalFloat(OBJECT_SELF,"AuraDiVine3_POSITION2");
            DeleteLocalFloat(OBJECT_SELF,"AuraDiVine3_POSITION3");
            DeleteLocalInt(OBJECT_SELF,"AuraDiEvard_CURRENT");
            DeleteLocalInt(OBJECT_SELF,"AuraDiOdore_CURRENT");
            DeleteLocalInt(OBJECT_SELF,"AuraDiStone_CURRENT");
            DeleteLocalInt(OBJECT_SELF,"AuraDiVine1_CURRENT");
            DeleteLocalInt(OBJECT_SELF,"AuraDiVine2_CURRENT");
            DeleteLocalInt(OBJECT_SELF,"AuraDiVine3_CURRENT");
            DeleteLocalInt(OBJECT_SELF,"AuraDiCprDoom_CURRENT");
            DeleteLocalInt(OBJECT_SELF,"AuraDiWeb_CURRENT");
            DeleteLocalInt(OBJECT_SELF,"AuraDiStorm_CURRENT");
            DeleteLocalInt(OBJECT_SELF,"AuraDiAcidFog_CURRENT");
            DeleteLocalInt(OBJECT_SELF,"AuraDiWallFire_CURRENT");
            DeleteLocalInt(OBJECT_SELF,"AuraDiLame_CURRENT");
            DeleteLocalInt(OBJECT_SELF,"AuraDiIncendiary_CURRENT");
            DeleteLocalInt(OBJECT_SELF,"AuraDiSpike_CURRENT");
            DeleteLocalInt(OBJECT_SELF,"AuraDiMind_CURRENT");
            DeleteLocalInt(OBJECT_SELF,"AuraDiPerp_CURRENT");
            DeleteLocalInt(OBJECT_SELF,"AuraDiKill_CURRENT");
            DeleteLocalString(OBJECT_SELF,"AuraDiKill_IMMUNI");
            DeleteLocalInt(OBJECT_SELF,"AuraDiFear_CURRENT");
            DeleteLocalString(OBJECT_SELF,"AuraDiFear_IMMUNI");
            DeleteLocalInt(OBJECT_SELF,"AuraDiGrease_CURRENT");
            DeleteLocalInt(OBJECT_SELF,"AuraDiEntangle_CURRENT");
            DeleteLocalInt(OBJECT_SELF,"AuraDiTerra_CURRENT");
            DeleteLocalInt(OBJECT_SELF,"AuraDiElettro_CURRENT");
            DeleteLocalInt(OBJECT_SELF,"AuraDiFuoco_CURRENT");
            DeleteLocalInt(OBJECT_SELF,"AuraDiFreddo_CURRENT");
            DeleteLocalInt(OBJECT_SELF,"AuraDiDrago_CURRENT");
            DeleteLocalString(OBJECT_SELF,"AuraDiDrago_IMMUNI");
            DeleteLocalInt(OBJECT_SELF,"AuraDiMorte_CURRENT");
            DeleteLocalString(OBJECT_SELF,"AuraDiMorte_IMMUNI");
            DeleteLocalInt(OBJECT_SELF,"AuraDiAcceca_CURRENT");
            DeleteLocalString(OBJECT_SELF,"AuraDiAcceca_IMMUNI");
            DeleteLocalInt(OBJECT_SELF,"AuraDiTroglo_CURRENT");
            DeleteLocalString(OBJECT_SELF,"AuraDiTroglo_IMMUNI");

    if(FireUserEvent(AI_FLAG_UDE_RESTED_PRE_EVENT, EVENT_RESTED_PRE_EVENT))
        // We may exit if it fires
        if(ExitFromUDE(EVENT_RESTED_PRE_EVENT)) return;

    // AI status check. Is the AI on?
    if(GetAIOff()) return;

    // Simple debug.
    // 66: "[Rested] Resting. Type: " + IntToString(GetLastRestEventType())
    DebugActionSpeakByInt(66, OBJECT_INVALID, GetLastRestEventType());

    // Reset all spell triggers.
    // Set all triggers
    object oTrigger = GetAIObject(AI_SPELL_TRIGGER_CREATURE);
    if(GetIsObjectValid(oTrigger))
    {
        LoopResetTriggers(SPELLTRIGGER_NOT_GOT_FIRST_SPELL, oTrigger);
        LoopResetTriggers(SPELLTRIGGER_DAMAGED_AT_PERCENT, oTrigger);
        LoopResetTriggers(SPELLTRIGGER_IMMOBILE, oTrigger);
        LoopResetTriggers(SPELLTRIGGER_START_OF_COMBAT, oTrigger);
    }
    // Some sitting for a few seconds.
    ActionPlayAnimation(ANIMATION_LOOPING_SIT_CROSS, f1, f6);
    DelayCommand(f9, ExecuteScript(FILE_WALK_WAYPOINTS, OBJECT_SELF));

    if(GetLocalInt(OBJECT_SELF,"DEADMAGIC_SPELLFAILURE"))
    {
        DelayCommand(f7,RemoveSpellsAndAbilitys(OBJECT_SELF));
    }

    // Fire End-heartbeat-UDE
    FireUserEvent(AI_FLAG_UDE_RESTED_EVENT, EVENT_RESTED_EVENT);
}

// Resets all spell triggers used for sString
void LoopResetTriggers(string sString, object oTrigger)
{
    int iCnt, iBreak, iUsed;
    for(iCnt = i1; iBreak != TRUE; iCnt++)
    {
        // Check max for this setting
        iUsed = GetLocalInt(oTrigger, sString + USED);
        if(iUsed)
        {
            DeleteLocalInt(oTrigger, sString + USED);
        }
        else
        {
            iBreak = TRUE;
        }
    }
}
