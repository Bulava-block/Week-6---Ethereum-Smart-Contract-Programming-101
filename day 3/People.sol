
pragma solidity 0.5.12;

contract People{

    struct Person {
      uint id;
      string name;
      uint age;
      uint height;
      bool senior;
    }

    event personCreated(string name, bool senior);
    event personDeleted(string name, bool senior, address deletedBy);


      uint public balance;
     address public owner;

    // modifier onlyOwner(){
       // require(msg.sender == owner);
      //  _; //Continue execution
  //  }


 //   constructor() public{
      //  owner = msg.sender;
  //  }

 //   modifier costs(uint cost){
    //    require(msg.value >= cost);
   //     _;
  //  }


    mapping (address => Person) internal people;
    address[] private creators;

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

   function deletePeopleOnly(address creator) internal{
        string memory name = people[creator].name;
        bool senior = people[creator].senior;

       delete people[creator];
       assert(people[creator].age == 0);
       emit personDeleted(name, senior, owner);



   }


   function getCreator(uint index) public view  returns(address){
       return creators[index];
   }

}
