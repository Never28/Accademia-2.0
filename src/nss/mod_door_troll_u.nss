void main()
{
    object oPC = GetLastUsedBy();
    object oTarget = GetObjectByTag("for_tro_cav_for");
    AssignCommand(oPC, ActionJumpToObject(oTarget));
}
