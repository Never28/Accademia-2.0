/*
  CREATO DA:      Tempesta
  DATA CREAZIONE: 10-08-2009
*/

// Funzione per Esplosione Solare.

#include "X0_I0_SPELLS"
#include "x2_inc_spellhook"

void main()
{
    if (!X2PreSpellCastCode())
        return;
    int nMetaMagic = GetMetaMagicFeat();
    effect eVis = EffectVisualEffect(VFX_IMP_DEATH);
    effect eVis2 = EffectVisualEffect(VFX_IMP_SUNSTRIKE);
    effect eStrike = EffectVisualEffect(VFX_FNF_SUNBEAM);
    effect eDam;
    effect eBlind = EffectBlindness();
    effect eDur = EffectVisualEffect(VFX_DUR_CESSATE_NEGATIVE);
    effect eLink = EffectLinkEffects(eBlind, eDur);
    int nCasterLevel= GetCasterLevel(OBJECT_SELF);
    int nDamage;
    int nOrgDam;
    int nMax;
    float fDelay;
    int nBlindLength = 3;
    int nDC = GetSpellSaveDC();
    if(GetHitDice(OBJECT_SELF)==40)
        nDC = nDC +5;
    else if(GetHitDice(OBJECT_SELF)>=31)
        nDC = nDC +3;
    else if(GetHitDice(OBJECT_SELF)>=21)
        nDC = nDC +2;
    else if(GetHitDice(OBJECT_SELF)>=11)
        nDC = nDC +1;
    ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eStrike, GetSpellTargetLocation());
    object oTarget = GetFirstObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_COLOSSAL, GetSpellTargetLocation());
    while(GetIsObjectValid(oTarget)){
        if (spellsIsTarget(oTarget, SPELL_TARGET_STANDARDHOSTILE, OBJECT_SELF)){
            fDelay = GetRandomDelay(1.0, 2.0);
            SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, SPELL_SUNBEAM));
            if ( ! MyResistSpell(OBJECT_SELF, oTarget, 1.0)){
                int nAspect = GetAppearanceType(oTarget);
                if (GetRacialType(oTarget) == RACIAL_TYPE_UNDEAD || nAspect == APPEARANCE_TYPE_SKELETON_CHIEFTAIN ||
      nAspect == APPEARANCE_TYPE_ZOMBIE_WARRIOR_2 || nAspect == APPEARANCE_TYPE_MOHRG || nAspect == APPEARANCE_TYPE_MUMMY_GREATER
      || nAspect == APPEARANCE_TYPE_VAMPIRE_MALE || nAspect == APPEARANCE_TYPE_VAMPIRE_FEMALE || nAspect == APPEARANCE_TYPE_LICH
      || nAspect == APPEARANCE_TYPE_MINDFLAYER_ALHOON || nAspect == APPEARANCE_TYPE_DEMI_LICH || nAspect == APPEARANCE_TYPE_GOLEM_BONE
      || nAspect == APPEARANCE_TYPE_DRACOLICH){
                    nDamage = d6(nCasterLevel*2);
                }
                else{
                    nDamage = d8(nCasterLevel*2);
                    nOrgDam = nDamage;
                }
                if (nMetaMagic == METAMAGIC_EMPOWER)
                    nDamage = nDamage + (nDamage/2);
                float fDamage = (IntToFloat(nDamage)/100.0)*50.0;
                nDamage = FloatToInt(fDamage);
                if(MySavingThrow(SAVING_THROW_REFLEX, oTarget, nDC, SAVING_THROW_TYPE_DIVINE, OBJECT_SELF, 1.0) == 0)
                    DelayCommand(1.0, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink, oTarget, RoundsToSeconds(nBlindLength)));
                else
                    nDamage = GetReflexAdjustedDamage(nDamage, oTarget, 0, SAVING_THROW_TYPE_DIVINE);
                eDam = EffectDamage(nDamage, DAMAGE_TYPE_DIVINE);
                if(nDamage > 0){
                    DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis2, oTarget));
                    DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, eDam, oTarget));
                }
            }
        }
        oTarget = GetNextObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_COLOSSAL, GetSpellTargetLocation());
    }
}
