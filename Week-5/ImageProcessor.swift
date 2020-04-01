//----------------------------------------------------------------------------------------
// - Jeff Henry
// - Coursera - Swift Programming by University of Toronto
// - Week 5
// - 01/12/2016
//
// Supported Filters
//      1) Warm Filter
//      2) Cool Filter
//      3) 50% Brightness
//      4) 150% Brightness
//      5) Grayscale
//
//  Instructions for use:
//      At the very end of the file, uncomment the different filter options and click the 
//      eye icon to see the result of the filtering. I have added 3 different combinations 
//      of filters, but feel free to mix and match.
//
//----------------------------------------------------------------------------------------
import UIKit
import Darwin

// Original Image
let image = UIImage(named: "sample")!

//==================================================================================================
// Image Processor Stuct
//==================================================================================================
class ImageProcessor {
    let image: RGBAImage
    var avgRed = 0
    var avgGreen = 0
    var avgBlue = 0
    
    init(image: UIImage) {
        self.image = RGBAImage(image:image)!
    }
    
    //==================================================================================================
    // Function:    process
    // Parameters:  Array of Filters to process
    // Returns:     None
    //==================================================================================================
    func process(filter: [String]){
        self.getAverages(self.image)
        
        for option in filter {
            switch option.lowercaseString {
            case "warm filter":
                self.warmFilter(self.image)
            case "cool filter":
                self.coolFilter(self.image)
            case "50% brightness":
                self.brightnessAdjust(self.image, percent: 50)
            case "150% brightness":
                self.brightnessAdjust(self.image, percent: 150)
            case "grayscale":
                self.grayscale(self.image)
            default:
                print("The filter", option.lowercaseString , "is not supported.")
            }
        }
    }
    
    //==================================================================================================
    // Function:    getAverages
    // Parameters:  image to reference
    // Returns:     None
    //==================================================================================================
    func getAverages(image: RGBAImage) {
        
        var totalRed = 0
        var totalGreen = 0
        var totalBlue = 0
        
        // Loop through the pixels and calculate the totals for Red, Blue, and Green
        for y in 0..<image.height {                 // For each y location
            for x in 0..<image.width {              // For each x location
                let index = y * image.width + x     // Grab the index of that coordinate [x,y]
                var pixel = image.pixels[index]     // Get the pixel object of that index
                totalRed += Int(pixel.red)          // Sum the red values
                totalGreen += Int(pixel.green)      // Sum the green values
                totalBlue += Int(pixel.blue)        // Sum the blue values
            }
        }
        
        //Lets do something with this data:
        let count = image.width * image.height
        self.avgRed = totalRed/count
        self.avgGreen = totalGreen/count
        self.avgBlue = totalBlue/count
    }
    
    //==================================================================================================
    // Function:    warmFilter
    // Param:       RGBAImage to be modified
    // Returns:     None
    //==================================================================================================
    func warmFilter(image: RGBAImage) {
        // Filter the image:
        for y in 0..<self.image.height {                     // For each y location
            for x in 0..<self.image.width {                  // For each x location
                let index = y * self.image.width + x         // Grab the index of that coordinate [x,y]
                var pixel = self.image.pixels[index]         // Get the pixel object of that index
                let redDiff = Int(pixel.red) - avgRed       // Determine how different the current pixel is from red.
                if(redDiff > 0) {
                    // Changes the pixel to be a 2.5x factor of the existing red.
                    pixel.red = UInt8( max (0, min (255, avgRed + redDiff * 2)))
                    pixel.blue = UInt8( max (0, min (255, avgBlue + redDiff / 2)))
                    
                    //Write the pixel back to the RGBA Image
                    self.image.pixels[index] = pixel
                }
            }
        }
    }
    
