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
    public static void testHandleTitleNormalization_vicePresident_happyPath() {

        // Arrange - Set up the data in order to test the method
        List<Lead> testLeads = [SELECT Id, Name, Title 
                                FROM Lead
                                WHERE Title LIKE '%VP%' 
                                OR Title LIKE '%v.p. of sales%'
                                OR Title LIKE '%vice president%'];
        
        System.debug(testLeads);
        
        // Act - call the method to perform the test
        LeadTriggerHandler.handleTitleNormalization(testLeads);

        // Assert - use assertions to determine if the code functions as expected
        for (Lead l : testLeads) {
            System.debug(l.Title);
            Assert.areEqual('Vice President', l.Title, 'Lead Title was not updated');
        }

    }

    @IsTest
    public static void testHandleTitleNormalization_manager_happyPath() {

        // Arrange - Set up the data in order to test the method
        List<Lead> testLeads = [SELECT Id, Name, Title 
                                FROM Lead
                                WHERE Title LIKE '%mgr%' 
                                OR Title LIKE '%manager%'
                                OR Title LIKE '%head of department%'];
        
        System.debug(testLeads);
        
        // Act - call the method to perform the test
        LeadTriggerHandler.handleTitleNormalization(testLeads);

        // Assert - use assertions to determine if the code functions as expected
        for (Lead l : testLeads) {
            System.debug(l.Title);
            Assert.areEqual('Manager', l.Title, 'Lead Title was not updated');
        }

    }

    @IsTest
    public static void testHandleTitleNormalization_executive_happyPath() {

        // Arrange - Set up the data in order to test the method
        List<Lead> testLeads = [SELECT Id, Name, Title 
                                FROM Lead
                                WHERE Title LIKE '%exec%' 
                                OR Title LIKE '%chief%'
                                OR Title LIKE '%head%'];
        
        System.debug(testLeads);
        
        // Act - call the method to perform the test
        LeadTriggerHandler.handleTitleNormalization(testLeads);

        // Assert - use assertions to determine if the code functions as expected
        for (Lead l : testLeads) {
            System.debug(l.Title);
            Assert.areEqual('Executive', l.Title, 'Lead Title was not updated');
        }

    }

    @IsTest
    public static void testHandleTitleNormalization_assistant_happyPath() {

        // Arrange - Set up the data in order to test the method
        List<Lead> testLeads = [SELECT Id, Name, Title 
                                FROM Lead
                                WHERE Title LIKE '%assist%' 
                                OR Title LIKE '%deputy%'
                                OR Title LIKE '%jr%'];
        
        System.debug(testLeads);
        
        // Act - call the method to perform the test
        LeadTriggerHandler.handleTitleNormalization(testLeads);

        // Assert - use assertions to determine if the code functions as expected
        for (Lead l : testLeads) {
            System.debug(l.Title);
            Assert.areEqual('Assistant', l.Title, 'Lead Title was not updated');
        }

    }
    @IsTest
    public static void testHandleTitleNormalization_noChange_negativePath() {

        // Arrange - Set up the data in order to test the method
        Lead unknownTitleLead = new Lead(
            FirstName = 'Ben',
            LastName = 'Reilly',
            Company = 'Unknown Inc.',
            Title = 'Scarlet Spider',
            Status = 'Open - Not Contacted'
        );
        insert unknownTitleLead;

        List<Lead> testLeads = [SELECT Id, Name, Title
                                FROM Lead
                                WHERE Id = :unknownTitleLead.Id];

        // Act - call the method to perform the test
        LeadTriggerHandler.handleTitleNormalization(testLeads);

        // Assert - use assertions to determine if the code functions as expected
        System.debug(testLeads[0]);
        Assert.areEqual('Scarlet Spider', testLeads[0].Title, 'Unexpected title change occurred');

    }
    @IsTest
    public static void testHandleTitleNormalization_nullTitle_edgeCase() {

        // Arrange - Set up the data in order to test the method
        Lead nullTitleLead = new Lead(
            FirstName = 'Frank',
            LastName = 'Castle',
            Company = 'Punisher Inc.',
            Title = null,
            Status = 'Open - Not Contacted'
        );
        insert nullTitleLead;

        List<Lead> testLeads = [SELECT Id, Name, Title
                                FROM Lead
                                WHERE Id = :nullTitleLead.Id];

        // Act - call the method to perform the test
        LeadTriggerHandler.handleTitleNormalization(testLeads);

        // Assert - use assertions to determine if the code functions as expected
        System.debug(testLeads[0]);
        Assert.areEqual(null, testLeads[0].Title, 'Title should remain null');

    }
    @IsTest
    public static void testHandleTitleNormalization_emptyTitle_edgeCase() {

        // Arrange - Set up the data in order to test the method
        Lead emptyTitleLead = new Lead(
            FirstName = 'Matt',
            LastName = 'Murdock',
            Company = 'Nelson & Murdock',
            Title = '',
            Status = 'Open - Not Contacted'
        );
        insert emptyTitleLead;

        List<Lead> testLeads = [SELECT Id, Name, Title
                                FROM Lead
                                WHERE Id = :emptyTitleLead.Id];

        // Act - call the method to perform the test
        LeadTriggerHandler.handleTitleNormalization(testLeads);

        // Assert - use assertions to determine if the code functions as expected
        System.debug(testLeads[0]);
        Assert.isTrue(String.isBlank(testLeads[0].Title), 'Title should remain empty or null');

    }
    @IsTest
    public static void testHandleTitleNormalization_mixedCase_edgeCase() {

        // Arrange - Set up the data in order to test the method
        Lead mixedCaseLead = new Lead(
            FirstName = 'Elektra',
            LastName = 'Natchios',
            Company = 'The Hand',
            Title = 'vIcE PrEsIdENT',
            Status = 'Open - Not Contacted'
        );
        insert mixedCaseLead;

        List<Lead> testLeads = [SELECT Id, Name, Title
                                FROM Lead
                                WHERE Id = :mixedCaseLead.Id];

        // Act - call the method to perform the test
        LeadTriggerHandler.handleTitleNormalization(testLeads);

        // Assert - use assertions to determine if the code functions as expected
        System.debug(testLeads[0]);
        Assert.areEqual('Vice President', testLeads[0].Title, 'Title was not normalized');

    }
 
}