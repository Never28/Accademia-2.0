void main()
{
    object oPC = OBJECT_SELF;
    object oSpellTarget = GetLocalObject(oPC,"mod_clas_cv3");
    int nDamage;
    float fTempo;
    effect eImpact;
    SetCutsceneMode(oPC);
    SpeakString("CARICA!!!!!");
    fTempo = GetDistanceBetween(oPC,oSpellTarget)*0.3;
    nDamage = FloatToInt(GetDistanceBetween(oPC,oSpellTarget))*20;
    eImpact = EffectDamage(nDamage,DAMAGE_TYPE_SLASHING);
    DelayCommand(0.0,AssignCommand(oPC,ClearAllActions()));
    DelayCommand(0.0,AssignCommand(oPC,ActionForceMoveToObject(oSpellTarget,TRUE)));
    ApplyEffectToObject(DURATION_TYPE_TEMPORARY,EffectMovementSpeedIncrease(99),oPC,fTempo);
    ApplyEffectToObject(DURATION_TYPE_TEMPORARY,EffectVisualEffect(VFX_DUR_SMOKE),oPC,fTempo);
    DelayCommand(fTempo,ApplyEffectToObject(DURATION_TYPE_INSTANT,EffectVisualEffect(VFX_IMP_BREACH),oSpellTarget));
    DelayCommand(fTempo,ApplyEffectToObject(DURATION_TYPE_INSTANT,eImpact,oSpellTarget));
    DelayCommand(fTempo,SetCutsceneMode(oPC,FALSE));
    DeleteLocalObject(oPC,"mod_clas_cv3");
}

