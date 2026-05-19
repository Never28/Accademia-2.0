void main()
{
    object oPC = GetPCSpeaker();

    string sGilda = GetLocalString(OBJECT_SELF,"gilda");
    string sTotalePC = GetLocalString(oPC,"gilda");
    string sGildaPC = GetSubString(sTotalePC,0,3);
    string sFazionePC = GetSubString(sTotalePC,3,3);

    if(sGilda == "gb1"){
        SetLocalString(oPC,"gilda","gb1"+"goo");
        SetCampaignString("accademia_new","gilda","gb1"+"goo",oPC);
        int nPunti = GetLocalInt(oPC,"puntigilda");
        SetCampaignInt("accademia_new","punti",0,oPC);
        SetLocalInt(oPC,"puntigilda",0);
        object oModule = GetModule();
        int nPuntiGilda = GetLocalInt(oModule,sGildaPC);
        SetLocalInt(oModule,sGildaPC,nPuntiGilda - nPunti);
    }
    else if(sGilda == "gb2"){
        SetLocalString(oPC,"gilda","gb2"+"goo");
        SetCampaignString("accademia_new","gilda","gb2"+"goo",oPC);
        int nPunti = GetLocalInt(oPC,"puntigilda");
        SetCampaignInt("accademia_new","punti",0,oPC);
        SetLocalInt(oPC,"puntigilda",0);
        object oModule = GetModule();
        int nPuntiGilda = GetLocalInt(oModule,sGildaPC);
        SetLocalInt(oModule,sGildaPC,nPuntiGilda - nPunti);
    }
    else if(sGilda == "gb3"){
        SetLocalString(oPC,"gilda","gb3"+"goo");
        SetCampaignString("accademia_new","gilda","gb3"+"goo",oPC);
        int nPunti = GetLocalInt(oPC,"puntigilda");
        SetCampaignInt("accademia_new","punti",0,oPC);
        SetLocalInt(oPC,"puntigilda",0);
        object oModule = GetModule();
        int nPuntiGilda = GetLocalInt(oModule,sGildaPC);
        SetLocalInt(oModule,sGildaPC,nPuntiGilda - nPunti);
    }
    else if(sGilda == "gb4"){
        SetLocalString(oPC,"gilda","gb4"+"goo");
        SetCampaignString("accademia_new","gilda","gb4"+"goo",oPC);
        int nPunti = GetLocalInt(oPC,"puntigilda");
        SetCampaignInt("accademia_new","punti",0,oPC);
        SetLocalInt(oPC,"puntigilda",0);
        object oModule = GetModule();
        int nPuntiGilda = GetLocalInt(oModule,sGildaPC);
        SetLocalInt(oModule,sGildaPC,nPuntiGilda - nPunti);
    }
    else if(sGilda == "gb5"){
        SetLocalString(oPC,"gilda","gb5"+"goo");
        SetCampaignString("accademia_new","gilda","gb5"+"goo",oPC);
        int nPunti = GetLocalInt(oPC,"puntigilda");
        SetCampaignInt("accademia_new","punti",0,oPC);
        SetLocalInt(oPC,"puntigilda",0);
        object oModule = GetModule();
        int nPuntiGilda = GetLocalInt(oModule,sGildaPC);
        SetLocalInt(oModule,sGildaPC,nPuntiGilda - nPunti);
    }
    else if(sGilda == "gb6"){
        SetLocalString(oPC,"gilda","gb6"+"goo");
        SetCampaignString("accademia_new","gilda","gb6"+"goo",oPC);
        int nPunti = GetLocalInt(oPC,"puntigilda");
        SetCampaignInt("accademia_new","punti",0,oPC);
        SetLocalInt(oPC,"puntigilda",0);
        object oModule = GetModule();
        int nPuntiGilda = GetLocalInt(oModule,sGildaPC);
        SetLocalInt(oModule,sGildaPC,nPuntiGilda - nPunti);
    }
    else if(sGilda == "gb7"){
        SetLocalString(oPC,"gilda","gb7"+"goo");
        SetCampaignString("accademia_new","gilda","gb7"+"goo",oPC);
        int nPunti = GetLocalInt(oPC,"puntigilda");
        SetCampaignInt("accademia_new","punti",0,oPC);
        SetLocalInt(oPC,"puntigilda",0);
        object oModule = GetModule();
        int nPuntiGilda = GetLocalInt(oModule,sGildaPC);
        SetLocalInt(oModule,sGildaPC,nPuntiGilda - nPunti);
    }
    else if(sGilda == "gb8"){
        SetLocalString(oPC,"gilda","gb8"+"goo");
        SetCampaignString("accademia_new","gilda","gb8"+"goo",oPC);
        int nPunti = GetLocalInt(oPC,"puntigilda");
        SetCampaignInt("accademia_new","punti",0,oPC);
        SetLocalInt(oPC,"puntigilda",0);
        object oModule = GetModule();
        int nPuntiGilda = GetLocalInt(oModule,sGildaPC);
        SetLocalInt(oModule,sGildaPC,nPuntiGilda - nPunti);
    }
    else if(sGilda == "gb9"){
        SetLocalString(oPC,"gilda","gb9"+"goo");
        SetCampaignString("accademia_new","gilda","gb9"+"goo",oPC);
        int nPunti = GetLocalInt(oPC,"puntigilda");
        SetCampaignInt("accademia_new","punti",0,oPC);
        SetLocalInt(oPC,"puntigilda",0);
        object oModule = GetModule();
        int nPuntiGilda = GetLocalInt(oModule,sGildaPC);
        SetLocalInt(oModule,sGildaPC,nPuntiGilda - nPunti);
    }
    else if(sGilda == "gm1"){
        SetLocalString(oPC,"gilda","gm1"+"evi");
        SetCampaignString("accademia_new","gilda","gm1"+"evi",oPC);
        int nPunti = GetLocalInt(oPC,"puntigilda");
        SetCampaignInt("accademia_new","punti",0,oPC);
        SetLocalInt(oPC,"puntigilda",0);
        object oModule = GetModule();
        int nPuntiGilda = GetLocalInt(oModule,sGildaPC);
        SetLocalInt(oModule,sGildaPC,nPuntiGilda - nPunti);
    }
    else if(sGilda == "gm2"){
        SetLocalString(oPC,"gilda","gm2"+"evi");
        SetCampaignString("accademia_new","gilda","gm2"+"evi",oPC);
        int nPunti = GetLocalInt(oPC,"puntigilda");
        SetCampaignInt("accademia_new","punti",0,oPC);
        SetLocalInt(oPC,"puntigilda",0);
        object oModule = GetModule();
        int nPuntiGilda = GetLocalInt(oModule,sGildaPC);
        SetLocalInt(oModule,sGildaPC,nPuntiGilda - nPunti);
    }
    else if(sGilda == "gm3"){
        SetLocalString(oPC,"gilda","gm3"+"evi");
        SetCampaignString("accademia_new","gilda","gm3"+"evi",oPC);
        int nPunti = GetLocalInt(oPC,"puntigilda");
        SetCampaignInt("accademia_new","punti",0,oPC);
        SetLocalInt(oPC,"puntigilda",0);
        object oModule = GetModule();
        int nPuntiGilda = GetLocalInt(oModule,sGildaPC);
        SetLocalInt(oModule,sGildaPC,nPuntiGilda - nPunti);
    }
    else if(sGilda == "gm4"){
        SetLocalString(oPC,"gilda","gm4"+"evi");
        SetCampaignString("accademia_new","gilda","gm4"+"evi",oPC);
        int nPunti = GetLocalInt(oPC,"puntigilda");
        SetCampaignInt("accademia_new","punti",0,oPC);
        SetLocalInt(oPC,"puntigilda",0);
        object oModule = GetModule();
        int nPuntiGilda = GetLocalInt(oModule,sGildaPC);
        SetLocalInt(oModule,sGildaPC,nPuntiGilda - nPunti);
    }
    else if(sGilda == "gm5"){
        SetLocalString(oPC,"gilda","gm5"+"evi");
        SetCampaignString("accademia_new","gilda","gm5"+"evi",oPC);
        int nPunti = GetLocalInt(oPC,"puntigilda");
        SetCampaignInt("accademia_new","punti",0,oPC);
        SetLocalInt(oPC,"puntigilda",0);
        object oModule = GetModule();
        int nPuntiGilda = GetLocalInt(oModule,sGildaPC);
        SetLocalInt(oModule,sGildaPC,nPuntiGilda - nPunti);
    }
    else if(sGilda == "gm6"){
        SetLocalString(oPC,"gilda","gm6"+"evi");
        SetCampaignString("accademia_new","gilda","gm6"+"evi",oPC);
        int nPunti = GetLocalInt(oPC,"puntigilda");
        SetCampaignInt("accademia_new","punti",0,oPC);
        SetLocalInt(oPC,"puntigilda",0);
        object oModule = GetModule();
        int nPuntiGilda = GetLocalInt(oModule,sGildaPC);
        SetLocalInt(oModule,sGildaPC,nPuntiGilda - nPunti);
    }
    else if(sGilda == "gm7"){
        SetLocalString(oPC,"gilda","gm7"+"evi");
        SetCampaignString("accademia_new","gilda","gm7"+"evi",oPC);
        int nPunti = GetLocalInt(oPC,"puntigilda");
        SetCampaignInt("accademia_new","punti",0,oPC);
        SetLocalInt(oPC,"puntigilda",0);
        object oModule = GetModule();
        int nPuntiGilda = GetLocalInt(oModule,sGildaPC);
        SetLocalInt(oModule,sGildaPC,nPuntiGilda - nPunti);
    }
    else if(sGilda == "gm8"){
        SetLocalString(oPC,"gilda","gm8"+"evi");
        SetCampaignString("accademia_new","gilda","gm8"+"evi",oPC);
        int nPunti = GetLocalInt(oPC,"puntigilda");
        SetCampaignInt("accademia_new","punti",0,oPC);
        SetLocalInt(oPC,"puntigilda",0);
        object oModule = GetModule();
        int nPuntiGilda = GetLocalInt(oModule,sGildaPC);
        SetLocalInt(oModule,sGildaPC,nPuntiGilda - nPunti);
    }
    else if(sGilda == "gm9"){
        SetLocalString(oPC,"gilda","gm9"+"evi");
        SetCampaignString("accademia_new","gilda","gm9"+"evi",oPC);
        int nPunti = GetLocalInt(oPC,"puntigilda");
        SetCampaignInt("accademia_new","punti",0,oPC);
        SetLocalInt(oPC,"puntigilda",0);
        object oModule = GetModule();
        int nPuntiGilda = GetLocalInt(oModule,sGildaPC);
        SetLocalInt(oModule,sGildaPC,nPuntiGilda - nPunti);
    }
}
