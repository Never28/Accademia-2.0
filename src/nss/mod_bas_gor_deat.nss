#include "x2_inc_spellhook"
void RemEff(object oPC){
    effect effoPC = GetFirstEffect(oPC);
    while(GetIsEffectValid(effoPC)==TRUE){
        RemoveEffect(oPC,effoPC);
        effoPC = GetNextEffect(oPC);
    }
}

void main()
{
        object Sarevok = GetLastKiller();
        AssignCommand(Sarevok,ClearAllActions(TRUE));
        object oArea = GetArea(Sarevok);
        object oPC = GetFirstObjectInArea(oArea);
        while(GetIsPC(oPC)==FALSE){
            oPC = GetNextObjectInArea(oArea);
        }
        object Allievo = GetObjectByTag("mod_bas_allievo");
        object Ogre1 = GetObjectByTag("mod_bas_ogre1");
        object Ogre2 = GetObjectByTag("mod_bas_ogre2");
        object Gorion = OBJECT_SELF;
        object Tamoko = GetObjectByTag("mod_bas_tamo");

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

        effect eRess = EffectResurrection();
        effect eHeal = EffectHeal(300);
        DelayCommand(5.0,ApplyEffectToObject(DURATION_TYPE_INSTANT,eRess,Gorion));
        DelayCommand(5.0,ApplyEffectToObject(DURATION_TYPE_INSTANT,eRess,Ogre1));
        DelayCommand(5.0,ApplyEffectToObject(DURATION_TYPE_INSTANT,eRess,Ogre2));
        DelayCommand(5.0,RemoveEffectsFromSpell(Tamoko, SPELL_HOLD_MONSTER));
        DelayCommand(6.0,ApplyEffectToObject(DURATION_TYPE_INSTANT,eHeal,Gorion));
        DelayCommand(6.0,ApplyEffectToObject(DURATION_TYPE_INSTANT,eHeal,Allievo));
        DelayCommand(6.0,ApplyEffectToObject(DURATION_TYPE_INSTANT,eHeal,Sarevok));
        DelayCommand(6.0,ApplyEffectToObject(DURATION_TYPE_INSTANT,eHeal,Ogre1));
        DelayCommand(6.0,ApplyEffectToObject(DURATION_TYPE_INSTANT,eHeal,Ogre2));
        object TapGor = GetWaypointByTag("mod_gor_t1");
        object TapAll = GetWaypointByTag("mod_all_t1");
        object TapSar = GetWaypointByTag("mod_sar_t1");
        object TapTam = GetWaypointByTag("mod_tam_t1");
        object TapOgr1 = GetWaypointByTag("mod_og1_t1");
        object TapOgr2 = GetWaypointByTag("mod_og2_t1");
        DelayCommand(7.0, AssignCommand(Tamoko, ClearAllActions(TRUE)));
        DelayCommand(7.0, AssignCommand(Sarevok, ClearAllActions(TRUE)));
        DelayCommand(7.0, AssignCommand(Ogre1, ClearAllActions(TRUE)));
        DelayCommand(7.0, AssignCommand(Ogre2, ClearAllActions(TRUE)));
        DelayCommand(7.0, AssignCommand(Gorion, ClearAllActions(TRUE)));
        DelayCommand(7.0, AssignCommand(Allievo, ClearAllActions(TRUE)));
        DelayCommand(8.0, AssignCommand(Tamoko, ActionJumpToObject(TapTam)));
        DelayCommand(8.0, AssignCommand(Sarevok, ActionJumpToObject(TapSar)));
        DelayCommand(8.0, AssignCommand(Ogre1, ActionJumpToObject(TapOgr1)));
        DelayCommand(8.0, AssignCommand(Ogre2, ActionJumpToObject(TapOgr2)));
        DelayCommand(8.0, AssignCommand(Gorion, ActionJumpToObject(TapGor)));
        DelayCommand(8.0, AssignCommand(Allievo, ActionJumpToObject(TapAll)));
        DelayCommand(10.0, SetLocalInt(GetModule(),"cutscene_gorion",0));
}
