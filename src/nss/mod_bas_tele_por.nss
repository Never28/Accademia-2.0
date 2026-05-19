#include "mod_bas_que_func"
void RemEff(object oPC){
    effect effoPC = GetFirstEffect(oPC);
    while(GetIsEffectValid(effoPC)==TRUE){
        RemoveEffect(oPC,effoPC);
        effoPC = GetNextEffect(oPC);
    }
}
void main()
{
    object oPC = GetLastUsedBy();
    if(GetItemPossessedBy(oPC,"deletemeplease")==OBJECT_INVALID){
        int nQuest = LetturaQuest(38,oPC);
        if(nQuest >=2){
            AssignCommand(oPC,ActionStartConversation(oPC,"mod_bas_tele",TRUE));
        }
        else if(nQuest==1){
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
        else if(nQuest==0){
            string sWay;
            if(GetItemPossessedBy(oPC,"vil_ara")!=OBJECT_INVALID)
                sWay = "vil_ara_t1";
            else if(GetItemPossessedBy(oPC,"vil_dro")!=OBJECT_INVALID){
                sWay = "vil_dro_t1";
            }
            else if(GetItemPossessedBy(oPC,"vil_kur")!=OBJECT_INVALID){
                sWay = "vil_kur_t1";
            }
            else if(GetItemPossessedBy(oPC,"vil_ruk")!=OBJECT_INVALID){
                sWay = "vil_ruk_t1";
            }
            else if(GetItemPossessedBy(oPC,"vil_kho")!=OBJECT_INVALID){
                sWay = "vil_kho_t1";
            }
            else if(GetItemPossessedBy(oPC,"vil_bru")!=OBJECT_INVALID){
                sWay = "vil_bru_t1";
            }
            else if(GetItemPossessedBy(oPC,"vil_aha")!=OBJECT_INVALID){
                sWay = "vil_aha_t1";
            }
            else if(GetItemPossessedBy(oPC,"vil_dis")!=OBJECT_INVALID){
                sWay = "vil_dis_t1";
            }
            else if(GetItemPossessedBy(oPC,"vil_kha")!=OBJECT_INVALID){
                sWay = "vil_kha_t1";
            }
            object oTarget = GetWaypointByTag(sWay);
            DelayCommand(1.0, AssignCommand(oPC, ActionJumpToObject(oTarget)));
            SendMessageToPC(oPC,"Prima di usare il portale o il simbolo magico devi guardare il filmato introduttivo");
        }
    }
    else
        SendMessageToPC(oPC,"Questo Personaggio deve essere cancellato, comunicalo sul forum");
}
