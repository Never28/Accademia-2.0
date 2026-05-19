void main()
{
    object oPC = GetLastUsedBy();
    AssignCommand(oPC,ActionStartConversation(oPC,"mod_for_bal",TRUE));
}
