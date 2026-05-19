#include "x2_inc_itemprop"

void AddItemPropertyVisualEffect(object oPC,int iSlot,int iItemVisual);

void Appearance(object oPC,int iAppearance);

void RemoveAllEffects(object oPC);

void CollorModLoad(string sTagg);

void CollorModEnter(string sTag);

void AddItemPropertyVisualEffect(object oPC,int iSlot,int iItemVisual)
{
    object oItem = GetItemInSlot(iSlot, oPC);
    itemproperty ipAdd = ItemPropertyVisualEffect(iItemVisual);
    effect AddVfx = EffectVisualEffect(VFX_IMP_SUPER_HEROISM);
    if(GetIsObjectValid(oItem)==TRUE){
        IPRemoveMatchingItemProperties(oItem,ITEM_PROPERTY_VISUALEFFECT, -1);
        IPSafeAddItemProperty(oItem,ipAdd);
        ApplyEffectToObject(DURATION_TYPE_INSTANT,AddVfx,oPC);
        FloatingTextStringOnCreature("Nuova visuale aggiunta",oPC);
    }
    if(GetIsObjectValid(oItem)==FALSE)
        FloatingTextStringOnCreature("Nessun item nella mano destra",oPC);
}

void APPEARANCE_CHANCE_VFX(object oPC)
{
    effect Appariance_Vfx_1 = EffectVisualEffect(VFX_IMP_PULSE_COLD);
    effect Appariance_Vfx_2 = EffectVisualEffect(VFX_IMP_PULSE_FIRE);
    effect Appariance_Vfx_3 = EffectVisualEffect(VFX_IMP_PULSE_HOLY);
    effect Appariance_Vfx_4 = EffectVisualEffect(VFX_IMP_PULSE_NATURE);
    DelayCommand(0.0,ApplyEffectToObject(DURATION_TYPE_INSTANT,Appariance_Vfx_1,oPC));
    DelayCommand(0.5,ApplyEffectToObject(DURATION_TYPE_INSTANT,Appariance_Vfx_2,oPC));
    DelayCommand(1.0,ApplyEffectToObject(DURATION_TYPE_INSTANT,Appariance_Vfx_3,oPC));
    DelayCommand(1.5,ApplyEffectToObject(DURATION_TYPE_INSTANT,Appariance_Vfx_4,oPC));
}

void CollorModLoad(string sTag)
{
    string sColor = GetName(GetObjectByTag(sTag));
    SetCustomToken(1001, GetSubString(sColor, 0, 6));
    SetCustomToken(1002, GetSubString(sColor, 6, 6));
    SetCustomToken(1003, GetSubString(sColor, 12, 6));
    SetCustomToken(1004, GetSubString(sColor, 18, 6));
    SetCustomToken(1005, GetSubString(sColor, 24, 6));
    SetCustomToken(1006, GetSubString(sColor, 30, 6));
    SetCustomToken(1007, GetSubString(sColor, 36, 6));

}
void CollorModEnter(string sTag)
{
    string sColor = GetName(GetObjectByTag(sTag));
    string sWhite = GetSubString(sColor, 0, 6);
    string sYellow = GetSubString(sColor, 6, 6);
    string sMagenta = GetSubString(sColor, 12, 6);
    string sCyan = GetSubString(sColor, 18, 6);
    string sRed = GetSubString(sColor, 24, 6);
    string sGreen = GetSubString(sColor, 30, 6);
    string sBlue = GetSubString(sColor, 36, 6);
}

