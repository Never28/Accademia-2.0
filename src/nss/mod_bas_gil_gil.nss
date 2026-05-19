void main()
{
    object oPC = GetPCSpeaker();
    object oPCAgg = GetFirstPC();
        object oModule = GetModule();
        int nPunti = GetLocalInt(oPCAgg,"puntigilda");
        int nGildaBuoni1 = GetLocalInt(oModule,"gb1");
        int nGildaBuoni2 = GetLocalInt(oModule,"gb2");
        int nGildaBuoni3 = GetLocalInt(oModule,"gb3");
        int nGildaBuoni4 = GetLocalInt(oModule,"gb4");
        int nGildaBuoni5 = GetLocalInt(oModule,"gb5");
        int nGildaBuoni6 = GetLocalInt(oModule,"gb6");
        int nGildaBuoni7 = GetLocalInt(oModule,"gb7");
        int nGildaBuoni8 = GetLocalInt(oModule,"gb8");
        int nGildaBuoni9 = GetLocalInt(oModule,"gb9");
        int nGildaCattivi1 = GetLocalInt(oModule,"gm1");
        int nGildaCattivi2 = GetLocalInt(oModule,"gm2");
        int nGildaCattivi3 = GetLocalInt(oModule,"gm3");
        int nGildaCattivi4 = GetLocalInt(oModule,"gm4");
        int nGildaCattivi5 = GetLocalInt(oModule,"gm5");
        int nGildaCattivi6 = GetLocalInt(oModule,"gm6");
        int nGildaCattivi7 = GetLocalInt(oModule,"gm7");
        int nGildaCattivi8 = GetLocalInt(oModule,"gm8");
        int nGildaCattivi9 = GetLocalInt(oModule,"gm9");
        SendMessageToPC(oPC,"Fazione del Bene: "+IntToString(nGildaBuoni1+nGildaBuoni2+nGildaBuoni3+nGildaBuoni4+nGildaBuoni5
        +nGildaBuoni6+nGildaBuoni7+nGildaBuoni8+nGildaBuoni9));
        SendMessageToPC(oPC,"Ordine del Corno dell'Unircorno: "+IntToString(nGildaBuoni1));
        SendMessageToPC(oPC,"Arpisti: "+IntToString(nGildaBuoni2));
        SendMessageToPC(oPC,"Ordine del Cuore Radioso: "+IntToString(nGildaBuoni3));
        SendMessageToPC(oPC,"Ordine di Lathander: "+IntToString(nGildaBuoni4));
        SendMessageToPC(oPC,"Mano Splendente: "+IntToString(nGildaBuoni5));
        SendMessageToPC(oPC,"Ordine di Bahamut: "+IntToString(nGildaBuoni6));
        SendMessageToPC(oPC,"Eletti di Mystra: "+IntToString(nGildaBuoni7));
        SendMessageToPC(oPC,"Seguaci del Libero Arbitrio: "+IntToString(nGildaBuoni8));
        SendMessageToPC(oPC,"Pugno Fiammante: "+IntToString(nGildaBuoni9));
        SendMessageToPC(oPC,"Fazione del Male: "+IntToString(nGildaCattivi1+nGildaCattivi2+nGildaCattivi3+nGildaCattivi4+nGildaCattivi5
        +nGildaCattivi6+nGildaCattivi7+nGildaCattivi8+nGildaCattivi9));
        SendMessageToPC(oPC,"Seguaci dell'Epidemia: "+IntToString(nGildaCattivi1));
        SendMessageToPC(oPC,"Zhentarim: "+IntToString(nGildaCattivi2));
        SendMessageToPC(oPC,"Trono di Ferro: "+IntToString(nGildaCattivi3));
        SendMessageToPC(oPC,"Ordine di Talos: "+IntToString(nGildaCattivi4));
        SendMessageToPC(oPC,"Monaci della Lunga Morte: "+IntToString(nGildaCattivi5));
        SendMessageToPC(oPC,"Ordine di Tiamat: "+IntToString(nGildaCattivi6));
        SendMessageToPC(oPC,"Stregoni Incapucciati: "+IntToString(nGildaCattivi7));
        SendMessageToPC(oPC,"Ladri Tenebrosi: "+IntToString(nGildaCattivi8));
        SendMessageToPC(oPC,"Ordine di Velsharoon: "+IntToString(nGildaCattivi9));
    while(oPCAgg!=OBJECT_INVALID){
        string sTotalePC = GetLocalString(oPCAgg,"gilda");
        string sGildaPC = GetSubString(sTotalePC,10,3);
        string sPlayer = GetName(oPCAgg);
        string sGilda;
        SendMessageToPC(oPC,sPlayer+": "+IntToString(nPunti));
        oPCAgg = GetNextPC();
    }
}
