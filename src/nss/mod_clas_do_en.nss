#include "X0_I0_SPELLS"

void main()
{
    object oPC = GetAreaOfEffectCreator(OBJECT_SELF);
    effect eRid1,eRid2,eRid3,eRid4,eRid5,eRid6,eRid7,eRid8,eRid9,eRid10,eRid11,eRid12,eVis;
    eVis = EffectVisualEffect(VFX_DUR_AURA_PULSE_YELLOW_WHITE);
    eRid1 = EffectDamageImmunityIncrease(DAMAGE_TYPE_ACID,5);
    eRid2 = EffectDamageImmunityIncrease(DAMAGE_TYPE_SLASHING,5);
    eRid3 = EffectDamageImmunityIncrease(DAMAGE_TYPE_COLD,5);
    eRid4 = EffectDamageImmunityIncrease(DAMAGE_TYPE_DIVINE,5);
    eRid5 = EffectDamageImmunityIncrease(DAMAGE_TYPE_ELECTRICAL,5);
    eRid6 = EffectDamageImmunityIncrease(DAMAGE_TYPE_FIRE,5);
    eRid7 = EffectDamageImmunityIncrease(DAMAGE_TYPE_MAGICAL,5);
    eRid8 = EffectDamageImmunityIncrease(DAMAGE_TYPE_NEGATIVE,5);
    eRid9 = EffectDamageImmunityIncrease(DAMAGE_TYPE_POSITIVE,5);
    eRid10 = EffectDamageImmunityIncrease(DAMAGE_TYPE_SONIC,5);
    eRid11 = EffectDamageImmunityIncrease(DAMAGE_TYPE_BLUDGEONING,5);
    eRid12 = EffectDamageImmunityIncrease(DAMAGE_TYPE_PIERCING,5);
    eRid1 = EffectLinkEffects(eVis,eRid1);
    eRid1 = EffectLinkEffects(eRid2,eRid1);
    eRid1 = EffectLinkEffects(eRid3,eRid1);
    eRid1 = EffectLinkEffects(eRid4,eRid1);
    eRid1 = EffectLinkEffects(eRid5,eRid1);
    eRid1 = EffectLinkEffects(eRid6,eRid1);
    eRid1 = EffectLinkEffects(eRid7,eRid1);
    eRid1 = EffectLinkEffects(eRid8,eRid1);
    eRid1 = EffectLinkEffects(eRid9,eRid1);
    eRid1 = EffectLinkEffects(eRid10,eRid1);
    eRid1 = EffectLinkEffects(eRid11,eRid1);
    eRid1 = EffectLinkEffects(eRid12,eRid1);
    object oTarget = GetFirstInPersistentObject();
    while(GetIsObjectValid(oTarget)){
        if (GetIsFriend(oTarget, oPC) == TRUE){
            ApplyEffectToObject(DURATION_TYPE_TEMPORARY,eRid1,oTarget,6.0);
            SendMessageToPC(oTarget,"LOL");
            SendMessageToPC(oPC,"E' Amico");
        }
        SendMessageToPC(oPC,"E' dentro");
        oTarget = GetNextInPersistentObject();
    }
    SendMessageToPC(oPC,"Script parte");
}

