void main()
{
    object oArea = OBJECT_SELF;
    SetLocalInt(oArea,"Start",1);
    object oPC = GetEnteringObject();
    string oName= GetPCPlayerName(oPC);
    effect eDam,eBonusAC;
    object oHorse = GetObjectByTag(oName+"i");
    ExecuteScript("mod_bas_horse_de",oHorse);
    SetLocalInt(oPC,"HorseMap",1);
    int nPheno = GetPhenoType(oPC);
    switch(nPheno){
        case 10: case 11: case 12: case 13: case 14: case 15: case 17: case 18:
            SetPhenoType(0,oPC);
            if(GetItemPossessedBy(oPC,"mod_clas_cv")!=OBJECT_INVALID){
                ExecuteScript("mod_bas_mount_cv",oPC);
            }
            break;
        case 27: case 28: case 30: case 31: case 32: case 33: case 34: case 35:
            SetPhenoType(2,oPC);
            if(GetItemPossessedBy(oPC,"mod_clas_cv")!=OBJECT_INVALID){
                ExecuteScript("mod_bas_mount_cv",oPC);
            }
            break;
    }
    object oItem;
    if((oItem = GetItemPossessedBy(oPC,"mod_bas_dismount"))!= OBJECT_INVALID)
        DestroyObject(oItem);
}
