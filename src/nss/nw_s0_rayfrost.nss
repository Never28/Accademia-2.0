/*
  CREATO DA:      Tempesta
  DATA CREAZIONE: 07-08-2009
*/

// Funzione per Raggio di gelo.

#include "NW_I0_SPELLS"
#include "x2_inc_spellhook"

void main()
{
    if (!X2PreSpellCastCode())
        return;
    object oTarget = GetSpellTargetObject();
    int nMetaMagic = GetMetaMagicFeat();
    int nCasterLevel = GetCasterLevel(OBJECT_SELF);
    if(nCasterLevel<0)
        nCasterLevel=1;
    int nDam;
    effect eDam;
    effect eVis = EffectVisualEffect(VFX_IMP_FROST_S);
    effect eRay = EffectBeam(VFX_BEAM_COLD, OBJECT_SELF, BODY_NODE_HAND);
    int nType = DAMAGE_TYPE_COLD;
    int nElement = GetLocalInt(OBJECT_SELF,"SapienteElementale");
    int nBonus=0;
    switch(nElement){
        case 1:
            nType = DAMAGE_TYPE_BLUDGEONING;
            break;
        case 2:
            nType = DAMAGE_TYPE_COLD;
            nBonus = 10;
            break;
        case 3:
            nType = DAMAGE_TYPE_ELECTRICAL;
            break;
        case 4:
            nType = DAMAGE_TYPE_FIRE;
            break;
    }
    if(!GetIsReactionTypeFriendly(oTarget)){
        SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, SPELL_RAY_OF_FROST));
        eRay = EffectBeam(VFX_BEAM_COLD, OBJECT_SELF, BODY_NODE_HAND);
        if(!MyResistSpell(OBJECT_SELF, oTarget)){
             nDam = nCasterLevel;
            if (nMetaMagic == METAMAGIC_MAXIMIZE)
                nDam = nCasterLevel;
            else if (nMetaMagic == METAMAGIC_EMPOWER)
                nDam = nDam + (nDam / 2);
            nDam = nDam + nBonus;
            float fDamage = (IntToFloat(nDam)/100.0)*65.0;
            nDam = FloatToInt(fDamage);
            //Set damage effect
            eDam = EffectDamage(nDam, nType);
            //Apply the VFX impact and damage effect
            ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget);
            ApplyEffectToObject(DURATION_TYPE_INSTANT, eDam, oTarget);
        }
    }
    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eRay, oTarget, 1.7);
}
