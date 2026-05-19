#include "NW_I0_SPELLS"


void main()
{
    object oPC = OBJECT_SELF;
    SignalEvent(oPC, EventSpellCastAt(OBJECT_SELF, GetSpellId()));
    int nShad = GetLevelByClass(CLASS_TYPE_DRAGON_DISCIPLE,oPC);
    int nUseDaze = nShad/1;
    if(nUseDaze < 1)
        nUseDaze = 1;
    if(GetItemPossessedBy(oPC,"mod_clas_drred")!=OBJECT_INVALID)
        AssignCommand(oPC,ActionCastSpellAtLocation(SPELLABILITY_DRAGON_BREATH_FIRE, GetSpellTargetLocation(), METAMAGIC_ANY, TRUE, PROJECTILE_PATH_TYPE_DEFAULT, TRUE));
    else if(GetItemPossessedBy(oPC,"mod_clas_drbla")!=OBJECT_INVALID)
        AssignCommand(oPC,ActionCastSpellAtLocation(SPELLABILITY_DRAGON_BREATH_ACID, GetSpellTargetLocation(), METAMAGIC_ANY, TRUE, PROJECTILE_PATH_TYPE_DEFAULT, TRUE));
    else if(GetItemPossessedBy(oPC,"mod_clas_drgre")!=OBJECT_INVALID)
        AssignCommand(oPC,ActionCastSpellAtLocation(SPELLABILITY_DRAGON_BREATH_GAS, GetSpellTargetLocation(), METAMAGIC_ANY, TRUE, PROJECTILE_PATH_TYPE_DEFAULT, TRUE));
    else if(GetItemPossessedBy(oPC,"mod_clas_drblu")!=OBJECT_INVALID)
        AssignCommand(oPC,ActionCastSpellAtLocation(SPELLABILITY_DRAGON_BREATH_LIGHTNING, GetSpellTargetLocation(), METAMAGIC_ANY, TRUE, PROJECTILE_PATH_TYPE_DEFAULT, TRUE));
    else if(GetItemPossessedBy(oPC,"mod_clas_drwhi")!=OBJECT_INVALID)
        AssignCommand(oPC,ActionCastSpellAtLocation(SPELLABILITY_DRAGON_BREATH_COLD, GetSpellTargetLocation(), METAMAGIC_ANY, TRUE, PROJECTILE_PATH_TYPE_DEFAULT, TRUE));
    else if(GetItemPossessedBy(oPC,"mod_clas_droro")!=OBJECT_INVALID)
        AssignCommand(oPC,ActionCastSpellAtLocation(SPELLABILITY_DRAGON_BREATH_WEAKEN, GetSpellTargetLocation(), METAMAGIC_ANY, TRUE, PROJECTILE_PATH_TYPE_DEFAULT, TRUE));
    else if(GetItemPossessedBy(oPC,"mod_clas_drarg")!=OBJECT_INVALID)
        AssignCommand(oPC,ActionCastSpellAtLocation(SPELLABILITY_DRAGON_BREATH_PARALYZE, GetSpellTargetLocation(), METAMAGIC_ANY, TRUE, PROJECTILE_PATH_TYPE_DEFAULT, TRUE));
    else if(GetItemPossessedBy(oPC,"mod_clas_drbro")!=OBJECT_INVALID)
        AssignCommand(oPC,ActionCastSpellAtLocation(SPELLABILITY_DRAGON_BREATH_FEAR, GetSpellTargetLocation(), METAMAGIC_ANY, TRUE, PROJECTILE_PATH_TYPE_DEFAULT, TRUE));
    else if(GetItemPossessedBy(oPC,"mod_clas_drott")!=OBJECT_INVALID)
        AssignCommand(oPC,ActionCastSpellAtLocation(SPELLABILITY_DRAGON_BREATH_SLEEP, GetSpellTargetLocation(), METAMAGIC_ANY, TRUE, PROJECTILE_PATH_TYPE_DEFAULT, TRUE));
    else if(GetItemPossessedBy(oPC,"mod_clas_drram")!=OBJECT_INVALID)
        AssignCommand(oPC,ActionCastSpellAtLocation(SPELLABILITY_DRAGON_BREATH_SLOW, GetSpellTargetLocation(), METAMAGIC_ANY, TRUE, PROJECTILE_PATH_TYPE_DEFAULT, TRUE));
    if(GetLocalInt(oPC,"nBreath")<nUseDaze)IncrementRemainingFeatUses(oPC,FEAT_DRAGON_DIS_BREATH);
        SetLocalInt(oPC,"nBreath",GetLocalInt(oPC,"nBreath")+1);
}





