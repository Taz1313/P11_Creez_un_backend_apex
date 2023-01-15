@isTest
private class ActiveAccountCheckBoxHandlerTest {

    @isTest
    static void checkActiveFieldWithOrdersTest() {
        // Création de 100 comptes
        List<Account> accounts = TestDataFactory.createAccounts(100);
        // Création de commandes associées aux comptes
        List<Order> orders = TestDataFactory.createOrdersForAccounts(accounts, 1, 100, 1);
        // Lancement du test
        Test.startTest();
        // Appel de la méthode updateActiveField pour mettre à jour le champ Actif__c
        ActiveAccountCheckBoxHandler.updateActiveField();
        // Fin du test
        Test.stopTest();
        // Récupération des comptes mis à jour à partir de la base de données
        List<Account> updatedAccounts = [SELECT Id, Actif__c FROM Account];
        // Boucle pour vérifier que tous les comptes ont Actif__c mis à true
        for (Account a : updatedAccounts) {
            System.assertEquals(true, a.Actif__c);
        }
    }

    @isTest
    static void checkActiveFieldWithoutOrdersTest() {
        // Création de 100 comptes en utilisant la méthode TestDataFactory.createAccounts 
        List<Account> accounts = TestDataFactory.createAccounts(100);
        // Lancement du test
        Test.startTest();
        // Appel de la méthode updateActiveField pour mettre à jour le champ Actif__c
        ActiveAccountCheckBoxHandler.updateActiveField();
        // Fin du test
        Test.stopTest();
        // Récupération des comptes mis à jour à partir de la base de données
        List<Account> updatedAccounts = [SELECT Id, Actif__c FROM Account];
        // Boucle pour vérifier que tous les comptes ont Actif__c mis à false
        for (Account a : updatedAccounts) {
            System.assertEquals(false, a.Actif__c);
        }
    }

    @isTest
    static void checkActiveFieldAndDeletingtOrdersTest() {
        // Création de 100 comptes
        List<Account> accounts = TestDataFactory.createAccounts(100);
        // Création de commandes associées aux comptes
        List<Order> orders = TestDataFactory.createOrdersForAccounts(accounts, 1, 100, 1);
        // Lancement du test
        Test.startTest();
        // Appel de la méthode updateActiveField pour mettre à jour le champ Actif__c
        ActiveAccountCheckBoxHandler.updateActiveField();
        // Fin du test
        Test.stopTest();
        // Récupération des comptes mis à jour à partir de la base de données
        List<Account> updatedAccounts = [SELECT Id, Actif__c FROM Account];
        // Boucle pour vérifier que tous les comptes ont Actif__c mis à true
        for (Account a : updatedAccounts) {
            System.assertEquals(true, a.Actif__c);
        }
        // Suppression des commandes 
        delete orders;
        // Récupération des comptes mis à jour à partir de la base de données
        List<Account> deletedOrdersOnAccounts = [SELECT Id, Actif__c FROM Account];
        // Boucle pour vérifier que tous les comptes ont Actif__c mis à false
        for (Account a : deletedOrdersOnAccounts) {
            System.assertEquals(false, a.Actif__c);
        }
    }
}