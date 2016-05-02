//: [Previous](@previous)

import Foundation

let date = NSDate()
date.description

let dateFormatter = NSDateFormatter()
dateFormatter.dateStyle = .MediumStyle
dateFormatter.timeStyle = NSDateFormatterStyle.ShortStyle
dateFormatter.stringFromDate(date)

// Enums test
enum CompassPoint {
    case North
    case South
    case East
    case West
}

var directionLong = CompassPoint.West
directionLong = .East // short, because the type is known

let directionShort: CompassPoint = .West // explicit type


let destination: NSDate? = dateFormatter.dateFromString("Oct 26, 1985, 01:21 AM")

let ransom = 1_000_000
let numberFormatter = NSNumberFormatter()
numberFormatter.numberStyle = .CurrencyStyle
numberFormatter.stringFromNumber(ransom)

numberFormatter.maximumFractionDigits = 0
numberFormatter.stringFromNumber(ransom)

//: [Next](@next)
