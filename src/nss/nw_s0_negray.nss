/*
  CREATO DA:      Tempesta
  DATA CREAZIONE: 13-07-2009
*/

// Funzione per il raggio di energia negativa.

#include "NW_I0_SPELLS"
#include "x2_inc_spellhook"
#include "mod_bad_dice"

void main()
{
    if (!X2PreSpellCastCode())
        return;
    object oTarget = GetSpellTargetObject();
    int nCasterLevel = GetCasterLevel(OBJECT_SELF);
    int nAbility = 0;
    int nMetaMagic = GetMetaMagicFeat();
    int nDC = GetSpellSaveDC();

    int nSave = SAVING_THROW_TYPE_NEGATIVE;
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


    if(GetHitDice(OBJECT_SELF)==40)
        nDC = nDC +5;
    else if(GetHitDice(OBJECT_SELF)>=31)
        nDC = nDC +3;
    else if(GetHitDice(OBJECT_SELF)>=21)
        nDC = nDC +2;
    else if(GetHitDice(OBJECT_SELF)>=11)
        nDC = nDC +1;
    int nRoll = nCasterLevel;
    if(nRoll==0)
        nRoll=1;
    int nDamage;
    nDamage = nNumberRandom(3,nCasterLevel);
    if (nMetaMagic == METAMAGIC_MAXIMIZE)
        nDamage = 3 * nRoll;
    else if (nMetaMagic == METAMAGIC_EMPOWER)
        nDamage = nDamage + (nDamage/2);

    effect eVis = EffectVisualEffect(VFX_IMP_NEGATIVE_ENERGY);
    effect eVisHeal = EffectVisualEffect(VFX_IMP_HEALING_M);
    effect eRay;
    int nAspect = GetAppearanceType(oTarget);
        if(GetRacialType(oTarget) != RACIAL_TYPE_UNDEAD || nAspect != APPEARANCE_TYPE_SKELETON_CHIEFTAIN ||
      nAspect != APPEARANCE_TYPE_ZOMBIE_WARRIOR_2 || nAspect != APPEARANCE_TYPE_MOHRG || nAspect != APPEARANCE_TYPE_MUMMY_GREATER
      || nAspect != APPEARANCE_TYPE_VAMPIRE_MALE || nAspect != APPEARANCE_TYPE_VAMPIRE_FEMALE || nAspect != APPEARANCE_TYPE_LICH
      || nAspect != APPEARANCE_TYPE_MINDFLAYER_ALHOON || nAspect != APPEARANCE_TYPE_DEMI_LICH || nAspect!= APPEARANCE_TYPE_GOLEM_BONE
      || nAspect != APPEARANCE_TYPE_DRACOLICH){
            if(!GetIsReactionTypeFriendly(oTarget)){
                SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, SPELL_NEGATIVE_ENERGY_RAY));
                eRay = EffectBeam(VFX_BEAM_EVIL, OBJECT_SELF, BODY_NODE_HAND);
                if (!MyResistSpell(OBJECT_SELF, oTarget)){
                    if(MySavingThrow(SAVING_THROW_WILL, oTarget, nDC, nSave))
                        nDamage /= 2;
                    effect eDam = EffectDamage(nDamage, nType);
                    DelayCommand(0.5, ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget));
                    ApplyEffectToObject(DURATION_TYPE_INSTANT, eDam, oTarget);
                }
            }
        }
        else{
            SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, SPELL_NEGATIVE_ENERGY_RAY, FALSE));
            eRay = EffectBeam(VFX_BEAM_EVIL, OBJECT_SELF, BODY_NODE_HAND);
            effect eHeal = EffectHeal(nDamage);
            ApplyEffectToObject(DURATION_TYPE_INSTANT, eVisHeal, oTarget);
            ApplyEffectToObject(DURATION_TYPE_INSTANT, eHeal, oTarget);
        }
    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eRay, oTarget, 1.7);
}
