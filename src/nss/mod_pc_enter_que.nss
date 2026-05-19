#include "mod_bas_que_func"

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
    object oPC = OBJECT_SELF;
    CopiaStringa(oPC);
    DelayCommand(1.0,AggiornaDiario(oPC));
    object oItem3 = GetItemInSlot(INVENTORY_SLOT_CLOAK,oPC);
    DelayCommand(0.9,AssignCommand(oPC,ActionUnequipItem(oItem3)));
    DelayCommand(1.8,AssignCommand(oPC,ActionEquipItem(oItem3,INVENTORY_SLOT_CLOAK)));

    object oItem6 = GetItemInSlot(INVENTORY_SLOT_NECK,oPC);
    DelayCommand(0.9,AssignCommand(oPC,ActionUnequipItem(oItem6)));
    DelayCommand(1.8,AssignCommand(oPC,ActionEquipItem(oItem6,INVENTORY_SLOT_NECK)));

    object oItem7 = GetItemInSlot(INVENTORY_SLOT_HEAD,oPC);
    DelayCommand(0.3,AssignCommand(oPC,ActionUnequipItem(oItem7)));
    DelayCommand(1.2,AssignCommand(oPC,ActionEquipItem(oItem7,INVENTORY_SLOT_HEAD)));

    object oWea = GetItemInSlot(INVENTORY_SLOT_RIGHTHAND,oPC);
    int nType = GetBaseItemType(oWea);
    if(nType == BASE_ITEM_SLING && nType == BASE_ITEM_SHORTBOW && nType == BASE_ITEM_LONGBOW &&
    nType == BASE_ITEM_HEAVYCROSSBOW){
        DelayCommand(0.3,AssignCommand(oPC,ActionUnequipItem(oWea)));
        DelayCommand(1.2,AssignCommand(oPC,ActionEquipItem(oWea,INVENTORY_SLOT_RIGHTHAND)));
    }
    else if(nType == BASE_ITEM_SHURIKEN && nType == BASE_ITEM_THROWINGAXE &&
    nType == BASE_ITEM_DART){
        string sResRef = GetResRef(oWea);
        SafeDestroyObject(oWea, 0.0);
        object oWea = CreateItemOnObject(sResRef,oPC,50);
        DelayCommand(1.2,AssignCommand(oPC,ActionEquipItem(oWea,INVENTORY_SLOT_RIGHTHAND)));
    }

}
