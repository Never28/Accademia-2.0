// Name     : DeleteChar include
// Purpose  : Delete character file from the server vault
// Authors  : Sean Anaya
// Modified : January, 19, 2005

// This file is licensed under the terms of the
// GNU GENERAL PUBLIC LICENSE (GPL) Version 2

/************************************/
/* Function prototypes              */
/************************************/

// Delete character file from the server vault
void deletechar(string sPlayerName, string sCharName);


/************************************/
/* Implementation                   */
/************************************/

void deletechar(string sPlayerName, string sCharName)
{
  object oModule = GetModule();
  SetLocalString(oModule, "NWNX!DELETECHAR!DELETE", sPlayerName + "?" + sCharName);
}

void main()
{
    object oPC = GetPCSpeaker();
    string sLogin = GetPCPlayerName(oPC);
    string sCharacter = GetName(oPC);
    DeleteLocalString(oPC,"quest");
    DeleteCampaignVariable("accademia_new","quest",oPC);
    FloatingTextStringOnCreature("Operazione effettuato con successo.",oPC,FALSE);
    CreateItemOnObject("deletemeplease", oPC);
    ApplyEffectToObject(DURATION_TYPE_INSTANT,EffectVisualEffect(VFX_FNF_PWKILL,FALSE),oPC);
    AssignCommand(oPC, SpeakString("Addio Mondo Crudele!"));
    DelayCommand(2.0, BootPC(oPC));
    DelayCommand(2.5, deletechar(sLogin,sCharacter));
}
