//: Playground - noun: a place where people can play

import Cocoa

var str = "Hello, playground"

class Student: NSObject {
    var name = ""
    var gradeLevel = 0
}

let s = Student()
s.setValue("Kelly", forKey: "name")
s.setValue(3, forKey: "gradeLevel")

s.name
s.gradeLevel

s.valueForKey("name")
s.valueForKey("gradeLevel")

class Person: NSObject {
    var spouse: Person? = nil
    var scooter: Scooter? = nil
}

class Scooter: NSObject {
    var modelName: String? = nil
}

let scooter = Scooter()
scooter.modelName = "BV250"
let selectedPerson = Person()
selectedPerson.spouse = Person()
selectedPerson.spouse?.scooter = scooter

let modelName = selectedPerson.valueForKeyPath("spouse.scooter.modelName") as! String
