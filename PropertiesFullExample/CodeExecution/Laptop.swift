//
//  Laptop.swift
//  PropertiesFullExample
//
//  Created by test on 01.08.2022.
//

import Foundation

// good link https://useyourloaf.com/blog/swift-lazy-property-initialization/

class Laptop {
    
    var someNumber = 15
    let someConst = 20
    
    var someInteger: Int
    // var someInteger = 55
    
    // it's still a stored property but with observers
    // will set
    // did set
    // it allows us to 'track' in some way when we change the value and perform some action depending on it
    var age: Int {
        // by default it's called 'newValue', but for our convenience we can give the variable a different name
        willSet (newValueFancyName) {
            print("Going to set new Value to age: \(newValueFancyName)")
            print("Current value of age: \(age)")
        }
        // by default it's called 'oldValue', but for our convenience we can give the variable a different name
        didSet(oldValueFancyName) {
            print("Have set new Value to the age variable, old value was: \(oldValueFancyName)")
            print("New value of age: \(age)")
        }
    }
    
    
    
    init(age: Int) {
        // instead of writing it here for all variables, we can move initialization to the top
        // because each class instance anyways will have that value
        someInteger = 55
        
        self.age = age
        
        print("Laptop was created")
        
        self.age = 25
    }
    
    func changeAge(age: Int){
        self.age = 33
    }
        
    
    struct SomeStructWithInteger {
        var someInt: Int
    }
    
    class SomeClassWithInteger {
        var someInt: Int
        
        init(someInt: Int){
            self.someInt = someInt
        }
    }
}