    //==================================================================================================
    // Function:    coolFilter
    // Param:       RGBAImage to be modified
    // Returns:     None
    //==================================================================================================
    func coolFilter(image: RGBAImage) {
        // Filter the image:
        for y in 0..<self.image.height {                     // For each y location
            for x in 0..<self.image.width {                  // For each x location
                let index = y * self.image.width + x         // Grab the index of that coordinate [x,y]
                var pixel = self.image.pixels[index]         // Get the pixel object of that index
                let redDiff = Int(pixel.red) - avgRed       // Determine how different the current pixel is from red.
                if(redDiff > 0) {
                    // Changes the pixel to be a 2.5x factor of the existing red.
                    pixel.red = UInt8( max (0, min (255, avgRed + redDiff / 2)))
                    pixel.blue = UInt8( max (0, min (255, avgBlue + redDiff * 2)))
                    
                    //Write the pixel back to the RGBA Image
                    self.image.pixels[index] = pixel
                }
            }
        }
    }
    
    //==================================================================================================
    // Function:    brightnessAdjust
    // Parameters:  RGBAImage to be modified, % Brightness to adjust
    // Returns:     None
    //==================================================================================================
    func brightnessAdjust(image: RGBAImage , percent: Int) {
        // Calculate the adjustment multiplier
        let adjust = Double(percent) / 100
        
        // Filter the image:
        for y in 0..<self.image.height {                     // For each y location
            for x in 0..<self.image.width {                  // For each x location
                let index = y * self.image.width + x         // Grab the index of that coordinate [x,y]
                var pixel = self.image.pixels[index]         // Get the pixel object of that index
                
                // Modify the pixel by the adjustment percentage
                let red = round(Double(pixel.red) * adjust)
                let blue = round(Double(pixel.blue) * adjust)
                let green = round(Double(pixel.green) * adjust)
                
                // Update the pixel
                pixel.red = UInt8( max (0, min (255, red)))
                pixel.blue = UInt8( max (0, min (255, blue)))
                pixel.green = UInt8( max (0, min (255, green)))
                
                //Write the pixel back to the RGBA Image
                self.image.pixels[index] = pixel
            }
        }
        
    }
    
    //==================================================================================================
    // Function:    greyscale
    // Parameters:  RGBAImage to be modified
    // Returns:     None
    //==================================================================================================
    func grayscale(image: RGBAImage) {
        // Filter the image:
        for y in 0..<self.image.height {                     // For each y location
            for x in 0..<self.image.width {                  // For each x location
                let index = y * self.image.width + x         // Grab the index of that coordinate [x,y]
                var pixel = self.image.pixels[index]         // Get the pixel object of that index
                
                // Calculate the greyscale value
                let gray = 0.299 * Double(pixel.red) + 0.587 * Double(pixel.green) + 0.114 * Double(pixel.blue)
                let grayRounded = round(gray)
                
                // Update the pixels:
                pixel.red = UInt8(grayRounded)
                pixel.green = UInt8(grayRounded)
                pixel.blue = UInt8(grayRounded)
                
                // Write the pixel back to the RGBA Image
                self.image.pixels[index] = pixel
            }
        }
    }
    
    //==================================================================================================
    // Function:    toUIImage
    // Parameters:  None
    // Returns:     RGBAImage converted into UIImage
    //==================================================================================================
    func toUIImage() -> UIImage {
        return self.image.toUIImage()!
    }
}

//==================================================================================================
// Perform Function calls below
// Available Filters:
//      1) Warm Filter
//      2) Cool Filter
//      3) 50% Brightness
//      4) 150% Brightness
//      5) Grayscale
//==================================================================================================

// Image Processor Objects
let filter1 = ImageProcessor(image: image)
let filter2 = ImageProcessor(image: image)
let filter3 = ImageProcessor(image: image)

// -------------- Uncomment the options below to see different combinations ---------------

//filter1.process(["Warm Filter", "150% Brightness"])
//let processedImage1 = filter1.toUIImage()

//filter2.process(["Cool Filter", "50% Brightness"])
//let processedImage2 = filter2.toUIImage()

//filter3.process(["Grayscale"])
//let processedImage3 = filter3.toUIImage()
