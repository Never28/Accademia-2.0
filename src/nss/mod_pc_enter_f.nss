/*
  CREATO DA:      Tempesta
  DATA CREAZIONE: 17-06-2009
*/

// La funzione quando entra per la prima volta.

#include "mod_bas_que_func"

void main()
{
    // Il giocatore che entra.
    object oPC = OBJECT_SELF;
    InizializzioneQuest(oPC);
    DelayCommand(3.0,FloatingTextStringOnCreature("<cттт> Benvenuto nella Costa della Spada " + GetName(oPC)+" !",oPC,TRUE));
    DelayCommand(6.0,FloatingTextStringOnCreature("<cттт> Nelle terre di Baldur's Gate potrai scrivere la tua leggenda! ",oPC,TRUE));
    DelayCommand(9.0,FloatingTextStringOnCreature("<cттт> Leggi il libro di Alaundo nel tuo inventario per sapere tutto su questo server!",oPC,TRUE));
    DelayCommand(9.0,ApplyEffectToObject(DURATION_TYPE_INSTANT,EffectVisualEffect(VFX_FNF_UNDEAD_DRAGON),oPC));

    // Il nome del Database.
    string oModulo = "modulo";
    GiveGoldToCreature(oPC,8000);
    // Scandagliamo l'inventario e cancelliamo tutti gli item base inutili.
    object oChest = GetItemInSlot(INVENTORY_SLOT_CHEST,oPC);
        DestroyObject(oChest,0.0);
    object oItem = GetFirstItemInInventory(oPC);
    while(oItem != OBJECT_INVALID){
        DestroyObject(oItem,0.0);
        oItem = GetNextItemInInventory(oPC);
    }
    if((GetLevelByClass(CLASS_TYPE_RANGER,oPC)>0||GetLevelByClass(CLASS_TYPE_ROGUE,oPC)>0) && GetItemPossessedBy(oPC,"trap_disable")==OBJECT_INVALID)
        CreateItemOnObject("trap_disable",oPC);
    if (GetItemPossessedBy(oPC,"mod_clas_songsle")==OBJECT_INVALID && GetLevelByClass(CLASS_TYPE_BARD,oPC)==1)
        CreateItemOnObject("mod_clas_songsle",oPC);
    // Diamo tutti gli item necessari per giocare.
    CreateItemOnObject("mod_bas_dadi",oPC);
    CreateItemOnObject("mod_bas_sarto",oPC);
    CreateItemOnObject("mod_bas_bookrule",oPC);
    CreateItemOnObject("mod_bas_bookmod",oPC);
    CreateItemOnObject("mod_bas_tele",oPC);
    CreateItemOnObject("dmfi_pc_follow",oPC);
    CreateItemOnObject("mod_bas_sca",oPC);
    object oVes = CreateItemOnObject("mod_bas_ini",oPC);
    AssignCommand(oPC,ActionEquipItem(oVes,INVENTORY_SLOT_CHEST));
    int Race = GetAppearanceType(oPC);
    switch (Race){
        case APPEARANCE_TYPE_ELF:
            CreateItemOnObject("hlslang_1",oPC);
            break;
        case APPEARANCE_TYPE_GNOME:
            CreateItemOnObject("hlslang_2",oPC);
            break;
        case APPEARANCE_TYPE_HALFLING:
            CreateItemOnObject("hlslang_3",oPC);
            break;
        case APPEARANCE_TYPE_DWARF:
            CreateItemOnObject("hlslang_4",oPC);
            break;
        case APPEARANCE_TYPE_HALF_ORC:
            CreateItemOnObject("hlslang_5",oPC);
            break;
    }
}
