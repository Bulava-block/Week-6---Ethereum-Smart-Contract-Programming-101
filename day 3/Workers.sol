
pragma solidity 0.5.12;

import './People.sol';  //   We inherite from People contract

contract Workers is People{
    
              //   worker=>boss  mapping
            mapping(address=>address) private fireman;
    
             // this is where we store salaris of our workers
            mapping(address=>uint) private salary;
     
     
             // this function is created by the worker.  address of the worker is used. The address of the 
     
        function createWorker(string memory name, uint age, uint height, uint paycheck, address boss) public{
        
        
             // require says - the once that creates the worker can't be the one who will fire the worker
             require(msg.sender!=boss);
        
             // We are using create createPerson from People contract because our worker is a createPerson plus 2 more parameteres
             createPerson(name, age, height);
         
             //we we connect the creaator of the worker and the address of the boss. The boss is the one who will be able to fire the worker
             fireman[msg.sender]=boss;
         
              //We add the parameter paycheck to the worker
             salary[msg.sender]=paycheck;
         
         
     }  
        
               // We use the address of the worker to fire him
         function fireWorker(address addressOfWorker) public {
                //the msg.sedner has to be "boss" of the worker and should not be equal to workers address
              require(msg.sender!=addressOfWorker);
         
              require(msg.sender==fireman[addressOfWorker]);
             
                 //we delete createPerson dunction People contract
              deletePeopleOnly(addressOfWorker);
            
               //We deltee salary from the mapping
              delete salary[addressOfWorker];
                //delete the address of the worker
              delete fireman[addressOfWorker];
        
     }
    
    
}
