/*
  CREATO DA:      Tempesta
  DATA CREAZIONE: 17-06-2009
*/

// La funzione quando entra un giocatore nel server.

#include "mod_bas_que_func"

void RemEff(object oPC){
    effect effoPC = GetFirstEffect(oPC);
    while(GetIsEffectValid(effoPC)==TRUE){
        RemoveEffect(oPC,effoPC);
        effoPC = GetNextEffect(oPC);
    }
}

#include "x3_inc_string"

void main()
{
    // Il giocatore che entra.
    object oPC = GetEnteringObject();
    string sName = StringReplace(GetPCPlayerName(oPC)," ","X");
    sName = StringReplace(sName,".","Y");
    sName = StringReplace(sName,"-","Z");
    sName = StringReplace(sName,"_","K");
    string sCDKEY = GetCampaignString("ACCADEMIA",sName,OBJECT_INVALID);
    if(sCDKEY == ""){
        SetCampaignString("ACCADEMIA",sName,GetPCPublicCDKey(oPC),OBJECT_INVALID);
    }
    else{
        if(sCDKEY != GetPCPublicCDKey(oPC)){
            DelayCommand(0.0,SendMessageToPC(oPC,"Non ci provare a fregare gli account degli altri"));
            DelayCommand(1.0,BootPC(oPC));
        }
    }
    if(GetCampaignInt("ACCADEMIA","inizio",oPC)==1)
        CopiaIncollaDatabase(oPC);
    object oArea = GetArea(oPC);
    if(GetTag(oArea)=="mod_sogno"){
            int nStanza = 1;
            int i = 0;
            string sStanza = "mod_stanza_t";
            while(nStanza != 0){
                i++;
                nStanza = GetLocalInt(GetModule(),sStanza+IntToString(i));
                if(i == 5){
                    nStanza = 0;
                    i = 1;
                }
            }
            sStanza = sStanza + IntToString(i);
            object oTarget = GetWaypointByTag(sStanza);
            SetLocalInt(GetModule(),sStanza,1);
            DelayCommand(300.0,SetLocalInt(GetModule(),sStanza,0));
            DelayCommand(3.0,SetCutsceneMode(oPC,FALSE,FALSE));
            DelayCommand(2.0, AssignCommand(oPC, ActionJumpToObject(oTarget)));
            DelayCommand(3.0, SetImmortal(oPC,FALSE));
            DelayCommand(3.0, RemEff(oPC));
    }
    else if(GetTag(oArea)=="ext_iso_sah_imb"&&GetLocalInt(OBJECT_SELF,"quest_nave_dag")==0){
        object oTarget2 = GetWaypointByTag("WP_sah_sba_t1");
        AssignCommand(oPC, ActionJumpToObject(oTarget2));
    }
    object oTotem = GetItemPossessedBy(oPC,"mod_clas_poly");
    if(oTotem!=OBJECT_INVALID)
        DestroyObject(oTotem);
    // Controlliamo dal database se e' la prima volta che il giocatore entra.
    // Se e' la prima volta facciamo partire lo script per chi fa la sua prima entrata.
    if((GetItemPossessedBy(oPC,"mod_bas_tele")==OBJECT_INVALID&&GetItemPossessedBy(oPC,"mod_bas_tele_t")==OBJECT_INVALID)&&(GetIsDM(oPC)==FALSE))
        ExecuteScript("mod_pc_enter_f",oPC);
    if((GetItemPossessedBy(oPC,"vil_ara")==OBJECT_INVALID&&GetItemPossessedBy(oPC,"vil_dro")==OBJECT_INVALID
    &&GetItemPossessedBy(oPC,"vil_kha")==OBJECT_INVALID&&GetItemPossessedBy(oPC,"vil_kho")==OBJECT_INVALID
    &&GetItemPossessedBy(oPC,"vil_kur")==OBJECT_INVALID&&GetItemPossessedBy(oPC,"vil_ruk")==OBJECT_INVALID
    &&GetItemPossessedBy(oPC,"vil_dis")==OBJECT_INVALID&&GetItemPossessedBy(oPC,"vil_aha")==OBJECT_INVALID
    &&GetItemPossessedBy(oPC,"vil_bru")==OBJECT_INVALID)&&(GetIsDM(oPC) == FALSE))
        ExecuteScript("mod_pc_enter_v",oPC);
    int nEntrace = GetLocalInt(oPC,"entrato");

    if(nEntrace == 0){
        DelayCommand(1.5,ExecuteScript("mod_pc_enter_que",oPC));
        SetLocalInt(oPC,"entrato",1);
        string sPlayer = GetPCPlayerName(oPC);
        DeleteCampaignVariable("accademia_new",sPlayer,GetModule());
        string sTotale = GetCampaignString("accademia_new","gilda",oPC);
        string sFazione = GetSubString(sTotale,3,3);
        string sGilda = GetSubString(sTotale,0,3);
        int nPunti = GetCampaignInt("accademia_new","punti",oPC);
        if(sGilda == ""){
            SetLocalInt(oPC,"puntigilda",0);
            SetLocalString(oPC,"gilda","xxx"+"yyy");
        }
        else{
            SetLocalInt(oPC,"puntigilda",nPunti);
            SetLocalString(oPC,"gilda",sGilda+sFazione);
        }
    }
    // Il nome del giocatore che entra.
    string NomeoPC = GetName(oPC);
    // Calcoliamo i suoi XP.
    string XP = IntToString(GetXP(oPC));
    // Fondiamo il nome del giocatore coi suoi XP per avere la variabile da cui ricavare i danni quando era uscito.
    string danni = NomeoPC+XP;
    // Mettiamo il valore nella variabile Danni Attuali.
    int DanniAttuali=GetLocalInt(GetModule(),danni);
    // Se i danni sono diversi da 0 applichiamo i danni al giocatore.
    if(DanniAttuali!=0){
        effect Danno=EffectDamage(DanniAttuali,DAMAGE_TYPE_DIVINE,DAMAGE_POWER_NORMAL);
        ApplyEffectToObject(DURATION_TYPE_INSTANT,Danno, oPC);
        DeleteLocalInt(GetModule(),danni);
    }
    if (GetItemPossessedBy(oPC,"mod_bas_dead")!=OBJECT_INVALID)
        ApplyEffectToObject(DURATION_TYPE_INSTANT,EffectDeath(),oPC);
    // Il nome del database del modulo

    // Facciamo sapere a tutti che il giocatore ha fatto la sua entrata nel server.
    object oPC2 = GetFirstPC();
    while(GetIsPC(oPC2) == TRUE&&GetIsDM(oPC)==FALSE){
        SendMessageToPC(oPC2,NomeoPC+" fa il suo ingresso in Accademia");
        oPC2 = GetNextPC();
    }
    SetLocalInt(oPC,"ANNEGARE",8);
    SetLocalInt(oPC,"NUMEROANNEGAMENTI",1);
    ExecuteScript("mod_clas_poly_de",oPC);
    int stampa1=GetLocalInt(oPC,"class_special");
    int stampa2=GetLocalInt(oPC,"car_ability");
    if(stampa2==0)
        ExecuteScript("mod_bas_car",oPC);
    if(stampa1==0)
        ExecuteScript("mod_bas_cla_spe",oPC);
}

