/*
  CREATO DA:      Tempesta
  DATA CREAZIONE: 18-06-2009
*/

// Funzione della Mappa di navigazione per il Piano Astrale.

void main()
{
    // Il giocatore da teletrasportare.
    object oPC = GetPCSpeaker();
    // Dado vita del Giocatore
    int nDice = GetHitDice(oPC);
    if(nDice >= 30){
        // Il punto dove teletrasportarlo.
        object oTarget = GetFactionLeader(oPC);
        // Effetto visivo per il teletrasporto.
        object oArea = GetArea(oTarget);
        string sArea = GetTag(oArea);
        string s3Area = GetStringLeft(sArea,3);
        if(sArea == "mod_inferno"||sArea == "mod_elemental"||sArea == "mod_drake_lev"||sArea == "mod_stanza"||sArea == "mod_sogno"||sArea=="mod_deity_druid"||s3Area == "vil"){
            SendMessageToPC(oPC,"Non puoi teletrasportarti dal tuo capo del gruppo perche' e' in un'area dove cio' non e' concesso");
        }
        else{
            int nNoTele = GetLocalInt(oArea,"teleport_on_off");
            if(nNoTele ==1)
                SendMessageToPC(oPC,"Non puoi teletrasportarti dal tuo capo del gruppo perche' e' in un'area dove cio' non e' concesso");
            else{
                effect eEff = EffectVisualEffect(VFX_IMP_SUNSTRIKE);
                // Fermiamo tutte le sue azioni e lo facciamo teletrasportare.
                AssignCommand(oPC, ClearAllActions());
                DelayCommand(0.5, ApplyEffectToObject(DURATION_TYPE_INSTANT,eEff,oPC));
                DelayCommand(3.0, AssignCommand(oPC, ActionJumpToObject(oTarget)));
            }
        }
    }
    else{
        SendMessageToPC(oPC,"Devi essere di 30 livello per utilizzare questo portale");
    }
}
