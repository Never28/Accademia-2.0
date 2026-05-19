void CreaOggetto(object oPC){
    CreateItemOnObject("set_01_w_elm",oPC);
}

void main()
{
    object oPC = GetPCSpeaker();
    object oItem = GetFirstItemInInventory(oPC);
    string sTag;
    int nGold = GetGold(oPC);
    int nDenRat=1,nCiuRat=4,nPelAni=4,nDiff_2,nDiff_3,nDiff_4,nDiff_5,nDiff_6;
    if(nGold>=2000){
        while(oItem!=OBJECT_INVALID){
            sTag = GetTag(oItem);
            if(sTag=="craft_1_g_m"&&nPelAni>0){
                nDiff_2 = GetItemStackSize(oItem);
                if(nDiff_2>nPelAni){
                    SetItemStackSize(oItem,nDiff_2-nPelAni);
                    nPelAni=0;
                }
                else if(nDiff_2==nPelAni){
                    DestroyObject(oItem,0.0);
                    nPelAni=0;
                }
                else{
                    DestroyObject(oItem,0.0);
                    nPelAni=nPelAni-nDiff_2;
                }
            }
            else if(sTag=="craft_1_rat"&&nCiuRat>0){
                nDiff_3 = GetItemStackSize(oItem);
                if(nDiff_3>nCiuRat){
                    SetItemStackSize(oItem,nDiff_3-nCiuRat);
                    nCiuRat=0;
                }
                else if(nDiff_3==nCiuRat){
                    DestroyObject(oItem,0.0);
                    nCiuRat=0;
                }
                else{
                    DestroyObject(oItem,0.0);
                    nCiuRat=nCiuRat-nDiff_3;
                }
            }
            else if(sTag=="craft_1_rat_bos1"&&nDenRat>0){
                nDiff_4 = GetItemStackSize(oItem);
                if(nDiff_4>nPelAni){
                    SetItemStackSize(oItem,nDiff_4-nDenRat);
                    nDenRat=0;
                }
                else if(nDiff_4==nDenRat){
                    DestroyObject(oItem,0.0);
                    nDenRat=0;
                }
                else{
                    DestroyObject(oItem,0.0);
                    nDenRat=nDenRat-nDiff_4;
                }
            }
            oItem = GetNextItemInInventory(oPC);
        }
        TakeGoldFromCreature(2000,oPC,TRUE);
        object oTap1 = GetObjectByTag("mod_for_can_t1");
        object oTap2 = GetObjectByTag("mod_for_can_t2");
        object oTap3 = GetObjectByTag("mod_for_can_t3");
        object oFab = GetObjectByTag("neg_can_fab");
        object oFor = GetObjectByTag("mod_for_can");
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
