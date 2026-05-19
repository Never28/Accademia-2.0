/*
  CREATO DA:      Tempesta
  DATA CREAZIONE: 17-06-2009
*/

// La funzione quando un giocatore riposa nel server.
void DistruggiPelle(object oPC){
    object oItem2 = GetFirstItemInInventory(oPC);
    while(oItem2!=OBJECT_INVALID){
        string sItem2 = GetStringLeft(GetTag(oItem2),4);
        if(sItem2 == "poly" && oItem2 != GetItemInSlot(INVENTORY_SLOT_CARMOUR,oPC) && GetBaseItemType(oItem2) == BASE_ITEM_CREATUREITEM)
            DestroyObject(oItem2);
        if(oItem2 != GetItemInSlot(INVENTORY_SLOT_CWEAPON_R,oPC) && GetBaseItemType(oItem2) == BASE_ITEM_CREATUREITEM)
            DestroyObject(oItem2);
        oItem2 = GetNextItemInInventory(oPC);
    }
}
void main()
{
    // Il giocatore che sta dormendo.
    object oPC = GetLastPCRested();

    // I metri in cui non devono esserci nemici.
    int iHostileRange = 30;
    // Controlliamo se ci sono nemici nelle vicinanze.
    if (GetLastRestEventType() == REST_EVENTTYPE_REST_STARTED){
        int i=1;
        object oSummon = GetAssociate(ASSOCIATE_TYPE_SUMMONED, oPC, i);
        while(GetIsObjectValid(oSummon)){
            AssignCommand(oSummon, SetIsDestroyable(TRUE, FALSE, FALSE));
            i++;
            oSummon = GetAssociate(ASSOCIATE_TYPE_SUMMONED, oPC, i);
        }
        object oCreature =GetNearestCreature(CREATURE_TYPE_REPUTATION, REPUTATION_TYPE_ENEMY);
        if (iHostileRange == 0 || (iHostileRange != 0 && GetDistanceToObject(oCreature) <= IntToFloat(iHostileRange))){
            DeleteLocalInt(oPC,"AuraDiZombie_CURRENT");
            DeleteLocalInt(oPC,"AuraDiSilenzio_CURRENT");
            DeleteLocalInt(oPC,"AuraDiInvisibilita_CURRENT");
            DeleteLocalInt(oPC,"AuraDiCantoFunebre_CURRENT");
            DeleteLocalInt(oPC,"AuraDiBattaglia_CURRENT");
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
            DeleteLocalInt(oPC,"AuraDiGrease_CURRENT");
            DeleteLocalInt(oPC,"AuraDiEntangle_CURRENT");
            DeleteLocalInt(oPC,"AuraDiTerra_CURRENT");
            DeleteLocalInt(oPC,"AuraDiElettro_CURRENT");
            DeleteLocalInt(oPC,"AuraDiFuoco_CURRENT");
            DeleteLocalInt(oPC,"AuraDiFreddo_CURRENT");
            DeleteLocalInt(oPC,"AuraDiDrago_CURRENT");
            DeleteLocalString(oPC,"AuraDiDrago_IMMUNI");
            DeleteLocalInt(oPC,"AuraDiFear_CURRENT");
            DeleteLocalString(oPC,"AuraDiFear_IMMUNI");
            DeleteLocalInt(oPC,"AuraDiMorte_CURRENT");
            DeleteLocalString(oPC,"AuraDiMorte_IMMUNI");
            DeleteLocalInt(oPC,"AuraDiAcceca_CURRENT");
            DeleteLocalString(oPC,"AuraDiAcceca_IMMUNI");
            DeleteLocalInt(oPC,"AuraDiTroglo_CURRENT");
            DeleteLocalString(oPC,"AuraDiTroglo_IMMUNI");
            effect eVis = EffectVisualEffect(VFX_IMP_SLEEP);
            effect eVis2 =EffectVisualEffect(VFX_DUR_BLACKOUT);
            ApplyEffectToObject( DURATION_TYPE_TEMPORARY, eVis,oPC);
            ApplyEffectToObject( DURATION_TYPE_TEMPORARY, eVis2,oPC,5.0);
        }
        //Se c'e' ne sono mandiamo un messaggio di avviso.
        else{
            AssignCommand (oPC, ClearAllActions());
            FloatingTextStringOnCreature ("Ci sono mostri vicini!!", oPC);
        }
    }
    // Se il Riposo viene fatto con successo esportiamo il giocatore.
    if ((GetLastRestEventType() == REST_EVENTTYPE_REST_FINISHED || GetLastRestEventType() == REST_EVENTTYPE_REST_CANCELLED)){
        ExportSingleCharacter(oPC);
        SendMessageToPC(oPC, "Dormendo hai ripreso forza e salute");
        ExecuteScript("mod_clas_poly_de",oPC);
        SetLocalInt(oPC,"metamorfosi",58);
        SetLocalInt(oPC,"SummonCap",0);
        SetLocalInt(oPC,"bevuta",0);
        SetLocalInt(oPC,"nDaze",0);
        SetLocalInt(oPC,"nTouch",0);
        SetLocalInt(oPC,"useammo",0);
        SetLocalInt(oPC,"nWrath",0);
        SetLocalInt(oPC,"nBreath",0);
        SetLocalInt(oPC,"nMKWrath",0);
        SetLocalInt(oPC,"b_1",0);
        DelayCommand(0.5,DistruggiPelle(oPC));
        int nBard = GetLevelByClass(CLASS_TYPE_BARD,oPC);
        if(GetHasFeat(FEAT_EXTRA_MUSIC,oPC)){
            nBard = nBard + 4;
        }
        SetLocalInt(oPC,"canto",nBard);
        effect eLoop = GetFirstEffect(oPC);
        while (GetIsEffectValid(eLoop)){
            if(GetEffectType(eLoop)==EFFECT_TYPE_SPELL_FAILURE)
                RemoveEffect(oPC,eLoop);
            eLoop=GetNextEffect(oPC);
        }
    }
    if (GetLastRestEventType() == REST_EVENTTYPE_REST_CANCELLED){
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY,EffectSpellFailure(100),oPC,6.0);
    }

}
