void main()
{
    object oPC = GetLastUsedBy();
    SetLocalString(oPC,"forgia_tut",GetTag(OBJECT_SELF));
    AssignCommand(oPC,ActionStartConversation(oPC,"mod_for_tut",TRUE));
}
