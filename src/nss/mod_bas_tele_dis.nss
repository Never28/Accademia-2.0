/*
  CREATO DA:      Tempesta
  DATA CREAZIONE: 18-06-2009
*/

// Funzione della Mappa di navigazione per il Piano Astrale.

void main()
{
    // Il giocatore da teletrasportare.
    object oPC = GetPCSpeaker();
    if(GetItemPossessedBy(oPC,"deletemeplease")==OBJECT_INVALID){
    // Il punto dove teletrasportarlo.
    object oTarget = GetWaypointByTag("vil_dis_t1");
    // Effetto visivo per il teletrasporto.
    effect eEff = EffectVisualEffect(VFX_IMP_MAGBLUE);
    // Fermiamo tutte le sue azioni e lo facciamo teletrasportare.
    AssignCommand(oPC, ClearAllActions());
    DelayCommand(0.5, ApplyEffectToObject(DURATION_TYPE_INSTANT,eEff,oPC));
    DelayCommand(3.0, AssignCommand(oPC, ActionJumpToObject(oTarget)));
    }
    else
        SendMessageToPC(oPC,"Questo Personaggio deve essere cancellato, comunicalo sul forum");
}
