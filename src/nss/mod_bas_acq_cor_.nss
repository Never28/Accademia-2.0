void main()
{
    object oPC = GetPCSpeaker();
    AssignCommand(oPC, ClearAllActions());
    object oTarget = GetWaypointByTag("ext_che_acq_t1");
    DelayCommand(1.0, AssignCommand(oPC, ActionJumpToObject(oTarget)));
}
