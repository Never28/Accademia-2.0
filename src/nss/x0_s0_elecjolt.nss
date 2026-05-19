//::///////////////////////////////////////////////
//:: Electric Jolt
//:: [x0_s0_ElecJolt.nss]
//:: Copyright (c) 2002 Bioware Corp.
//:://////////////////////////////////////////////
/*
1d3 points of electrical damage to one target.
*/
//:://////////////////////////////////////////////
//:: Created By: Brent
//:: Created On: July 17 2002
//:://////////////////////////////////////////////

#include "X0_I0_SPELLS"
#include "x2_inc_spellhook"

void main()
{

/*
  Spellcast Hook Code
  Added 2003-06-20 by Georg
  If you want to make changes to all spells,
  check x2_inc_spellhook.nss to find out more

*/

    if (!X2PreSpellCastCode())
    {
    // If code within the PreSpellCastHook (i.e. UMD) reports FALSE, do not run this spell
        return;
    }

    int nType = DAMAGE_TYPE_ELECTRICAL;
    int nElement = GetLocalInt(OBJECT_SELF,"SapienteElementale");
    int nBonus = 0;
    switch(nElement){
        case 1:
            nType = DAMAGE_TYPE_BLUDGEONING;
            break;
        case 2:
            nType = DAMAGE_TYPE_COLD;
            break;
        case 3:
            nType = DAMAGE_TYPE_ELECTRICAL;
            nBonus = 10;
            break;
        case 4:
            nType = DAMAGE_TYPE_FIRE;
            break;
    }
    int nMetaMagic = GetMetaMagicFeat();
    object oTarget = GetSpellTargetObject();
    int nCasterLevel = GetCasterLevel(OBJECT_SELF);


    effect eVis = EffectVisualEffect(VFX_IMP_LIGHTNING_S);
    if(!GetIsReactionTypeFriendly(oTarget))
    {
        //Fire cast spell at event for the specified target
        SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, SPELL_ELECTRIC_JOLT));
        //Make SR Check
        if(!MyResistSpell(OBJECT_SELF, oTarget))
        {
            //Set damage effect
                int nDamage = nCasterLevel;
                if (nMetaMagic == METAMAGIC_MAXIMIZE)
                    nDamage = nCasterLevel;
                else if (nMetaMagic == METAMAGIC_EMPOWER)
                   nDamage = nDamage + (nDamage / 2);
                nDamage = nDamage + nBonus;
                float fDamage = (IntToFloat(nDamage)/100.0)*65.0;
                nDamage = FloatToInt(fDamage);
            effect eBad = EffectDamage(nDamage, nType);
            ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget);
            ApplyEffectToObject(DURATION_TYPE_INSTANT, eBad, oTarget);
        }
    }
}






