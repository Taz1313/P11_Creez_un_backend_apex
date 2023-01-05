global class CreateReminderTasksBatch implements Database.Batchable<SObject> {

    // Méthode pour récupérer les comptes à traiter par le batch
    global Database.QueryLocator start(Database.BatchableContext bc) {
        // Requête pour récupérer les comptes avec leurs commandes et tâches associées
        return Database.getQueryLocator('SELECT OwnerId, (SELECT Id FROM Orders), (SELECT Id FROM Tasks WHERE Subject=\'Call\') FROM Account');
    }
  
    // Méthode pour traiter les comptes récupérés par la méthode start
    global void execute(Database.BatchableContext bc, List<Account> accounts) {
        // Liste de tâches à créer
        List<Task> tasks = new List<Task>();
        // Pour chaque compte
        for (Account account : accounts) {
            // Si le compte n'a pas de commandes et pas de tâches 'Call' associées
            if (account.Orders.size() == 0 && account.Tasks.size() == 0) {
                // Création d'une nouvelle tâche 'Call' pour le compte
                Task task = new Task(
                    OwnerId = account.OwnerId,
                    Subject = 'Call',
                    Status = 'New',
                    Priority = 'Normal',
                    WhatId = account.Id,
                    ReminderDateTime = DateTime.now().addDays(5)
                );
                // Ajout de la tâche à la liste de tâches à créer
                tasks.add(task);
            }
        }
        // Insertion de la liste de tâches en base de données
        insert tasks;
    }
  
    // Méthode appelée à la fin du traitement du batch
    global void finish(Database.BatchableContext bc) {
        // Pas de post-traitement nécessaire
    }
}