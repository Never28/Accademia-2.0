void main()
{
    object oPC = GetPCSpeaker();
    object oPCAgg = GetFirstPC();
    while(oPCAgg!=OBJECT_INVALID){
        string sTotalePC = GetLocalString(oPCAgg,"gilda");
        string sGildaPC = GetSubString(sTotalePC,0,3);
        string sPlayer = GetName(oPCAgg);
        string sGilda = "";
        if(sGildaPC == "gb1")
            sGilda = "Ordine del Corno dell'Unircorno";
        else if(sGildaPC == "gb2")
            sGilda = "Arpisti";
        else if(sGildaPC == "gb3")
            sGilda = "Ordine del Cuore Radioso:";
        else if(sGildaPC == "gb4")
            sGilda = "Ordine di Lathander";
        else if(sGildaPC == "gb5")
            sGilda = "Mano Splendente";
        else if(sGildaPC == "gb6")
            sGilda = "Ordine di Bahamut";
        else if(sGildaPC == "gb7")
            sGilda = "Eletti di Mystra";
        else if(sGildaPC == "gb8")
            sGilda = "Seguaci del Libero Arbitrio";
        else if(sGildaPC == "gb9")
            sGilda = "Pugno Fiammante";
        else if(sGildaPC == "gm1")
            sGilda = "Seguaci dell'Epidemia";
        else if(sGildaPC == "gm2")
            sGilda = "Zhentarim";
        else if(sGildaPC == "gm3")
            sGilda = "Trono di Ferro";
        else if(sGildaPC == "gm4")
            sGilda = "Ordine di Talos";
        else if(sGildaPC == "gm5")
            sGilda = "Monaci della Lunga Morte";
        else if(sGildaPC == "gm6")
            sGilda = "Ordine di Tiamat";
        else if(sGildaPC == "gm7")
            sGilda = "Stregoni Incapucciati";
        else if(sGildaPC == "gm8")
            sGilda = "Ladri Tenebrosi";
        else if(sGildaPC == "gm9")
            sGilda = "Ordine di Velsharoon";
        SendMessageToPC(oPC,sPlayer+": "+sGilda);
        oPCAgg = GetNextPC();
    }
}
