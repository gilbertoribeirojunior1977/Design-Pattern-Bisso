public with sharing class DailyLeadProcessor implements Schedulable {
    public void execute(SchedulableContext ctx) {
        List<Lead> lstLeads = [SELECT Id, LeadSource 
                               FROM Lead
                               WHERE LeadSource = null];
        // Create a task for each opportunity in the list
        for (Lead oLead : lstLeads) {
            oLead.LeadSource = 'Dreamforce';
        }

        Update lstLeads;

    }
}