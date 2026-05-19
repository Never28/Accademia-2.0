/*
  CREATO DA:      Tempesta
  DATA CREAZIONE: 24-06-2009
*/

// Totem delle Trasformazioni OnSpawn.


int GetChatCreature(object oPC,string sTrasformation)
{
    if(sTrasformation == "Lupo")
        return 1;
    else if(sTrasformation == "Tasso")
        return 2;
    else if(sTrasformation == "Cinghiale")
        return 3;
    else if(sTrasformation == "Orso")
        return 4;
    else if(sTrasformation == "Pantera")
        return 5;
    else if(sTrasformation == "Orso Crudele")
        return 6;
    else if(sTrasformation == "Tasso Crudele")
        return 7;
    else if(sTrasformation == "Lupo Crudele")
        return 8;
    else if(sTrasformation == "Pantera Crudele")
        return 9;
    else if(sTrasformation == "Cinghiale Crudele")
        return 10;
    else if(sTrasformation == "Tigre Leggendaria")
        return 11;
    else if(sTrasformation == "Scarabeo")
        return 12;
    else if(sTrasformation == "Ragno")
        return 13;
    else if(sTrasformation == "Serpente")
        return 90;
    else if(sTrasformation == "Scarabeo Crudele")
        return 14;
    else if(sTrasformation == "Ragno Crudele")
        return 15;
    else if(sTrasformation == "Serpente Crudele")
        return 91;
    else if(sTrasformation == "Ragno Leggendario")
        return 16;
    else if(sTrasformation == "Elementale Fuoco")
        return 17;
    else if(sTrasformation == "Elementale Acqua")
        return 18;
    else if(sTrasformation == "Elementale Aria")
        return 19;
    else if(sTrasformation == "Elementale Terra")
        return 20;
    else if(sTrasformation == "Elementale Fuoco Anziano")
        return 21;
    else if(sTrasformation == "Elementale Acqua Anziano")
        return 22;
    else if(sTrasformation == "Elementale Aria Anziano")
        return 23;
    else if(sTrasformation == "Elementale Terra Anziano")
        return 24;
    else if(sTrasformation == "Draghetto Rosso")
        return 25;
    else if(sTrasformation == "Draghetto Blu")
        return 26;
    else if(sTrasformation == "Draghetto Nero")
        return 27;
    else if(sTrasformation == "Draghetto Verde")
        return 28;
    else if(sTrasformation == "Draghetto Bianco")
        return 29;
    else if(sTrasformation == "Draghetto Oro")
        return 30;
    else if(sTrasformation == "Draghetto Bronzo")
        return 31;
    else if(sTrasformation == "Draghetto Argento")
        return 32;
    else if(sTrasformation == "Draghetto Ottone")
        return 33;
    else if(sTrasformation == "Draghetto Rame")
        return 34;
    else if(sTrasformation == "Coboldo")
        return 35;
    else if(sTrasformation == "Scorpionide")
        return 36;
    else if(sTrasformation == "Minotauro")
        return 37;
    else if(sTrasformation == "Gigante Fuoco")
        return 38;
    else if(sTrasformation == "Gigante Freddo")
        return 39;
    else if(sTrasformation == "Troll")
        return 40;
    else if(sTrasformation == "Basilisco")
        return 41;
    else if(sTrasformation == "Krenshar")
        return 42;
    else if(sTrasformation == "Manticora")
        return 43;
    else if(sTrasformation == "Beholder")
        return 44;
    else if(sTrasformation == "Mind Flayer")
        return 45;
    else if(sTrasformation == "Drider")
        return 46;
    else if(sTrasformation == "Scheletro")
        return 47;
    else if(sTrasformation == "Zombie")
        return 48;
    else if(sTrasformation == "Mohrg")
        return 49;
    else if(sTrasformation == "Mummia")
        return 50;
    else if(sTrasformation == "Vampiro")
        return 51;
    else if(sTrasformation == "Lich")
        return 52;
    else if(sTrasformation == "Alhoon")
        return 53;
    else if(sTrasformation == "Demilich")
        return 54;
    else if(sTrasformation == "Azer")
        return 55;
    else if(sTrasformation == "Arconte Segugio")
        return 56;
    else if(sTrasformation == "Vendicatore Celestiale")
        return 57;
    else if(sTrasformation == "Avatar Mielikki")
        return 58;
    else if(sTrasformation == "Rakshasa")
        return 59;
    else if(sTrasformation == "Diavolo Fossa")
        return 60;
    else if(sTrasformation == "Balor")
        return 61;
    else if(sTrasformation == "Avatar Talona")
        return 62;
    else if(sTrasformation == "Slaad Rosso")
        return 63;
    else if(sTrasformation == "Slaad Verde")
        return 64;
    else if(sTrasformation == "Slaad Blu")
        return 65;
    else if(sTrasformation == "Slaad Bianco")
        return 66;
    else if(sTrasformation == "Slaad Grigio")
        return 67;
    else if(sTrasformation == "Slaad Nero")
        return 68;
    else if(sTrasformation == "Slaad Morte")
        return 69;
    else if(sTrasformation == "Guardiano Protettore")
        return 70;
    else if(sTrasformation == "Golem Ferro")
        return 71;
    else if(sTrasformation == "Golem Ossa")
        return 72;
    else if(sTrasformation == "Golem Carne Demoniaca")
        return 73;
    else if(sTrasformation == "Golem Mithral")
        return 74;
    else if(sTrasformation == "Golem Adamantio")
        return 75;
    else if(sTrasformation == "Drago Rosso")
        return 76;
    else if(sTrasformation == "Drago Nero")
        return 77;
    else if(sTrasformation == "Drago Blu")
        return 78;
    else if(sTrasformation == "Drago Bianco")
        return 79;
    else if(sTrasformation == "Drago Verde")
        return 80;
    else if(sTrasformation == "Drago Ombra")
        return 81;
    else if(sTrasformation == "Drago Oro")
        return 82;
    else if(sTrasformation == "Drago Argento")
        return 83;
    else if(sTrasformation == "Drago Ottone")
        return 84;
    else if(sTrasformation == "Drago Rame")
        return 85;
    else if(sTrasformation == "Drago Bronzo")
        return 86;
    else if(sTrasformation == "Drago Prismatico")
        return 87;
    else if(sTrasformation == "Dracolich")
        return 88;
    else if(sTrasformation == "Normale")
        return 89;
    else if(sTrasformation == "Avatar Natura")
        return 92;
    return 0;
}



