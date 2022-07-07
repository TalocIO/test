//SPDX-License-Identifier: MIT
//chnages for testing'';
//Need solidity version number declared at the top of the page - examnple = 
pragma solidity ^0.6.0 ;

//this is creating a contract named "simplestrorage", with all types includeded within. a contract is like a class, where you define functions and parameters
contract simplestorage {

    uint256 favoriteNumber = 5; 
    bool favroritebBool = true; 
    string favoriteString = "string"; 
    int256 favoriteInt = 10;
    address favoriteAddress = 0xA89B9663829E7B767766f6e30af393E996063360;
    bytes32 favoriteByte = "cat"; 
//^^each contract you create in the same file will have a different address, 

}

-------------------------------------------------------------------------
//In solidity there are 2 ways to store information , either on memeory or storage
//Storage -  refers to variables stored permanently on the blockchain. data will be persisted even after function is executed 
//Memory -  variables are temporary, data will only be stored during execution of fucntion
//State - variables (variables declared outside of functions) are by default storage and written permanently to the blockchain, 
contract SimpleStorage {
    uint storedData; // State variable


//variables declared inside functions are memory and will disappear when the function call ends. However, there are times when you do need to use keywords to delcare these within functions

//View  - it's only viewing the data but not modifying it (read only) 
//Pure  - make a calculation, but not save the state anywhere
//"view" and "pure" are two non-state changing functions(that dont have to make transactions to eth evm) 

//example : 
contract C {
    // The data location of x is storage.
    // This is the only place where the
    // data location can be omitted.
    uint[] x;

    // The data location of memoryArray is memory.
    function f(uint[] memory memoryArray) public {
        x = memoryArray; // works, copies the whole array to storage
        uint[] storage y = x; // works, assigns a pointer, data location of y is storage
        y[7]; // fine, returns the 8th element
        y.pop(); // fine, modifies x through y
        delete x; // fine, clears the array, also modifies y
        // The following does not work; it would need to create a new temporary /
        // unnamed array in storage, but storage is "statically" allocated:
        // y = memoryArray;
        // This does not work either, since it would "reset" the pointer, but there
        // is no sensible location it could point to.
        // delete y;
        g(x); // calls g, handing over a reference to x
        h(x); // calls h and creates an independent, temporary copy in memory
    }

    function g(uint[] storage) internal pure {}
    function h(uint[] memory) public pure {}
}

//another example :
function sayHello() public view returns (string memory)

//use "pure" here to make a calculation, but not save the state anywhere
    function retrieve(uint256 favoriteNumber) public pure returns(uint256) {
        favoriteNumber + favoriteNumber; 

----------------------------------------------------------------------------------

// we can create functions, modifiers, structs, arrays, and mappings in solidity 
//becuase solidity is a static language you always need to declare your data types and variable states

    
// Visibility - public, internal , external, private  variables define what can be called from where

//Public -  out side contracts are able to read from, but not write to. functions are public by default, unless you declare the visibility  
//Private - This means only other functions within our contract will be able to call this function
//Internal - is the same as private, except that it's also accessible to contracts that inherit from this contract.
//External - is similar to public, except that these functions can ONLY be called outside the contract — they can't be called by other functions inside that contract. 

---------------------------------------------------------------------------------
//  Functions - Functions are usually defined inside a contract, but they can also be defined outside of contracts.
// Function types come in two flavours - internal and external and have different levels of visibility towards other contracts.
// Internal functions can only be called inside the current contract (more specifically, inside the current code unit, which also includes internal library functions and inherited functions) 
// External functions consist of an address and a function signature and they can be passed via and returned from external function calls.

//Functions accept parameters and return variables to pass parameters and values between them.
//template : 
function (<parameter types>) {internal|external} [pure|view|payable] [returns (<return types>)]


//In contrast to the parameter types, the return types cannot be empty - if the function type should not return anything, the whole returns (<return types>) part has to be omitted.
//By default, function types are internal, so the internal keyword can be omitted. Note that this only applies to function types. Visibility has to be specified explicitly for functions defined in contracts, they do not have a default.

// Helper function defined outside of a contract
function helper(uint x) pure returns (uint) {
    return x * 2;
}


//this is defining a "public" function called _favoritenumber, that will set the 'favorite number object' equal the new function 
    function store(uint256 _favoriteNumber) public{ 
    favoriteNumber = _favoriteNumber; 
    }


//function that is returning something - "view" and "pure" are two non-state changing functions(that dont have to make transactions to eth evm) 
//view = just reading off of the blockchain
    function retrieve() public view returns(uint256){
        return favoriteNumber;
    }


// "Constructors" are only run when the contract is created
//create permission so certian people can call certian functions (kind of like having an owner/admin)
constructor(){ 
    owner = msg.sender
}
address owner; 
modifier onlyOwner() {
    require(msg.sender ==o owner) 
} 
//^^ Modifiers are logic that are used to modify other functions, usually to check some requirements prior to execution. we have to create modifiers 1st then attach them to a function
//modifier "onlywhileopen" is logic that says a function can only be ran while open (timestamp) 
uint256 opentime = 1655808459; 
modifier onlyWhileOpen(){
require( block.timestamp >= openingtime)
 }
//^^^ "Require" makes it so that the function will throw an error and stop executing if some condition is not true. Put a require statement at the beginning of a function




//  Returns
//To return a value from a function, the declaration looks like this:
string greeting = "What's up dog";
function sayHello() public returns (string memory) {
  return greeting;
}
/////handeling multiple returns 
function multipleReturns() internal returns(uint a, uint b, uint c) {
  return (1, 2, 3);
}
function processMultipleReturns() external {
  uint a;
  uint b;
  uint c;
  // This is how you do multiple assignment:
  (a, b, c) = multipleReturns();
}

// Or if we only cared about one of the values:
function getLastReturnValue() external {
  uint c;
  // We can just leave the other fields blank:
  (,,c) = multipleReturns();
}



// Payable   -  to send money to a smart contract need a special fucntion called "payable" to receive payment  and show balance after 
    recieve() payable external {
        balance += msg.value;  
    }
//to make contract be able to accept some type of payment , can use "payable" ( this function can be used to pay for things) 
//in remix, every function you make you can assign a "value" to, this will be associated with a wei (gas) 
contract fundme { 
//to keep track of people who send you money, you can create a mapping that 
mapping(address =>uint256) public addresstoAmountFundeded
    function fund() public payable { 
        addresstoAmountFunded[msg.sender]+= msg.value; 
        //^^msg.sender = sender of money , msg.value = the amount they sent

    }
}

-------------------------------------------------------------------------------------
//Errors allow you to define descriptive names and data for failure situations. Errors can be used in revert statements.

/// Not enough funds for transfer. Requested `requested`,
/// but only `available` available.
error NotEnoughFunds(uint requested, uint available);

contract Token {
    mapping(address => uint) balances;
    function transfer(address to, uint amount) public {
        uint balance = balances[msg.sender];
        if (balance < amount)
            revert NotEnoughFunds(amount, balance);
        balances[msg.sender] -= amount;
        balances[to] += amount;
        // ...
    }
}
//The concept of “undefined” or “null” values does not exist in Solidity, but newly declared variables always have a default value dependent on its type. 
//To handle any unexpected values, you should use the revert function to revert the whole transaction, or return a tuple with a second bool value denoting success.

----------------------------------------------------------------------------------
//Structs allow you to create more complicated data types that have multiple properties. Structs allow for more arbitrary data types- example ; a “person struct” could have first_name ,last_name as strings. You could put structs inside arrays. 
//structs are ways to define new types in solidity( or new objects) 

//uint256 is at index 0 in the struct, string is at index 1 in the struct 
struct people {
    uint256 favoriteNumber;
    string name; 
}
//example of how to use the struct 
people public person = people {(favoriteNumber:2, name: "Patrick")} ; 

//example
contract Ballot {
    struct Voter { // Struct
        uint weight;
        bool voted;
        address delegate;
        uint vote;
    }

// another full example :

// Defines a new type with two fields.
// Declaring a struct outside of a contract allows it to be shared by multiple contracts.
struct Funder {
    address addr;
    uint amount;
}

contract CrowdFunding {
    // Structs can also be defined inside contracts, which makes them visible only there and in derived contracts.
    struct Campaign {
        address payable beneficiary;
        uint fundingGoal;
        uint numFunders;
        uint amount;
        mapping (uint => Funder) funders;
    }

    uint numCampaigns;
    mapping (uint => Campaign) campaigns;

    function newCampaign(address payable beneficiary, uint goal) public returns (uint campaignID) {
        campaignID = numCampaigns++; // campaignID is return variable
        // We cannot use "campaigns[campaignID] = Campaign(beneficiary, goal, 0, 0)"
        // because the right hand side creates a memory-struct "Campaign" that contains a mapping.
        Campaign storage c = campaigns[campaignID];
        c.beneficiary = beneficiary;
        c.fundingGoal = goal;
    }

    function contribute(uint campaignID) public payable {
        Campaign storage c = campaigns[campaignID];
        // Creates a new temporary memory struct, initialised with the given values
        // and copies it over to storage.
        // Note that you can also use Funder(msg.sender, msg.value) to initialise.
        c.funders[c.numFunders++] = Funder({addr: msg.sender, amount: msg.value});
        c.amount += msg.value;
    }

    function checkGoalReached(uint campaignID) public returns (bool reached) {
        Campaign storage c = campaigns[campaignID];
        if (c.amount < c.fundingGoal)
            return false;
        uint amount = c.amount;
        c.amount = 0;
        c.beneficiary.transfer(amount);
        return true;
    }
}
//Struct types can be used inside mappings and arrays and they can themselves contain mappings and arrays.
//Note how in all the functions, a struct type is assigned to a local variable with data location storage. 
//This does not copy the struct but only stores a reference so that assignments to members of the local variable actually write to the state.



----------------------------------------------------------------------------------
//Arrays can be used to create list of an object or type, in this example list of "people"
//When you want a collection of something, you can use an array. There are two types of arrays in Solidity: fixed arrays and dynamic arrays: 
//below is a dynamic array of size 0 ( nothing inside) 
people[] public people; 

//fixed array with maximim of 1 person inside of it
people[1] public people; 

// Array with a fixed length of 2 elements:
uint[2] fixedArray;
// another fixed Array, can contain 5 strings:
string[5] stringArray;
// a dynamic Array - has no fixed size, can keep growing:
uint[] dynamicArray;
//fucntion to add person to the array 
function addPerson(string memory _name, uint256 _favoriteNumber) public {
    people.push ({favoriteNumber: _favoritenumber, name:_name}); 
}

//Array elements can be of any type, including mapping or struct

//.push() and .push(value) can be used to append a new element at the end of the array
//where .push() appends a zero-initialized element and returns a reference to it.

//Examples
contract ArrayContract {
    uint[2**20] aLotOfIntegers;
    // Note that the following is not a pair of dynamic arrays but a
    // dynamic array of pairs (i.e. of fixed size arrays of length two).
    // Because of that, T[] is always a dynamic array of T, even if T
    // itself is an array.
    // Data location for all state variables is storage.
    bool[2][] pairsOfFlags;

    // newPairs is stored in memory - the only possibility
    // for public contract function arguments
    function setAllFlagPairs(bool[2][] memory newPairs) public {
        // assignment to a storage array performs a copy of ``newPairs`` and
        // replaces the complete array ``pairsOfFlags``.
        pairsOfFlags = newPairs;
    }

    struct StructType {
        uint[] contents;
        uint moreInfo;
    }
    StructType s;

    function f(uint[] memory c) public {
        // stores a reference to ``s`` in ``g``
        StructType storage g = s;
        // also changes ``s.moreInfo``.
        g.moreInfo = 2;
        // assigns a copy because ``g.contents``
        // is not a local variable, but a member of
        // a local variable.
        g.contents = c;
    }

    function setFlagPair(uint index, bool flagA, bool flagB) public {
        // access to a non-existing index will throw an exception
        pairsOfFlags[index][0] = flagA;
        pairsOfFlags[index][1] = flagB;
    }

    function changeFlagArraySize(uint newSize) public {
        // using push and pop is the only way to change the
        // length of an array
        if (newSize < pairsOfFlags.length) {
            while (pairsOfFlags.length > newSize)
                pairsOfFlags.pop();
        } else if (newSize > pairsOfFlags.length) {
            while (pairsOfFlags.length < newSize)
                pairsOfFlags.push();
        }
    }

    function clear() public {
        // these clear the arrays completely
        delete pairsOfFlags;
        delete aLotOfIntegers;
        // identical effect here
        pairsOfFlags = new bool[2][](0);
    }

    bytes byteData;

    function byteArrays(bytes memory data) public {
        // byte arrays ("bytes") are different as they are stored without padding,
        // but can be treated identical to "uint8[]"
        byteData = data;
        for (uint i = 0; i < 7; i++)
            byteData.push();
        byteData[3] = 0x08;
        delete byteData[2];
    }

    function addFlag(bool[2] memory flag) public returns (uint) {
        pairsOfFlags.push(flag);
        return pairsOfFlags.length;
    }

    function createMemoryArray(uint size) public pure returns (bytes memory) {
        // Dynamic memory arrays are created using `new`:
        uint[2][] memory arrayOfPairs = new uint[2][](size);

        // Inline arrays are always statically-sized and if you only
        // use literals, you have to provide at least one type.
        arrayOfPairs[0] = [uint(1), 2];

        // Create a dynamic byte array:
        bytes memory b = new bytes(200);
        for (uint i = 0; i < b.length; i++)
            b[i] = bytes1(uint8(i));
        return b;
    }
}

-------------------------------------------------------------------------------
//Events are a way for your contract to communicate that something happened on the blockchain to your app front-end, which can be 'listening' for certain events and take action when they happen.
// Events allow clients to react to specific contract changes you declare
contract SimpleAuction {
    event HighestBidIncreased(address bidder, uint amount); // Event

    function bid() public payable {
        // ...
        emit HighestBidIncreased(msg.sender, msg.value); // Triggering event
    }
}
// example of declaring an event
event IntegersAdded(uint x, uint y, uint result);

function add(uint _x, uint _y) public returns (uint) {
  uint result = _x + _y;

//functions can trigger events using "emit" 
// fire an event to let the app know the function was called:
  emit IntegersAdded(_x, _y, result);
  return result;
}


---------------------------------------------------------------------------
//Mapping  - another way of storing organized data in Solidity. A mapping is essentially a key-value store for storing and looking up data. 
//They can be used  like databases when used with structs and arrays
//mapping data structure = a dictionary like data structure, or an associated array , with 1 value per key 

//template:
mapping(KeyType => ValueType)
//and variables of mapping type are declared using the syntax:
mapping(KeyType => ValueType) VariableName
//The "KeyType" can be any built-in value type, bytes, string, or any contract or enum type. Other user-defined or complex types, such as mappings, structs or array types are not allowed
//"ValueType" can be any type, including mappings, arrays and structs.


//example: 
people[] public people;
mapping (string => uint256) public nametofavoriteNumber; 

// Defining a mapping looks like this: For a financial app, storing a uint that holds the user's account balance:
mapping (address => uint) public accountBalance;
// Or could be used to store / lookup usernames based on userId
mapping (uint => string) userIdToName;

//the key data is not stored in a mapping, only its keccak256 hash is used to look up the value.
//Mappings can only have a data location of "storage" and thus are allowed for state variables, as storage reference types in functions, or as parameters for library functions. 
//They cannot be used as parameters or return parameters of contract functions that are publicly visible.
//These restrictions are also true for arrays and structs that contain mappings.



//"msg.sender" refers to the address of the person (or smart contract) who called the current function **In Solidity, function execution always needs to start with an external caller. A contract will just sit on the blockchain doing nothing until someone calls one of its functions. So there will always be a msg.sender.
//Here's an example of using msg.sender and updating a mapping:
mapping (address => uint) favoriteNumber;

function setMyNumber(uint _myNumber) public {
// Update our `favoriteNumber` mapping to store `_myNumber` under `msg.sender`
  favoriteNumber[msg.sender] = _myNumber;
// ^ The syntax for storing data in a mapping is just like with arrays
}

function whatIsMyNumber() public view returns (uint) {
// Retrieve the value stored in the sender's address
// Will be `0` if the sender hasn't called `setMyNumber` yet
  return favoriteNumber[msg.sender];
}
--------------------------------------------------------------------------
////Enums are one way to create a user-defined type in Solidity
//Enums -  can be used to create custom types with a finite set of ‘constant values. 
//An enum type is a special data type that enables for a variable to be a set of predefined constants. 
//The variable must be equal to one of the values that have been predefined for it. Common examples include compass directions (values of NORTH, SOUTH, EAST, and WEST) and the days of the week
//Enums require at least one member, and its default value when declared is the first member. Enums cannot have more than 256 members.
//Enums can also be declared on the file level, outside of contract or library definitions.

contract Purchase {
    enum State { Created, Locked, Inactive } // Enum
}
 //example -
contract test {
    enum ActionChoices { GoLeft, GoRight, GoStraight, SitStill }
    ActionChoices choice;
    ActionChoices constant defaultChoice = ActionChoices.GoStraight;

    function setGoStraight() public {
        choice = ActionChoices.GoStraight;
    }

    // Since enum types are not part of the ABI, the signature of "getChoice"
    // will automatically be changed to "getChoice() returns (uint8)"
    // for all matters external to Solidity.
    function getChoice() public view returns (ActionChoices) {
        return choice;
    }

    function getDefaultChoice() public pure returns (uint) {
        return uint(defaultChoice);
    }

    function getLargestValue() public pure returns (ActionChoices) {
        return type(ActionChoices).max;
    }

    function getSmallestValue() public pure returns (ActionChoices) {
        return type(ActionChoices).min;
    }
}

---------------------------------------------------------------------------
//import can be used to have one contract call another on thhe network
import "./SimpleStorage.sol"
//^^this is the equivalent of copying pasting the entire code fopr that .sol file 

//you need a function in the new contract to be able to make the call 
contract storagefactory {
    function createSimpleStorageContract () public {
// were gong to create an object "SimpleStorage" , of type SimpleStorage.sol, and name it simpleStorage and this will be a new SimpleStorage contract 
SimpleStorage simpleStorage = new SimpleStorage(); 
//to add each new contract created ^^ we will make an array and push it to that array list
SimpleStorage[] public simpleStorageArray; 
simpleStorageArray.push(simpleStorage); 
    }
}
//^^successfully deployed a c ontract to the blockchain using another contract

//to have a contract call another contracts functions ( create a function to call the "store function") 
function sfStore(uint256 _simpleStorageIndex, uint256 simpleStorageNumber) public {
//anytime you interact with a contract you need = 1. the adress 2. ABI ( you can get the ABI from .sol imports ) 
//ABI = 
}
} 

//inheret - you can have one contract inheret the functions of another by  = 
contract StorageFactory is SimpleStorage { 
}
//^^storagefactory now has all functions of SimpleStorage contract

//used to import one .sol file with another in the same directory. used when we want to split solidity code 
import "./someothercontract.sol";

contract newContract is SomeOtherContract {

}

}

-------------------------------------------------------------------------------------
//defining an interface for your contract. 
//we're not defining the function bodies. Instead of curly braces ({ and }), we're simply ending the function declaration with a semi-colon (;) This is how the compiler knows it's an interface.
//By including this interface in our dapp's code our contract knows what the other contract's functions look like, how to call them, and what sort of response to expect
contract NumberInterface {
  function getNum(address _myAddress) public view returns (uint);
}

//once defined the iterface, we can use it in a contract as follows; 
//In this way, your contract can interact with any other contract on the Ethereum blockchain, as long they expose those functions as public or external.
contract MyContract {
  address NumberInterfaceAddress = 0xab38... 
  // ^ The address of the FavoriteNumber contract on Ethereum
  NumberInterface numberContract = NumberInterface(NumberInterfaceAddress);
  // Now `numberContract` is pointing to the other contract

  function someFunction() public {
    // Now we can call `getNum` from that contract:
    uint num = numberContract.getNum(msg.sender);
    // ...and do something with `num` here
  }
}



----------------------------------------------------------------------
//delete -  

//example : 
contract DeleteExample {
    uint data;
    uint[] dataArray;

    function f() public {
        uint x = data;
        delete x; // sets x to 0, does not affect data
        delete data; // sets data to 0, does not affect x
        uint[] storage y = dataArray;
        delete dataArray; // this sets dataArray.length to zero, but as uint[] is a complex object, also
        // y is affected which is an alias to the storage object
        // On the other hand: "delete y" is not valid, as assignments to local variables
        // referencing storage objects can only be made from existing storage objects.
        assert(y.length == 0);
    }
}

------------------------------------------------------------------------------------
///IF statments in solidity look just like JS
function eatBLT(string memory sandwich) public {
  // Remember with strings, we have to compare their keccak256 hashes
  // to check equality
  if (keccak256(abi.encodePacked(sandwich)) == keccak256(abi.encodePacked("BLT"))) {
    eat();
  }
}

---------------------------------------------------------------------------------



//flow of syntax to define any variabke in solidity = type of var(uint356) visibility of var (public) name of var 


}