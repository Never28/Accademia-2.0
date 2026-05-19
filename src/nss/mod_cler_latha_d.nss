/*
  CREATO DA:      Tempesta
  DATA CREAZIONE: 17-06-2009
*/

// Funzione per il dialogo di Lathander.

void main()
{
    object oPC = GetLastUsedBy();
    AssignCommand(oPC,ActionStartConversation(oPC,"mod_lathander",TRUE));
}

