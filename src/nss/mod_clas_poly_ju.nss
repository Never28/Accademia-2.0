/*
  CREATO DA:      Tempesta
  DATA CREAZIONE: 28-06-2009
*/

// Funzione per il ritorno.


void main()
{
    object oPC = OBJECT_SELF;
    location oLocation = GetLocalLocation(oPC,"mod_return");
    AssignCommand(oPC,JumpToLocation(oLocation));
}
