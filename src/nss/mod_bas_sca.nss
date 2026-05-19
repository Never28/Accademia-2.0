/*
  CREATO DA:      Tempesta
  DATA CREAZIONE: 01/10/2010
*/

// Funzione per lo scalcare

#include "x2_inc_switches"
#include "mod_bas_sca_per"

void SafeDestroyObject(object oObject, float fDelay)
{
    SetIsDestroyable(TRUE);
    if(GetPlotFlag(oObject)) { DelayCommand(0.0,SetPlotFlag(oObject, FALSE)); }
    if(GetImmortal(oObject)) { DelayCommand(0.0,SetImmortal(oObject, FALSE)); }
    if(!GetDroppableFlag(oObject)) { DelayCommand(0.0,SetDroppableFlag(oObject, TRUE)); }
    DestroyObject(oObject, fDelay);
}


void main()
{
    int nEvent = GetUserDefinedItemEventNumber();
    object oPC;
    object oItem,oItem2;
    object oSpellOrigin;
    object oSpellTarget;
    object oTarget;
    float fDistance;
    string sTagTarget,sResTarget, sResRef;
    int nScalc,nScalcPC;
    int iSpell;
    string sTag,sRef;
    int nStack;
    int nResult = X2_EXECUTE_SCRIPT_END;

    switch (nEvent)
    {
        case X2_ITEM_EVENT_ONHITCAST:
            oItem  =  GetSpellCastItem();
            oPC = OBJECT_SELF;
            oSpellOrigin = OBJECT_SELF ;
            oSpellTarget = GetSpellTargetObject();
            break;

        case X2_ITEM_EVENT_ACTIVATE:
            oPC   = GetItemActivator();
            oItem = GetItemActivated();
            oTarget = GetItemActivatedTarget();
            sTag = GetStringLeft(GetTag(oTarget),8);
            if(sTag=="craft_1_"){
                nStack = GetItemStackSize(oTarget);
                GiveGoldToCreature(oPC,50*nStack);
                SafeDestroyObject(oTarget,0.0);
            }
            else if(sTag=="craft_2_"||sTag=="craft_5_"||sTag=="craft_8_"||sTag=="craft_9_"){
                nStack = GetItemStackSize(oTarget);
                GiveGoldToCreature(oPC,200*nStack);
                SafeDestroyObject(oTarget,0.0);
            }
            else if(sTag=="craft_3_"||sTag=="craft_4_"||sTag=="craft_6_"||sTag=="craft_7_"||
            sTag=="craft_10"||sTag=="craft_11"||sTag=="craft_12"){
                nStack = GetItemStackSize(oTarget);
                GiveGoldToCreature(oPC,400*nStack);
                SafeDestroyObject(oTarget,0.0);
            }
            else if(sTag=="craft_27"||sTag=="craft_15"||sTag=="craft_18"||sTag=="craft_19"||
            sTag=="craft_24"||sTag=="craft_27"){
                nStack = GetItemStackSize(oTarget);
                GiveGoldToCreature(oPC,800*nStack);
                SafeDestroyObject(oTarget,0.0);
            }
            else if(sTag=="craft_13"||sTag=="craft_14"||sTag=="craft_25"||sTag=="craft_26"||
            sTag=="craft_16"||sTag=="craft_17"||sTag=="craft_20"||sTag=="craft_23"||sTag=="craft_22"){
                nStack = GetItemStackSize(oTarget);
                GiveGoldToCreature(oPC,1500*nStack);
                SafeDestroyObject(oTarget,0.0);
            }
            else if(sTag=="craft_30"){
                nStack = GetItemStackSize(oTarget);
                GiveGoldToCreature(oPC,1100*nStack);
                SafeDestroyObject(oTarget,0.0);
            }
            else if(sTag=="craft_33"){
                nStack = GetItemStackSize(oTarget);
                GiveGoldToCreature(oPC,1400*nStack);
                SafeDestroyObject(oTarget,0.0);
            }
            else if(sTag=="craft_36"||sTag=="craft_39"||sTag=="craft_42"||sTag=="craft_45"){
                nStack = GetItemStackSize(oTarget);
                GiveGoldToCreature(oPC,1700*nStack);
                SafeDestroyObject(oTarget,0.0);
            }
            else if(sTag=="craft_48"||sTag=="craft_51"||sTag=="craft_63"||sTag=="craft_78"){
                nStack = GetItemStackSize(oTarget);
                GiveGoldToCreature(oPC,2000*nStack);
                SafeDestroyObject(oTarget,0.0);
            }
            else if(sTag=="craft_28"||sTag=="craft_29"||sTag=="craft_31"||sTag=="craft_32"||
            sTag=="craft_34"||sTag=="craft_35"||sTag=="craft_38"||sTag=="craft_37"
            ||sTag=="craft_40"||sTag=="craft_41"||sTag=="craft_43"||sTag=="craft_44"){
                nStack = GetItemStackSize(oTarget);
                GiveGoldToCreature(oPC,5000*nStack);
                SafeDestroyObject(oTarget,0.0);
            }
            else if(sTag=="craft_46"||sTag=="craft_47"||sTag=="craft_49"||sTag=="craft_50"||sTag=="craft_61"||sTag=="craft_76"){
                nStack = GetItemStackSize(oTarget);
                GiveGoldToCreature(oPC,7000*nStack);
                SafeDestroyObject(oTarget,0.0);
            }
            sRef = GetStringLeft(GetResRef(oTarget),6);
            if(sRef=="set_01"||sRef=="set_02"||sRef=="set_03"||sRef=="set_04"||sRef=="set_05"||
                sRef=="set_06"||sRef=="set_07"||sRef=="set_08"||sRef=="set_09"||sRef=="set_10"||
                sRef=="set_11"||sRef=="set_12"){
                GiveGoldToCreature(oPC,8000);
                SafeDestroyObject(oTarget,0.0);
            }
            else if(sRef=="set_17"||sRef=="set_16"||sRef=="set_18"||
            sRef=="set_19"||sRef=="set_20"||sRef=="set_22"||sRef=="set_23"||sRef=="set_24"||sRef=="set_13"
            ||sRef=="set_14"||sRef=="set_15"||sRef=="set_25"||sRef=="set_26"||sRef=="set_27"){
                GiveGoldToCreature(oPC,32000);
                SafeDestroyObject(oTarget,0.0);
            }
            else if(sRef=="set_28"||sRef=="set_29"||sRef=="set_30"||
            sRef=="set_31"||sRef=="set_32"||sRef=="set_33"||sRef=="set_34"||sRef=="set_35"||sRef=="set_36"
            ||sRef=="set_37"||sRef=="set_38"||sRef=="set_39"||sRef=="set_40"||sRef=="set_41"||sRef=="set_42"
            ||sRef=="set_43"||sRef=="set_44"||sRef=="set_45"){
                GiveGoldToCreature(oPC,128000);
                SafeDestroyObject(oTarget,0.0);
            }
            else if(sRef=="set_46"||sRef=="set_49"||sRef=="set_50"||
            sRef=="set_51"||sRef=="set_61"||sRef=="set_76"){
                GiveGoldToCreature(oPC,256000);
                SafeDestroyObject(oTarget,0.0);
            }
            sTag = GetStringLeft(GetTag(oTarget),7);
            if(GetTag(oTarget)=="crystal_pos_1"||GetTag(oTarget)=="crystal_div_1"||
            GetTag(oTarget)=="crystal_neg_1"||GetTag(oTarget)=="crystal_mag_1"){
                GiveGoldToCreature(oPC,2000);
                SafeDestroyObject(oTarget,0.0);
            }
            else if(GetTag(oTarget)=="crystal_pos_2"||GetTag(oTarget)=="crystal_div_2"||
            GetTag(oTarget)=="crystal_neg_2"||GetTag(oTarget)=="crystal_mag_2"){
                GiveGoldToCreature(oPC,8000);
                SafeDestroyObject(oTarget,0.0);
            }
            else if(GetTag(oTarget)=="crystal_pos_3"||GetTag(oTarget)=="crystal_div_3"||
            GetTag(oTarget)=="crystal_neg_3"||GetTag(oTarget)=="crystal_mag_3"){
                GiveGoldToCreature(oPC,32000);
                SafeDestroyObject(oTarget,0.0);
            }
            sResRef = GetResRef(oTarget);
            if((sResRef=="weap_bas_daxe1"||sResRef=="weap_bas_dmace1"||sResRef=="weap_bas_dswo1"||sResRef=="weap_bas_alab1"||
                sResRef=="weap_bas_staff1"||sResRef=="weap_bas_scy1"||sResRef=="weap_bas_spea1"||sResRef=="weap_bas_lanbat1"||
                sResRef=="weap_bas_trid1"||sResRef=="weap_bas_gaxe1"||sResRef=="weap_bas_smaxe1"||sResRef=="weap_bas_baxe1"||
                sResRef=="weap_bas_dwaxe1"||sResRef=="weap_bas_kat1"||sResRef=="weap_bas_scim1"||sResRef=="weap_bas_rap1"||
                sResRef=="weap_bas_kama1"||sResRef=="weap_bas_whi1"||sResRef=="weap_bas_sic1"||sResRef=="weap_bas_club1"||
                sResRef=="weap_bas_dag1"||sResRef=="weap_bas_bsw1"||sResRef=="weap_bas_ssw1"||sResRef=="weap_bas_lsw1"||
                sResRef=="weap_bas_gsw1"||sResRef=="weap_bas_lham1"||sResRef=="weap_bas_sham1"||sResRef=="weap_bas_lfla1"||
                sResRef=="weap_bas_hfla1"||sResRef=="weap_bas_mace1"||sResRef=="weap_bas_kukr1_1"||sResRef=="weap_bas_lsta1")&&
                (GetItemHasItemProperty(oTarget,ITEM_PROPERTY_DECREASED_SKILL_MODIFIER)==TRUE)){
                GiveGoldToCreature(oPC,8000);
                SafeDestroyObject(oTarget,0.0);
            }
            else if((sResRef=="weap_bas_daxe4"||sResRef=="weap_bas_dmace4"||sResRef=="weap_bas_dswo4"||sResRef=="weap_bas_alab4"||
                sResRef=="weap_bas_staff4"||sResRef=="weap_bas_scy4"||sResRef=="weap_bas_spea4"||sResRef=="weap_bas_lanbat4"||
                sResRef=="weap_bas_trid4"||sResRef=="weap_bas_gaxe4"||sResRef=="weap_bas_smaxe4"||sResRef=="weap_bas_baxe4"||
                sResRef=="weap_bas_dwaxe4"||sResRef=="weap_bas_kat4"||sResRef=="weap_bas_scim4"||sResRef=="weap_bas_rap4"||
                sResRef=="weap_bas_kama4"||sResRef=="weap_bas_whi4"||sResRef=="weap_bas_sic4"||sResRef=="weap_bas_club4"||
                sResRef=="weap_bas_dag4"||sResRef=="weap_bas_bsw4"||sResRef=="weap_bas_ssw4"||sResRef=="weap_bas_lsw4"||
                sResRef=="weap_bas_gsw4"||sResRef=="weap_bas_lham4"||sResRef=="weap_bas_sham4"||sResRef=="weap_bas_lfla4"||
                sResRef=="weap_bas_hfla4"||sResRef=="weap_bas_mace4"||sResRef=="weap_bas_kukr1_4"||sResRef=="weap_bas_lstar4")&&
                (GetItemHasItemProperty(oTarget,ITEM_PROPERTY_DECREASED_SKILL_MODIFIER)==TRUE)){
                GiveGoldToCreature(oPC,32000);
                SafeDestroyObject(oTarget,0.0);
            }
            else if((sResRef=="weap_bas_daxe6"||sResRef=="weap_bas_dmace6"||sResRef=="weap_bas_dswo6"||sResRef=="weap_bas_alab6"||
                sResRef=="weap_bas_staff6"||sResRef=="weap_bas_scy6"||sResRef=="weap_bas_spea6"||sResRef=="weap_bas_lanbat6"||
                sResRef=="weap_bas_trid6"||sResRef=="weap_bas_gaxe6"||sResRef=="weap_bas_smaxe6"||sResRef=="weap_bas_baxe6"||
                sResRef=="weap_bas_dwaxe6"||sResRef=="weap_bas_kat6"||sResRef=="weap_bas_scim6"||sResRef=="weap_bas_rap6"||
                sResRef=="weap_bas_kama6"||sResRef=="weap_bas_whi6"||sResRef=="weap_bas_sic6"||sResRef=="weap_bas_club6"||
                sResRef=="weap_bas_dag6"||sResRef=="weap_bas_bsw6"||sResRef=="weap_bas_ssw6"||sResRef=="weap_bas_lsw6"||
                sResRef=="weap_bas_gsw6"||sResRef=="weap_bas_lham6"||sResRef=="weap_bas_sham6"||sResRef=="weap_bas_lfla6"||
                sResRef=="weap_bas_hfla6"||sResRef=="weap_bas_mace6"||sResRef=="weap_bas_kukr1_6"||sResRef=="weap_bas_lstar6")&&
                (GetItemHasItemProperty(oTarget,ITEM_PROPERTY_DECREASED_SKILL_MODIFIER)==TRUE)){
                GiveGoldToCreature(oPC,128000);
                SafeDestroyObject(oTarget,0.0);
            }
            else if((sResRef=="weap_bas_lcro1"||sResRef=="weap_bas_lbow1"||sResRef=="weap_bas_sbow1"||sResRef=="weap_bas_sli1")&&
            (GetItemHasItemProperty(oTarget,ITEM_PROPERTY_DECREASED_SKILL_MODIFIER)==TRUE||
            GetItemHasItemProperty(oTarget,ITEM_PROPERTY_ADDITIONAL)==TRUE||
            GetItemHasItemProperty(oTarget,ITEM_PROPERTY_BONUS_SPELL_SLOT_OF_LEVEL_N)==TRUE||
            GetItemHasItemProperty(oTarget,ITEM_PROPERTY_IMMUNITY_SPECIFIC_SPELL)==TRUE)){
                GiveGoldToCreature(oPC,8000);
                SafeDestroyObject(oTarget,0.0);
            }
            else if((sResRef=="weap_bas_lcros4"||sResRef=="weap_bas_lbow4"||sResRef=="weap_bas_sbow4"||sResRef=="weap_bas_sli4")&&
            (GetItemHasItemProperty(oTarget,ITEM_PROPERTY_DECREASED_SKILL_MODIFIER)==TRUE||
            GetItemHasItemProperty(oTarget,ITEM_PROPERTY_ADDITIONAL)==TRUE||
            GetItemHasItemProperty(oTarget,ITEM_PROPERTY_BONUS_SPELL_SLOT_OF_LEVEL_N)==TRUE||
            GetItemHasItemProperty(oTarget,ITEM_PROPERTY_IMMUNITY_SPECIFIC_SPELL)==TRUE)){
                GiveGoldToCreature(oPC,32000);
                SafeDestroyObject(oTarget,0.0);
            }
            else if((sResRef=="weap_bas_lcros6"||sResRef=="weap_bas_lbow6"||sResRef=="weap_bas_sbow6"||sResRef=="weap_bas_sli6")&&
            (GetItemHasItemProperty(oTarget,ITEM_PROPERTY_DECREASED_SKILL_MODIFIER)==TRUE||
            GetItemHasItemProperty(oTarget,ITEM_PROPERTY_ADDITIONAL)==TRUE||
            GetItemHasItemProperty(oTarget,ITEM_PROPERTY_BONUS_SPELL_SLOT_OF_LEVEL_N)==TRUE||
            GetItemHasItemProperty(oTarget,ITEM_PROPERTY_IMMUNITY_SPECIFIC_SPELL)==TRUE)){
                GiveGoldToCreature(oPC,128000);
                SafeDestroyObject(oTarget,0.0);
            }
            else if(sResRef=="loot_mo_01_br1"&&
                (GetItemHasItemProperty(oTarget,ITEM_PROPERTY_DECREASED_SKILL_MODIFIER)==TRUE)){
                GiveGoldToCreature(oPC,8000);
                SafeDestroyObject(oTarget,0.0);
            }
            else if(sResRef=="loot_mo_16_br1"&&
                (GetItemHasItemProperty(oTarget,ITEM_PROPERTY_DECREASED_SKILL_MODIFIER)==TRUE)){
                GiveGoldToCreature(oPC,32000);
                SafeDestroyObject(oTarget,0.0);
            }
            else if((sResRef=="loot_mo_26_br1"||sResRef=="loot_mo_26_br2")&&
                (GetItemHasItemProperty(oTarget,ITEM_PROPERTY_DECREASED_SKILL_MODIFIER)==TRUE)){
                GiveGoldToCreature(oPC,128000);
                SafeDestroyObject(oTarget,0.0);
            }
            if((sResRef=="weap_bas_axt_1"||sResRef=="weap_bas_dar_1"||sResRef=="weap_bas_shu_1")&&
                (GetItemHasItemProperty(oTarget,ITEM_PROPERTY_DECREASED_SKILL_MODIFIER)==TRUE)){
                GiveGoldToCreature(oPC,8000);
                SafeDestroyObject(oTarget,0.0);
                oItem2 = GetFirstItemInInventory(oPC);
                while(oItem2!=OBJECT_INVALID){
                    if(GetTag(oItem)==GetTag(oItem2))
                        DestroyObject(oItem2);
                    oItem2 = GetNextItemInInventory(oPC);
                }
            }
            if((sResRef=="weap_bas_axt_4"||sResRef=="weap_bas_dar_4"||sResRef=="weap_bas_shu_4")&&
                (GetItemHasItemProperty(oTarget,ITEM_PROPERTY_DECREASED_SKILL_MODIFIER)==TRUE)){
                GiveGoldToCreature(oPC,32000);
                SafeDestroyObject(oTarget,0.0);
                oItem2 = GetFirstItemInInventory(oPC);
                while(oItem2!=OBJECT_INVALID){
                    if(GetTag(oItem)==GetTag(oItem2))
                        DestroyObject(oItem2);
                    oItem2 = GetNextItemInInventory(oPC);
                }
            }
            if((sResRef=="weap_bas_axt_6"||sResRef=="weap_bas_dar_6"||sResRef=="weap_bas_shu_6")&&
                (GetItemHasItemProperty(oTarget,ITEM_PROPERTY_DECREASED_SKILL_MODIFIER)==TRUE)){
                GiveGoldToCreature(oPC,128000);
                SafeDestroyObject(oTarget,0.0);
                oItem2 = GetFirstItemInInventory(oPC);
                while(oItem2!=OBJECT_INVALID){
                    if(GetTag(oItem)==GetTag(oItem2))
                        DestroyObject(oItem2);
                    oItem2 = GetNextItemInInventory(oPC);
                }
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

