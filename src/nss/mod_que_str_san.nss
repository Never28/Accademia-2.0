void StampaFraseSpell(int nRandom,object oSantuario){
    switch(nRandom){
        case 1:
            AssignCommand(oSantuario,SpeakString("Piove dal cielo durante le guerre e riduce le case in cenere..",TALKVOLUME_TALK));
            break;
        case 2:
            AssignCommand(oSantuario,SpeakString("La vendetta vi va servita e gli assassini la usano spesso",TALKVOLUME_TALK));
            break;
        case 3:
            AssignCommand(oSantuario,SpeakString("Se c'e' un terremoto ve ne e' una, ma questa e' sotto diversa forma..",TALKVOLUME_TALK));
            break;
        case 4:
            AssignCommand(oSantuario,SpeakString("Quando piove, il cielo puo' essere molto d'aiuto..",TALKVOLUME_TALK));
            break;
        case 5:
            AssignCommand(oSantuario,SpeakString("Tutti nella propria balestra ne vorrebero uno..",TALKVOLUME_TALK));
            break;
        case 6:
            AssignCommand(oSantuario,SpeakString("Lo potresti ricavare da un cerchio nel ghiaccio..",TALKVOLUME_TALK));
            break;
        case 7:
            AssignCommand(oSantuario,SpeakString("Puoi vincerla a braccio di ferro, ma non ti fara' comunque passare..",TALKVOLUME_TALK));
            break;
        case 8:
            AssignCommand(oSantuario,SpeakString("Maledetti Mindflayer, e' la loro arma principale..",TALKVOLUME_TALK));
            break;
        case 9:
            AssignCommand(oSantuario,SpeakString("Prima si sente forte, poco dopo si sente a pezzi..",TALKVOLUME_TALK));
            break;
        case 10:
            AssignCommand(oSantuario,SpeakString("L'anima dei seguaci di Velsharoon la ha persa da tanto tempo..",TALKVOLUME_TALK));
            break;
    }
}

void main()
{
    object oSantuario = OBJECT_SELF;
    int nSantuario = GetLocalInt(oSantuario,"n_santuario");
    if(nSantuario == 1)
        StampaFraseSpell(GetLocalInt(GetModule(),"n_spell_s1"),oSantuario);
    else if(nSantuario == 2)
        StampaFraseSpell(GetLocalInt(GetModule(),"n_spell_s2"),oSantuario);
    else if(nSantuario == 3)
        StampaFraseSpell(GetLocalInt(GetModule(),"n_spell_s3"),oSantuario);
}
