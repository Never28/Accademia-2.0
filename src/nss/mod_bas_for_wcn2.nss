#include "x2_inc_itemprop"

void main()
{
    object oPC = GetPCSpeaker();
    object oWeap = GetItemInSlot(INVENTORY_SLOT_RIGHTHAND,oPC);
    string sResRef = GetResRef(oWeap);
    int nLunghezza = GetStringLength(sResRef);
    object oItem = GetFirstItemInInventory(oPC);
    itemproperty ip_Item = GetFirstItemProperty(oWeap);
    while(GetIsItemPropertyValid(ip_Item)){
        int nType = GetItemPropertyType(ip_Item);
        if(nType == ITEM_PROPERTY_DECREASED_SKILL_MODIFIER){
            SendMessageToPC(oPC,"L'arma ha gia' un potenziamento speciale sopra di se, non e' ulteriormente potenziabile");
            return;
        }
        ip_Item = GetNextItemProperty(oWeap);
    }
    if((sResRef=="weap_bas_daxe4"||sResRef=="weap_bas_dmace4"||sResRef=="weap_bas_dswo4"||sResRef=="weap_bas_alab4"||
    sResRef=="weap_bas_staff4"||sResRef=="weap_bas_scy4"||sResRef=="weap_bas_spea4"||sResRef=="weap_bas_lanbat4"||
    sResRef=="weap_bas_trid4"||sResRef=="weap_bas_gaxe4"||sResRef=="weap_bas_smaxe4"||sResRef=="weap_bas_baxe4"||
    sResRef=="weap_bas_dwaxe4"||sResRef=="weap_bas_kat4"||sResRef=="weap_bas_scim4"||sResRef=="weap_bas_rap4"||
    sResRef=="weap_bas_kama4"||sResRef=="weap_bas_whi4"||sResRef=="weap_bas_sic4"||sResRef=="weap_bas_club4"||
    sResRef=="weap_bas_dag4"||sResRef=="weap_bas_bsw4"||sResRef=="weap_bas_ssw4"||sResRef=="weap_bas_lsw4"||
    sResRef=="weap_bas_gsw4"||sResRef=="weap_bas_lham4"||sResRef=="weap_bas_sham4"||sResRef=="weap_bas_lfla4"||
    sResRef=="weap_bas_hfla4"||sResRef=="weap_bas_mace4"||sResRef=="weap_bas_kukr1_4"||sResRef=="weap_bas_lstar4")&&
    (GetItemPossessedBy(oPC,"crystal_neg_2")!=OBJECT_INVALID)){
        oItem = GetFirstItemInInventory(oPC);
        string sTag;
        int nGold = GetGold(oPC);
        int nItem1=1,nItem4=6,nDiff_1,nDiff_4;
        if(nGold>=32000){
            while(oItem!=OBJECT_INVALID){
                sTag = GetTag(oItem);
                if(sTag=="crystal_neg_2"&&nItem1>0){
                    nDiff_1 = GetItemStackSize(oItem);
                    if(nDiff_1>nItem1){
                        SetItemStackSize(oItem,nDiff_1-nItem1);
                        nItem1=0;
                    }
                    else if(nDiff_1==nItem1){
                        DestroyObject(oItem,0.0);
                        nItem1=0;
                    }
                    else{
                        DestroyObject(oItem,0.0);
                        nItem1=nItem1-nDiff_1;
                    }
                }
                oItem = GetNextItemInInventory(oPC);
            }
            IPSafeAddItemProperty(oWeap, ItemPropertyDecreaseSkill(SKILL_SPELLCRAFT,1));
            IPSafeAddItemProperty(oWeap, ItemPropertyDamageBonus(IP_CONST_DAMAGETYPE_NEGATIVE,IP_CONST_DAMAGEBONUS_1d6));
            TakeGoldFromCreature(32000,oPC,TRUE);
            SetItemCursedFlag(oItem, TRUE);
            SetPlotFlag(oWeap,TRUE);
            object oTap1 = GetObjectByTag("mod_for_ber_t1");
            object oTap2 = GetObjectByTag("mod_for_ber_t2");
            object oTap3 = GetObjectByTag("mod_for_ber_t3");
            object oFab = GetObjectByTag("neg_ber_fab");
            object oFor = GetObjectByTag("mod_for_ber");
            SetCutsceneMode(oPC,TRUE,FALSE);
            SetLocalInt(oFab,"occupato",1);
            DelayCommand(0.0,AssignCommand(oFab,ActionForceMoveToObject(oTap1,TRUE)));
            DelayCommand(6.0,AssignCommand(oFab,ActionAttack(oFor,TRUE)));
            DelayCommand(5.0,ApplyEffectToObject(DURATION_TYPE_TEMPORARY,EffectVisualEffect(VFX_IMP_FLAME_M),oFor));
            DelayCommand(6.0,ApplyEffectToObject(DURATION_TYPE_TEMPORARY,EffectVisualEffect(VFX_IMP_FLAME_M),oFor));
            DelayCommand(7.0,ApplyEffectToObject(DURATION_TYPE_TEMPORARY,EffectVisualEffect(VFX_IMP_SUNSTRIKE),oFor));
            DelayCommand(7.0,AssignCommand(oFab,ActionPlayAnimation(ANIMATION_FIREFORGET_VICTORY1,1.0)));
            DelayCommand(8.0,AssignCommand(oFab,ClearAllActions(TRUE)));
            DelayCommand(9.0,SetCutsceneMode(oPC,FALSE,TRUE));
            DelayCommand(9.0,AssignCommand(oFab,ActionForceMoveToObject(oTap2,TRUE)));
            DelayCommand(10.0,SetLocalInt(oFab,"occupato",0));
            DelayCommand(14.0,AssignCommand(oFab,ActionForceMoveToObject(oTap3,TRUE)));
        }
        else
            SendMessageToPC(oPC,"Non cercare di imbrogliare lasciando i soldi per terra, il fabbro non e' un pollo e tu sei un lamer!");
    }
}
