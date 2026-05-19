/*
  CREATO DA:      Tempesta
  DATA CREAZIONE: 07-08-2009
*/

// Funzione per Fiotto Acido.

#include "NW_I0_SPELLS"
#include "x2_inc_spellhook"

void main()
{
    if (!X2PreSpellCastCode())
        return;
    int nCasterLevel = GetCasterLevel(OBJECT_SELF);
    int nType = DAMAGE_TYPE_ACID;
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
    object oTarget = GetSpellTargetObject();
    int nDamage;
    int nMetaMagic = GetMetaMagicFeat();
    effect eVis = EffectVisualEffect(VFX_IMP_ACID_S);
    if(!GetIsReactionTypeFriendly(oTarget))
    {
        //Fire cast spell at event for the specified target
        SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, 424));
        //Make SR Check
        if(!MyResistSpell(OBJECT_SELF, oTarget))
        {
            //Set damage effect
                nDamage = nCasterLevel;
                if (nMetaMagic == METAMAGIC_MAXIMIZE)
                    nDamage = nCasterLevel;
                else if (nMetaMagic == METAMAGIC_EMPOWER)
                   nDamage = nDamage + (nDamage / 2);
                float fDamage = (IntToFloat(nDamage)/100.0)*65.0;
                nDamage = FloatToInt(fDamage);
            effect eBad = EffectDamage(nDamage, nType);
            //Apply the VFX impact and damage effect
            ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget);
            ApplyEffectToObject(DURATION_TYPE_INSTANT, eBad, oTarget);
        }
    }
}




