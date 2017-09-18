trigger ContactUpdateTrigger on Contact (after update, before update) {
    
        	FutureMethod.updateExternalObjectMatchId();
            System.debug('trigger updateExternalObjectMatchId');
    
}