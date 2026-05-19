void StatuaTvT(object oStatua){
    if(GetIsObjectValid(oStatua)==TRUE){
        int nControll = 0;
        object oTarget2 = OBJECT_INVALID;
        object oTarget = GetFirstObjectInShape(SHAPE_SPHERE,10.0,GetLocation(oStatua),TRUE,OBJECT_TYPE_CREATURE);
        while(oTarget!=OBJECT_INVALID&&nControll==0){
            if(GetIsPC(oTarget)==TRUE&&GetIsDead(oTarget)==FALSE){
                string sTotale = GetLocalString(oTarget,"gilda");
                string sFaction = GetSubString(sTotale,3,3);
                string sTurret = GetSubString(GetTag(oStatua),6,4);
                if(sFaction == "goo" && sTurret == "evil" && nControll == 0){
                    oTarget2 = oTarget;
                    nControll = 1;
                }
                else if(sFaction == "evi" && sTurret == "good" && nControll == 0){
                    oTarget2 = oTarget;
                    nControll = 1;
                }
            }
            else{
                if(GetIsDead(oTarget)==FALSE){
                    string sFaction = GetSubString(GetTag(oTarget),10,3);
                    string sTurret = GetSubString(GetTag(oStatua),6,4);
                    if(sFaction == "buo" && sTurret == "evil" && nControll == 0){
                        oTarget2 = oTarget;
                        nControll = 1;
                    }
                    else if(sFaction == "mal" && sTurret == "good" && nControll == 0){
                        oTarget2 = oTarget;
                        nControll = 1;
                    }
                }
            }
            oTarget = GetNextObjectInShape(SHAPE_SPHERE,10.0,GetLocation(oStatua),TRUE,OBJECT_TYPE_CREATURE);
        }
        if(GetIsObjectValid(oTarget2)==TRUE){
            int nDamage = 200;
            float fDist = GetDistanceBetween(oStatua, oTarget2);
            float fDelay = fDist/(3.0 * log(fDist) + 2.0);
            effect eVis = EffectVisualEffect(VFX_IMP_FLAME_M);
            effect eVis2 = EffectVisualEffect(VFX_FNF_FIREBALL);
            AssignCommand(oStatua,ActionCastFakeSpellAtObject(SPELL_FIREBALL, oTarget2, PROJECTILE_PATH_TYPE_BALLISTIC));
            DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eVis, oTarget2));
            DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eVis2, oTarget2));
            effect eDamage = EffectDamage(nDamage,DAMAGE_TYPE_MAGICAL);
            DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT,eDamage,oTarget2));
        }
        DelayCommand(6.0,StatuaTvT(oStatua));
    }
}

void main()
{
    object oStatua = OBJECT_SELF;
    if(GetIsObjectValid(oStatua)==TRUE)
        DelayCommand(6.0,StatuaTvT(oStatua));
}
