/*
  CREATO DA:      Tempesta
  DATA CREAZIONE: 06-08-2009
*/

// Funzione per Dito della Morte.

#include "x0_I0_SPELLS"
#include "x2_inc_spellhook"
#include "mod_bad_dice"

void main()
{
    if (!X2PreSpellCastCode())
        return;
    object oTarget = GetSpellTargetObject();
    int nCasterLvl = GetCasterLevel(OBJECT_SELF);
    int nMetaMagic = GetMetaMagicFeat();
    int nDamage;
    effect eDam;
    int nDC = GetSpellSaveDC();
    if(GetHitDice(OBJECT_SELF)==40)
        nDC = nDC +5;
    else if(GetHitDice(OBJECT_SELF)>=31)
        nDC = nDC +3;
    else if(GetHitDice(OBJECT_SELF)>=21)
        nDC = nDC +2;
    else if(GetHitDice(OBJECT_SELF)>=11)
        nDC = nDC +1;

    int nSave = SAVING_THROW_TYPE_FIRE;
    int nType = DAMAGE_TYPE_NEGATIVE;
    int nBonus;
    int nElement = GetLocalInt(OBJECT_SELF,"SapienteElementale");
    switch(nElement){
        case 1:
            nType = DAMAGE_TYPE_BLUDGEONING;
            break;
        case 2:
            nType = DAMAGE_TYPE_COLD;
            break;
        case 3:
            nType = DAMAGE_TYPE_ELECTRICAL;
            break;
        case 4:
            nType = DAMAGE_TYPE_FIRE;
            break;
    }
    effect eVis = EffectVisualEffect(VFX_IMP_DEATH_L);
    effect eVis2 = EffectVisualEffect(VFX_IMP_NEGATIVE_ENERGY);
    if(spellsIsTarget(oTarget, SPELL_TARGET_SELECTIVEHOSTILE,OBJECT_SELF)){
        SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, SPELL_FINGER_OF_DEATH));
         if (GetObjectType(oTarget) == OBJECT_TYPE_CREATURE){
            if (!MyResistSpell(OBJECT_SELF, oTarget)){
                 if (!MySavingThrow(SAVING_THROW_FORT, oTarget, nDC, SAVING_THROW_TYPE_DEATH)){
                    ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectDeath(), oTarget);
                 }
                 else{
                    if ( GetIsImmune( oTarget, IMMUNITY_TYPE_DEATH) == FALSE ){
                        nDamage = nNumberRandom(7,nCasterLvl*2);
                        if (nMetaMagic == METAMAGIC_MAXIMIZE)
                            nDamage = 14*(nCasterLvl);
                        if (nMetaMagic == METAMAGIC_EMPOWER)
                            nDamage = nDamage + (nDamage/2);
                        float fDamage = (IntToFloat(nDamage)/100.0)*30.0;
                        nDamage = FloatToInt(fDamage);
                        eDam = EffectDamage(nDamage, nType);
                        ApplyEffectToObject(DURATION_TYPE_INSTANT, eDam, oTarget);
                        ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis2, oTarget);
                    }
                }
            }
        }
    }
}
