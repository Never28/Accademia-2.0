void main()
{
    object oPC = GetPCSpeaker();
    string sGilda = GetLocalString(OBJECT_SELF,"gilda");
    string sTotalePC = GetLocalString(oPC,"gilda");
    string sFazionePC = GetSubString(sTotalePC,3,3);
    int nPunti = GetLocalInt(oPC,"puntigilda");
    object oModule = GetModule();
    int nPuntiGilda = GetLocalInt(oModule,sGilda);
    SetLocalInt(oModule,sGilda,nPuntiGilda - nPunti);
    SetLocalString(oPC,"gilda","xxx"+"yyy");
    SetLocalInt(oPC,"puntigilda",0);
    SetCampaignInt("accademia_new","punti",0,oPC);
    SetCampaignString("accademia_new","gilda","xxx"+"yyy",oPC);
}
