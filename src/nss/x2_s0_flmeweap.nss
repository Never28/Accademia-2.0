/*
  CREATO DA:      Tempesta
  DATA CREAZIONE: 06-08-2009
*/

// Funzione per Arma Infuocata.

#include "nw_i0_spells"
#include "x2_i0_spells"
#include "x2_inc_spellhook"


void AddFlamingEffectToWeapon(object oTarget, float fDuration, int nCasterLvl)
{
    int nDam = IP_CONST_DAMAGEBONUS_1;
    if(nCasterLvl==1)
        nDam = IP_CONST_DAMAGEBONUS_1;
    else if(nCasterLvl==2)
        nDam = IP_CONST_DAMAGEBONUS_2;
    else if(nCasterLvl==3)
        nDam = IP_CONST_DAMAGEBONUS_3;
    else if(nCasterLvl==4)
        nDam = IP_CONST_DAMAGEBONUS_4;
    else if(nCasterLvl==5)
        nDam = IP_CONST_DAMAGEBONUS_5;
    else if(nCasterLvl==6)
        nDam = IP_CONST_DAMAGEBONUS_6;
    else if(nCasterLvl==7)
        nDam = IP_CONST_DAMAGEBONUS_7;
    else if(nCasterLvl==8)
        nDam = IP_CONST_DAMAGEBONUS_8;
    else if(nCasterLvl==9)
        nDam = IP_CONST_DAMAGEBONUS_9;
    else if(nCasterLvl==10)
        nDam = IP_CONST_DAMAGEBONUS_10;
   IPSafeAddItemProperty(oTarget, ItemPropertyDamageBonus(IP_CONST_DAMAGETYPE_FIRE,nDam), fDuration, X2_IP_ADDPROP_POLICY_REPLACE_EXISTING);
   IPSafeAddItemProperty(oTarget, ItemPropertyVisualEffect(ITEM_VISUAL_FIRE), fDuration,X2_IP_ADDPROP_POLICY_REPLACE_EXISTING,FALSE,TRUE);
   return;
}

void main()
{
    if (!X2PreSpellCastCode())
        return;
    effect eVis = EffectVisualEffect(VFX_IMP_PULSE_FIRE);
    eVis = EffectLinkEffects(EffectVisualEffect(VFX_IMP_FLAME_M),eVis);
    effect eDur = EffectVisualEffect(VFX_DUR_CESSATE_POSITIVE);
    int nDuration = 2 * GetCasterLevel(OBJECT_SELF);
    int nMetaMagic = GetMetaMagicFeat();
    int nCasterLvl = GetCasterLevel(OBJECT_SELF);
    int eDam;
    eDam = nCasterLvl/4;
    if (nMetaMagic == METAMAGIC_EXTEND)
        nDuration = nDuration * 2;
    object oMyWeapon   =  IPGetTargetedOrEquippedMeleeWeapon();
        if(GetIsObjectValid(oMyWeapon) ){
            SignalEvent(GetItemPossessor(oMyWeapon), EventSpellCastAt(OBJECT_SELF, GetSpellId(), FALSE));
            if (nDuration>0){
                ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, GetItemPossessor(oMyWeapon));
                ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eDur, GetItemPossessor(oMyWeapon), TurnsToSeconds(nDuration));
                AddFlamingEffectToWeapon(oMyWeapon, TurnsToSeconds(nDuration),eDam);
            }
                return;
        }
        else{
               FloatingTextStrRefOnCreature(83615, OBJECT_SELF);
               return;
        }
}
