@isTest
private class ActiveAccountCheckBoxHandlerTest {

    @isTest
    static void testUpdateActiveField() {
      // Création de deux comptes en utilisant la méthode TestDataFactory.createAccounts
      List<Account> accounts = TestDataFactory.createAccounts(2);
      Account account1 = accounts[0];
      Account account2 = accounts[1];
  
      // Vérification que le champ Actif__c de chaque compte est initialement défini sur false
      System.assertEquals(false, account1.Actif__c);
      System.assertEquals(false, account2.Actif__c);
  
      // Création de commandes pour chaque compte en utilisant la méthode TestDataFactory.createOrdersForAccounts
      TestDataFactory.createOrdersForAccounts(new List<Account> { account1 }, 1, 100, 1);
      TestDataFactory.createOrdersForAccounts(new List<Account> { account2 }, 2, 100, 1);
  
      // Appel de la méthode updateActiveField de la classe ActiveAccountCheckBoxHandler
      ActiveAccountCheckBoxHandler.updateActiveField();
  
      // Récupération des comptes à nouveau à partir de la base de données
      account1 = [SELECT Id, Actif__c FROM Account WHERE Id = :account1.Id];
      account2 = [SELECT Id, Actif__c FROM Account WHERE Id = :account2.Id];
  
      // Vérification que le champ Actif__c de chaque compte est maintenant défini sur true
      System.assertEquals(true, account1.Actif__c);
      System.assertEquals(true, account2.Actif__c);
  
      // Récupération de toutes les commandes associées au second compte
      List<Order> orders = [SELECT Id FROM Order WHERE AccountId = :account2.Id];
      // Suppression de ces commandes
      delete orders;
  
      // Appel de la méthode updateActiveField de la classe ActiveAccountCheckBoxHandler
      ActiveAccountCheckBoxHandler.updateActiveField();
  
      // Récupération du second compte à nouveau à partir de la base de données
      account2 = [SELECT Id, Actif__c FROM Account WHERE Id = :account2.Id];
  
      // Vérification que le champ Actif__c du second compte est maintenant défini sur false
      System.assertEquals(false, account2.Actif__c);
    }
}
