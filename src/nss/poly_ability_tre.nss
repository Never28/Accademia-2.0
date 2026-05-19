#include "NW_I0_SPELLS"

void main()
{
    //Declare major variables
    object oTarget = GetItemActivatedTarget();
    int nAge = GetHitDice(OBJECT_SELF);
    int nSag = GetAbilityModifier(ABILITY_WISDOM,OBJECT_SELF);
    int nDamage, nDamStrike; // for level drain
    int nDC;
    int nMutaLv = GetLevelByClass(CLASS_TYPE_SHIFTER,OBJECT_SELF);
    int nDruidLv = GetLevelByClass(CLASS_TYPE_DRUID,OBJECT_SELF);
    nDruidLv = nMutaLv + nDruidLv;
    nMutaLv = nDruidLv/2;
    if (nMutaLv >= 1){
        nDC = 10 + nSag + nMutaLv;
    }
    else{
        nDC = nAge+10;
    }
    effect eDom = EffectCutsceneDominated();
    eDom = GetScaledEffect(eDom, oTarget);
    effect eMind = EffectVisualEffect(VFX_DUR_MIND_AFFECTING_DOMINATED);
    effect eDur = EffectVisualEffect(VFX_DUR_CESSATE_NEGATIVE);
    effect eLink = EffectLinkEffects(eMind, eDom);
    eLink = EffectLinkEffects(eLink, eDur);
    effect eVis = EffectVisualEffect(VFX_IMP_DOMINATE_S);
    int nDuration = nMutaLv;
    nDuration = GetCasterLevel(OBJECT_SELF);
    int nRacial = GetRacialType(oTarget);
    SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, SPELL_DOMINATE_PERSON, FALSE));
    if(!GetIsReactionTypeFriendly(oTarget)){
        if  (nRacial == RACIAL_TYPE_BEAST){
           if (!MyResistSpell(OBJECT_SELF, oTarget)){
                if (!MySavingThrow(SAVING_THROW_WILL, oTarget, nDC, SAVING_THROW_TYPE_MIND_SPELLS, OBJECT_SELF, 1.0)){
                    DelayCommand(1.0, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink, oTarget, RoundsToSeconds(20)));
                    ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget);
                }
            }
        }
    }
}
