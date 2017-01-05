global class TrainWebService{   
 webService static Id TrainMember(String name, Integer SeatNo, DateTime Departure, String trainName)
  {       
    Train__c train = new Train__c(Train_Name__c = trainName, Name = name, Seat_Availablility__c = SeatNo, Train_Date_Time__c = Departure); 
       insert Train ; 
        return Train.id;  
   }
}