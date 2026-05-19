#include "NW_I0_SPELLS"
#include "x2_i0_spells"

void main()
{
    //Declare major variables
    object oTarget = GetEnteringObject();
    effect eVis = EffectVisualEffect(VFX_IMP_BREACH);
    effect eDur2 = EffectVisualEffect(VFX_DUR_CESSATE_NEGATIVE);
    effect eLink;
    object oBarb =GetAreaOfEffectCreator();
    int nDuration = 40;
    int nDC;
    int nRide = GetSkillRank(SKILL_RIDE,oBarb);
    nDC = nRide / 2;
    if(nDC > 50)
        nDC = 50;

    if(GetIsEnemy(oTarget, oBarb)){
        SignalEvent(oTarget, EventSpellCastAt(oBarb, GetSpellId()));
          if(!MySavingThrow(SAVING_THROW_WILL, oTarget, nDC, SAVING_THROW_REFLEX)){
            effect eFear = EffectKnockdown();
            eLink = EffectLinkEffects(eLink, eDur2);
            eLink = ExtraordinaryEffect(eLink);
            ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink, oTarget, RoundsToSeconds(3));
            ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget);

         }
      }

}
