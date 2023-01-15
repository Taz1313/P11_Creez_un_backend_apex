@isTest
private class CheckOrderStatusHandlerTest {

   @isTest
   static void checkStatusWithProductsTest() {
        // Création dde 100 comptes et d'une commande associée par compte
        List<Account> accounts = TestDataFactory.createAccounts(100);
        List<Order> orders = TestDataFactory.createOrdersForAccounts(accounts, 1, 100, 1);
        Order order = orders[0];
        // Changement du statut de la commande en 'Ordered'
        order.Status = 'Ordered';
        Test.startTest();
        // Mise à jour de la commande en base de données
        update order;
        Test.stopTest();   
        // Récupération de la commande à nouveau à partir de la base de données
        order = [SELECT Id, Status FROM Order WHERE Id = :order.Id];
        // Vérification que le statut de la commande est maintenant 'Ordered'
        System.assertEquals('Ordered', order.Status);
    }
}