public class CheckOrderStatusHandler {
    // Méthode pour vérifier le statut d'une liste de commandes
    public static void checkStatus(List<Order> orders) {
        for (Order o : orders) {
            // Si le statut de la commande est 'Ordered' et que le champ TotalAmount est égal à 0
            if (o.Status == 'Ordered' && o.TotalAmount == 0) {
                // Ajout d'une erreur à la commande indiquant qu'elle ne peut pas être mise en statut 'Ordered' si aucun produit n'y est associé
                o.addError('Vous ne pouvez pas passer l\'order en Ordered si aucun produit n\'y est associé');
            }
        }
    }
}
