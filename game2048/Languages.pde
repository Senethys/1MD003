class Language { 
  
  StringList languages = new StringList();
  HashMap<Integer, String> en_ui = new HashMap<Integer,String>();
  HashMap<Integer, String> en_tutorial = new HashMap<Integer,String>();
  HashMap<Integer, String> en_tutorial_sub = new HashMap<Integer,String>();
  HashMap<Integer, String> se_ui = new HashMap<Integer,String>();
  HashMap<Integer, String> se_tutorial = new HashMap<Integer,String>();
  HashMap<Integer, String> se_tutorial_sub = new HashMap<Integer,String>();

  String defaultLang = "English";
  String currentLanguage = "English";
  
  Language() {
    
    en_ui.put(1, "Score");
    en_ui.put(2, "Undo");
    en_ui.put(3, "Redo");
    en_ui.put(4, "Tutorial");
    
    se_ui.put(1, "Poäng");
    se_ui.put(2, "Ångra");
    se_ui.put(3, "Gör om");
    se_ui.put(4, "Handledning");

    
    //English
    en_tutorial.put(1, "This game is about combining tiles! Try moving the tiles by using the one of arrow keys.");
    en_tutorial.put(2, "As you could see, one or all tiles moved until they reached the border or another tile.");
    en_tutorial_sub.put(2, "Try moving them again in another direction.");
    en_tutorial.put(3, "Once you succesfully move or combine tiles, a new one will appear in an empty space.");
    en_tutorial_sub.put(3, "Press any arrow key to continue.");
    en_tutorial.put(4, "Only the tiles with the same tile number will combine!");
    en_tutorial_sub.put(4, "Try to combine some tiles");
    en_tutorial.put(5, "Your goal is to combine enough tiles to reach number 2048!");
    en_tutorial_sub.put(5, "But be carefull as to not run out of tile-space!");
    en_tutorial.put(6, "You are on your way now.");
    en_tutorial_sub.put(6, "Good luck!");
    

    //Swedish
    se_tutorial.put(1, "Spelet handlar om att flytta på plattor! Försök att flytta på plattorna med pil-knapparna.");
    se_tutorial.put(2, "Som du kunde se, plattorna förflyttade tills de nådde gränsen eller en annan platta.");
    se_tutorial_sub.put(2, "Försköt att flytta på dem i en annan riktning.");
    se_tutorial.put(3, "Då du har lyckats flytta eller kombinera plattor kommer nya att dyka upp!");
    se_tutorial_sub.put(3, "Klicka på en pilknapp för att fortsätta.");
    se_tutorial.put(4, "Ändast plattor med samma tal kan kombineras!");
    se_tutorial_sub.put(4, "Försök att kombinera några plattor.");
    se_tutorial.put(5, "Ditt mål är att kombinera dessa tills du får 2048!");
    se_tutorial_sub.put(5, "Var försiktig med att inte få slut på plats.");
    se_tutorial.put(6, "Det går bra för dig.");
    se_tutorial_sub.put(6, "Lycka till!");
    
  }
  
  String tutorialLanguage(int tutorialStep) {
    String result = "";
    if(currentLanguage == "English") {
      result = en_tutorial.get(tutorialStep);
    } else if(currentLanguage == "Swedish") {
      result = se_tutorial.get(tutorialStep);
    }
    return result;
  }
  
   String tutorial_subLanguage(int tutorialSubStep) {
    String result = "";
    if(currentLanguage == "English") {
      result = en_tutorial_sub.get(tutorialSubStep);
    } else if(currentLanguage == "Swedish") {
      result = se_tutorial_sub.get(tutorialSubStep);
    }
    return result;
  }
  
  String ui_Language(int code) {
    String result = "";
    if(currentLanguage == "English") {
      result = en_ui.get(code);
    } else if(currentLanguage == "Swedish") {
      result = se_ui.get(code);
    }
    return result;
  }
  
  void setLanguage(String newLang) {
    currentLanguage = newLang;
  }
  
    void toggleLanguage() {
      if(currentLanguage == "English") {
          currentLanguage = "Swedish";
      } else {
          currentLanguage = "English";
  }
}   
};
