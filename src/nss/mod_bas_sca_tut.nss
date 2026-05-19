
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
    object oPC = GetPCSpeaker();
    string sTag,sTagR;
    int nStack = 0;
    object oTarget = GetFirstItemInInventory(oPC);
    while(oTarget != OBJECT_INVALID){
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
        else if(sTag=="craft_48"||sTag=="craft_51"||sTag=="craft_63"||sTag=="craft_73"||sTag=="craft_78"){
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
        else if(sTag=="craft_46"||sTag=="craft_47"||sTag=="craft_49"||sTag=="craft_50"||sTag=="craft_61"||sTag=="craft_73"||sTag=="craft_76"){
            nStack = GetItemStackSize(oTarget);
            GiveGoldToCreature(oPC,7000*nStack);
            SafeDestroyObject(oTarget,0.0);
        }
        oTarget = GetNextItemInInventory(oPC);
    }
}
