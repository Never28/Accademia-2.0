void main()
{
    object oPC = GetClickingObject();
    AssignCommand(oPC,ActionStartConversation(oPC,"mod_bas_gor",TRUE));
}
