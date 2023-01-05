public with sharing class ActiveAccountCheckBoxHandler {
    // Méthode pour mettre à jour le champ Actif__c de tous les comptes
    public static void updateActiveField() {
        // Requête pour récupérer une liste de comptes qui ont des commandes associées
        List<Account> accountsWithOrders = [
            SELECT Id FROM Account WHERE Id IN (
            SELECT AccountId FROM Order
            )
        ];
    
        // Requête pour récupérer tous les comptes
        List<Account> allAccounts = [SELECT Id FROM Account];
    
        // Pour chaque compte, définir le champ Actif__c sur true si le compte a des commandes associées, sinon sur false
        for (Account a : allAccounts) {
            a.Actif__c = accountsWithOrders.contains(a);
        }
        // Mettre à jour la liste de tous les comptes en base de données
        update allAccounts;
    }
}
