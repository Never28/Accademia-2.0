void main()
{
    object oPC = GetPCSpeaker();
    int nAli = GetCreatureWingType(oPC);
    if(nAli>0&&nAli<79)
        SendMessageToPC(oPC,"Non puoi modificare le tue ali essendo Discepolo del Drago di 9 Livello, o Araldo Divino");
    else{
        nAli = nAli -1;
        if(nAli < 0)
            nAli = 90;
        if(nAli == 78)
            nAli = 0;
        SetCreatureWingType(nAli,oPC);
    }
}
