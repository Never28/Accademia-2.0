/*
  CREATO DA:      Tempesta
  DATA CREAZIONE: 17-06-2009
*/

// La funzione quando un giocatore sta morendo.

void VitaMorte(object oPC);

void VitaMorte(object oPC)
{
    effect eVis = EffectVisualEffect(VFX_COM_CHUNK_RED_LARGE);
    int nStab=GetLocalInt(oPC,"STABILIZZATO");
    if (GetCurrentHitPoints(oPC)>0){
        DeleteLocalInt(oPC,"STABILIZZATO");
        return;
    }
    if(GetCurrentHitPoints(oPC)<=-10){
        ApplyEffectToObject(DURATION_TYPE_INSTANT,EffectDeath(),oPC);
        return;
    }
    if (nStab){
        ApplyEffectToObject(DURATION_TYPE_INSTANT,EffectHeal(1),oPC);
        DelayCommand(6.0,VitaMorte(oPC));
        return;
    }
    else if (!nStab){
        if (GetCurrentHitPoints(oPC)>0){
            DeleteLocalInt(oPC,"STABILIZZATO");
            return;
        }
        if ((Random(99)+1)>75){
            SetLocalInt(oPC,"STABILIZZATO",TRUE);
            FloatingTextStringOnCreature("L'emorragia delle ferite si e' bloccata, lentamente riprendi coscenza..",oPC);
            DelayCommand(6.0,VitaMorte(oPC));
            return;
        }
        else if ((GetCurrentHitPoints()>-9)||(GetCurrentHitPoints()<=-1)){
            ApplyEffectToObject(DURATION_TYPE_INSTANT,EffectDamage(1),oPC);
            ApplyEffectToObject(DURATION_TYPE_INSTANT,eVis,oPC);
            switch(d3(1)){
                case 1:
                    PlayVoiceChat(VOICE_CHAT_HEALME);
                    break;
                case 2:
                    PlayVoiceChat(VOICE_CHAT_HELP);
                    break;
                case 3:
                    PlayVoiceChat(VOICE_CHAT_NEARDEATH);
                    break;
            }
            DelayCommand(6.0,VitaMorte(oPC));
            return;
        }
    }
    else if (GetCurrentHitPoints()==-9){
        ApplyEffectToObject(DURATION_TYPE_INSTANT,EffectDamage(1),oPC);
        ApplyEffectToObject(DURATION_TYPE_INSTANT,eVis,oPC);
      }
}

void main()
{
    object oPC=GetLastPlayerDying();
    object oMob=GetNearestCreature(CREATURE_TYPE_IS_ALIVE,TRUE,oPC,1);
    int i=1;
    while (oMob!=OBJECT_INVALID){
        if (GetIsEnemy(oPC,oMob))
            AssignCommand(oMob,ClearAllActions(TRUE));
        i++;
        oMob=GetNearestCreature(CREATURE_TYPE_IS_ALIVE,TRUE,oPC,i);
    }
    DelayCommand(6.0,VitaMorte(oPC));
}

