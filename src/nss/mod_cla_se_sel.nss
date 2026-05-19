void main()
{
    object oItem = OBJECT_SELF;
    object oPC = GetLastUsedBy();
    string sItem = GetTag(oItem);
    location oLocation = GetLocalLocation(oPC,"mod_return");
    if(sItem == "se_elemental_earth"){
        CreateItemOnObject("mod_clas_se1",oPC);
        AssignCommand(oPC,JumpToLocation(oLocation));
    }
    if(sItem == "se_elemental_water"){
        CreateItemOnObject("mod_clas_se2",oPC);
        AssignCommand(oPC,JumpToLocation(oLocation));
    }
    if(sItem == "se_elemental_air"){
        CreateItemOnObject("mod_clas_se3",oPC);
        AssignCommand(oPC,JumpToLocation(oLocation));
    }
    if(sItem == "se_elemental_fire"){
        CreateItemOnObject("mod_clas_se4",oPC);
        AssignCommand(oPC,JumpToLocation(oLocation));
    }
}
