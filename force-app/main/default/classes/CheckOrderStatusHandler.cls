public class CheckOrderStatusHandler {
    // Méthode pour vérifier le statut d'une liste de commandes et bloquer le changement sous condition
    public static void checkStatus(List<Order> orders) {
        // Boucle pour parcourir toutes les commandes
        Map<Id, Order> mapIdOrders = new Map<Id, Order>(orders);
        List<Order> listOrders = [SELECT Id, Status, (SELECT Id FROM OrderItems) FROM Order WHERE Id IN :mapIdOrders.keySet()];
        for (Order order : listOrders) {
            // Si le statut de la commande est 'Ordered' et que la commande est vide
            if (order.Status == 'Ordered' && order.OrderItems.isEmpty()) {
                // Ajout d'une erreur à la commande
                order.addError('Vous ne pouvez pas passer l\'order en Ordered si aucun produit n\'y est associé');
            }
        }
    }
}