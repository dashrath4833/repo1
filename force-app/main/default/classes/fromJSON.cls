public class fromJSON{
	public String odataContext;	//https://graph.microsoft.com/v1.0/$metadata#users('48d31887-5fad-4d73-a9f5-3c356e68a038')/drive/root/children
	public cls_value[] value;
	public class cls_value {
		public String createdDateTime;	//2017-07-31T18:56:29Z
		public String eTag;	//"{60F36ED0-85CE-4771-B349-E671C691EFCA},1"
		public String id;	//01BYE5RZ6QN3ZWBTUFOFD3GSPGOHDJD36K
		public String lastModifiedDateTime;	//2017-07-31T18:56:29Z
		public String name;	//Attachments
		public String webUrl;	//https://m365x214355-my.sharepoint.com/personal/meganb_m365x214355_onmicrosoft_com/Documents/Attachments
		public String cTag;	//"c:{60F36ED0-85CE-4771-B349-E671C691EFCA},0"
        public Integer size;	//0
		public cls_createdBy createdBy;
		public cls_lastModifiedBy lastModifiedBy;
		public cls_parentReference parentReference;
		public cls_fileSystemInfo fileSystemInfo;
		public cls_folder folder;
		public cls_specialFolder specialFolder;
	}
	public class cls_createdBy {
		public cls_user user;
	}
	public class cls_user {
		public String email;	//MeganB@M365x214355.onmicrosoft.com
		public String id;	//48d31887-5fad-4d73-a9f5-3c356e68a038
		public String displayName;	//Megan Bowen
	}
	class cls_lastModifiedBy {
		public cls_user user;
	}
	class cls_parentReference {
		public String driveType;	//business
		public String driveId;	//b!-RIj2DuyvEyV1T4NlOaMHk8XkS_I8MdFlUCq1BlcjgmhRfAj3-Z8RY2VpuvV_tpd
		public String id;	//01BYE5RZ56Y2GOVW7725BZO354PWSELRRZ
		public String path;	///drive/root:
	}
	class cls_fileSystemInfo {
		public String createdDateTime;	//2017-07-31T18:56:29Z
		public String lastModifiedDateTime;	//2017-07-31T18:56:29Z
	}
	class cls_folder {
		public Integer childCount;	//0
	}
	class cls_specialFolder {
		public String name;	//attachments
	}
	public static fromJSON parse(String json){
		return (fromJSON) System.JSON.deserialize(json, fromJSON.class);
	}
}