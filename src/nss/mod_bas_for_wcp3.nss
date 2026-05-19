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
    if((sResRef=="weap_bas_daxe6"||sResRef=="weap_bas_dmace6"||sResRef=="weap_bas_dswo6"||sResRef=="weap_bas_alab6"||
    sResRef=="weap_bas_staff6"||sResRef=="weap_bas_scy6"||sResRef=="weap_bas_spea6"||sResRef=="weap_bas_lanbat6"||
    sResRef=="weap_bas_trid6"||sResRef=="weap_bas_gaxe6"||sResRef=="weap_bas_smaxe6"||sResRef=="weap_bas_baxe6"||
    sResRef=="weap_bas_dwaxe6"||sResRef=="weap_bas_kat6"||sResRef=="weap_bas_scim6"||sResRef=="weap_bas_rap6"||
    sResRef=="weap_bas_kama6"||sResRef=="weap_bas_whi6"||sResRef=="weap_bas_sic6"||sResRef=="weap_bas_club6"||
    sResRef=="weap_bas_dag6"||sResRef=="weap_bas_bsw6"||sResRef=="weap_bas_ssw6"||sResRef=="weap_bas_lsw6"||
    sResRef=="weap_bas_gsw6"||sResRef=="weap_bas_lham6"||sResRef=="weap_bas_sham6"||sResRef=="weap_bas_lfla6"||
    sResRef=="weap_bas_hfla6"||sResRef=="weap_bas_mace6"||sResRef=="weap_bas_kukr1_6"||sResRef=="weap_bas_lstar6")&&
    (GetItemPossessedBy(oPC,"crystal_pos_3")!=OBJECT_INVALID)){
        oItem = GetFirstItemInInventory(oPC);
        string sTag;
        int nGold = GetGold(oPC);
        int nItem1=1,nItem2=4,nDiff_1,nDiff_2;
        if(nGold>=128000){
            while(oItem!=OBJECT_INVALID){
                sTag = GetTag(oItem);
                if(sTag=="crystal_pos_3"&&nItem1>0){
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
            IPSafeAddItemProperty(oWeap, ItemPropertyDamageBonus(IP_CONST_DAMAGETYPE_POSITIVE,IP_CONST_DAMAGEBONUS_2d4));
            TakeGoldFromCreature(128000,oPC,TRUE);
            SetItemCursedFlag(oItem, TRUE);
            SetPlotFlag(oWeap,TRUE);
            object oTap1 = GetObjectByTag("mod_for_bal_t1");
            object oTap2 = GetObjectByTag("mod_for_bal_t2");
            object oTap3 = GetObjectByTag("mod_for_bal_t3");
            object oFab = GetObjectByTag("neg_bal_fab");
            object oFor = GetObjectByTag("mod_for_bal");
            SetCutsceneMode(oPC,TRUE,FALSE);
            SetLocalInt(oFab,"occupato",1);
            DelayCommand(0.0,AssignCommand(oFab,ActionForceMoveToObject(oTap1,TRUE)));
            DelayCommand(4.0,AssignCommand(oFab,ActionAttack(oFor,TRUE)));
            DelayCommand(5.0,ApplyEffectToObject(DURATION_TYPE_TEMPORARY,EffectVisualEffect(VFX_IMP_FLAME_M),oFor));
            DelayCommand(6.0,ApplyEffectToObject(DURATION_TYPE_TEMPORARY,EffectVisualEffect(VFX_IMP_FLAME_M),oFor));
            DelayCommand(7.0,ApplyEffectToObject(DURATION_TYPE_TEMPORARY,EffectVisualEffect(VFX_IMP_SUNSTRIKE),oFor));
            DelayCommand(7.0,AssignCommand(oFab,ActionPlayAnimation(ANIMATION_FIREFORGET_VICTORY1,1.0)));
            DelayCommand(8.0,AssignCommand(oFab,ClearAllActions(TRUE)));
            DelayCommand(9.0,SetCutsceneMode(oPC,FALSE,TRUE));
            DelayCommand(9.0,AssignCommand(oFab,ActionForceMoveToObject(oTap2,TRUE)));
            DelayCommand(10.0,SetLocalInt(oFab,"occupato",0));
            DelayCommand(12.0,AssignCommand(oFab,ActionForceMoveToObject(oTap3,TRUE)));
        }
        else
            SendMessageToPC(oPC,"Non cercare di imbrogliare lasciando i soldi per terra, il fabbro non e' un pollo e tu sei un lamer!");
    }
}
