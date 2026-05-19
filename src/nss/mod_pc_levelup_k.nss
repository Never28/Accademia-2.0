/*
  CREATO DA:      Tempesta
  DATA CREAZIONE: 06-07-2009
*/

// Funzione per il level up teleport del draconico.

void main()
{
    object oPC = OBJECT_SELF;
    object oWay = GetWaypointByTag("mod_drake_lev_t1");
    location oLocation = GetLocation(oWay);
    AssignCommand(oPC,JumpToLocation(oLocation));
}
