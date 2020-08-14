
pragma solidity 0.5.12;

//Parameters that our Person will have
contract People{
      
    struct Person {
      uint id;
      string name;
      uint age;
      uint height;
      bool senior;
    }
     //Events that will pop up in our "Console.log" that is at the bottom of remix
    event personCreated(string name, bool senior);
    event personDeleted(string name, bool senior, address deletedBy);

      //We declare 2 variables 
      uint public balance;
     address public owner;

     //I commented out this modifier on purpose so that any address could create workers and not just the owner
    // modifier onlyOwner(){
       // require(msg.sender == owner);
      //  _; //Continue execution
  //  }

  //I commented out this constructor on purpose so that any address could create workers and not just the owner
 //   constructor() public{
      //  owner = msg.sender;
  //  }



   //I removed it because whenever I make our createPerson function internal it would give me an error.
 //   modifier costs(uint cost){
    //    require(msg.value >= cost);
   //     _;
  //  }

       //create mapping thatpoints at the person
    mapping (address => Person) internal people;
    //create an array of creators
    address[] private creators;

      //This is how we create person
    function createPerson(string memory name, uint age, uint height) internal {
      require(age < 75, "Age needs to be below 75");


        //This creates a person
        Person memory newPerson;
        newPerson.name = name;
        newPerson.age = age;
        newPerson.height = height;

        if(age >= 65){
           newPerson.senior = true;
       }
       else{
           newPerson.senior = false;
       }

        insertPerson(newPerson);
        creators.push(msg.sender);


// I still don't understand fully how this works. In this case it veryfies the parameters we input in the function
        assert(
            keccak256(
                abi.encodePacked(
                    people[msg.sender].name,
                    people[msg.sender].age,
                    people[msg.sender].height,
                    people[msg.sender].senior
                )
            )
            ==
            keccak256(
                abi.encodePacked(
                    newPerson.name,
                    newPerson.age,
                    newPerson.height,
                    newPerson.senior
                )
            )
        );
        emit personCreated(newPerson.name, newPerson.senior);
    }
    
    
    // I don't use this function in my assignment.
    function insertPerson(Person memory newPerson) private {
        address creator = msg.sender;
        people[creator] = newPerson;
    }
    function getPerson() public view returns(string memory name, uint age, uint height, bool senior){
        address creator = msg.sender;
        return (people[creator].name, people[creator].age, people[creator].height, people[creator].senior);
    }
    function deletePerson(address creator) public {

       deletePeopleOnly(creator);



   }
           //this deletes a person
   function deletePeopleOnly(address creator) internal{
        string memory name = people[creator].name;
        bool senior = people[creator].senior;

        delete people[creator];
        assert(people[creator].age == 0);
        emit personDeleted(name, senior, owner);
          


   }

         //     N/A
   function getCreator(uint index) public view  returns(address){
       return creators[index];
   }

}
