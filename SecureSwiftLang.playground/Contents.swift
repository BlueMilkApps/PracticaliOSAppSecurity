import UIKit


//: ## Type Safety and Mutability
//: Explicit and Inferred with constants and variables
let firstName: String = "Jim"
let lastName = "Bob"

//firstName = "We Like Beer!"
//firstName: Int = 12345
let fullName = firstName + " " + lastName

var fact = "I Like Beer"
fact = "I Like Beer and Pizza"
fact += " and Swift"


//: ## String Safety
//printf("Nice try %x", firstName)

class Dog: NSObject {
    var name: String
    var breed: String
    
    init(name: String, breed: String){
        self.name = name
        self.breed = breed
    }
}

let myDog = Dog(name: "Spot", breed: "Snoopy-kind")
println("My dog's name is \(myDog.name)")

// Still beware of Cocoa's NSString and the old school format-specifiers - %x, %p, etc.
//let someString = NSString(format:"Hello Mem Addrs! %p", firstName)

//: ## Definitive Init
let favoriteBeer: String
let age = 37

// Not init'd yet
//println(favoriteBeer)

if age < 28 {
    favoriteBeer = "Miller Lite"
}else{
    favoriteBeer = "Anchor Steam"
}

println(favoriteBeer)


//: ## Integer Overflow
//// Highest positive Int
Int.max
//
//// Set a variable at it
var a = 9223372036854775807
//
//// Overflow trapped and reported out (crash, good thing)
//a += 1
//
//// Forced overflow behavior
a = a &+ 1


//: ## Array Bounds Checking
let fruit = ["Apple", "Banana", "Orange"]
//
fruit[1]
// Crash, good thing
//fruit[3]
