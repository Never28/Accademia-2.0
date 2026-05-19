void SafeDestroyObject(object oObject){
    SetIsDestroyable(TRUE);
    if(GetPlotFlag(oObject)) { DelayCommand(0.0,SetPlotFlag(oObject, FALSE)); }
    if(GetImmortal(oObject)) { DelayCommand(0.0,SetImmortal(oObject, FALSE)); }
    if(!GetDroppableFlag(oObject)) { DelayCommand(0.0,SetDroppableFlag(oObject, TRUE)); }
    DestroyObject(oObject);
}

void main()
{
        object oArmaSpec = OBJECT_SELF;
        object oPC = GetLocalObject(oArmaSpec,"Tirante");
        float fCurrentFacing = GetFacing(oArmaSpec)+90.0;
        if(fCurrentFacing>360.0)
            fCurrentFacing = fCurrentFacing-360.0;
        vector vCurrentPosition = GetPosition(oArmaSpec);
        vector vDelta;
        vDelta.x = cos(fCurrentFacing) * 30.0;
        vDelta.y = sin(fCurrentFacing) * 30.0;
        vector vImpact;
        vImpact.x = vCurrentPosition.x + vDelta.x;
        vImpact.y = vCurrentPosition.y + vDelta.y;
        location lImpact = Location(GetArea(oArmaSpec), vImpact, fCurrentFacing);
        object oTarget = GetFirstObjectInShape(SHAPE_SPELLCONE,30.0,lImpact,TRUE,OBJECT_TYPE_CREATURE);
        while(GetIsEnemy(oTarget,oPC)==FALSE&&oTarget!=OBJECT_INVALID){
            oTarget = GetNextObjectInShape(SHAPE_SPELLCONE,30.0,lImpact,TRUE,OBJECT_TYPE_CREATURE);
        }
        location lArma = GetLocation(oArmaSpec);
        if(GetIsEnemy(oTarget,oPC)==TRUE){
            int nCasterLevel = GetLevelByClass(CLASS_TYPE_BARD,oPC)+GetLevelByClass(CLASS_TYPE_HARPER,oPC);
            int nSkill = GetSkillRank(SKILL_CRAFT_WEAPON,oPC,TRUE);
            int nBonus = 0;
            int nDamage;
            if(nCasterLevel>=40 && nSkill>=43 && GetItemPossessedBy(oPC,"mod_clas_al") != OBJECT_INVALID){
                nBonus = 20;
            }
            else if(nCasterLevel>=31 && nSkill>=34){
                nBonus = 15;
            }
            else if(nCasterLevel>=21 && nSkill>=24){
                nBonus = 10;
            }
            else if(nCasterLevel>=15 && nSkill>=14){
                nBonus = 5;
            }
            else{
                nBonus = 1;
            }
            int nAC = GetAC(oTarget);
            int nAttack = GetBaseAttackBonus(oPC);
            int nForza = GetAbilityModifier(ABILITY_STRENGTH,oPC);
            int nDex = GetAbilityModifier(ABILITY_DEXTERITY,oPC);
            if(nForza > nDex)
                nAttack = nAttack + nForza;
            else
                nAttack = nAttack + nDex;
            nAttack = nAttack + nBonus;
            nAttack = d20(1) + nAttack;
            if(nAttack>=nAC){
                float fDist = GetDistanceBetween(oArmaSpec, oTarget);
                float fDelay = fDist/(3.0 * log(fDist) + 2.0);
                effect eVis = EffectVisualEffect(VFX_COM_CHUNK_RED_BALLISTA);
                AssignCommand(oArmaSpec,ActionCastFakeSpellAtObject(SPELL_TRAP_ARROW, oTarget, PROJECTILE_PATH_TYPE_BALLISTIC));
                SetLocalObject(oPC,"Balista_Target",oTarget);
                DelayCommand(fDelay,ExecuteScript("mod_clas_har_d",oPC));
                DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eVis, oTarget));
            }
            else{
                AssignCommand(oArmaSpec,ActionCastFakeSpellAtObject(SPELL_TRAP_ARROW, oTarget, PROJECTILE_PATH_TYPE_BALLISTIC));
            }
            if(d20(1)==1){
                ApplyEffectToObject(DURATION_TYPE_INSTANT,EffectVisualEffect(VFX_COM_CHUNK_STONE_MEDIUM),oArmaSpec);
                SendMessageToPC(oPC,"La Balista si e' rotta");
                AssignCommand(oArmaSpec,SpeakString("La Balista si e' rotta"));
                DelayCommand(0.5,SafeDestroyObject(oArmaSpec));
                return;
            }
        }
}

