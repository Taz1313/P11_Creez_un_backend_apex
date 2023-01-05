@isTest
private class CheckOrderStatusHandlerTest {

    @isTest
    static void checkStatusWithoutProductsTest() {
        // Création d'un compte et d'une commande associée sans produits en utilisant la méthode TestDataFactory.createAccounts et TestDataFactory.createOrdersForAccounts
        List<Account> accounts = TestDataFactory.createAccounts(1);
        List<Order> orders = TestDataFactory.createOrdersForAccounts(accounts, 1, 0, 1);
        Order order = orders[0];
        // Changement du statut de la commande en 'Ordered'
        order.Status = 'Ordered';
        Test.startTest();
        // Mise à jour de la commande en base de données
        update order;
        Test.stopTest();
        // Récupération de la commande à nouveau à partir de la base de données
        order = [SELECT Id, Status FROM Order WHERE Id = :order.Id];
        // Vérification que le statut de la commande est maintenant 'Draft'
        System.assertEquals('Draft', order.Status);
    }

   @isTest
   static void checkStatusWithProductsTest() {
        // Création d'un compte et d'une commande associée avec des produits en utilisant la méthode TestDataFactory.createAccounts et TestDataFactory.createOrdersForAccounts
        List<Account> accounts = TestDataFactory.createAccounts(1);
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
