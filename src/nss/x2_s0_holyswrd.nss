/*
  CREATO DA:      Tempesta
  DATA CREAZIONE: 06-08-2009
*/

// Funzione per Spada Sacra.

#include "nw_i0_spells"
#include "x2_i0_spells"
#include "x2_inc_spellhook"
#include "x2_inc_toollib"

void  AddHolyAvengerEffectToWeapon(object oMyWeapon, float fDuration)
{
   IPSafeAddItemProperty(oMyWeapon,ItemPropertyHolyAvenger(), fDuration, X2_IP_ADDPROP_POLICY_KEEP_EXISTING,TRUE,TRUE);
   return;
}

void main()
{
    if (!X2PreSpellCastCode())
        return;
    effect eVis = EffectVisualEffect(VFX_IMP_GOOD_HELP);
    effect eDur = EffectVisualEffect(VFX_DUR_CESSATE_POSITIVE);
    int nDuration = GetCasterLevel(OBJECT_SELF);
    if(GetAppearanceType(OBJECT_SELF)==APPEARANCE_TYPE_GOLEM_IRON)
        nDuration = GetLevelByClass(CLASS_TYPE_SHIFTER,OBJECT_SELF)+GetLevelByClass(CLASS_TYPE_DRUID,OBJECT_SELF);
    int nMetaMagic = GetMetaMagicFeat();
    if (nMetaMagic == METAMAGIC_EXTEND)
        nDuration = nDuration * 2;
    object oMyWeapon   =  IPGetTargetedOrEquippedMeleeWeapon();
    if(GetIsObjectValid(oMyWeapon) ){
        SignalEvent(oMyWeapon, EventSpellCastAt(OBJECT_SELF, GetSpellId(), FALSE));
        if (nDuration>0){
            ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, GetItemPossessor(oMyWeapon));
            ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eDur, GetItemPossessor(oMyWeapon), RoundsToSeconds(nDuration));
            AddHolyAvengerEffectToWeapon(oMyWeapon, RoundsToSeconds(nDuration));
        }
        TLVFXPillar(VFX_IMP_GOOD_HELP, GetLocation(GetSpellTargetObject()), 4, 0.0f, 6.0f);
        DelayCommand(1.0f, ApplyEffectAtLocation(DURATION_TYPE_INSTANT, EffectVisualEffect( VFX_IMP_SUPER_HEROISM),GetLocation(GetSpellTargetObject())));
        return;
    }
    else{
        FloatingTextStrRefOnCreature(83615, OBJECT_SELF);
        return;
    }

}
