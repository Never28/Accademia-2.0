/*
  CREATO DA:      Tempesta
  DATA CREAZIONE: 17-06-2009
*/

// Funzione per il lancio di 1d20 con la sacca dei dadi.

void main()
{
    // Il giocatore che lancia il dado.
    object oPC = GetLastSpeaker();
    // Il nome del giocatore che lancia il dado.
    string NomeoPC = GetName(oPC);
    // Lanciamo un dado da 20.
    int RisultatoDado = d20(1);
    // Facciamo dire al giocatore che ha lanciato il dado il suo risultato.
    SpeakString(NomeoPC+" Tira il Dado e ottiene: "+IntToString(RisultatoDado), TALKVOLUME_TALK);
}
