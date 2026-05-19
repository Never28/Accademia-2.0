void main()
{
    object oPC = OBJECT_SELF;
    object oTarget = GetItemActivatedTarget();
    int nAlign = GetAlignmentGoodEvil(oTarget);
    if(GetIsFriend(oTarget,oPC)==FALSE){
        if(nAlign == ALIGNMENT_EVIL){
            int nLevel = 30;
            if(GetHasFeat(FEAT_EPIC_GREAT_SMITING_10,oPC) == TRUE)
                nLevel = nLevel + 300;
            else if(GetHasFeat(FEAT_EPIC_GREAT_SMITING_9,oPC) == TRUE)
                nLevel = nLevel + 270;
            else if(GetHasFeat(FEAT_EPIC_GREAT_SMITING_8,oPC) == TRUE)
                nLevel = nLevel + 240;
            else if(GetHasFeat(FEAT_EPIC_GREAT_SMITING_7,oPC) == TRUE)
                nLevel = nLevel + 210;
            else if(GetHasFeat(FEAT_EPIC_GREAT_SMITING_6,oPC) == TRUE)
                nLevel = nLevel + 180;
            else if(GetHasFeat(FEAT_EPIC_GREAT_SMITING_5,oPC) == TRUE)
                nLevel = nLevel + 150;
            else if(GetHasFeat(FEAT_EPIC_GREAT_SMITING_4,oPC) == TRUE)
                nLevel = nLevel + 120;
            else if(GetHasFeat(FEAT_EPIC_GREAT_SMITING_3,oPC) == TRUE)
                nLevel = nLevel + 90;
            else if(GetHasFeat(FEAT_EPIC_GREAT_SMITING_2,oPC) == TRUE)
                nLevel = nLevel + 60;
            else if(GetHasFeat(FEAT_EPIC_GREAT_SMITING_1,oPC) == TRUE)
                nLevel = nLevel + 30;
            int nChar = GetAbilityModifier(ABILITY_CHARISMA,oPC);
            int nAB = GetBaseAttackBonus(oPC);
            int nAC = GetAC(oTarget);
            int nAttack = d20(1) + nAB + nChar +10;
            if(nAttack >= nAC){
                int nDC = 50;
                effect eDamage = EffectDamage(nLevel,DAMAGE_TYPE_POSITIVE);
                effect eVis = EffectVisualEffect(VFX_IMP_HEALING_X);
                eDamage = EffectLinkEffects(eVis,eDamage);
                if(WillSave(oTarget,nDC,SAVING_THROW_TYPE_POSITIVE,oPC)==0){
                    effect eDeath = ExtraordinaryEffect(EffectDeath(TRUE));
                    effect eVis2 = EffectVisualEffect(VFX_IMP_DEATH);
                    eDeath = EffectLinkEffects(eDeath,eVis2);
                    DelayCommand(2.0,ApplyEffectToObject(DURATION_TYPE_INSTANT,eDeath,oTarget,0.0));
                }
                DelayCommand(0.5,ApplyEffectToObject(DURATION_TYPE_INSTANT,eDamage,oTarget,0.0));
            }
            else
                SendMessageToPC(oPC,"Bersaglio Mancato");
        }
        else
            SendMessageToPC(oPC,"Bersaglio di Allineamento non Malvagio");
    }
    else
        SendMessageToPC(oPC,"Bersaglio Amico");
}
