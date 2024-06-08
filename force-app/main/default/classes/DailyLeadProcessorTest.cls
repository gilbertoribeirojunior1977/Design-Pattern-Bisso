@IsTest
public class DailyLeadProcessorTest {
    public static String CRON_EXP = '0 0 0 15 3 ? 2042';
    @IsTest
    static void testScheduledJob() {
        // Create some out of date Opportunity records
        List<Lead> leads = new List<Lead>();
        
        for (Integer i=0; i<200; i++) {
            Lead l = new Lead(
                Status = 'Working - Contacted',
                Company = 'Company ' + i,
                FirstName = 'First Name Lead ' + i,
                LastName = 'Last Name Lead ' + i
            );
            leads.add(l);
        }
        
        insert leads;
        
        // Obtém os IDs dos Leads que forma inseridos
        Map<Id, Lead> leadMap = new Map<Id, Lead>(leads);
        List<Id> leadIds = new List<Id>(leadMap.keySet());
        Test.startTest();

        // Starta a JOB
        String jobId = System.schedule('ScheduledApexTest',  CRON_EXP, new DailyLeadProcessor());
        
        Test.stopTest();
        
        // Valida se os Leads forma criados
        List<Lead> lt = [SELECT Id
                         FROM Lead
                         WHERE LeadSource = 'Dreamforce'];

        System.assertEquals(leadIds.size(), lt.size(), 'Leads were not created');
    }
}