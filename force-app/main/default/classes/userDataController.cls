public class userDataController {
    @AuraEnabled(Cacheable=True)
    public static List<user> userDatafetch(){
        List<User> user_list = [Select id,name,firstName,FullPhotoUrl ,isActive from user where FirstName!=null];
		return user_list;
    }

    @AuraEnabled
    public static void userActivate( string userId){
        User userClicked = [Select id,name,firstName,isActive from user where Id = :userId];
        SYSTEM.debug('USERcLIKED'+userClicked);
        if(!userClicked.isActive){
            userClicked.isActive=true;
        }
		update userClicked;
    }

    @AuraEnabled
    public static void userDeactivate( Id userId){
        system.debug(userId);
        User userClicked = [Select id,name,isActive from user where id = :userId];
        system.debug(userClicked);
        if(userClicked.isActive){
            userClicked.isActive=false;
        }
		update userClicked;
    }
}