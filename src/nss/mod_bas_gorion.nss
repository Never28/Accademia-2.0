#include "mod_bas_que_func"
#include "x2_inc_spellhook"

void main()
{
    object oPC = GetPCSpeaker();
    int nQuest = LetturaQuest(38,oPC);
    if(nQuest == 0){
        object oModule = GetModule();
        int nUse = GetLocalInt(oModule,"cutscene_gorion");
        if(nUse==0){
            SetLocalInt(oModule,"cutscene_gorion",1);
            DelayCommand(1.0,ScritturaQuest("1",38,oPC));
            DelayCommand(2.0,IncollaStringa(oPC, GetLocalString(oPC,"quest")));
            AddJournalQuestEntry("quest_38",1,oPC,FALSE);
            if(GetItemPossessedBy(oPC,"mod_bas_tele_t")!=OBJECT_INVALID){
                string sDesc = GetDescription(oPC);
                string sTrama1 = " \n\n^Anno: 1369 DR^\nTi sei allenato per due anni con Gorion e suo figlio. Durante la notte hai avuto uno strano sogno, in cui hai visto il tuo maestro essere vittima di un'imboscata e sacrificare la sua vita per permettere a suo figlio di fuggire dai sicari a lui interessati.";
                sDesc = sDesc + sTrama1;
                SetDescription(oPC,sDesc);
            }
            object TapSog = GetWaypointByTag("mod_bas_sog_t1");
            AssignCommand(oPC, ActionJumpToObject(TapSog));
            ApplyEffectToObject(DURATION_TYPE_PERMANENT,EffectVisualEffect(VFX_DUR_CUTSCENE_INVISIBILITY),oPC);
            ApplyEffectToObject(DURATION_TYPE_TEMPORARY,EffectSlow(),oPC,60.0);
            SetCutsceneMode(oPC,TRUE,FALSE);
            SetImmortal(oPC,TRUE);
            object Gorion = GetObjectByTag("mod_bas_gorion");
            SetImmortal(Gorion,TRUE);
            object Allievo = GetObjectByTag("mod_bas_allievo");
            object Ogre1 = GetObjectByTag("mod_bas_ogre1");
            object Ogre2 = GetObjectByTag("mod_bas_ogre2");
            object Sarevok = GetObjectByTag("mod_bas_sare");
            object Tamoko = GetObjectByTag("mod_bas_tamo");
            object TapGor = GetWaypointByTag("mod_gor_t2");
            object TapAll = GetWaypointByTag("mod_all_t2");
            TapSog = GetWaypointByTag("mod_bas_sog_t2");
            AssignCommand(Gorion,SetIsDestroyable(FALSE, TRUE, TRUE));
            AssignCommand(Ogre1,SetIsDestroyable(FALSE, TRUE, TRUE));
            AssignCommand(Ogre2,SetIsDestroyable(FALSE, TRUE, TRUE));
            object TapSar = GetWaypointByTag("mod_sar_t2");
            object TapTam = GetWaypointByTag("mod_tam_t2");
            object TapOgr1 = GetWaypointByTag("mod_og1_t2");
            object TapOgr2 = GetWaypointByTag("mod_og2_t2");
            DelayCommand(6.0,AssignCommand(Gorion,ActionSpeakString("Muoviamoci, la notte si sta facendo sempre piu' buia, faremo bene a trovare un riparo. Ti spieghero' tutto il prima possibile, ora non c'e' tempo..")));
            DelayCommand(9.0,AssignCommand(oPC,ActionForceMoveToObject(TapSog)));
            DelayCommand(9.0,AssignCommand(Gorion,ActionMoveToObject(TapGor)));
            DelayCommand(9.0,AssignCommand(Allievo,ActionMoveToObject(TapAll)));
            DelayCommand(17.0,AssignCommand(Gorion,ActionSpeakString("Aspetta, c'e' qualcosa di strano.. Siamo caduti in un'imboscata.. Preparati!")));
            DelayCommand(18.0,AssignCommand(Sarevok,ActionMoveToObject(TapSar)));
            DelayCommand(18.0,AssignCommand(Tamoko,ActionMoveToObject(TapTam)));
            DelayCommand(18.0,AssignCommand(Ogre1,ActionMoveToObject(TapOgr1)));
            DelayCommand(18.0,AssignCommand(Ogre2,ActionMoveToObject(TapOgr2)));
            DelayCommand(23.0,AssignCommand(Sarevok,ActionSpeakString("Ci vedi bene per essere un vecchio. Sai bene perche' sono qui, arrenditi e non ti uccidero'. Se cercherai di opporti invece pagherai con la vita.")));
            DelayCommand(28.0,AssignCommand(Gorion,ActionSpeakString("Sei uno stupido se pensi che io ci creda. Andatevene via e nessuno si fara' del male.")));
            DelayCommand(31.0,AssignCommand(Sarevok,ActionSpeakString("Mi dispiace che tu abbia fatto questa scelta vecchio!")));
            DelayCommand(35.0,AssignCommand(Gorion,ActionCastSpellAtObject(SPELL_FLAME_ARROW, Ogre1, METAMAGIC_ANY, TRUE, 0, PROJECTILE_PATH_TYPE_DEFAULT, FALSE)));
            DelayCommand(38.0,AssignCommand(Tamoko,ActionCastSpellAtObject(SPELL_FLAME_STRIKE, Allievo, METAMAGIC_ANY, TRUE, 0, PROJECTILE_PATH_TYPE_DEFAULT, FALSE)));
            TapAll = GetWaypointByTag("mod_all_t3");
            DelayCommand(39.5,AssignCommand(Gorion,ActionSpeakString("Scappa, non farti prendere, ci penso io a loro!")));
            DelayCommand(41.0,AssignCommand(Allievo,ActionMoveToObject(TapAll,TRUE)));
            DelayCommand(42.0,AssignCommand(Gorion,ActionCastSpellAtObject(SPELL_HOLD_MONSTER, Tamoko, METAMAGIC_ANY, TRUE, 0, PROJECTILE_PATH_TYPE_DEFAULT, FALSE)));
            DelayCommand(45.0,ApplyEffectToObject(DURATION_TYPE_TEMPORARY,EffectVisualEffect(VFX_DUR_PARALYZE_HOLD),Tamoko,24.0));
            DelayCommand(45.0,AssignCommand(Ogre2,ActionAttack(Gorion)));
            DelayCommand(45.0,AssignCommand(Sarevok,ActionAttack(Gorion)));
            DelayCommand(48.0,AssignCommand(Gorion,ActionCastSpellAtObject(SPELL_BALL_LIGHTNING, Ogre2, METAMAGIC_ANY, TRUE, 0, PROJECTILE_PATH_TYPE_DEFAULT, FALSE)));
            DelayCommand(49.0,SetImmortal(Gorion,FALSE));
            DelayCommand(49.0,AssignCommand(Gorion,ActionCastSpellAtObject(SPELL_ISAACS_GREATER_MISSILE_STORM, Ogre2, METAMAGIC_ANY, TRUE, 0, PROJECTILE_PATH_TYPE_DEFAULT, FALSE)));
            DelayCommand(57.0,AssignCommand(Gorion,ActionAttack(Sarevok)));
        }
        else{
            SendMessageToPC(oPC,"Attendi, altri giocatori stanno guardando il filmato per iniziare la propria avventura su accademia, ritorna fra poco per vederlo e incominciare a giocare anche tu");
        }
    }
    else{
        object oTarget = GetWaypointByTag("cit_can_t1");
        DelayCommand(0.0, AssignCommand(oPC, ActionJumpToObject(oTarget)));
    }
}
