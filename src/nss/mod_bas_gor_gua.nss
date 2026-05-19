#include "mod_bas_que_func"
void main()
{
    object oPC = GetPCSpeaker();
    DelayCommand(1.0,ScritturaQuest("2",38,oPC));
    DelayCommand(2.0,IncollaStringa(oPC, GetLocalString(oPC,"quest")));
    AddJournalQuestEntry("quest_38",2,oPC,FALSE);
    object oWay = GetWaypointByTag("cit_can_tav_t1");
    DelayCommand(1.0, AssignCommand(oPC, ActionJumpToObject(oWay)));
            if(GetItemPossessedBy(oPC,"mod_bas_tele_t")!=OBJECT_INVALID){
                string sDesc = GetDescription(oPC);
                string sTrama1 = " \nAl momento del tuo risveglio, una guardia ti annuncia che cio' che avevi sognato si e' avverato: il tuo maestro Gorion e' morto, vittima di un imboscata nella foresta. Sconosciuti sono gli assalitori, e non si sa che fine abbia fatto il figlio del tuo maestro, ma una lettera lasciata dal tuo mentore ti informa di vegliare sul ragazzo diretto alla Locanda del braccio amico, per incontrare Jaheira e Minsc, due amici di Gorion.";
                string sTrama2 = " Non ti resta che partire a tua volta per adempire alle ultime volontà del tuo maestro.";
                sDesc = sDesc + sTrama1+sTrama2;
                SetDescription(oPC,sDesc);
            }
}

