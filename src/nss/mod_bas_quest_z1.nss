#include "mod_bas_que_func"

int StartingConditional()
{
    object oPC = GetPCSpeaker();
    string sQuest = GetLocalString(OBJECT_SELF,"quest");
    object oItem = GetFirstItemInInventory(oPC);
    string sTag = GetTag(oItem);
    int nItem1,nItem2,nDiff_1;
    string sItem;
    if(sQuest == "26"){
        sItem = "craft_1_nmo";
    }
    if(sQuest == "27"){
        sItem = "craft_19_bas";
    }
    if(sQuest == "27"||sQuest == "26"){
        while(oItem!=OBJECT_INVALID){
            sTag = GetTag(oItem);
            if(sTag==sItem)
                nItem1 = nItem1 + GetItemStackSize(oItem);
            oItem = GetNextItemInInventory(oPC);
        }
        if(nItem1>=20){
            return TRUE;
        }
    }
    else if(sQuest == "29"){
        string sItem2;
        if(sQuest == "29"){
            sItem = "craft_1_muc";
            sItem2 = "craft_1_gal";
        }
        while(oItem!=OBJECT_INVALID){
            sTag = GetTag(oItem);
            if(sTag==sItem)
                nItem1 = nItem1 + GetItemStackSize(oItem);
            else if(sTag==sItem2)
                nItem2 = nItem2 + GetItemStackSize(oItem);
            oItem = GetNextItemInInventory(oPC);
        }
        if(nItem1>=4&&nItem2>=4){
            return TRUE;
        }
    }
    return FALSE;
}
