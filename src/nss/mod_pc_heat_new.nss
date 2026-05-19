/*
  CREATO DA:      Tempesta
  DATA CREAZIONE: 17-06-2009
*/

// La funzione per l'heatbeat del Giocatori.

#include "mod_omb_ant_spa"
void HeatPC(){
    object oPC=GetFirstPC();
    object oItem,oItem1;
    string sDisItem,sDisItem1;
    int nRangedType,nRangedType1;
    while(oPC!=OBJECT_INVALID){
        oItem = GetItemInSlot(INVENTORY_SLOT_RIGHTHAND,oPC);
        if(oItem!=OBJECT_INVALID){
            sDisItem = GetResRef(oItem);
            nRangedType = GetBaseItemType(oItem);
            if(nRangedType==BASE_ITEM_DART){
                if(sDisItem=="weap_bas_dar_1")
                    SetItemStackSize(oItem,50);
                else if(sDisItem=="weap_bas_dar_2")
                    SetItemStackSize(oItem,50);
                else if(sDisItem=="weap_bas_dar_3")
                    SetItemStackSize(oItem,50);
                else if(sDisItem=="weap_bas_dar_4")
                    SetItemStackSize(oItem,50);
                else if(sDisItem=="weap_bas_dar_5")
                    SetItemStackSize(oItem,50);
                else if(sDisItem=="weap_bas_dar_6")
                    SetItemStackSize(oItem,50);
                else if(sDisItem=="weap_bas_dar_7")
                    SetItemStackSize(oItem,50);
                else if(sDisItem=="weap_bas_dar_8")
                    SetItemStackSize(oItem,50);
            }
            else if(nRangedType==BASE_ITEM_THROWINGAXE){
                if(sDisItem=="weap_bas_axt_1")
                    SetItemStackSize(oItem,50);
                else if(sDisItem=="weap_bas_axt_2")
                    SetItemStackSize(oItem,50);
                else if(sDisItem=="weap_bas_axt_3")
                    SetItemStackSize(oItem,50);
                else if(sDisItem=="weap_bas_axt_4")
                    SetItemStackSize(oItem,50);
                else if(sDisItem=="weap_bas_axt_5")
                    SetItemStackSize(oItem,50);
                else if(sDisItem=="weap_bas_axt_6")
                    SetItemStackSize(oItem,50);
                else if(sDisItem=="weap_bas_axt_7")
                    SetItemStackSize(oItem,50);
                else if(sDisItem=="weap_bas_axt_8")
                    SetItemStackSize(oItem,50);
            }
            else if(nRangedType==BASE_ITEM_SHURIKEN){
                if(sDisItem=="weap_bas_shu_1")
                    SetItemStackSize(oItem,50);
                else if(sDisItem=="weap_bas_shu_2")
                    SetItemStackSize(oItem,50);
                else if(sDisItem=="weap_bas_shu_3")
                    SetItemStackSize(oItem,50);
                else if(sDisItem=="weap_bas_shu_4")
                    SetItemStackSize(oItem,50);
                else if(sDisItem=="weap_bas_shu_5")
                    SetItemStackSize(oItem,50);
                else if(sDisItem=="weap_bas_shu_6")
                    SetItemStackSize(oItem,50);
                else if(sDisItem=="weap_bas_shu_7")
                    SetItemStackSize(oItem,50);
                else if(sDisItem=="weap_bas_shu_8")
                    SetItemStackSize(oItem,50);
            }
            else if(nRangedType==BASE_ITEM_LONGBOW||nRangedType==BASE_ITEM_SHORTBOW){
                oItem1 = GetItemInSlot(INVENTORY_SLOT_ARROWS,oPC);
                sDisItem1 = GetResRef(oItem1);
                if(oItem1!=OBJECT_INVALID){
                        if(sDisItem1=="weap_bas_fre_1")
                            SetItemStackSize(oItem1,99);
                        else if(sDisItem1=="weap_bas_fre_2")
                            SetItemStackSize(oItem1,99);
                        else if(sDisItem1=="weap_bas_fre_3")
                            SetItemStackSize(oItem1,99);
                        else if(sDisItem1=="weap_bas_fre_4")
                            SetItemStackSize(oItem1,99);
                        else if(sDisItem1=="weap_bas_fre_5")
                            SetItemStackSize(oItem1,99);
                        else if(sDisItem1=="weap_bas_fre_6")
                            SetItemStackSize(oItem1,99);
                        else if(sDisItem1=="weap_bas_fre_7")
                            SetItemStackSize(oItem1,99);
                        else if(sDisItem1=="weap_bas_fre_8")
                            SetItemStackSize(oItem1,99);
                }
            }
            else if(nRangedType==BASE_ITEM_HEAVYCROSSBOW){
                oItem1 = GetItemInSlot(INVENTORY_SLOT_BOLTS,oPC);
                sDisItem1 = GetResRef(oItem1);
                if(oItem1!=OBJECT_INVALID){
                        if(sDisItem1=="weap_bas_mun_1")
                            SetItemStackSize(oItem1,99);
                        else if(sDisItem1=="weap_bas_mun_2")
                            SetItemStackSize(oItem1,99);
                        else if(sDisItem1=="weap_bas_mun_3")
                            SetItemStackSize(oItem1,99);
                        else if(sDisItem1=="weap_bas_mun_4")
                            SetItemStackSize(oItem1,99);
                        else if(sDisItem1=="weap_bas_mun_5")
                            SetItemStackSize(oItem1,99);
                        else if(sDisItem1=="weap_bas_mun_6")
                            SetItemStackSize(oItem1,99);
                        else if(sDisItem1=="weap_bas_mun_7")
                            SetItemStackSize(oItem1,99);
                        else if(sDisItem1=="weap_bas_mun_8")
                            SetItemStackSize(oItem1,99);
                    }
            }
            else if(nRangedType==BASE_ITEM_SLING){
                oItem1 = GetItemInSlot(INVENTORY_SLOT_BULLETS,oPC);
                sDisItem1 = GetResRef(oItem1);
                if(oItem1!=OBJECT_INVALID){
                        if(sDisItem1=="weap_bas_pro_1")
                            SetItemStackSize(oItem1,99);
                        else if(sDisItem1=="weap_bas_pro_2")
                            SetItemStackSize(oItem1,99);
                        else if(sDisItem1=="weap_bas_pro_3")
                            SetItemStackSize(oItem1,99);
                        else if(sDisItem1=="weap_bas_pro_4")
                            SetItemStackSize(oItem1,99);
                        else if(sDisItem1=="weap_bas_pro_5")
                            SetItemStackSize(oItem1,99);
                        else if(sDisItem1=="weap_bas_pro_6")
                            SetItemStackSize(oItem1,99);
                        else if(sDisItem1=="weap_bas_pro_7")
                            SetItemStackSize(oItem1,99);
                        else if(sDisItem1=="weap_bas_pro_8")
                            SetItemStackSize(oItem1,99);
                    }
            }
        }
        ThinkChecks(6.0,oPC);
        oPC = GetNextPC();
    }
    DelayCommand(6.0,HeatPC());
}
void main()
{
    HeatPC();
}

