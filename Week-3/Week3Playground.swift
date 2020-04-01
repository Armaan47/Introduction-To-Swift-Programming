//----------------------------------------------------------------------------------------
// - Jeff Henry
// - Coursera - Swift Programming by University of Toronto
// - Week 3 - Advanced Swift
// - 01/08/2016
// - Lesson Notes with Comments
//----------------------------------------------------------------------------------------

import UIKit

//Optionals, Closures, and Properties

var str:String = "String"           // Variable can only be a string
var optional:String? = "Optional"   // Variable could be a string or could be something else down the line.
optional!.characters.count          // ! Froces it to be a string before evaluating the count

func performMagic (spell: String) -> String {
    return spell
}


let attack = performMagic("Firaga")

// Counter inherits function
let counter = performMagic
counter("Blizzard")

// Alternate function declaration - Closures
var newPerformMagic = {
    (spell:String) -> String in
    return spell
}

newPerformMagic("Haste")

// Structs:

struct Animal {
    var name: String = ""
    var heightInches = 0.0
    var heightCm: Double {
        get {
            return 2.54 * heightInches
        }
        set (newHeightCM){
            heightInches = newHeightCM / 2.54
        }
    }
}

let dog = Animal ( name: "dog" , heightInches: 40)
dog.heightInches
dog.heightCm

var dog2 = Animal (name: "mini" , heightInches: 60)
dog2.heightInches
dog2.heightCm

dog2.heightCm = 254
dog2.heightInches


let noValue:Int? = nil
//let unwrappedValue = noValue! - Will Crash at the second line
