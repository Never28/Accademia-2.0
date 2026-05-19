#include "mod_bas_que_func"

void main()
{
    object oPC = GetPCSpeaker();
    DelayCommand(0.0,ScritturaQuest("4",38,oPC));
    DelayCommand(1.0,IncollaStringa(oPC, GetLocalString(oPC,"quest")));
    AddJournalQuestEntry("quest_38",4,oPC,FALSE);
    if(GetItemPossessedBy(oPC,"mod_bas_tele_t")!=OBJECT_INVALID){
        string sDesc = GetDescription(oPC);
        string sTrama1 = " \nAffrontando le insidie della foresta, e aiutando la milizia nella lotta contro gli umanoidi che la infestano, sei giunto alla strada del leone, che ti permetterà di raggiungere la Locanda del Braccio Amico.";
        sDesc = sDesc + sTrama1;
        SetDescription(oPC,sDesc);
    }
}
