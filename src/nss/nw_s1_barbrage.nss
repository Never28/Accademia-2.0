          //::///////////////////////////////////////////////
//:: Barbarian Rage
//:: NW_S1_BarbRage
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    The Str and Con of the Barbarian increases,
    Will Save are +2, AC -2.
    Greater Rage starts at level 15.
*/
//:://////////////////////////////////////////////
//:: Created By: Preston Watamaniuk
//:: Created On: Aug 13, 2001
//:://////////////////////////////////////////////

#include "x2_i0_spells"

void main()
{
    if(!GetHasFeatEffect(FEAT_BARBARIAN_RAGE))
    {
        //Declare major variables
        int nLevel = GetLevelByClass(CLASS_TYPE_BARBARIAN);
        int nIncrease;
        int nIncrease2;
        int nIncrease3;
        int nSave;
        if (nLevel < 15)
        {
            nIncrease = 2;
            nIncrease2 = 20;
            nIncrease3 = 3;
            nSave = 2;
        }
        else
        {
            nIncrease = 4;
            nIncrease2 = 40;
            nIncrease3 = 5;
            nSave = 3;
        }

        //Determine the duration by getting the con modifier after being modified
        int nCon = 6 + (GetAbilityModifier(ABILITY_CONSTITUTION)*2);
        effect eStr = EffectAttackIncrease(nIncrease,ATTACK_BONUS_MISC);
        effect eCon = EffectTemporaryHitpoints(nIncrease2);
        effect eDanno = EffectDamageIncrease(nIncrease3,DAMAGE_TYPE_MAGICAL);
        effect eSave = EffectSavingThrowIncrease(SAVING_THROW_WILL, nSave);
        effect eAC = EffectACDecrease(2, AC_DODGE_BONUS);
        effect eDur = EffectVisualEffect(VFX_DUR_CESSATE_POSITIVE);

        effect eLink = EffectLinkEffects(eDanno, eStr);
        eLink = EffectLinkEffects(eLink, eSave);

        eLink = EffectLinkEffects(eLink, eDur);
        SignalEvent(OBJECT_SELF, EventSpellCastAt(OBJECT_SELF, SPELLABILITY_BARBARIAN_RAGE, FALSE));
        //Make effect extraordinary
        eLink = ExtraordinaryEffect(eLink);
        effect eVis = EffectVisualEffect(VFX_FNF_HOWL_WAR_CRY); //Change to the Rage VFX

        if (nCon > 0)
        {
            //Apply the VFX impact and effects
            ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink, OBJECT_SELF, RoundsToSeconds(nCon));
              ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eCon, OBJECT_SELF, RoundsToSeconds(nCon));
              ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eAC, OBJECT_SELF, RoundsToSeconds(nCon));

            ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, OBJECT_SELF) ;

        // 2003-07-08, Georg: Rage Epic Feat Handling
        CheckAndApplyEpicRageFeats(nCon);
        }
    }
}
