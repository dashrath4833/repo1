global class practiceClass {
    public static void mainClass(){
        Map<string,List<integer>> mp = new map<string,List<integer>>();
        list<integer> inte  = new List<integer>();
        for(integer i = 0;i<5;i++){
            inte.add(i);
        }
         list<integer> inte1  = new List<integer>();
        for(integer i = 6;i<11;i++){
            inte1.add(i);
        }
        
        mp.put('test',inte);
        mp.put('test1',inte1);
        system.debug(mp);
    }

    
}