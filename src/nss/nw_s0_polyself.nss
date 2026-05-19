/*
  CREATO DA:      Tempesta
  DATA CREAZIONE: 24-06-2009
*/

// Polymorfismo.

void SafePolymorph(object oPC, int nRanged, int nMelee, int nShield, int nSpellFailure, string sPolyType, int nPolyType)
{
    int eEffectType;
    effect eLoop = GetFirstEffect(oPC);
    while (GetIsEffectValid(eLoop)){
        eEffectType = GetEffectType(eLoop);
        if(eEffectType==EFFECT_TYPE_SPELL_FAILURE||eEffectType==EFFECT_TYPE_AREA_OF_EFFECT||eEffectType==EFFECT_TYPE_CONCEALMENT||eEffectType==EFFECT_TYPE_ELEMENTALSHIELD)
            RemoveEffect(oPC,eLoop);
        eLoop=GetNextEffect(oPC);
    }
    object oSkinOld = GetItemInSlot(INVENTORY_SLOT_CARMOUR,oPC);
    SetLocalInt(oPC,"poly_weaponr",nRanged);
    SetLocalInt(oPC,"poly_weaponm",nMelee);
    SetLocalInt(oPC,"poly_shield",nShield);
    DestroyObject(oSkinOld,0.0);
    SetCreatureAppearanceType(oPC,nPolyType);
    object oSkin = CreateItemOnObject(sPolyType,oPC);
    SetLocalInt(oPC,"poly_ability_psh",0);
    AssignCommand(oPC,ClearAllActions());
    if(nRanged==1&&nMelee==0){
        object oWeapon = GetItemInSlot(INVENTORY_SLOT_RIGHTHAND,oPC);
        int nRangedType = GetBaseItemType(oWeapon);
        if(nRangedType==BASE_ITEM_DART||nRangedType==BASE_ITEM_THROWINGAXE||nRangedType==BASE_ITEM_SHURIKEN||
        nRangedType==BASE_ITEM_SHORTBOW||nRangedType==BASE_ITEM_LIGHTCROSSBOW||nRangedType==BASE_ITEM_LONGBOW||
        nRangedType==BASE_ITEM_HEAVYCROSSBOW||nRangedType==BASE_ITEM_SLING)
        AssignCommand(oPC,ActionUnequipItem(oWeapon));
    }
    if(nRanged==1&&nMelee==1){
        object oWeapon = GetItemInSlot(INVENTORY_SLOT_RIGHTHAND,oPC);
        AssignCommand(oPC,ActionUnequipItem(oWeapon));
    }
    if(nRanged==0&&nMelee==1){
        object oWeapon = GetItemInSlot(INVENTORY_SLOT_RIGHTHAND,oPC);
        int nRangedType = GetBaseItemType(oWeapon);
        if(nRangedType==BASE_ITEM_DART||nRangedType==BASE_ITEM_THROWINGAXE||nRangedType==BASE_ITEM_SHURIKEN||
        nRangedType==BASE_ITEM_SHORTBOW||nRangedType==BASE_ITEM_LIGHTCROSSBOW||nRangedType==BASE_ITEM_LONGBOW||
        nRangedType==BASE_ITEM_HEAVYCROSSBOW||nRangedType==BASE_ITEM_SLING){}
        AssignCommand(oPC,ActionUnequipItem(oWeapon));
    }
    if(nShield==1){
        object oShield = GetItemInSlot(INVENTORY_SLOT_LEFTHAND,oPC);
        AssignCommand(oPC,ActionUnequipItem(oShield));
    }
    if(nSpellFailure==1)
        ApplyEffectToObject(DURATION_TYPE_PERMANENT,EffectSpellFailure(100,SPELL_SCHOOL_GENERAL),oPC);
    ApplyEffectToObject(DURATION_TYPE_INSTANT,EffectVisualEffect(VFX_IMP_POLYMORPH),oPC,0.0);
    DelayCommand(1.0,AssignCommand(oPC,ActionEquipItem(oSkin,INVENTORY_SLOT_CARMOUR)));
}

#include "x2_inc_spellhook"

void main()
{
    if (!X2PreSpellCastCode())
        return;
    object oPC = OBJECT_SELF;
    int nSpell = GetSpellId();
    object oTarget = GetSpellTargetObject();
    effect eVis = EffectVisualEffect(VFX_IMP_POLYMORPH);
    effect ePoly;
    int nPoly;
    int nMetaMagic = GetMetaMagicFeat();
    float nDuration = 60.0;
    if (nMetaMagic == METAMAGIC_EXTEND)
        nDuration = nDuration *2;
    int nMetaSpec = GetLocalInt(oPC,"metamorfosispec");
    if(GetAppearanceType(oPC)==APPEARANCE_TYPE_ELF||GetAppearanceType(oPC)==APPEARANCE_TYPE_HUMAN||
    GetAppearanceType(oPC)==APPEARANCE_TYPE_HALF_ELF||GetAppearanceType(oPC)==APPEARANCE_TYPE_HALF_ORC||
    GetAppearanceType(oPC)==APPEARANCE_TYPE_HALFLING||GetAppearanceType(oPC)==APPEARANCE_TYPE_GNOME||
    GetAppearanceType(oPC)==APPEARANCE_TYPE_DWARF){
        int nPheno = GetPhenoType(oPC);
        if(nPheno == 0 || nPheno == 2){
            if(nSpell == 387)
                SafePolymorph(oPC, 1, 1, 1, 1, "poly_wizspider", APPEARANCE_TYPE_SPIDER_GIANT);
            else if (nSpell == 388)
                SafePolymorph(oPC, 1, 1, 1, 0, "poly_wiztroll", APPEARANCE_TYPE_TROLL_SHAMAN);
            else if (nSpell == 389)
                SafePolymorph(oPC, 1, 1, 1, 1, "poly_wizumber", APPEARANCE_TYPE_UMBERHULK);
            else if (nSpell == 390)
                SafePolymorph(oPC, 1, 1, 1, 0, "poly_wizpixie", APPEARANCE_TYPE_FAIRY);
            else if (nSpell == 391)
                SafePolymorph(oPC, 0, 0, 0, 0, "poly_wizzombie", APPEARANCE_TYPE_ZOMBIE);
            SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, SPELL_POLYMORPH_SELF, FALSE));
            AssignCommand(oTarget, ClearAllActions());
            ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget);
            object oSkinOld = GetItemInSlot(INVENTORY_SLOT_CARMOUR,oPC);
            DestroyObject(oSkinOld,0.0);
            if(nMetaSpec == 0){
                CreateItemOnObject("mod_bas_polyself",oPC);
                SetLocalInt(oPC,"metamorfosi",0);
                SetLocalInt(oPC,"metamorfosispec",1);
                ExecuteScript("mod_clas_poly_wt",oPC);
            }
        }
        else
            SendMessageToPC(oPC,"Non puoi usare questo incantesimo a cavallo");
    }
    else
        SendMessageToPC(oPC,"Non puoi usare questo incantesimo da trasformato");
}

