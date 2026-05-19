//::///////////////////////////////////////////////
//:: Knock
//:: NW_S0_Knock
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Opens doors not locked by magical means.
*/
//:://////////////////////////////////////////////
//:: Created By: Preston Watamaniuk
//:: Created On: Nov 29, 2001
//:://////////////////////////////////////////////
//:: Last Updated By: Georg 2003/07/31 - Added signal event and custom door flags
//:: VFX Pass By: Preston W, On: June 22, 2001
#include "nw_i0_spells"

#include "x2_inc_spellhook"


void main()
{

/*
  Spellcast Hook Code
  Added 2003-06-23 by GeorgZ
  If you want to make changes to all spells,
  check x2_inc_spellhook.nss to find out more

*/

    if (!X2PreSpellCastCode())
    {
    // If code within the PreSpellCastHook (i.e. UMD) reports FALSE, do not run this spell
        return;
    }

// End of Spell Cast Hook


    object oTarget;
    effect eVis = EffectVisualEffect(VFX_IMP_KNOCK);
    oTarget = GetFirstObjectInShape(SHAPE_SPHERE, 50.0, GetLocation(OBJECT_SELF), FALSE, OBJECT_TYPE_DOOR | OBJECT_TYPE_PLACEABLE);
    float fDelay;
    int nResist;

    while(GetIsObjectValid(oTarget))
    {
        SignalEvent(oTarget,EventSpellCastAt(OBJECT_SELF,GetSpellId()));
        fDelay = GetRandomDelay(0.5, 2.5);
        if(!GetPlotFlag(oTarget) && GetLocked(oTarget))
        {
            int nLockDC = GetLockLockDC(oTarget);
            int nCasterLevel = GetCasterLevel(OBJECT_SELF);
            int nSpellCraft = GetSkillRank(SKILL_SPELLCRAFT,OBJECT_SELF);
            int nDice = d20(1);
            int nRollTest = nDice+(nSpellCraft/2)+nCasterLevel;
            if(nRollTest>=nLockDC){
                DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget));
                AssignCommand(oTarget, ActionUnlockObject(oTarget));
            }
        }
        oTarget = GetNextObjectInShape(SHAPE_SPHERE, 50.0, GetLocation(OBJECT_SELF), FALSE, OBJECT_TYPE_DOOR | OBJECT_TYPE_PLACEABLE);
    }
}
