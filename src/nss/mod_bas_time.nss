/*
  CREATO DA:      Tempesta
  DATA CREAZIONE: 13-07-2009
*/

// Funzione per la meridiana.

void main()
{
    int nHour = GetTimeHour();
    int nMinute = GetTimeMinute();
    int nSecond = GetTimeSecond();
    ActionSpeakString("Ad Accademia sono le <cþ>"+IntToString(nHour)+":"+IntToString(nMinute)+":"+IntToString(nSecond)+"</c>");
}
