/*
  CREATO DA:      Tempesta
  DATA CREAZIONE: 17-06-2009
*/

// La funzione quando un giocatore muore.

#include "x2_inc_spellhook"

void RessurrezioneC(object oPC)
{
    object oItem;
        if (GetIsObjectValid(oPC))
        {
            SignalEvent(oPC, EventSpellCastAt(OBJECT_SELF, SPELL_RESURRECTION, FALSE));
                int stampa1=GetLocalInt(oPC,"class_special");
                int stampa2=GetLocalInt(oPC,"car_ability");
                if(stampa2==0)
                    ExecuteScript("mod_bas_car",oPC);
                if(stampa1==0)
                    ExecuteScript("mod_bas_cla",oPC);
                //Declare major variables
                DestroyObject(GetItemPossessedBy(oPC,"mod_bas_death"));
                int nHealed = GetMaxHitPoints(oPC);
                effect eRaise = EffectResurrection();
                effect eHeal = EffectHeal(nHealed + 10);
                effect eVis = EffectVisualEffect(VFX_IMP_RAISE_DEAD);
                //Apply the heal, raise dead and VFX impact effect
                ApplyEffectToObject(DURATION_TYPE_INSTANT, eRaise, oPC);
                ApplyEffectToObject(DURATION_TYPE_INSTANT, eHeal, oPC);
                ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eVis, GetLocation(oPC));
            }

    SetLocalInt(oPC,"ResurrezioneC",2);
}

