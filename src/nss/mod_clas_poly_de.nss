/*
  CREATO DA:      Tempesta
  DATA CREAZIONE: 25-06-2009
*/

// Totem delle Trasformazioni distruzione.

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
    object oSkinOld = GetItemInSlot(INVENTORY_SLOT_CARMOUR,oPC);
    SafeDestroyObject(oSkinOld,0.0);
    if(GetItemPossessedBy(oPC,"mod_deity_sekki")!=OBJECT_INVALID||
    GetItemPossessedBy(oPC,"mod_deity_mephi")!=OBJECT_INVALID||
    GetItemPossessedBy(oPC,"mod_bas_polyself")!=OBJECT_INVALID){
        if(GetItemPossessedBy(oPC,"hlslang_1")!=OBJECT_INVALID)
            SetCreatureAppearanceType(oPC,APPEARANCE_TYPE_ELF);
        else if(GetItemPossessedBy(oPC,"hlslang_5")!=OBJECT_INVALID)
            SetCreatureAppearanceType(oPC,APPEARANCE_TYPE_HALF_ORC);
        else if(GetItemPossessedBy(oPC,"hlslang_2")!=OBJECT_INVALID)
            SetCreatureAppearanceType(oPC,APPEARANCE_TYPE_GNOME);
        else if(GetItemPossessedBy(oPC,"hlslang_3")!=OBJECT_INVALID)
            SetCreatureAppearanceType(oPC,APPEARANCE_TYPE_HALFLING);
        else if(GetItemPossessedBy(oPC,"hlslang_4")!=OBJECT_INVALID)
            SetCreatureAppearanceType(oPC,APPEARANCE_TYPE_DWARF);
        else
            SetCreatureAppearanceType(oPC,APPEARANCE_TYPE_HALF_ELF);
        SetLocalInt(oPC,"poly_ability",89);
        SetLocalInt(oPC,"poly_weaponr",0);
        SetLocalInt(oPC,"poly_weaponm",0);
        SetLocalInt(oPC,"poly_shield",0);
        SetLocalInt(oPC,"metamorfosispec",0);
        SetLocalInt(oPC,"metamorfosi",0);
        object oAntiPoly = GetItemPossessedBy(oPC,"mod_bas_polyself");
        if(oAntiPoly!=OBJECT_INVALID)
            DestroyObject(oAntiPoly,0.0);
    }

    ExecuteScript("mod_clas_poly_df",oPC);
}
