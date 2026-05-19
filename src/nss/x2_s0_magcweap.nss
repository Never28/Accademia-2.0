/*
  CREATO DA:      Tempesta
  DATA CREAZIONE: 06-08-2009
*/

// Funzione per Arma Magica.

#include "nw_i0_spells"
#include "x2_i0_spells"
#include "x2_inc_spellhook"


void  AddEnhancementEffectToWeapon(object oMyWeapon, int DamageWeap, float fDuration)
{
    int nDam = IP_CONST_DAMAGEBONUS_1;
    if(DamageWeap==1)
        nDam = IP_CONST_DAMAGEBONUS_1;
    else if(DamageWeap==2)
        nDam = IP_CONST_DAMAGEBONUS_2;
    else if(DamageWeap==3)
        nDam = IP_CONST_DAMAGEBONUS_3;
    else if(DamageWeap==4)
        nDam = IP_CONST_DAMAGEBONUS_4;
    else if(DamageWeap==5)
        nDam = IP_CONST_DAMAGEBONUS_5;
    IPSafeAddItemProperty(oMyWeapon,ItemPropertyDamageBonus(IP_CONST_DAMAGETYPE_PIERCING,nDam), fDuration);
    return;
}


void main()
{
    if (!X2PreSpellCastCode())
        return;
    effect eVis = EffectVisualEffect(VFX_IMP_SUPER_HEROISM);
    effect eDur = EffectVisualEffect(VFX_DUR_CESSATE_POSITIVE);
    int nDuration = GetCasterLevel(OBJECT_SELF);
    int nCasterLv = nDuration;
    int Bonus = nDuration/8;
    if(Bonus<1)
        Bonus = 1;
    int nMetaMagic = GetMetaMagicFeat();
    object oMyWeapon   =  IPGetTargetedOrEquippedMeleeWeapon();
    if (nMetaMagic == METAMAGIC_EXTEND)
        nDuration = nDuration * 2;
    if(GetIsObjectValid(oMyWeapon) ){
        SignalEvent(GetItemPossessor(oMyWeapon), EventSpellCastAt(OBJECT_SELF, GetSpellId(), FALSE));
        if (nDuration>0){
            ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, GetItemPossessor(oMyWeapon));
            ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eDur, GetItemPossessor(oMyWeapon), TurnsToSeconds(nDuration));
            AddEnhancementEffectToWeapon(oMyWeapon, Bonus, TurnsToSeconds(nDuration));
        }
        return;
    }
    else{
        FloatingTextStrRefOnCreature(83615, OBJECT_SELF);
        return;
    }
}
