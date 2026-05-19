void main()
{
    object oPC = GetPCSpeaker();
    object oArea = GetArea(oPC);
    string sArea = GetTag(oArea);
    string sZone;
    if(sArea == "dun_che_sup")
        sZone = "dun_che_bib_t1";
    else
        sZone = "dun_che_mag_t1";
    object oTarget = GetObjectByTag(sZone);
    AssignCommand(oPC, ActionJumpToObject(oTarget));
}
