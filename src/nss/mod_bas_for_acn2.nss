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
        if(nType == ITEM_PROPERTY_DECREASED_SKILL_MODIFIER||
        nType == ITEM_PROPERTY_ADDITIONAL||
        nType == ITEM_PROPERTY_BONUS_SPELL_SLOT_OF_LEVEL_N||
        nType == ITEM_PROPERTY_IMMUNITY_SPECIFIC_SPELL){
            SendMessageToPC(oPC,"L'arma ha gia' un potenziamento speciale sopra di se, non e' ulteriormente potenziabile");
            return;
        }
        ip_Item = GetNextItemProperty(oWeap);
    }
    if((sResRef=="weap_bas_lcros4"||sResRef=="weap_bas_lbow4"||sResRef=="weap_bas_sbow4"||sResRef=="weap_bas_sli4")&&
    (GetItemPossessedBy(oPC,"crystal_neg_2")!=OBJECT_INVALID)){
        oItem = GetFirstItemInInventory(oPC);
        string sTag;
        int nGold = GetGold(oPC);
        int nItem1=1,nItem2=4,nDiff_1,nDiff_2;
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
            IPSafeAddItemProperty(oWeap, ItemPropertyBonusLevelSpell(IP_CONST_CLASS_RANGER,0));
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
            DelayCommand(4.0,AssignCommand(oFab,ActionAttack(oFor,TRUE)));
            DelayCommand(5.0,ApplyEffectToObject(DURATION_TYPE_TEMPORARY,EffectVisualEffect(VFX_IMP_FLAME_M),oFor));
            DelayCommand(6.0,ApplyEffectToObject(DURATION_TYPE_TEMPORARY,EffectVisualEffect(VFX_IMP_FLAME_M),oFor));
            DelayCommand(7.0,ApplyEffectToObject(DURATION_TYPE_TEMPORARY,EffectVisualEffect(VFX_IMP_SUNSTRIKE),oFor));
            DelayCommand(7.0,AssignCommand(oFab,ActionPlayAnimation(ANIMATION_FIREFORGET_VICTORY1,1.0)));
            DelayCommand(8.0,AssignCommand(oFab,ClearAllActions(TRUE)));
            DelayCommand(9.0,SetCutsceneMode(oPC,FALSE,TRUE));
            DelayCommand(9.0,AssignCommand(oPC,ActionUnequipItem(oWeap)));
            DelayCommand(9.0,AssignCommand(oFab,ActionForceMoveToObject(oTap2,TRUE)));
            DelayCommand(10.0,AssignCommand(oPC,ActionEquipItem(oWeap,INVENTORY_SLOT_RIGHTHAND)));
            DelayCommand(10.0,SetLocalInt(oFab,"occupato",0));
            DelayCommand(12.0,AssignCommand(oFab,ActionForceMoveToObject(oTap3,TRUE)));
        }
        else
            SendMessageToPC(oPC,"Non cercare di imbrogliare lasciando i soldi per terra, il fabbro non e' un pollo e tu sei un lamer!");
    }
}
