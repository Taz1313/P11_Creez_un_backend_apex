global class ScheduledTask implements Schedulable {
    global void execute(SchedulableContext sc) {
      // Création d'une instance de la classe Batch CreateReminderTasksBatch
      CreateReminderTasksBatch batch = new CreateReminderTasksBatch();
      // Utilisation de la méthode executeBatch pour planifier l'exécution de la classe Batch
      Database.executeBatch(batch, 200);
    }
}