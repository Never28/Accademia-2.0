                     //::///////////////////////////////////////////////
//:: Divine Power
//:: NW_S0_DivPower.nss
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
   Improves the Clerics base attack by 33%, +1 HP
   per level and raises their strength to 18 if
   is not already there.
*/
//:://////////////////////////////////////////////
//:: Created By: Preston Watamaniuk
//:: Created On: Oct 21, 2001
//:://////////////////////////////////////////////

/*
bugfix by Kovi 2002.07.22
- temporary hp was stacked
- loosing temporary hp resulted in loosing the other bonuses
- number of attacks was not increased (should have been a BAB increase)
still problem:
~ attacks are better still approximation (the additional attack is at full BAB)
~ attack/ability bonuses count against the limits
*/

/*
Edited By Spezza Ossa 2003.11.19
*/
#include "nw_i0_spells"


void main()
{
  //Declare major variables
  object oTarget = GetSpellTargetObject();
  int nLevel = GetCasterLevel(OBJECT_SELF);
  int nMetaMagic = GetMetaMagicFeat();
  effect eVis = EffectVisualEffect(VFX_IMP_SUPER_HEROISM);
  effect eDur = EffectVisualEffect(VFX_DUR_CESSATE_POSITIVE);

  effect eLink = EffectLinkEffects(eVis, eDur);
  //Meta-Magic
  if(nMetaMagic == METAMAGIC_EXTEND)
  {
      nLevel *= 2;
  }

  RemoveEffectsFromSpell(OBJECT_SELF,SPELL_DIVINE_POWER);
  //RemoveTempHitPoints();

  //Fire cast spell at event for the specified target
  SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, SPELL_DIVINE_POWER, FALSE));

  //Apply Link and VFX effects to the target
  ApplyEffectToObject(DURATION_TYPE_TEMPORARY,EffectModifyAttacks(2),OBJECT_SELF, RoundsToSeconds(nLevel));
  ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink, oTarget, RoundsToSeconds(nLevel));
}
