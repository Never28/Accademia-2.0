void main()
{
    object oPC = GetPCSpeaker();
    object oTarget = GetWaypointByTag("WP_isoladeimannari");
    AssignCommand(oPC, ClearAllActions());
    DelayCommand(3.0, AssignCommand(oPC, ActionJumpToObject(oTarget)));
}
