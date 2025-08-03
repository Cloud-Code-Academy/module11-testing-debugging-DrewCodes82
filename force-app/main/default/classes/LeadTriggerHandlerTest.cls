@IsTest
public with sharing class LeadTriggerHandlerTest {
    @TestSetup
    static void setup(){
        Lead vpLead1 = new Lead(FirstName = 'Peter', LastName = 'Parker', Company = 'Daily Bugle', Title = 'VP', Status = 'Open - Not Contacted', Industry = 'Technology', LeadSource = 'Website', Email = 'NotSpiderMan@DailyBugle.com', Phone = '555-555-5555');
        Lead vpLead2 = new Lead(FirstName = 'Mary Jane', LastName = 'Watson', Company = 'Daily Bugle', Title = 'v.p. of sales', Status = 'Open - Not Contacted', Phone = '555-555-1234');
        Lead vpLead3 = new Lead(FirstName = 'Robbie', LastName = 'Robertson', Company = 'Daily Bugle', Title = 'vice president', Status = 'Open - Not Contacted',LeadSource = 'Website', Email = 'Robbie.Robertson@DailyBugle.com');
        Lead mgrLead1 = new Lead(FirstName = 'Clark', LastName = 'Kent', Company = 'Daily Planet', Title = 'senior mgr', Status = 'Open - Not Contacted', Industry = 'Communications', LeadSource = 'Website', Email = 'NotSuperMan@DailyPlanet.com', Phone = '555-123-4567');
        Lead mgrLead2 = new Lead(FirstName = 'Lois', LastName = 'Lane', Company = 'Daily Planet', Title = 'Awesome manager', Status = 'Open - Not Contacted', Industry = 'Technology', LeadSource = 'Website', Email = 'Lois.Lane@DailyPlanet.com');
        Lead mgrLead3 = new Lead(FirstName = 'Jimmy', LastName = 'Olsen', Company = 'Daily Planet', Title = 'head of department', Status = 'Open - Not Contacted', Industry = 'Technology', LeadSource = 'Other', Email = 'Jimmy.Olsen@DailyPlanet.com', Phone = '123-456-7890');
        Lead execLead1 = new Lead(FirstName = 'Jonah', LastName = 'Jameson', Company = 'Daily Bugle', Title = 'Editor in Chief', Status = 'Open - Not Contacted', Industry = 'Communications', LeadSource = 'Website', Phone = '555-123-7654');
        Lead execLead2 = new Lead(FirstName = 'Perry', LastName = 'White', Company = 'Daily Planet', Title = 'executive editor', Status = 'Open - Not Contacted', Industry = 'Techology', LeadSource = 'Website', Phone = '555-123-7654');
        Lead execLead3 = new Lead(FirstName = 'Frederick', LastName = 'Foswell', Company = 'Daily Bugle', Title = 'head journalist', Status = 'Open - Not Contacted', LeadSource = 'Website', Email = 'Freddy.Foswell@DailyBugle.com');
        Lead assistantLead1 = new Lead(FirstName = 'Glory', LastName = 'Grant', Company = 'Daily Bugle', Title = 'administrative assistant', Status = 'Open - Not Contacted', Phone = '555-777-8888');
        Lead assistantLead2 = new Lead(FirstName = 'Steve', LastName = 'Lombard', Company = 'Daily Planet', Title = 'sports deputy', Status = 'Open - Not Contacted', Industry = 'Technology');
        Lead assistantLead3 = new Lead(FirstName = 'Lana', LastName = 'Lang', Company = 'Daily Planet', Title = 'jr editor', Status = 'Open - Not Contacted', Industry = 'Communications', Phone = '555-444-7788');
        
        List<Lead> leads = new List<Lead>{vpLead1, vpLead2, vpLead3, mgrLead1, mgrLead2, mgrLead3, execLead1, execLead2, execLead3, assistantLead1, assistantLead2, assistantLead3}; 
        
        insert leads;
    }
    @IsTest
    public static void testHandleTitleNormalization_positive() {

        // Arrange - Set up the data in order to test the method
        
        // Act - call the method to perform the test

        // Assert - use assertions to determine if the code functions as expected

    }
 
}