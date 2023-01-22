public class ActiveAccountCheckBoxHandler {
    // Méthode pour mettre à jour le champ Actif__c pour tous les comptes
    public static void updateActiveField() {
        // Récupération de tous les comptes et leurs commandes associées en utilisant une requête SOQL
        List<Account> accounts = [
            SELECT Id, (SELECT Id FROM Orders) FROM Account
        ];
    
        // Boucle pour parcourir tous les comptes
        for (Account a : accounts) {
            // Si un compte a au moins une commande associée, alors Actif__c est mis à true, sinon à false
            a.Actif__c = a.Orders.size() > 0;
        }
        // Mise à jour de tous les comptes en base de données
        update accounts;
    }
}