void SafeDestroyObject(object oObject){
    SetIsDestroyable(TRUE);
    DestroyObject(oObject);
}

void main()
{
    object oEnter = GetEnteringObject();
    int nSpot;
    if(GetIsInCombat(oEnter)==FALSE)
        nSpot = 20 + GetSkillRank(SKILL_SPOT,oEnter);
    else
        nSpot = d20(1) + GetSkillRank(SKILL_SPOT,oEnter);
    if(nSpot >= 65){
        object oDoor = GetObjectByTag("mod_door_troll");
        if(oDoor == OBJECT_INVALID){
            object oTap = GetObjectByTag("troll_door_t1");
            string sTap = GetTag(oTap);
            location lTap = GetLocation(oTap);
            object oDoor = CreateObject(OBJECT_TYPE_PLACEABLE,"mod_door_troll",lTap);
            AssignCommand(oEnter,ClearAllActions());
            AssignCommand(oEnter,PlayVoiceChat(VOICE_CHAT_LOOKHERE,oEnter));
            DelayCommand(60.0,SafeDestroyObject(oDoor));
        }
    }
}
