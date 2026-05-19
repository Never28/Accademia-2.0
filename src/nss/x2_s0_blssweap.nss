/*
  CREATO DA:      Tempesta
  DATA CREAZIONE: 06-08-2009
*/

// Funzione per Benedire l'Arma.

#include "nw_i0_spells"
#include "x2_i0_spells"

#include "x2_inc_spellhook"


void AddBlessEffectToWeapon(object oTarget, float fDuration,int nDam)
{
    int nDam1 = IP_CONST_DAMAGEBONUS_1;
    if(nDam==1)
        nDam1 = IP_CONST_DAMAGEBONUS_1;
    else if(nDam==2)
        nDam1 = IP_CONST_DAMAGEBONUS_2;
    else if(nDam==3)
        nDam1 = IP_CONST_DAMAGEBONUS_3;
    else if(nDam==4)
        nDam1 = IP_CONST_DAMAGEBONUS_4;
    else if(nDam==5)
        nDam1 = IP_CONST_DAMAGEBONUS_5;
    else if(nDam==6)
        nDam1 = IP_CONST_DAMAGEBONUS_6;
    else if(nDam==7)
        nDam1 = IP_CONST_DAMAGEBONUS_7;
    else if(nDam==8)
        nDam1 = IP_CONST_DAMAGEBONUS_8;
    else if(nDam==9)
        nDam1 = IP_CONST_DAMAGEBONUS_9;
    else if(nDam==10)
        nDam1 = IP_CONST_DAMAGEBONUS_10;
   IPSafeAddItemProperty(oTarget, ItemPropertyDamageBonusVsRace(IP_CONST_RACIALTYPE_UNDEAD, IP_CONST_DAMAGETYPE_DIVINE, nDam1), fDuration,X2_IP_ADDPROP_POLICY_REPLACE_EXISTING );
   IPSafeAddItemProperty(oTarget, ItemPropertyVisualEffect(ITEM_VISUAL_HOLY), fDuration,X2_IP_ADDPROP_POLICY_REPLACE_EXISTING,FALSE,TRUE );
   return;
}


void main()
{
    if (!X2PreSpellCastCode())
        return;
    effect eVis = EffectVisualEffect(VFX_IMP_SUPER_HEROISM);
    effect eDur = EffectVisualEffect(VFX_DUR_CESSATE_POSITIVE);
    object oTarget = GetSpellTargetObject();
    int nDuration = 2 * GetCasterLevel(OBJECT_SELF);
    int nDam = GetCasterLevel(OBJECT_SELF)/4;
    if(nDam<1)
        nDam = 1;
    int nMetaMagic = GetMetaMagicFeat();
    if (nMetaMagic == METAMAGIC_EXTEND)
       nDuration = nDuration * 2;
   object oMyWeapon   =  IPGetTargetedOrEquippedMeleeWeapon();
   if(GetIsObjectValid(oMyWeapon) ){
        SignalEvent(GetItemPossessor(oMyWeapon), EventSpellCastAt(OBJECT_SELF, GetSpellId(), FALSE));
        if (nDuration>0){
           AddBlessEffectToWeapon(oMyWeapon, TurnsToSeconds(nDuration),nDam);
           ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, GetItemPossessor(oMyWeapon));
           ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eDur, GetItemPossessor(oMyWeapon), TurnsToSeconds(nDuration));
        }
        return;
    }
        else{
           FloatingTextStrRefOnCreature(83615, OBJECT_SELF);
           return;
    }
}
