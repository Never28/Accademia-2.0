#include "x2_inc_itemprop"

void main()
{
    object oPC = OBJECT_SELF;
    int nBarb = GetLevelByClass(CLASS_TYPE_BARBARIAN,oPC);
    object oSkin = CreateItemOnObject("poly_base",oPC);
    if(nBarb == 40){
        itemproperty ipAdd = ItemPropertyBonusFeat(63);
        IPSafeAddItemProperty(oSkin, ipAdd);
        ipAdd = ItemPropertyBonusFeat(64);
        IPSafeAddItemProperty(oSkin, ipAdd);
        ipAdd = ItemPropertyBonusFeat(65);
        IPSafeAddItemProperty(oSkin, ipAdd);
        ipAdd = ItemPropertyBonusFeat(66);
        IPSafeAddItemProperty(oSkin, ipAdd);
        ipAdd = ItemPropertyBonusFeat(67);
        IPSafeAddItemProperty(oSkin, ipAdd);
    }
    AssignCommand(oPC,ActionEquipItem(oSkin,INVENTORY_SLOT_CARMOUR));
}
