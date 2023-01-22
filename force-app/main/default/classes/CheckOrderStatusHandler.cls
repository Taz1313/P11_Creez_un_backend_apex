public class CheckOrderStatusHandler {
    // Méthode pour vérifier le statut d'une liste de commandes et bloquer le changement sous condition
    public static void checkStatus(List<Order> orders) {
        // Boucle pour parcourir toutes les commandes
        for (Order o : orders) {
            // Si le statut de la commande est 'Ordered' et que la commande est vide
            if (o.Status == 'Ordered' && o.OrderItems.isEmpty()) {
                // Ajout d'une erreur à la commande
                o.addError('Vous ne pouvez pas passer l\'order en Ordered si aucun produit n\'y est associé');
            }
        }
    }
}