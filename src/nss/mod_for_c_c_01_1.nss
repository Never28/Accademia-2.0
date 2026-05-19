void CreaOggetto(object oPC){
    CreateItemOnObject("set_01_w_and",oPC);
}

void main()
{
    object oPC = GetPCSpeaker();
    object oItem = GetFirstItemInInventory(oPC);
    string sTag;
    int nGold = GetGold(oPC);
    int nOssRat=6,nCuoZom=2,nFasMum=2,nDiff_1,nDiff_2,nDiff_3,nDiff_4,nDiff_5,nDiff_6;
    if(nGold>=2000){
        while(oItem!=OBJECT_INVALID){
            sTag = GetTag(oItem);
            if(sTag=="craft_1_zom"&&nCuoZom>0){
                nDiff_3 = GetItemStackSize(oItem);
                if(nDiff_3>nCuoZom){
                    SetItemStackSize(oItem,nDiff_3-nCuoZom);
                    nCuoZom=0;
                }
                else if(nDiff_3==nCuoZom){
                    DestroyObject(oItem,0.0);
                    nCuoZom=0;
                }
                else{
                    DestroyObject(oItem,0.0);
                    nCuoZom=nCuoZom-nDiff_3;
                }
            }
            else if(sTag=="craft_1_rat_bos3"&&nOssRat>0){
                nDiff_4 = GetItemStackSize(oItem);
                if(nDiff_4>nOssRat){
                    SetItemStackSize(oItem,nDiff_4-nOssRat);
                    nOssRat=0;
                }
                else if(nDiff_4==nOssRat){
                    DestroyObject(oItem,0.0);
                    nOssRat=0;
                }
                else{
                    DestroyObject(oItem,0.0);
                    nOssRat=nOssRat-nDiff_4;
                }
            }
            else if(sTag=="craft_1_mum"&&nFasMum>0){
                nDiff_6 = GetItemStackSize(oItem);
                if(nDiff_6>nFasMum){
                    SetItemStackSize(oItem,nDiff_6-nFasMum);
                    nFasMum=0;
                }
                else if(nDiff_6==nFasMum){
                    DestroyObject(oItem,0.0);
                    nFasMum=0;
                }
                else{
                    DestroyObject(oItem,0.0);
                    nFasMum=nFasMum-nDiff_6;
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
