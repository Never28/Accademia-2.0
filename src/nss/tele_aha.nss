void main()
{
    object oPC = GetPCSpeaker();
    object oTarget = GetWaypointByTag("vil_aha_t1");
    DelayCommand(0.0, AssignCommand(oPC, ActionJumpToObject(oTarget)));
    SetCutsceneMode(oPC,FALSE);
    CreateItemOnObject("vil_aha",oPC);
    DelayCommand(1.0,ExecuteScript("mod_pc_desc",oPC));
}
