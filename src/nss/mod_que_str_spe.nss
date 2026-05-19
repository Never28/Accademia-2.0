void main()
{
    int nNumberSpell = GetLocalInt(GetModule(),"Quest_Strega_Spell");
    object oPC = GetLastUsedBy();
    int nSkill = d20(20)+GetSkillRank(SKILL_SPELLCRAFT,oPC);
    if(nSkill >= 70){
        if(nNumberSpell!=3){
            AssignCommand(OBJECT_SELF,SpeakString("L'altare presenta tre gemme che sembrano reagire agli incantesimi. Forse la giusta sequenza può liberare l'ingresso"));
        }
        else{
            AssignCommand(OBJECT_SELF,SpeakString("L'ingresso e' gia' aperto.."));
        }
    }
    else{
        AssignCommand(OBJECT_SELF,SpeakString("Questo altare davanti alla caverna emana una strana aura magica. forse ha a che fare con l'entrata della caverna"));
    }
}

