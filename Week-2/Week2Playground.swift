//----------------------------------------------------------------------------------------
// - Jeff Henry
// - Coursera - Swift Programming by University of Toronto
// - Week 2 - Swift Basics
// - 01/06/2016
// - Lesson Notes with Comments
//----------------------------------------------------------------------------------------

import UIKit

//------------------- Variable Declarations -------
var str:String? = "Hello"       // Create a variable called str, assign it a type of String, ? Says it might change. (Kind of redundent)

str = nil                       // If variable is set to ?, it can be set to nil even if it is a string.

str = "Hello"

let constantString = "Hello"    // Let command sets a variable to a constant value like a #define in C (Can't be modified)

print(str)                      // Similar to a console print statement

print(constantString)

//------------------- If/Else Statements -------------------
let name = "Jeffrey"
if (name.characters.count > 7) {
    print ("Long Name")
}
else if (name.characters.count > 5) {
    print ("Medium Name")
}
else {
    print ("Short Name")
}


//------------------- Switch Statments -------------------
switch name.characters.count {
case 8...10: print("Long Name")         // Range of values between 8 and 10
case 5..<8: print("7 Character Name")   // <= 7
case 5: print("5 Character Name")       // = 5
default: print("Some Length")           // Default statement
}


//------------------- While Loop -------------------
var number = 0
while number < 10 {
    number++
}

//------------------- For Loops -------------------
for (var number = 0 ; number < 10 ; number++){
    number
}

for number in 0..<10 {                      // Alternate shorthand of a for loop
    number
}

for number in [2,5,1,9,6] {                 // Iterates through an array
    number
}



//------------------- Arrays -------------------
var animals:[String] = ["Dog" , "Horse" , "Cat"]     // Defined array
animals[0]
animals[1]
animals[2]

animals[2] = "Monkey"
animals

//------------------- Dictionaries -------------------
// Mapping Keys to values, similar to hashes

var size = ["Dog" : "Medium" ,                 // Key : Value
            "Horse" : "Large" ,
            "Cat" : "Small" ,
            "Monkey" : "Small"]

size [ "Dog" ]
size [ "Cat" ]
size [ "Monkey" ]
size [ "Horse" ]
size [ "Elephant" ]                            // Key that isn't in the dictionary returns nil

let dogsize = size[ "Dog" ]                    // Dictionary values can be stored to a variable

for index in animals {
    size[ index ]                              // Loops through size array using dictionary lookup to animals array
}

//------------------- Functions -------------------
func doMath(a:Double , b:Double, op:String) -> Double   // -> "Return" - Specifies the return type
{
    var result:Double = 0
    switch op {
        case "+": result = a + b
        case "-": result = a - b
        case "/": result = a / b
        case "*": result = a * b
    default: print("Bad Operator:",op)
    }
    return result
}

doMath(2.0, b: 3.0, op: "+")                        // a: doesn't need to be specified for first parameter
doMath(3.0, b: 2.0, op: "-")
doMath(6.0, b: 3.0, op: "/")
doMath(2.0, b: 3.0, op: "*")

//------------------- 2D Arrays -------------------

var array = [
        [1, 3, 5],
        [2, 4, 6],
        [7, 8, 9]
]

func raiseLowerValuesOfImage(inout image:[[Int]]){      // Type - Array of Array of Int, which is why there are double brackets
                                                        // inout allows the parameter to be modified (by reference)
    for row in 0..<image.count {
        for column in 0..<image[row].count {
            image[row][column]
            if (image[row][column] < 5) {
                image[row][column] = image[row][column] + 1
            }
        }
    }
    image
}

// Pass the array by reference
raiseLowerValuesOfImage(&array)

// Verify that the values were saved to the original variable
array
