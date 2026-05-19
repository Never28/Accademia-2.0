 void main()
{
    object oPC = OBJECT_SELF;
    location lLocation = GetLocation(oPC);
    int nFor,nDex,nCon,nHit,nDamage;
    DelayCommand(1.0,ApplyEffectAtLocation(DURATION_TYPE_INSTANT,EffectVisualEffect(VFX_FNF_HOWL_MIND),lLocation,3.0));
    DelayCommand(2.0,ApplyEffectAtLocation(DURATION_TYPE_INSTANT,EffectVisualEffect(VFX_FNF_HOWL_MIND),lLocation,3.0));
    DelayCommand(3.0,ApplyEffectAtLocation(DURATION_TYPE_INSTANT,EffectVisualEffect(VFX_FNF_HOWL_MIND),lLocation,3.0));
    SpeakString("Tornado di Lame!");
    nFor = GetAbilityModifier(ABILITY_STRENGTH);
    nDex = GetAbilityModifier(ABILITY_DEXTERITY);
    nCon = 0;
    nHit = 0;
    object oTarget = GetFirstObjectInShape(SHAPE_SPHERE, 10.0, lLocation, TRUE);
    while(GetIsObjectValid(oTarget)){
        if(oTarget != OBJECT_SELF && GetIsEnemy(oTarget,oPC)){
            DelayCommand(3.0,ActionCastFakeSpellAtObject(498, oPC, PROJECTILE_PATH_TYPE_DEFAULT));
            nDamage = nFor;
            if(nFor<nDex){
                nCon = 1;
                nDamage = nDex;
            }
            if(nCon == 1)
                nHit = TouchAttackRanged(oTarget);
            else
                nHit = TouchAttackMelee(oTarget);
            if(nHit == 1 || nHit == 2){
                DelayCommand(1.0,ApplyEffectToObject(DURATION_TYPE_INSTANT,EffectVisualEffect(VFX_IMP_FROST_L),oTarget));
                DelayCommand(1.0,ApplyEffectToObject(DURATION_TYPE_INSTANT,EffectDamage(nDamage*3,DAMAGE_TYPE_PIERCING),oTarget,0.0));
                if(nCon == 1)
                    nHit = TouchAttackRanged(oTarget);
                else
                    nHit = TouchAttackMelee(oTarget);
                if(nHit == 1 || nHit == 2){
                    DelayCommand(2.0,ApplyEffectToObject(DURATION_TYPE_INSTANT,EffectVisualEffect(VFX_IMP_FROST_L),oTarget));
                    DelayCommand(2.0,ApplyEffectToObject(DURATION_TYPE_INSTANT,EffectDamage(nDamage*6,DAMAGE_TYPE_PIERCING),oTarget,0.0));
                    if(nCon == 1)
                        nHit = TouchAttackRanged(oTarget);
                    else
                        nHit = TouchAttackMelee(oTarget);
                    if(nHit == 1 || nHit == 2){
                        DelayCommand(3.0,ApplyEffectToObject(DURATION_TYPE_INSTANT,EffectVisualEffect(VFX_IMP_FROST_L),oTarget));
                        DelayCommand(3.0,ApplyEffectToObject(DURATION_TYPE_INSTANT,EffectDamage(nDamage*9,DAMAGE_TYPE_PIERCING),oTarget,0.0));
                    }
                }
            }
        }
        oTarget = GetNextObjectInShape(SHAPE_SPHERE, 10.0, lLocation, TRUE);
    }
}
