public class duplicateContact {
    public static List<Contact> removeDuplicate(List<Contact> lstContact){
        Map<string,contact> mapContact = new Map<string, Contact>();
        List<Contact> lstCont = new List<Contact>();
        for(contact ct:lstContact){
            if(!mapContact.containsKey(ct.FirstName)){
                mapContact.put(ct.Name,ct);
             }else{
                lstCont.add(ct);     
            }
        }
        return lstContact;
    }
}