/*
  CREATO DA:      Tempesta
  DATA CREAZIONE: 18-06-2009
*/

// Funzione per Sfidare la morte

#include "X0_I0_SPELLS"
#include "x2_inc_spellhook"

void SafePolymorph(object oPC, int nRanged, int nMelee, int nShield, int nSpellFailure, string sPolyType, int nPolyType)
{
    int eEffectType;
    effect eLoop = GetFirstEffect(oPC);
    while (GetIsEffectValid(eLoop)){
        RemoveEffect(oPC,eLoop);
        eLoop=GetNextEffect(oPC);
    }
    ExecuteScript("mod_bas_car",oPC);
    ExecuteScript("mod_bas_cla_spe",oPC);
    object oSkinOld = GetItemInSlot(INVENTORY_SLOT_CARMOUR,oPC);
    SetLocalInt(oPC,"poly_weaponr",nRanged);
    SetLocalInt(oPC,"poly_weaponm",nMelee);
    SetLocalInt(oPC,"poly_shield",nShield);
    DestroyObject(oSkinOld,0.0);
    SetCreatureAppearanceType(oPC,nPolyType);
    object oSkin = CreateItemOnObject(sPolyType,oPC);
    SetLocalInt(oPC,"poly_ability_psh",0);
    AssignCommand(oPC,ClearAllActions());
    if(nRanged==1&&nMelee==0){
        object oWeapon = GetItemInSlot(INVENTORY_SLOT_RIGHTHAND,oPC);
        int nRangedType = GetBaseItemType(oWeapon);
        if(nRangedType==BASE_ITEM_DART||nRangedType==BASE_ITEM_THROWINGAXE||nRangedType==BASE_ITEM_SHURIKEN||
        nRangedType==BASE_ITEM_SHORTBOW||nRangedType==BASE_ITEM_LIGHTCROSSBOW||nRangedType==BASE_ITEM_LONGBOW||
        nRangedType==BASE_ITEM_HEAVYCROSSBOW||nRangedType==BASE_ITEM_SLING)
        AssignCommand(oPC,ActionUnequipItem(oWeapon));
    }
    if(nRanged==1&&nMelee==1){
        object oWeapon = GetItemInSlot(INVENTORY_SLOT_RIGHTHAND,oPC);
        AssignCommand(oPC,ActionUnequipItem(oWeapon));
    }
    if(nRanged==0&&nMelee==1){
        object oWeapon = GetItemInSlot(INVENTORY_SLOT_RIGHTHAND,oPC);
        int nRangedType = GetBaseItemType(oWeapon);
        if(nRangedType==BASE_ITEM_DART||nRangedType==BASE_ITEM_THROWINGAXE||nRangedType==BASE_ITEM_SHURIKEN||
        nRangedType==BASE_ITEM_SHORTBOW||nRangedType==BASE_ITEM_LIGHTCROSSBOW||nRangedType==BASE_ITEM_LONGBOW||
        nRangedType==BASE_ITEM_HEAVYCROSSBOW||nRangedType==BASE_ITEM_SLING){}
        AssignCommand(oPC,ActionUnequipItem(oWeapon));
    }
    if(nShield==1){
        object oShield = GetItemInSlot(INVENTORY_SLOT_LEFTHAND,oPC);
        AssignCommand(oPC,ActionUnequipItem(oShield));
    }
    if(nSpellFailure==1)
        ApplyEffectToObject(DURATION_TYPE_PERMANENT,EffectSpellFailure(100,SPELL_SCHOOL_GENERAL),oPC);
    ApplyEffectToObject(DURATION_TYPE_INSTANT,EffectVisualEffect(VFX_IMP_POLYMORPH),oPC,0.0);
    AssignCommand(oPC,ActionEquipItem(oSkin,INVENTORY_SLOT_CARMOUR));
}

void main()
{
    int nEvent = GetUserDefinedItemEventNumber();
    object oPC;
    object oItem;
    object oSpellOrigin;
    object oSpellTarget;
    int iSpell;
    int nResult = X2_EXECUTE_SCRIPT_END;
    location lTarget;
    int EntangleCap;
    int nAppearance;
    switch (nEvent){

        case X2_ITEM_EVENT_ONHITCAST:
            oItem  =  GetSpellCastItem();
            oPC = OBJECT_SELF;
            oSpellOrigin = OBJECT_SELF ;
            oSpellTarget = GetSpellTargetObject();
            break;

        case X2_ITEM_EVENT_ACTIVATE:
            oPC   = GetItemActivator();
            if(GetAppearanceType(oPC)==APPEARANCE_TYPE_ELF||GetAppearanceType(oPC)==APPEARANCE_TYPE_HALF_ELF
            ||GetAppearanceType(oPC)==APPEARANCE_TYPE_HALFLING||GetAppearanceType(oPC)==APPEARANCE_TYPE_GNOME
            ||GetAppearanceType(oPC)==APPEARANCE_TYPE_HALF_ORC||GetAppearanceType(oPC)==APPEARANCE_TYPE_HUMAN
            ||GetAppearanceType(oPC)==APPEARANCE_TYPE_DWARF){
                SafePolymorph(oPC, 1, 1, 1, 0, "poly_elemfuo", APPEARANCE_TYPE_ELEMENTAL_FIRE);
            }
            else{
                if(GetItemPossessedBy(oPC,"hlslang_1")!=OBJECT_INVALID)
                    SetCreatureAppearanceType(oPC,APPEARANCE_TYPE_ELF);
                else if(GetItemPossessedBy(oPC,"hlslang_5")!=OBJECT_INVALID)
                    SetCreatureAppearanceType(oPC,APPEARANCE_TYPE_HALF_ORC);
                else if(GetItemPossessedBy(oPC,"hlslang_2")!=OBJECT_INVALID)
                    SetCreatureAppearanceType(oPC,APPEARANCE_TYPE_GNOME);
                else if(GetItemPossessedBy(oPC,"hlslang_3")!=OBJECT_INVALID)
                    SetCreatureAppearanceType(oPC,APPEARANCE_TYPE_HALFLING);
                else if(GetItemPossessedBy(oPC,"hlslang_4")!=OBJECT_INVALID)
                    SetCreatureAppearanceType(oPC,APPEARANCE_TYPE_DWARF);
                else
                    SetCreatureAppearanceType(oPC,APPEARANCE_TYPE_HALF_ELF);
                SetLocalInt(oPC,"poly_weaponr",0);
                SetLocalInt(oPC,"poly_weaponm",0);
                SetLocalInt(oPC,"poly_shield",0);
            }
            break;
        case X2_ITEM_EVENT_EQUIP:

            oPC = GetPCItemLastEquippedBy();
            oItem = GetPCItemLastEquipped();
            break;

        case X2_ITEM_EVENT_UNEQUIP:
            oPC    = GetPCItemLastUnequippedBy();
            oItem  = GetPCItemLastUnequipped();
            break;

        case X2_ITEM_EVENT_ACQUIRE:
            oPC = GetModuleItemAcquiredBy();
            oItem  = GetModuleItemAcquired();
            break;

        case X2_ITEM_EVENT_UNACQUIRE:
            oPC = GetModuleItemLostBy();
            oItem  = GetModuleItemLost();
            break;

       case X2_ITEM_EVENT_SPELLCAST_AT:
            oPC = OBJECT_SELF;
            oItem  = GetSpellTargetObject();
            iSpell = GetSpellId();
            nResult = X2_EXECUTE_SCRIPT_CONTINUE;
            break;
    }
    SetExecutedScriptReturnValue(nResult);
}

