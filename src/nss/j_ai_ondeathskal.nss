#include "j_inc_constants"
#include "x2_inc_compon"
#include "mod_bas_sca_per"
#include "mod_bas_que_func"

int HitDiceByXP(object oPC2)
{
   int nHD=GetXP(oPC2);
   if (nHD < 1000) return 1;
   else if (nHD < 3000) return 2;
   else if (nHD < 6000) return 3;
   else if (nHD < 10000) return 4;
   else if (nHD < 15000) return 5;
   else if (nHD < 21000) return 6;
   else if (nHD < 28000) return 7;
   else if (nHD < 36000) return 8;
   else if (nHD < 45000) return 9;
   else if (nHD < 55000) return 10;
   else if (nHD < 66000) return 11;
   else if (nHD < 78000) return 12;
   else if (nHD < 91000) return 13;
   else if (nHD < 105000) return 14;
   else if (nHD < 120000) return 15;
   else if (nHD < 136000) return 16;
   else if (nHD < 153000) return 17;
   else if (nHD < 171000) return 18;
   else if (nHD < 190000) return 19;
   else if (nHD < 210000) return 20;
   else if (nHD < 231000) return 21;
   else if (nHD < 253000) return 22;
   else if (nHD < 276000) return 23;
   else if (nHD < 300000) return 24;
   else if (nHD < 325000) return 25;
   else if (nHD < 351000) return 26;
   else if (nHD < 378000) return 27;
   else if (nHD < 406000) return 28;
   else if (nHD < 435000) return 29;
   else if (nHD < 465000) return 30;
   else if (nHD < 496000) return 31;
   else if (nHD < 528000) return 32;
   else if (nHD < 561000) return 33;
   else if (nHD < 595000) return 34;
   else if (nHD < 630000) return 35;
   else if (nHD < 666000) return 36;
   else if (nHD < 703000) return 37;
   else if (nHD < 741000) return 38;
   else if (nHD < 780000) return 39;
   else return 40;
}
// We need a wrapper. If the amount of deaths, got in this, is not equal to iDeaths,
// we don't execute the script, else we do. :-P
void DeathCheck(int iDeaths);

