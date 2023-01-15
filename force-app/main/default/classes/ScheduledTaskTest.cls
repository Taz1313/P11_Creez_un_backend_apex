@isTest
private class ScheduledTaskTest {
    @isTest
    static void schedulerTaskBatchTest() {
        // Démarrage de la phase de test
        Test.startTest();

        // Planification de l'exécution de la classe ScheduledTask
        String CRON_EXP = '0 0 0 ? * MON#1';
        ScheduledTask scheduledTask = new ScheduledTask();
        System.schedule('Test Scheduler', CRON_EXP, scheduledTask);

        // Attente de l'exécution de la classe UpdateAccountsScheduler
        Test.stopTest();
        List<CronTrigger> cronTriggers = [SELECT Id FROM CronTrigger WHERE CronJobDetail.Name = 'Test Scheduler'];
        System.assertEquals(1, cronTriggers.size());
    }
}