//::///////////////////////////////////////////////
//:: Divine Shield
//:: x0_s2_divshield.nss
//:: Copyright (c) 2002 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Up to [turn undead] times per day the character may add his Charisma bonus to his armor
    class for a number of rounds equal to the Charisma bonus.
*/
//:://////////////////////////////////////////////
//:: Created By: Brent
//:: Created On: Sep 13, 2002
//:://////////////////////////////////////////////
#include "x0_i0_spells"

void main()
{

   if (!GetHasFeat(FEAT_TURN_UNDEAD, OBJECT_SELF))
   {
        SpeakStringByStrRef(40550);
   }
   else
   if(GetHasFeatEffect(414) == FALSE)
   {
        //Declare major variables
        object oTarget = GetSpellTargetObject();
        int nLevel = GetCasterLevel(OBJECT_SELF);

        effect eVis = EffectVisualEffect(VFX_IMP_SUPER_HEROISM);
        effect eDur = EffectVisualEffect(VFX_DUR_CESSATE_POSITIVE);
        int nDuration = (GetAbilityModifier(ABILITY_CHARISMA)*2);
        int nCharismaBonus = GetAbilityModifier(ABILITY_CHARISMA);
        effect eAC = EffectACIncrease(nCharismaBonus);
        effect eLink = EffectLinkEffects(eAC, eDur);
        eLink = SupernaturalEffect(eLink);
        RemoveEffectsFromSpell(oTarget, GetSpellId());
        SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, 474, FALSE));
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink, oTarget, RoundsToSeconds(nDuration));
        ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget);
        DecrementRemainingFeatUses(OBJECT_SELF, FEAT_TURN_UNDEAD);
    }
}