void main()
{

    SetLocalInt(GetModule(),"skalmad",1);
    DelayCommand(900.0,SetLocalInt(GetModule(),"skalmad",0));
    int nRandomQ = d20(1);
    string sDoor = IntToString(nRandomQ);
    sDoor = "sk_" + sDoor;
    object oDoor = GetObjectByTag(sDoor);
    SetLocalInt(oDoor,"skalmad_quest",1);
    DelayCommand(900.0,SetLocalInt(oDoor,"skalmad_quest",0));
    int i;
    for(i=0;i<21;i++){
        sDoor = "sk_"+IntToString(i);
        oDoor = GetObjectByTag(sDoor);
        SetLockKeyRequired(oDoor,FALSE);
        SetLocked(oDoor,FALSE);
        DelayCommand(899.0,SetLocked(oDoor,TRUE));
        DelayCommand(900.0,SetLockKeyRequired(oDoor,TRUE));
    }
    // If we are set to, don't fire this script at all
    if(GetAIInteger(I_AM_TOTALLY_DEAD)) return;

    // Pre-death-event
    if(FireUserEvent(AI_FLAG_UDE_DEATH_PRE_EVENT, EVENT_DEATH_PRE_EVENT))
        // We may exit if it fires
        if(ExitFromUDE(EVENT_DEATH_PRE_EVENT)) return;

    // Note: No AI on/off check here.

    // Who killed us? (alignment changing, debug, XP).
    object oKiller = GetLastKiller();
    // Stops if we just applied EffectDeath to ourselves.
    if(GetLocalTimer(AI_TIMER_DEATH_EFFECT_DEATH)) return;

    // Special: To stop giving out multiple amounts of XP, we use EffectDeath
    // to change the killer, so the XP systems will NOT award MORE XP.
    // - Even the default one suffers from this!
    if(GetAIInteger(WE_HAVE_DIED_ONCE))
    {
        if(!GetLocalTimer(AI_TIMER_DEATH_EFFECT_DEATH))
        {
            // Don't apply effect death to self more then once per 2 seconds.
            SetLocalTimer(AI_TIMER_DEATH_EFFECT_DEATH, f2);
            // This should make the last killer us.
            ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectResurrection(), OBJECT_SELF);
            ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectDamage(GetMaxHitPoints()), OBJECT_SELF);
        }
    }
    else if(oKiller != OBJECT_SELF)
    {
        SetAIInteger(WE_HAVE_DIED_ONCE, TRUE);
  object oKiller = GetLastKiller();
  object oPC2;
  object oArea = GetArea(oKiller);
  SetLocalInt(OBJECT_SELF,"scalcare",1);
  DelayCommand(300.0,DeleteLocalInt(OBJECT_SELF,"scalcare"));
  int nAlign = GetAlignmentGoodEvil(OBJECT_SELF);
  int iGP = 30;
  int iPx = 18;
  int iMaxPx = 480;
  float fCR = GetChallengeRating(OBJECT_SELF);
  int iCR = FloatToInt(fCR);
  int iGPT = iGP * iCR - HitDiceByXP(oKiller);


 int iDouble=1;
 oPC2 = GetFirstFactionMember(oKiller,TRUE);
 while (oPC2 != OBJECT_INVALID)
 {
      if (GetXP(oPC2)>=190001) {
         iDouble=0;
         break;
      }
      oPC2 = GetNextFactionMember(oKiller,TRUE);
 }

 int iMO=0;
 int iXP=0;

if (GetIsObjectValid(GetMaster(oKiller)))
   {
   oKiller=GetMaster(oKiller);
   }
 int Minimo=HitDiceByXP(oKiller)-10;
 if (Minimo<1) Minimo=1;
 int Massimo=HitDiceByXP(oKiller)+10;
 if (Massimo>40)Massimo=40;
 oPC2 = GetFirstFactionMember(oKiller,TRUE);

 while (oPC2 != OBJECT_INVALID){
    if (GetIsPC(oPC2)){
        if(GetArea(oPC2)==oArea){
            string sRef = GetResRef(OBJECT_SELF);
            int nScalc = GetLocalInt(OBJECT_SELF,"scalcare");
            if(nScalc == 1)
                Scalcare(oPC2,GetTag(OBJECT_SELF),GetResRef(OBJECT_SELF),0);
            string sQuest = GetLocalString(OBJECT_SELF,"quest");
            int nQuest = LetturaQuest(StringToInt(sQuest),oPC2);
            if(nQuest == 0){
                AddJournalQuestEntry("quest_"+sQuest,1,oPC2,FALSE);
                ScritturaQuest("1",StringToInt(sQuest),oPC2);
            }
            else if(nQuest == 1)
                SendMessageToPC(oPC2,"Hai gia' completato la quest, ma devi ancora parlare con il tuo mandante per la ricompensa, affrettati");
        }
        if (GetArea(oPC2) == oArea && GetCurrentHitPoints(oPC2)>0) {
            if(GetLevelByClass(CLASS_TYPE_DRUID,oPC2)==40 && GetAppearanceType(oPC2)==APPEARANCE_TYPE_ALLIP)
                ApplyEffectToObject(DURATION_TYPE_INSTANT,EffectHeal(GetHitDice(OBJECT_SELF)),oPC2);
            iMO=iGPT;
            iXP=(iPx*iCR)-(5*HitDiceByXP(oPC2));
            //se tutti hanno liv<20, aumenta l'exp a tutti
            if(iDouble) iXP=iXP + 10;
            //se solo pg ha liv><20, aumenta la sua exp
            if(HitDiceByXP(oPC2)<=20) iXP=iXP + 37;
            //altre regole
            if((HitDiceByXP(oPC2)-iCR)<=5)
                iXP=iXP;
            else if((HitDiceByXP(oPC2)-iCR)>5)
                iXP=(iXP)/6;
            //cap, se serve
            if (iGPT < 1)
                iGPT= 1;
            if (iXP <1)
               iXP = 1;
            if (iXP >iMaxPx)
               iXP = iMaxPx;
            if((GetIsPC(oPC2))&&((HitDiceByXP(oPC2)>Massimo)||(HitDiceByXP(oPC2)<Minimo)))
                SendMessageToPC(oPC2,"Troppa Differenza di Livello tra i Giocatori");
            else
                    GiveXPToCreature(oPC2,iXP);
        }
    }
    oPC2 = GetNextFactionMember(oKiller,TRUE);
}

    // Note: Here we do a simple way of checking how many times we have died.
    // Nothing special. Debugging most useful aspect.
    int iDeathCounterNew = GetAIInteger(AMOUNT_OF_DEATHS);
    iDeathCounterNew++;
    SetAIInteger(AMOUNT_OF_DEATHS, iDeathCounterNew);

    // Here is the last time (in game seconds) we died. It is used in the executed script
    // to make sure we don't prematurly remove areselves.

    // We may want some sort of visual effect - like implosion or something, to fire.
    int iDeathEffect = GetAIConstant(AI_DEATH_VISUAL_EFFECT);

    // Valid constants from 0 and up. Apply to our location (not to us, who will go!)
    if(iDeathEffect >= i0)
    {
        ApplyEffectAtLocation(DURATION_TYPE_INSTANT, EffectVisualEffect(iDeathEffect), GetLocation(OBJECT_SELF));
    }

    // Always shout when we are killed. Reactions - Morale penalty, and attack the killer.
    AISpeakString(I_WAS_KILLED);

    // Speaks the set death speak, like "AGGGGGGGGGGGGGGGGGGG!! NOOOO!" for instance :-)
    SpeakArrayString(AI_TALK_ON_DEATH);

    // First check - do we use "destroyable corpses" or not? (default, yes)
    if(!GetSpawnInCondition(AI_FLAG_OTHER_TURN_OFF_CORPSES, AI_OTHER_MASTER))
    {
        // We will actually dissapear after 1.0 seconds if not raised.
        int iTime = 0;
        if(iTime == i0) // Error checking
        {
            iTime = i2;
        }
        // 64: "[Death] Checking corpse status in " + IntToString(iTime) + " [Killer] " + GetName(oKiller) + " [Times Died Now] " + IntToString(iDeathCounterNew)
        DebugActionSpeakByInt(64, oKiller, iTime, IntToString(iDeathCounterNew));
        // Delay check
        DelayCommand(IntToFloat(iTime), DeathCheck(iDeathCounterNew));
    }
    else
    {
/************************ [Alternative Corpses] ********************************
    This is where you can add some alternative corpse code - EG looting
    and so on, without disrupting the rest of the AI (as the corpses
    are turned off).
************************* [Alternative Corpses] *******************************/
    // Add alternative corpse code here

       craft_drop_items(OBJECT_SELF);



/************************ [Alternative Corpses] *******************************/
    }
    // Signal the death event.
    FireUserEvent(AI_FLAG_UDE_DEATH_EVENT, EVENT_DEATH_EVENT);
    }
}

// We need a wrapper. If the amount of deaths, got in this, is not equal to iDeaths,
// we don't execute the script, else we do. :-P
void DeathCheck(int iDeaths)
{
    // Do the deaths imputted equal the amount we have suffered?
    if(GetAIInteger(AMOUNT_OF_DEATHS) == iDeaths)
    {
        // - This now includes a check for Bioware's lootable functions and using them.
        ExecuteScript(FILE_DEATH_CLEANUP, OBJECT_SELF);
    }

}
