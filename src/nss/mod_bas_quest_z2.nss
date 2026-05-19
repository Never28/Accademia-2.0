#include "mod_bas_que_func"

void main()
{
    object oPC = GetPCSpeaker();
    string sQuest = GetLocalString(OBJECT_SELF,"quest");
    int nItem1,nItem2,nDiff_1,nDiff_2;
    string sItem,sItem2;
    if(sQuest == "26"){
        GiveXPToCreature(oPC,1000);
        GiveGoldToCreature(oPC,1000);
        sItem = "craft_1_nmo";
        nItem1 = 20;
    }
    if(sQuest == "27"){
        GiveXPToCreature(oPC,5000);
        GiveGoldToCreature(oPC,5000);
        sItem = "craft_19_bas";
        nItem1 = 20;
    }
    if(sQuest == "29"){
        GiveXPToCreature(oPC,500);
        GiveGoldToCreature(oPC,500);
        sItem = "craft_1_muc";
        sItem2 = "craft_1_gal";
        nItem1 = 4;
        nItem2 = 4;
    }
    if(sQuest == "26"||sQuest == "27"){
        object oItem = GetFirstItemInInventory(oPC);
        string sTag;
        while(oItem!=OBJECT_INVALID){
            sTag = GetTag(oItem);
            if(sTag==sItem&&nItem1>0){
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
    }
    else if(sQuest == "29"){
        object oItem = GetFirstItemInInventory(oPC);
        string sTag;
        while(oItem!=OBJECT_INVALID){
            sTag = GetTag(oItem);
            if(sTag==sItem&&nItem1>0){
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
            if(sTag==sItem2&&nItem2>0){
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
    }
    AddJournalQuestEntry("quest_"+sQuest,2,oPC,FALSE);
    ScritturaQuest("2",StringToInt(sQuest),oPC);
    IncollaStringa(oPC, GetLocalString(oPC,"quest"));
}
