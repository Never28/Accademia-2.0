#include"lcs_color_func"

void main()
{
    object oPC = GetPCSpeaker();
    int WeapCollor;
    if(GetLocalInt(oPC,"WeapCollor")== TRUE){
        FloatingTextStringOnCreature("Spam lag fixed",oPC);
        return;
    }
    else{
        SetLocalInt(oPC,"WeapCollor",TRUE);
        DelayCommand(2.0,SetLocalInt(oPC,"WeapCollor",FALSE));
        AddItemPropertyVisualEffect(oPC,INVENTORY_SLOT_RIGHTHAND,ITEM_VISUAL_FIRE);
    }
}

