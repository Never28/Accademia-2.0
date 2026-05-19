void CreaOggetto(object oPC){
    object oItem1;
    object oItem = CreateItemOnObject("set_30_w_arm",oPC);
    oItem1 = CopyItemAndModify(oItem,ITEM_APPR_TYPE_ARMOR_MODEL,ITEM_APPR_ARMOR_MODEL_TORSO,9);
    DestroyObject(oItem);
}

void main()
{
    object oPC = GetPCSpeaker();
    object oItem = GetFirstItemInInventory(oPC);
    string sTag;
    int nGold = GetGold(oPC);
    int nItem1=4,nItem2=8,nDiff_1,nDiff_2;
    if(nGold>=32000){
        while(oItem!=OBJECT_INVALID){
            sTag = GetTag(oItem);
            if(sTag=="craft_30_opa"&&nItem1>0){
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
            else if(sTag=="craft_30_tgu"&&nItem2>0){
                nDiff_2 = GetItemStackSize(oItem);
                if(nDiff_2>nItem2){
                    SetItemStackSize(oItem,nDiff_2-nItem2);
                    nItem2=0;
                }
                else if(nDiff_2==nItem2){
                    DestroyObject(oItem,0.0);
                    nItem2=0;
                }
                else{
                    DestroyObject(oItem,0.0);
                    nItem2=nItem2-nDiff_2;
                }
            }
            oItem = GetNextItemInInventory(oPC);
        }
        TakeGoldFromCreature(32000,oPC,TRUE);
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
        DelayCommand(9.0,CreaOggetto(oPC));
        DelayCommand(9.0,AssignCommand(oFab,ActionForceMoveToObject(oTap2,TRUE)));
        DelayCommand(10.0,SetLocalInt(oFab,"occupato",0));
        DelayCommand(12.0,AssignCommand(oFab,ActionForceMoveToObject(oTap3,TRUE)));
    }
    else
        SendMessageToPC(oPC,"Non cercare di imbrogliare lasciando i soldi per terra, il fabbro non e' un pollo e tu sei un lamer!");
}
