/*
  CREATO DA:      Tempesta
  DATA CREAZIONE: 06-08-2009
*/

// Funzione per Benedizione.

#include "NW_I0_SPELLS"
#include "x2_inc_spellhook"

void main()
{
    if (!X2PreSpellCastCode())
        return;
    object oTarget = GetSpellTargetObject();
    int nDuration = GetCasterLevel(OBJECT_SELF);
    int Bonus = 1;
    int nLevel = GetCasterLevel(OBJECT_SELF);
    if(nLevel>20)
        Bonus = 2;
    effect eVis = EffectVisualEffect(VFX_IMP_HEAD_HOLY);
    effect eBonDam = EffectDamageIncrease(Bonus, DAMAGE_TYPE_SLASHING);
    effect eDur = EffectVisualEffect(VFX_DUR_CESSATE_POSITIVE);
    effect eImpact = EffectVisualEffect(VFX_FNF_LOS_HOLY_30);
    effect eAttack = EffectAttackIncrease(Bonus);
    effect eSave = EffectSavingThrowIncrease(SAVING_THROW_ALL, Bonus, SAVING_THROW_TYPE_ALL);
    effect eLink = EffectLinkEffects(eAttack, eSave);
    eLink = EffectLinkEffects(eLink, eBonDam);
    eLink = EffectLinkEffects(eLink, eDur);
    int nMetaMagic = GetMetaMagicFeat();
    float fDelay;
    if (nMetaMagic == METAMAGIC_EXTEND)
        nDuration = nDuration *2;
    ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eImpact, GetSpellTargetLocation());
    oTarget = GetFirstObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_COLOSSAL, GetLocation(OBJECT_SELF));
            while(GetIsObjectValid(oTarget)){
                if(GetIsReactionTypeFriendly(oTarget) || GetFactionEqual(oTarget)){
                    fDelay = GetRandomDelay(0.4, 1.1);
                    SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, SPELL_BLESS, FALSE));
                    DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget));
                    DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink, oTarget, TurnsToSeconds(nDuration)));
                }
                oTarget = GetNextObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_COLOSSAL, GetLocation(OBJECT_SELF));
            }
}

