void main()
{
    object oPC = GetExitingObject();
    int nEffectType;
    if(GetTag(OBJECT_SELF) == "dun_che_mag"){
        effect eLoop = GetFirstEffect(oPC);
        SetLocalInt(oPC,"NUMEROANNEGAMENTI",1);
        SetLocalInt(oPC,"STOANNEGANDO",0);
        SetLocalInt(oPC,"ANNEGARE",8);
        int nAspect = GetAppearanceType(oPC);
        while (GetIsEffectValid(eLoop)){
            nEffectType = GetEffectType(eLoop);
            if (nEffectType == EFFECT_TYPE_ARCANE_SPELL_FAILURE &&
            (nAspect != APPEARANCE_TYPE_DOG_WOLF &&
            nAspect != APPEARANCE_TYPE_BADGER &&
            nAspect != APPEARANCE_TYPE_BOAR &&
            nAspect != APPEARANCE_TYPE_BEAR_BROWN &&
            nAspect != APPEARANCE_TYPE_CAT_PANTHER &&
            nAspect != APPEARANCE_TYPE_BEAR_DIRE &&
            nAspect != APPEARANCE_TYPE_BADGER_DIRE &&
            nAspect != APPEARANCE_TYPE_DOG_DIRE_WOLF &&
            nAspect != APPEARANCE_TYPE_CAT_MPANTHER &&
            nAspect != APPEARANCE_TYPE_BOAR_DIRE &&
            nAspect != APPEARANCE_TYPE_CAT_CAT_DIRE &&
            nAspect != APPEARANCE_TYPE_BEETLE_STINK &&
            nAspect != APPEARANCE_TYPE_SPIDER_GIANT &&
            nAspect != APPEARANCE_TYPE_BEETLE_STAG &&
            nAspect != APPEARANCE_TYPE_SPIDER_DIRE &&
            nAspect != APPEARANCE_TYPE_SPIDER_DEMON &&
            nAspect != APPEARANCE_TYPE_ELEMENTAL_FIRE &&
            nAspect != APPEARANCE_TYPE_ELEMENTAL_WATER &&
            nAspect != APPEARANCE_TYPE_ELEMENTAL_AIR &&
            nAspect != APPEARANCE_TYPE_ELEMENTAL_EARTH &&
            nAspect != APPEARANCE_TYPE_ELEMENTAL_FIRE_ELDER &&
            nAspect != APPEARANCE_TYPE_ELEMENTAL_WATER_ELDER &&
            nAspect != APPEARANCE_TYPE_ELEMENTAL_AIR_ELDER &&
            nAspect != APPEARANCE_TYPE_ELEMENTAL_EARTH_ELDER &&
            nAspect != APPEARANCE_TYPE_BASILISK &&
            nAspect != APPEARANCE_TYPE_CAT_KRENSHAR &&
            nAspect != APPEARANCE_TYPE_MANTICORE &&
            nAspect != APPEARANCE_TYPE_GOLEM_IRON &&
            nAspect != APPEARANCE_TYPE_GOLEM_BONE &&
            nAspect != APPEARANCE_TYPE_GOLEM_DEMONFLESH &&
            nAspect != APPEARANCE_TYPE_GOLEM_MITHRAL &&
            nAspect != APPEARANCE_TYPE_GOLEM_ADAMANTIUM &&
            nAspect != 183 &&
            nAspect != 178))
                RemoveEffect(oPC,eLoop);
            if (nEffectType == EFFECT_TYPE_MOVEMENT_SPEED_DECREASE || nEffectType == EFFECT_TYPE_SLOW)
                RemoveEffect(oPC,eLoop);
            eLoop = GetNextEffect(oPC);
        }
    }
}
