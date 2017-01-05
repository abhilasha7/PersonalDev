trigger caseTrigger on Case (after insert) {
    
    if(trigger.isAfter && trigger.isInsert){
    
        system.debug('===>'+trigger.new);
        trigger.new[0].addError('Please check with Sys Admin.');
    
    }

}