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
    
    dynamic var firstName = ""
    dynamic var lastName = ""
    
    dynamic var fullName: String {
        return "\(firstName) \(lastName)"
    }
    
    class func keyPathsForValuesAffectingFullName() -> NSSet {
        print("Somebody has called me")
        
        return Set(["firstName", "lastName"])
    }
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

class Observer: NSObject {
    dynamic var temp = 1;
    
    override func observeValueForKeyPath(keyPath: String?, ofObject object: AnyObject?, change: [String : AnyObject]?, context: UnsafeMutablePointer<Void>) {
        print("Somebody has changed \(keyPath) of \(object), value \(change), context: \(context)")
    }
}

var observer = Observer()
observer.addObserver(observer, forKeyPath: "temp", options: NSKeyValueObservingOptions.Old, context: nil);

observer.temp = 2;
observer.temp = 3;

var person = Person()
person.firstName = "Vest"
person.lastName = "Master"
person.fullName


