@isTest
private class CreateReminderTasksBatchTest {

    @isTest
    static void createReminderTasksForAccountWithoutOrderTest() {
        // Création de 100 comptes sans commandes
        List<Account> accounts =  TestDataFactory.createAccounts(100);
        Test.startTest();
        // Création d'un objet CreateReminderTasksBatch
        CreateReminderTasksBatch obj = new CreateReminderTasksBatch();
        // Exécution du batch
        Id batchId = DataBase.executeBatch(obj);
        Test.stopTest();
        
        // Récupération des comptes avec leurs commandes et tâches associées à partir de la base de données
        List<Account> results = [SELECT Id, (SELECT AccountId FROM Orders),(SELECT WhatId FROM Tasks)FROM  Account];
        // Récupération de toutes les tâches à partir de la base de données
        List<Task> tasks = [SELECT WhatId, Subject, Status, Priority FROM Task];
        // Pour chaque compte
        for (Account account : results){
            // Vérification que le compte a bien une tâche associée
            System.assertEquals(1, account.Tasks.size());
        }
    }

    @isTest
    static void noCreateReminderTasksForAccountWithOrderTest() {
        // Création de 100 comptes sans commandes
        List<Account> accounts =  TestDataFactory.createAccounts(100);
        List<Order> orders = TestDataFactory.createOrdersForAccounts(accounts, 1, 0, 1);
        Test.startTest();
        // Création d'un objet CreateReminderTasksBatch
        CreateReminderTasksBatch obj = new CreateReminderTasksBatch();
        // Exécution du batch
        Id batchId = DataBase.executeBatch(obj);
        Test.stopTest();
        
        // Récupération des comptes avec leurs commandes et tâches associées à partir de la base de données
        List<Account> results = [SELECT Id, (SELECT AccountId FROM Orders),(SELECT WhatId FROM Tasks)FROM  Account];
        // Récupération de toutes les tâches à partir de la base de données
        List<Task> tasks = [SELECT WhatId FROM Task];
        // Pour chaque compte
        for (Account account : results){
            // Vérification que le compte n'a pas de tâche associée
            System.assertEquals(0, account.Tasks.size());
        }
    }
}

