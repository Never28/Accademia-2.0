/*
  CREATO DA:      Tempesta
  DATA CREAZIONE: 09-08-2009
*/

// Funzione per Martello degli Dei.

#include "X0_I0_SPELLS"
#include "x2_inc_spellhook"

void main()
{
    if (!X2PreSpellCastCode())
        return;
    int nCasterLvl = GetCasterLevel(OBJECT_SELF);
    int nMetaMagic = GetMetaMagicFeat();
    effect eDam;
    int RollDam = nCasterLvl;
    effect eDaze = EffectDazed();
    effect eMind = EffectVisualEffect(VFX_DUR_MIND_AFFECTING_NEGATIVE);
    effect eDur = EffectVisualEffect(VFX_DUR_CESSATE_NEGATIVE);
    effect eLink = EffectLinkEffects(eMind, eDaze);
    eLink = EffectLinkEffects(eLink, eDur);
    effect eVis = EffectVisualEffect(VFX_IMP_DIVINE_STRIKE_HOLY);
    effect eStrike = EffectVisualEffect(VFX_FNF_STRIKE_HOLY);
    float fDelay;
    int nDamageDice = nCasterLvl;
    if(nDamageDice == 0)
        nDamageDice = 1;
    if (nDamageDice > 5)
        nDamageDice = 5;
    int nDamage;
    ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eStrike, GetSpellTargetLocation());
    object oTarget = GetFirstObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_HUGE, GetSpellTargetLocation());
    int nDC = GetSpellSaveDC();
    if(GetHitDice(OBJECT_SELF)==40)
        nDC = nDC +5;
    else if(GetHitDice(OBJECT_SELF)>=31)
        nDC = nDC +3;
    else if(GetHitDice(OBJECT_SELF)>=21)
        nDC = nDC +2;
    else if(GetHitDice(OBJECT_SELF)>=11)
        nDC = nDC +1;
        while (GetIsObjectValid(oTarget)){
            if (spellsIsTarget(oTarget, SPELL_TARGET_SELECTIVEHOSTILE, OBJECT_SELF)){
                SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, SPELL_HAMMER_OF_THE_GODS));
                if (!MyResistSpell(OBJECT_SELF, oTarget)){
                    fDelay = GetRandomDelay(0.6, 1.3);
                    nDamage = d4(RollDam*2);
                    if (nMetaMagic == METAMAGIC_MAXIMIZE)
                        nDamage = 8 * RollDam;
                    else if (nMetaMagic == METAMAGIC_EMPOWER)
                        nDamage = FloatToInt( IntToFloat(nDamage)/2+nDamage);
                float fDamage = (IntToFloat(nDamage)/100.0)*20.0;
                nDamage = FloatToInt(fDamage);
                    if(MySavingThrow(SAVING_THROW_WILL, oTarget, nDC, SAVING_THROW_TYPE_DIVINE, OBJECT_SELF, 0.5)==0){
                        DelayCommand(0.5, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink, oTarget, RoundsToSeconds(d6())));
                    }
                    else{
                        nDamage = nDamage / 2;
                    }
                    eDam = EffectDamage(nDamage,DAMAGE_TYPE_DIVINE);
                    DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, eDam, oTarget));
                    DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget));
                 }
            }
            oTarget = GetNextObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_HUGE, GetSpellTargetLocation());
        }
}
