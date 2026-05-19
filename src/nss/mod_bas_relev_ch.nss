/*
  CREATO DA:      Tempesta
  DATA CREAZIONE: 15-07-2009
*/

// Rilivellare sistemazione caratteristiche.

void main()
{
    object oPC=OBJECT_SELF;
    object oItem;
    int GuardiaNera=GetLevelByClass(CLASS_TYPE_BLACKGUARD,oPC);
    int intelligenza=GetAbilityScore(oPC,ABILITY_INTELLIGENCE,TRUE);
    int saggezza=GetAbilityScore(oPC,ABILITY_WISDOM,TRUE);
    int carisma=GetAbilityScore(oPC,ABILITY_CHARISMA,TRUE);
    int destrezza=GetAbilityScore(oPC,ABILITY_DEXTERITY,TRUE);
    int forza=GetAbilityScore(oPC,ABILITY_STRENGTH,TRUE);
    int costituzione=GetAbilityScore(oPC,ABILITY_CONSTITUTION,TRUE);
    if ((forza<32)&&(GetItemPossessedBy(oPC,"car_str")!=OBJECT_INVALID)){
        oItem=GetItemPossessedBy(oPC,"car_str");
        DestroyObject(oItem,0.0);
        SetLocalInt(oPC,"car_ability",0);
    }
    if ((destrezza<32)&&(GetItemPossessedBy(oPC,"car_dex")!=OBJECT_INVALID)){
        oItem=GetItemPossessedBy(oPC,"car_dex");
        DestroyObject(oItem,0.0);
        SetLocalInt(oPC,"car_ability",0);
    }
    if ((costituzione<32)&&(GetItemPossessedBy(oPC,"car_con")!=OBJECT_INVALID)){
        oItem=GetItemPossessedBy(oPC,"car_con");
        DestroyObject(oItem,0.0);
        SetLocalInt(oPC,"car_ability",0);
    }
    if ((carisma<32)&&(GetItemPossessedBy(oPC,"car_cha")!=OBJECT_INVALID)){
        oItem=GetItemPossessedBy(oPC,"car_cha");
        DestroyObject(oItem,0.0);
        SetLocalInt(oPC,"car_ability",0);
    }
    if ((saggezza<32)&&(GetItemPossessedBy(oPC,"car_wis")!=OBJECT_INVALID)){
        oItem=GetItemPossessedBy(oPC,"car_wis");
        DestroyObject(oItem,0.0);
        SetLocalInt(oPC,"car_ability",0);
    }
    if ((intelligenza<32)&&(GetItemPossessedBy(oPC,"car_int")!=OBJECT_INVALID)){
        oItem=GetItemPossessedBy(oPC,"car_int");
        DestroyObject(oItem,0.0);
        SetLocalInt(oPC,"car_ability",0);
    }
    int stampa2=GetLocalInt(oPC,"car_ability");
    if(GetLocalInt(oPC,"car_ability")==0)
        ExecuteScript("mod_pc_lev_car",oPC);
    else
        ExecuteScript("mod_bas_car",oPC);
}



