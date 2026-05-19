/*
  CREATO DA:      Tempesta
  DATA CREAZIONE: 06-08-2009
*/

// Funzione per Arma Frastornante.

#include "nw_i0_spells"
#include "x2_i0_spells"
#include "x2_inc_spellhook"


void  AddDeafeningClangEffectToWeapon(object oMyWeapon, float fDuration,int nDam)
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
   IPSafeAddItemProperty(oMyWeapon,ItemPropertyDamageBonus(IP_CONST_DAMAGETYPE_SONIC, nDam1), fDuration, X2_IP_ADDPROP_POLICY_REPLACE_EXISTING ,FALSE,TRUE);
   IPSafeAddItemProperty(oMyWeapon, ItemPropertyOnHitCastSpell(137, 5),fDuration,  X2_IP_ADDPROP_POLICY_KEEP_EXISTING, TRUE,FALSE);
   IPSafeAddItemProperty(oMyWeapon, ItemPropertyVisualEffect(ITEM_VISUAL_SONIC), fDuration,X2_IP_ADDPROP_POLICY_REPLACE_EXISTING,FALSE,TRUE );
   return;
}

void main()
{
    if (!X2PreSpellCastCode())
        return;
    effect eVis = EffectVisualEffect(VFX_IMP_SUPER_HEROISM);
    effect eDur = EffectVisualEffect(VFX_DUR_CESSATE_POSITIVE);
    int nDuration = GetCasterLevel(OBJECT_SELF);
    int nDam = GetCasterLevel(OBJECT_SELF)/4;
    if(nDam<1)
        nDam = 1;
    int nMetaMagic = GetMetaMagicFeat();
    int Aspect = GetAppearanceType(OBJECT_SELF);
    if(Aspect == APPEARANCE_TYPE_GOLEM_IRON){
        int nSag = GetAbilityModifier(ABILITY_WISDOM,OBJECT_SELF);
        int nDC;
        int nMutaLv = GetLevelByClass(CLASS_TYPE_SHIFTER,OBJECT_SELF);
        int nDruidLv = GetLevelByClass(CLASS_TYPE_DRUID,OBJECT_SELF);
        nDruidLv = nMutaLv + nDruidLv;
        nMutaLv = nDruidLv/2;
        nDam= (nDruidLv)/4;
        nDuration = nDruidLv;
    }
    object oMyWeapon   =  IPGetTargetedOrEquippedMeleeWeapon();
    if (nMetaMagic == METAMAGIC_EXTEND)
        nDuration = nDuration * 2;
    if (nDuration == 0)
      nDuration =1;
    if(GetIsObjectValid(oMyWeapon) ){
        SignalEvent(GetItemPossessor(oMyWeapon), EventSpellCastAt(OBJECT_SELF, GetSpellId(), FALSE));
        if (nDuration>0){

            ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, GetItemPossessor(oMyWeapon));
            ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eDur, GetItemPossessor(oMyWeapon), TurnsToSeconds(nDuration));
            AddDeafeningClangEffectToWeapon(oMyWeapon, TurnsToSeconds(nDuration), nDam);
        }
        return;
    }
        else{
           FloatingTextStrRefOnCreature(83615, OBJECT_SELF);
           return;
    }

}
