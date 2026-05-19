#include "X0_I0_SPELLS"

void main()
{
    object oTarget = GetEnteringObject();
    int nDam;
    int nActivated = GetLocalInt(OBJECT_SELF,"TrapActive");
    if (GetStandardFactionReputation(STANDARD_FACTION_HOSTILE,oTarget) < 11){
        if(nActivated == 1){
            nDam = d4(2);
            nDam = GetReflexAdjustedDamage(nDam, oTarget, 12, SAVING_THROW_TYPE_COLD, OBJECT_SELF);
            effect eDam = EffectDamage(d4(2), DAMAGE_TYPE_COLD);
            effect eVis = EffectVisualEffect(VFX_IMP_FROST_S);
            ApplyEffectToObject(DURATION_TYPE_INSTANT, eDam, oTarget);
            ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget);
        }
    }
}

