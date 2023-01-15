trigger OrderStatusTrigger on Order (before update, after insert, after delete) {
    // Si l'opération est une insertion ou une suppression
    if (Trigger.isInsert || Trigger.isDelete) {
        ActiveAccountCheckBoxHandler.updateActiveField();
    }
    // Si l'opération est une mise à jour
    if (Trigger.isUpdate) {
        CheckOrderStatusHandler.checkStatus(Trigger.new);
    }
}