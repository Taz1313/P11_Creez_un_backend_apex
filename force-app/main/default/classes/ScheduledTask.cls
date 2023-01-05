global class ScheduledTask implements Schedulable {
    global void execute(SchedulableContext sc) {
      // Création d'une instance de la classe Batch CreateReminderTasksBatch
      CreateReminderTasksBatch batch = new CreateReminderTasksBatch();
      // Planification de l'exécution du Batch tous les premiers lundis de chaque mois à minuit
      String schedule = '0 0 0 ? * MON#1';
      // Utilisation de la méthode executeBatch pour planifier l'exécution de la classe Batch
      ID batchProcessId = Database.executeBatch(batch, 200);
    }
}
  

// Utilisation du planificateur sur console debug
// System.schedule('Task Scheduler', '0 0 0 * * ?', new ScheduledTask());
