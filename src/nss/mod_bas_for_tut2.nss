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
    if((sResRef == "tut_arma")&&(GetItemPossessedBy(oPC,"crystal_tut") != OBJECT_INVALID)){
        oItem = GetFirstItemInInventory(oPC);
        string sTag;
        int nGold = GetGold(oPC);
        int nItem1=1,nItem2=4,nDiff_1,nDiff_2;
        if(nGold>=0){
            while(oItem!=OBJECT_INVALID){
                sTag = GetTag(oItem);
                if(sTag=="crystal_tut"&&nItem1>0){
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
            IPSafeAddItemProperty(oWeap, ItemPropertyOnHitCastSpell(IP_CONST_ONHIT_CASTSPELL_LIGHT,40));
            SetItemCursedFlag(oItem, TRUE);
            SetPlotFlag(oWeap,TRUE);
            object oFor = GetObjectByTag(GetLocalString(oPC,"forgia_tut"));
            DeleteLocalString(oPC,"forgia_tut");
            string sFor = GetTag(oFor);
            object oTap1;
            object oTap2;
            object oTap3;
            object oFab;
            if(sFor=="mod_for_tut_dro"){
                oTap1 = GetObjectByTag("neg_tut_fab_drt1");
                oTap2 = GetObjectByTag("neg_tut_fab_drt2");
                oTap3 = GetObjectByTag("neg_tut_fab_drt3");
                oFab = GetObjectByTag("neg_tut_fab_dro");
            }
            else if(sFor=="mod_for_tut_elf"){
                oTap1 = GetObjectByTag("neg_tut_fab_elt1");
                oTap2 = GetObjectByTag("neg_tut_fab_elt2");
                oTap3 = GetObjectByTag("neg_tut_fab_elt3");
                oFab = GetObjectByTag("neg_tut_fab_elf");
            }
            else if(sFor=="mod_for_tut_dwa"){
                oTap1 = GetObjectByTag("neg_tut_fab_dwt1");
                oTap2 = GetObjectByTag("neg_tut_fab_dwt2");
                oTap3 = GetObjectByTag("neg_tut_fab_dwt3");
                oFab = GetObjectByTag("neg_tut_fab_dwa");
            }
            else if(sFor=="mod_for_tut_gno"){
                oTap1 = GetObjectByTag("neg_tut_fab_gnt1");
                oTap2 = GetObjectByTag("neg_tut_fab_gnt2");
                oTap3 = GetObjectByTag("neg_tut_fab_gnt3");
                oFab = GetObjectByTag("neg_tut_fab_gno");
            }
            else if(sFor=="mod_for_tut_hal"){
                oTap1 = GetObjectByTag("neg_tut_fab_hat1");
                oTap2 = GetObjectByTag("neg_tut_fab_hat2");
                oTap3 = GetObjectByTag("neg_tut_fab_hat3");
                oFab = GetObjectByTag("neg_tut_fab_hal");
            }
            else if(sFor=="mod_for_tut_mez"){
                oTap1 = GetObjectByTag("neg_tut_fab_met1");
                oTap2 = GetObjectByTag("neg_tut_fab_met2");
                oTap3 = GetObjectByTag("neg_tut_fab_met3");
                oFab = GetObjectByTag("neg_tut_fab_mez");
            }
            else if(sFor=="mod_for_tut_hum"){
                oTap1 = GetObjectByTag("neg_tut_fab_hut1");
                oTap2 = GetObjectByTag("neg_tut_fab_hut2");
                oTap3 = GetObjectByTag("neg_tut_fab_hut3");
                oFab = GetObjectByTag("neg_tut_fab_hum");
            }
            else if(sFor=="mod_for_tut_due"){
                oTap1 = GetObjectByTag("neg_tut_fab_dut1");
                oTap2 = GetObjectByTag("neg_tut_fab_dut2");
                oTap3 = GetObjectByTag("neg_tut_fab_dut3");
                oFab = GetObjectByTag("neg_tut_fab_due");
            }
            else if(sFor=="mod_for_tut_svi"){
                oTap1 = GetObjectByTag("neg_tut_fab_svt1");
                oTap2 = GetObjectByTag("neg_tut_fab_svt2");
                oTap3 = GetObjectByTag("neg_tut_fab_svt3");
                oFab = GetObjectByTag("neg_tut_fab_svi");
            }
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
