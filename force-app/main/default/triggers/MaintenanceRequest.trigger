trigger MaintenanceRequest on Case (before update, after update) {
    System.debug('Estou na trigger');
    if(Trigger.isUpdate && Trigger.isAfter){
        System.debug('Entrou no if da Trigguer');
        MaintenanceRequestHelper.updateWorkOrders(Trigger.New, Trigger.OldMap);
    }
}