//----------------------------------------------------------------------------------------
// - Jeff Henry
// - Coursera - Swift Programming by University of Toronto
// - Week 4 - Image Processing
// - 01/10/2016
// - Lesson Notes with Comments
//----------------------------------------------------------------------------------------

import UIKit

// This can be any image, just add it to the resources folder of the playground. Smaller images recommended (100 x 100)
let image = UIImage(named: "Forest.png")!

// Convert the image into the RGBAImage type
let myRGBA = RGBAImage(image: image)!

let x = 25
let y = 25

// Every column is sequentually stacked, therefore to get the index, you must go through
// y rows and then x columns over.
let index = y * myRGBA.width + x

// Get the pixel at that index
var pixel = myRGBA.pixels[index]

// Let's check some of those pixel colors
pixel.red
pixel.blue
pixel.green

// Let's change those pixel colors
pixel.red = 255
pixel.green = 0
pixel.blue = 0

// Convert the new image back to UIImage
let newImage = myRGBA.toUIImage()

//----------------------------------------------------------------------------------------
/* - Commented out after determining averages - Uncomment in playground to see caclulations
//----------------------------------------------------------------------------------------
var totalRed = 0
var totalGreen = 0
var totalBlue = 0

// Let's try some changes with a loop (Image is 100x100, so it will loop 10000 times):
for y in 0..<myRGBA.height {                // For each y location
    for x in 0..<myRGBA.width {             // For each x location
        let index = y * myRGBA.width + x    // Grab the index of that coordinate [x,y]
        var pixel = myRGBA.pixels[index]    // Get the pixel object of that index
        totalRed += Int(pixel.red)          // Sum the red values
        totalGreen += Int(pixel.green)      // Sum the green values
        totalBlue += Int(pixel.blue)        // Sum the blue values
    }
}

//Lets do something with this data:
let count = myRGBA.width * myRGBA.height
let avgRed = totalRed/count
let avgGreen = totalGreen/count
let avgBlue = totalBlue/count
//----------------------------------------------------------------------------------------*/

// Averages determine using above for loop:
let avgRed = 87
let avgGreen = 47
let avgBlue = 26

// Lets modify more than one pixel:
for y in 0..<myRGBA.height {                    // For each y location
    for x in 0..<myRGBA.width {                 // For each x location
        let index = y * myRGBA.width + x        // Grab the index of that coordinate [x,y]
        var pixel = myRGBA.pixels[index]        // Get the pixel object of that index
        let redDiff = Int(pixel.red) - avgRed   // Determine how different the current pixel is from red.
        if(redDiff > 0) {                       // Change the pixel if the red difference > 0
            // Changes the pixel to be a 5x factor of the existing red.
            // Use min to avoid going over 255
            // Use max to avoid going negative
            pixel.red = UInt8( max (0, min (255, avgRed + redDiff*5)))
            
            //Write the pixel back to the RGBA Image
            myRGBA.pixels[index] = pixel
        }
    }
}

// Show these images to see the differences
let newRedImage = myRGBA.toUIImage()    // Filtered Image
image                                   // Original Image
