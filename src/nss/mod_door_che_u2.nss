void main()
{
    object oPC = GetLastUsedBy();
    AssignCommand(oPC,ActionStartConversation(oPC,"mod_bas_acq_cor2",TRUE));
}
