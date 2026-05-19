void main()
{
    object oPC = OBJECT_SELF;
    if(GetItemPossessedBy(oPC,"mod_bas_tele")==OBJECT_INVALID){
        int nRace = GetRacialType(oPC);
        string sName = GetName(oPC);
        int nSex = GetGender(oPC);
        string sDeity = GetDeity(oPC);
        int nAge = GetAge(oPC);
        string sAge;
        string sRace;
        string sDesc;
        if(nRace == RACIAL_TYPE_HUMAN){
            sRace = "umano";
            if(nAge<=30)
                sAge = " giovane ";
            else if(nAge>31&&nAge<50)
                sAge = " adulto ";
            else
                sAge = " anziano ";
        }
        else if(nRace == RACIAL_TYPE_HALFORC){
            sRace = "mezzorco";
            if(nAge<=25)
                sAge = " giovane ";
            else if(nAge>25&&nAge<40)
                sAge = " adulto ";
            else
                sAge = " anziano ";
        }
        else if(nRace == RACIAL_TYPE_HALFELF){
            sRace = "mezzelfo";
            if(nAge<=50)
                sAge = " giovane ";
            else if(nAge>51&&nAge<100)
                sAge = " adulto ";
            else
                sAge = " anziano ";
        }
        else if(nRace == RACIAL_TYPE_DWARF){
            sRace = "nano";
            if(nAge<=100)
                sAge = " giovane ";
            else if(nAge>100&&nAge<200)
                sAge = " adulto ";
            else
                sAge = " anziano ";
        }
        else if(nRace == RACIAL_TYPE_ELF){
            sRace = "elfo";
            if(nAge<=200)
                sAge =  " giovane ";
            else if(nAge>200&&nAge<400)
                sAge = " adulto ";
            else
                sAge = " anziano ";
        }
        else if(nRace == RACIAL_TYPE_GNOME){
            sRace = "gnomo";
            if(nAge<=100)
                sAge = " giovane ";
            else if(nAge>100&&nAge<200)
                sAge = " adulto ";
            else
                sAge = " anziano ";
        }
        else if(nRace == RACIAL_TYPE_HALFLING){
            sRace = "halfling";
            if(nAge<=40)
                sAge = " giovane ";
            else if(nAge>40&&nAge<80)
                sAge = " adulto ";
            else
                sAge = " anziano ";
        }
        string sSub = GetSubRace(oPC);
        if(sSub == "Drow"||sSub=="Duergar"||sSub=="Svirfneblin")
            sRace = sSub;
        string sVillage;
        if(GetItemPossessedBy(oPC,"vil_ara")!=OBJECT_INVALID)
            sVillage = "Aranel. Dagli elfi ha appreso ";
        else if(GetItemPossessedBy(oPC,"vil_dro")!=OBJECT_INVALID)
            sVillage = "Drolbo. Dagli halfling ha appreso ";
        else if(GetItemPossessedBy(oPC,"vil_kha")!=OBJECT_INVALID)
            sVillage = "Khartaster. Dagli uomini ha appreso ";
        else if(GetItemPossessedBy(oPC,"vil_kho")!=OBJECT_INVALID)
            sVillage = "Khondar. Dai nani ha appreso ";
        else if(GetItemPossessedBy(oPC,"vil_kur")!=OBJECT_INVALID)
            sVillage = "Kurumbas. Dagli gnomi ha appreso ";
        else if(GetItemPossessedBy(oPC,"vil_ruk")!=OBJECT_INVALID)
            sVillage = "Rukh. Dai mezzorchi ha appreso ";
        else if(GetItemPossessedBy(oPC,"vil_dis")!=OBJECT_INVALID)
            sVillage = "Dissengulp. Dagli Svirfneblin ha appreso ";
        else if(GetItemPossessedBy(oPC,"vil_aha")!=OBJECT_INVALID)
            sVillage = "Ahazindul. Dai Drow ha appreso ";
        else if(GetItemPossessedBy(oPC,"vil_bru")!=OBJECT_INVALID)
            sVillage = "Bruthwol. Dai Duergar ha appreso ";
        int nClass = GetClassByPosition(1,oPC);
        string sClass;
        if(nClass == CLASS_TYPE_BARBARIAN)
            sClass = "l'arte della guerra e della ferocia dei barbari. ";
        else if(nClass == CLASS_TYPE_BARD)
            sClass = "l'arte della musica e del viaggiare dei bardi. ";
        else if(nClass == CLASS_TYPE_CLERIC)
            sClass = "l'arte della magia divina dei chierici. ";
        else if(nClass == CLASS_TYPE_DRUID)
            sClass = "l'arte della magia della natura dei druidi. ";
        else if(nClass == CLASS_TYPE_FIGHTER)
            sClass = "l'arte del combattimento dei guerrieri. ";
        else if(nClass == CLASS_TYPE_MONK)
            sClass = "l'arte della meditazione e delle arti marziali dei monaci. ";
        else if(nClass == CLASS_TYPE_PALADIN)
            sClass = "la potenza della giustizia e del combattimento dei paladini. ";
        else if(nClass == CLASS_TYPE_RANGER)
            sClass = "l'arte della sopravvivenza e del combattimento dei ranger. ";
        else if(nClass == CLASS_TYPE_ROGUE)
            sClass = "l'arte della furtivita' e della fuga dei ladri. ";
        else if(nClass == CLASS_TYPE_SORCERER)
            sClass = "l'arte della magia arcana e del potere interiore degli stregoni. ";
        else if(nClass == CLASS_TYPE_WIZARD)
            sClass = "l'arte della magia arcana e dello studio dei maghi. ";
        string sDeityD;
        if(sDeity == "Talos")
            sDeityD = sName+" venera Talos, il Signore delle Tempeste. ";
        else if (sDeity == "Lathander")
            sDeityD = sName+" venera Lathander, il Signore delle Mattino. ";
        else if (sDeity == "Helm")
            sDeityD = sName+" venera Helm, il Protettore. ";
        else if (sDeity == "Mielikki")
            sDeityD = sName+" venera Mielikki, la Signora della Foresta. ";
        else if (sDeity == "Talona")
            sDeityD = sName+" venera Talona, la Signora del Veleno. ";
        else if (sDeity == "Tiamat")
            sDeityD = sName+" venera Tiamat, la Regina dei Draghi Cromatici. ";
        else if (sDeity == "Bahamut")
            sDeityD = sName+" venera Bahamut, Re dei Draghi Metallici. ";
        else if (sDeity == "Mystra")
            sDeityD = sName+" venera Mystra, la Signora dei Misteri. ";
        else if (sDeity == "Cyric")
            sDeityD = sName+" venera Cyric, il Principe delle Menzogne. ";
        else if (sDeity == "Velsharoon")
            sDeityD = sName+" venera Velsharoon, l'Arcimago della Necromanzia. ";
        else if (sDeity == "Garl Glittergold")
            sDeityD = sName+" venera Garl Glittergold, L'Antico Protettore degli Gnomi. ";
        else if (sDeity == "Corellon Larethian")
            sDeityD = sName+" venera Corellon Larethian, il Creatore degli Elfi. ";
        else if (sDeity == "Yondalla")
            sDeityD = sName+" venera Yondalla, la Protettrice degli Halfling. ";
        else if (sDeity == "Moradin")
            sDeityD = sName+" venera Moradin, il Padre dei Nani. ";
        else if (sDeity == "Gruumsh")
            sDeityD = sName+" venera Gruumsh, Colui che Non Dorme Mai. ";
        else if (sDeity == "Loth")
            sDeityD = sName+" venera Loth, la Regina dei Ragni. ";
        else if (sDeity == "Laduguer")
            sDeityD = sName+" venera Laduguer, il Protettore Grigio. ";
        else if (sDeity == "Urdlen")
            sDeityD = sName+" venera Urdlen, il Grande Artiglio. ";
        int nGoodEvil = GetAlignmentGoodEvil(oPC);
        int nLawChaos = GetAlignmentLawChaos(oPC);
        string sAlign;
        if(nGoodEvil == ALIGNMENT_EVIL){
            if(nLawChaos == ALIGNMENT_LAWFUL)
                sAlign = "Caratterialmente prende sempre cio' che vuole seguendo un codice morale, ma senza alcun riguardo per chi ferisce nel farlo.";
            else if(nLawChaos == ALIGNMENT_CHAOTIC)
                sAlign = "Caratterialmente fa cio' che la sua ingordigia, il suo odio e il suo desiderio di distruzione lo spingono a fare.";
            else
                sAlign = "Caratterialmente e' disposto a fare di tutto, fiche' gli e' consentito di cavarsela; pensa solo a se stesso e non versa lacrime per chi uccide.";
        }
        else if(nGoodEvil == ALIGNMENT_NEUTRAL){
            if(nLawChaos == ALIGNMENT_LAWFUL)
                sAlign = "Caratterialmente agisce come gli suggeriscono le leggi, le tradizioni o il suo codice d'onore personale. L'ordine e l'organizzazione sono di importanza vitale per lui.";
            else if(nLawChaos == ALIGNMENT_CHAOTIC)
                sAlign = "Caratterialmente segue esclusivamente il suo arbitrio. Mette la liberta' sopra ogni cosa ma non lotta per difendere quella degli altri, respinge l'autorita' e si scaglia contro le tradizioni.";
            else
                sAlign = "Caratterialmente fa sempre cio' che gli sembra una buona idea. Quando si tratta del male e del male, del caos o della legge non ha particolari tendenze dall'una o dall'altra parte";
        }
        else{
            if(nLawChaos == ALIGNMENT_LAWFUL)
                sAlign = "Caratterialmente si comporta esattamente come si pensa o ci si aspetta che agisca una persona di indole buona. Unisce un forte sentimento di opposizione nei confronti del male alla disciplina necessaria per combatterlo senza tregua.";
            else if(nLawChaos == ALIGNMENT_CHAOTIC)
                sAlign = "Caratterialmente segue soltanto la propria coscienza, senza preoccuparsi di ci che gli altri si aspettano da lui. Segue la sua strada, ma riesce comunque ad essere gentile e bendisposto. Crede nel bene e nella giustizia, ma non ha molto rispetto per le leggi e le regole.";
            else
                sAlign = "Caratterialmente fa sempre del suo meglio, nei limiti delle sue possibilita' Sente l'impulso di fare del bene senza avere pregiudizi e senza andare contro l'autorita'";
        }
        if(nSex == GENDER_MALE)
            sDesc = sName+" e' un "+sRace+sAge+" nato a "+sVillage+sClass+sDeityD+sAlign+" Ora e' in partenza per candlekeep per iniziare il suo addestramento col sommo Gorion, famoso per aver allenato i migliori avventurieri del Faerun.";
        else
            sDesc = sName+" e' una "+sRace+sAge+" nata a "+sVillage+sClass+sDeityD+sAlign+" Ora e' in partenza per candlekeep per iniziare il suo addestramento col sommo Gorion, famoso per aver allenato i migliori avventurieri del Faerun.";
        SetDescription(oPC,sDesc);
        AssignCommand(GetModule(),ActionSpeakString(sDesc,TALKVOLUME_SHOUT));
    }
}
