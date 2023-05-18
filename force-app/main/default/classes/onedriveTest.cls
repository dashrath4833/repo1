@isTest
public class onedriveTest {
	@isTest
    private static void driveTesting(){
        Test.setMock(HttpCalloutMock.class, new mockCalloutDrive());
        drive.files();
    }
}