

/// Instead of having a mapping where we store people, create a new array where we can store the people.


pragma solidity 0.5.12;

contract HelloWorld{

    struct Person {
      uint id;
      string name;
      uint age;
      uint height;

    }

    Person[] public people;

    function createPerson(string memory name, uint age, uint height) public {

        Person memory newPerson;
        newPerson.name = name;
        newPerson.age = age;
        newPerson.height = height;

        people.push(newPerson);
    }
}


/  /When someone creates a new person, add the Person object to the people array instead of the mapping.














///Modify the Person struct and  add an address property Creator. Make sure to edit the createPerson function so that it sets this property to the msg.sender.


pragma solidity 0.5.12;

contract HelloWorld{

    struct Person {
      uint id;
      string name;
      uint age;
      uint height;
    }

    mapping (address => Person) private people;

    function createPerson(string memory name, uint age, uint height) public {
        address creator = msg.sender;

        //This creates a person
        Person memory newPerson;
        newPerson.name = name;
        newPerson.age = age;
        newPerson.height = height;

        people[creator] = newPerson;
    }
    function getPerson() public view returns(string memory name, uint age, uint height){
        address creator = msg.sender;
        return (people[creator].name, people[creator].age, people[creator].height);
    }
}



//Create a public get function where we can input an index and retrieve the Person object with that index in the array.

pragma solidity 0.5.12;

contract HelloWorld{

    struct Person {


      string name;
      uint age;

    }

    Person[] private people;

    function createPerson(string memory name, uint age) public {


        Person memory newPerson;
        newPerson.name = name;
        newPerson.age=age;




        people.push(newPerson);
    }


    function  getPerson(uint index) public view returns(string memory name, uint age){

       return(people[index].name, people[index].age);


    }






//Modify the Person struct and  add an address property Creator. Make sure to edit the createPerson function so that it sets this property to the msg.sender.


pragma solidity 0.5.12;

contract HelloWorld{

    struct Person {


      string name;
      uint age;
      address creator;
    }

    Person[] private people;

    function createPerson(string memory name, uint age, address creator) public {


        Person memory newPerson;
        newPerson.name = name;
        newPerson.age=age;
        newPerson.creator=creator;



        people.push(newPerson);
    }

    function  getPerson(uint index) public view returns(string memory name, uint age, address creator){

       return(
        people[index].name,
        people[index].age,
        people[index].creator

        );


    }

}



//Create a new mapping (address to uint) which stores the index position of the last person added to the array by an address.

//Modify the createPerson function to set/update this mapping for every new person created.
 //(HINT: The return value of the array push() function could help you)


pragma solidity 0.5.12;

contract HelloWorld{

    struct Person {


      string name;
      uint age;
      address creator;
    }

    Person[] private people;
    mapping(address=>uint) public map;

    function createPerson(string memory name, uint age) public {

        map[msg.sender]=people.length;


        Person memory newPerson;
        newPerson.name = name;
        newPerson.age=age;
        newPerson.creator=msg.sender;



        people.push(newPerson);
    }


    function  getPerson(uint index) public view returns(string memory name, uint age, address creator){


       return(
        people[index].name,
        people[index].age,
        people[index].creator

        );


    }

}


//Create a function that returns an array of all the ID's that the msg.sender has created.


//I didn't remove the function  we don't use. I just added new elements to the previous assignment.

pragma solidity 0.5.12;

contract HelloWorld{

    // Objects with properties
    struct Person {
      uint id;
      string name;
      uint age;
      address creator;
    }

    // people=[{id:1, name: "stas", age:1}, {id:2, a}....]
    Person[] private people;

    // key and value pairs

    //          key      value
    // mapping(uint => address) map
    //  set:   map[1] = msg.sender;
    //  get:   address creator = map[1];


    mapping(address => uint) private map;

    // map[msg.sender] => {id:0, name....}
    // map[msg.sender].creator
    /*
        Person memory person = map[msg.sender];
        address creator = map[msg.sender].creator;
    */

    function createPerson(string memory name, uint age) public {

        // Create a local variable of type Person
        Person memory newPerson;

        //Store the index of the last person created
        map[msg.sender]= people.length;

        newPerson.id = people.length;
        newPerson.name = name;
        newPerson.age=age;
        newPerson.creator=msg.sender;

        // Add the newPerson to the people array
        people.push(newPerson);

    }


    function  getPerson(uint index) public view returns(string memory name, uint age){
       return(
        people[index].name,
        people[index].age
        );
    }


    // We create an array that contains all the IDS of the people;
    // Loop through the array and remove the



    // Get ids for the people created by msg.sender

    // Will be called by different users
      function getIDS() public view returns(uint[] memory){

          // msg.sender will be different
            //   address sender = msg.sender;

          // Create an temporal array to store the IDS

          // ids will be an array with the same length as people array
          uint[] memory ids = new uint[](people.length); // [0,0,0,0,0,0,0]

          // the array that is returned start in 0
          uint totalIds = 0;

          // Loop through all people in the array
          // We use i as the index that change by 1
          for(uint i=0; i<people.length; i++){

              // Check if the person in that index i of people array
              // Check if the creator was the current user calling this function (msg.sender)
              if(people[i].creator == msg.sender){ // 4

                // when there is a math, store the age of the person and add it to the ids array
                  ids[totalIds] = people[i].age;
                  totalIds++;
              }
          }

          return ids;  // [,,,5,,,,,]   [5, 4, 7]
      }


}
