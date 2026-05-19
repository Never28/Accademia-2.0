void main()
{
    object oPC = GetLastUsedBy();
    DelayCommand(0.0, AssignCommand(oPC, ActionJumpToObject(GetWaypointByTag("rim_citta_t2"))));
}