void main()
{
    object oPC = GetLastPlayerDied();
    effect eVis = EffectVisualEffect(VFX_COM_CHUNK_RED_LARGE);
    effect eLoop=GetFirstEffect(oPC);
    object oKiller = GetLastKiller();
    object oPC2 = GetFirstFactionMember(oKiller,TRUE);
    while (oPC2 != OBJECT_INVALID){
        if(GetLevelByClass(CLASS_TYPE_DRUID,oPC2)==40 && GetAppearanceType(oPC2)==APPEARANCE_TYPE_ALLIP)
            ApplyEffectToObject(DURATION_TYPE_INSTANT,EffectHeal(GetHitDice(oPC)),oPC2);
        oPC2 = GetNextFactionMember(oKiller,TRUE);
    }

    while (GetIsEffectValid(eLoop)){
        if (GetEffectType(eLoop)==EFFECT_TYPE_POLYMORPH)
            RemoveEffect(oPC, eLoop);
        eLoop=GetNextEffect(oPC);
    }
    if (GetItemPossessedBy(oPC,"mod_bas_death")==OBJECT_INVALID){
        CreateItemOnObject("mod_bas_death",oPC);
        ApplyEffectToObject(DURATION_TYPE_INSTANT,eVis,oPC,1.5);
        ApplyEffectToObject(DURATION_TYPE_INSTANT,eVis,oPC,1.8);
        ApplyEffectToObject(DURATION_TYPE_INSTANT,eVis,oPC,2.1);
    }
    AdjustFactionReputation(oPC,GetLastKiller(),80);
    DeleteLocalInt(oPC,"AuraDiZombie_CURRENT");
    DeleteLocalInt(oPC,"AuraDiSilenzio_CURRENT");
    DeleteLocalInt(oPC,"AuraDiInvisibilita_CURRENT");
    DeleteLocalInt(oPC,"AuraDiBattaglia_CURRENT");
    DeleteLocalInt(oPC,"AuraDiCantoFunebre_CURRENT");
    DeleteLocalInt(oPC,"AuraDiMutaM_CURRENT");
    DeleteLocalInt(oPC,"AuraDiMutaG_CURRENT");
    DeleteLocalInt(oPC,"AuraDiMutaE_CURRENT");
    DeleteLocalInt(oPC,"AuraDiBlack_CURRENT");
    DeleteLocalInt(oPC,"AuraDiTigre_CURRENT");
    DeleteLocalFloat(oPC,"AuraDiEntangle_POSITION1");
    DeleteLocalFloat(oPC,"AuraDiEntangle_POSITION2");
    DeleteLocalFloat(oPC,"AuraDiEntangle_POSITION3");
    DeleteLocalFloat(oPC,"AuraDiSpike_POSITION1");
    DeleteLocalFloat(oPC,"AuraDiSpike_POSITION2");
    DeleteLocalFloat(oPC,"AuraDiSpike_POSITION3");
    DeleteLocalFloat(oPC,"AuraDiVine1_POSITION1");
    DeleteLocalFloat(oPC,"AuraDiVine1_POSITION2");
    DeleteLocalFloat(oPC,"AuraDiVine1_POSITION3");
    DeleteLocalFloat(oPC,"AuraDiVine2_POSITION1");
    DeleteLocalFloat(oPC,"AuraDiVine2_POSITION2");
    DeleteLocalFloat(oPC,"AuraDiVine2_POSITION3");
    DeleteLocalFloat(oPC,"AuraDiVine3_POSITION1");
    DeleteLocalFloat(oPC,"AuraDiVine3_POSITION2");
    DeleteLocalFloat(oPC,"AuraDiVine3_POSITION3");
    DeleteLocalInt(oPC,"AuraDiEvard_CURRENT");
    DeleteLocalInt(oPC,"AuraDiOdore_CURRENT");
    DeleteLocalInt(oPC,"AuraDiStone_CURRENT");
    DeleteLocalInt(oPC,"AuraDiVine1_CURRENT");
    DeleteLocalInt(oPC,"AuraDiVine2_CURRENT");
    DeleteLocalInt(oPC,"AuraDiVine3_CURRENT");
    DeleteLocalInt(oPC,"AuraDiCprDoom_CURRENT");
    DeleteLocalInt(oPC,"AuraDiWeb_CURRENT");
    DeleteLocalInt(oPC,"AuraDiStorm_CURRENT");
    DeleteLocalInt(oPC,"AuraDiAcidFog_CURRENT");
    DeleteLocalInt(oPC,"AuraDiWallFire_CURRENT");
    DeleteLocalInt(oPC,"AuraDiLame_CURRENT");
    DeleteLocalInt(oPC,"AuraDiIncendiary_CURRENT");
    DeleteLocalInt(oPC,"AuraDiSpike_CURRENT");
    DeleteLocalInt(oPC,"AuraDiMind_CURRENT");
    DeleteLocalInt(oPC,"AuraDiPerp_CURRENT");
    DeleteLocalInt(oPC,"AuraDiKill_CURRENT");
    DeleteLocalString(oPC,"AuraDiKill_IMMUNI");
    DeleteLocalInt(oPC,"AuraDiFear_CURRENT");
    DeleteLocalString(oPC,"AuraDiFear_IMMUNI");
    DeleteLocalInt(oPC,"AuraDiGrease_CURRENT");
    DeleteLocalInt(oPC,"AuraDiEntangle_CURRENT");
    DeleteLocalInt(oPC,"AuraDiTerra_CURRENT");
    DeleteLocalInt(oPC,"AuraDiElettro_CURRENT");
    DeleteLocalInt(oPC,"AuraDiFuoco_CURRENT");
    DeleteLocalInt(oPC,"AuraDiFreddo_CURRENT");
    DeleteLocalInt(oPC,"AuraDiDrago_CURRENT");
    DeleteLocalString(oPC,"AuraDiDrago_IMMUNI");
    DeleteLocalInt(oPC,"AuraDiMorte_CURRENT");
    DeleteLocalString(oPC,"AuraDiMorte_IMMUNI");
    DeleteLocalInt(oPC,"AuraDiAcceca_CURRENT");
    DeleteLocalString(oPC,"AuraDiAcceca_IMMUNI");
    DeleteLocalInt(oPC,"AuraDiTroglo_CURRENT");
    DeleteLocalString(oPC,"AuraDiTroglo_IMMUNI");
    SetLocalInt(oPC,"metamorfosi",58);
    SetLocalInt(oPC,"car_ability",0);
    CreateItemOnObject("mod_bas_dead",oPC);
    SetLocalInt(oPC,"class_special",0);
    if(GetLocalInt(oPC,"ResurrezioneC") == 1)
        DelayCommand(2.5,RessurrezioneC(oPC));
    else
        DelayCommand(2.5, PopUpDeathGUIPanel(oPC));
}
