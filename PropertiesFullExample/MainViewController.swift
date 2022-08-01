//
//  ViewController.swift
//  PropertiesFullExample
//
//  Created by test on 01.08.2022.
//

import UIKit

class MainViewController: UIViewController {

    @IBOutlet weak var laptopAgeLabel: UITextField!
    
    @IBAction func laptopAgeEditingEnded(_ sender: Any) {
        print("Laptop age editing ended: \(laptopAgeLabel.text)")
        
        if let text = laptopAgeLabel.text, let number = Int(text){
            //laptop.age = number
            laptop.changeAge(age: number)
        }else{
            print("Couldn't convert text '\(laptopAgeLabel.text)' to int")
        }
    }
    
    // this thing is nil initially, we can use optional binding to check for nil
    // we can also try to reach inner value straight away, but this will cause an Exception and the app will crash
    var laptop: Laptop!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .blue
        
        if let laptop = laptop{
            print("laptop is initialized, it's age: \(laptop.age)")
        }else{
            print("laptop is not initialized")
        }
        
        
        print("Instead of initializer, on viewDidLoad we pretend like this method is init for ViewController")
        laptop = Laptop(age: 5)
        
        //someTests()
        
        //someTests_2_MoreProperties()
    }
    
//    init() {
//        super.init()
//        print("Laptop init was called")
//    }
//
//    required init?(coder: NSCoder) {
//        print("Laptop required init was called")
//        fatalError("init(coder:) has not been implemented")
//    }
    
    func someTests(){
        // we can call init on classes and structs explicitly (explicit (явно) / implicit (неявно))
        var someInt: Laptop.SomeClassWithInteger = Laptop.SomeClassWithInteger.init(someInt: 5)
        var someInt2: Laptop.SomeStructWithInteger = Laptop.SomeStructWithInteger.init(someInt: 5)
        
        // here we create instances with initialized implicitly
        var someInt3 = Laptop.SomeStructWithInteger(someInt: 6)
        
        // it's still optional that can be nil or has value
        var someOtherVar: Laptop.SomeStructWithInteger!
        
        // will cause an app crash
        //print(someOtherVar.someInt)
        
        // check if value exists with optional binding
        if let value = someOtherVar {
            
        }
        
        // passing different values to methods with enums
        someTests_2(customEnum: .FirstValue(someInt: 5))
        someTests_2(customEnum: .SecondValue(someString: "Hello"))
        
        // _____
        
        someTests_3()
        
        // _____
        
        someCrazyTests()
    }
    
    func someTests_2(customEnum: CustomEnumToPassDataAround){
        
        // Me and other devs prefer for auto-complete to fill in swithc statements with different values
        switch customEnum {
        case .FirstValue(let someInt):
            print("Enum passed some int value: \(someInt)")
        case .SecondValue(let someString):
            print("Enum passed some string value: \(someString)")
        }
    }
    
    // ____
    enum CustomEnumToPassDataAround {
        case FirstValue(someInt: Int)
        case SecondValue(someString: String)
        // recursive enum
        //case ThirdValue(someEnum: CustomEnumToPassDataAround)
    }
    
    // raw value is string
    enum CustomStringEnum: String{
        case Cat
        case Dog
        case Hello
    }
    
    enum CustomIntEnum: Int {
        case First = 1
        case Second = 2
        case Third = 3
    }
    
    func someTests_3(){
        var stringCatValue = "Cat"
        
        // try to convert string to enum, the result is optional
        var someEnum = CustomStringEnum(rawValue: stringCatValue)
        print(someEnum!)
        
        // transformed integer 2 to enum with value "Second"
        // this is with help of 'RawValue'
        var someInt = 2
        var someIntEnum = CustomIntEnum(rawValue: someInt)
        print(someIntEnum!)
    }
    
    enum SomeInterestingEnum {
        // error: Enum with raw type cannot have cases with arguments
        case First(someStringToPass: String) // = "FirstEnum"
        case SecondEnum(someStringToPass: String) //  = "SecondEnum"
    }
    
    
    func someCrazyTests(){
        giveMeValue(someEnum: .doSomethingElse(someString_2: "Hello", someOtherInt: 228))
    }
    
    func giveMeValue(someEnum: SomeEnumWithInnerDataTypes.SomeStruct_1.SomeEnumWithSuperInnerValue.SomeStruct_2.SomeSuperSuperEnum){
        switch someEnum {
            
        case .doSomething(someString: let someString):
            print("passed value around")
        case .doSomethingElse(someString_2: let someString_2, someOtherInt: let someOtherInt):
            print("passed 2 values around: \(someString_2), \(someOtherInt))")
        }
    }
    
    // please don't do something like that, it doesn't make a lot of sense
    enum SomeEnumWithInnerDataTypes {
        struct SomeStruct_1 {
            enum SomeEnumWithSuperInnerValue {
                struct SomeStruct_2 {
                    enum SomeSuperSuperEnum {
                        case doSomething(someString: String)
                        case doSomethingElse(someString_2: String, someOtherInt: Int)
                    }
                }
            }
        }
    }
    
    // ________________________________
    
    func someTests_2_MoreProperties(){
        print(computer)
        
        computer = Computer(age: 11, power: 100)
    }
    
    private var innerComputer: Computer?
    
    var computer: Computer {
        // newValue are also accessible in set, oldValue - doesn't exist
        get{
            print("Getting stored Computer property")
            // if innerComputer is nil, will just create a new computer and return it (but won't record it)
            //return innerComputer ?? Computer(age: 3, power: 12)
            
            if let computerToReturn = innerComputer {
                return computerToReturn
            }else{
                innerComputer = Computer(age: 3, power: 12)
                return innerComputer!
            }
        }
        set{
            print("Setting stored Computer property, new value will be: \(newValue)")
            innerComputer = newValue
        }
    }
    
    // consider computed property above, as a replacement to the code below
    
    func getComputer() -> Computer {
        if let computerToReturn = innerComputer {
            return computerToReturn
        }else{
            innerComputer = Computer(age: 3, power: 12)
            return innerComputer!
        }
    }
    
    func setComputer(computerToSet: Computer){
        innerComputer = computerToSet
    }
    
    // ________________________________
    
    func someTests_regularLazyProperties(){
        
    }
    // first thing will be created instantly after viewDidLoad (actually when instance of ViewController via init is created)
    // in fact PLEASE UNCOMMENT LINE BELOW there will be an exception
    //private  var innerComputer1: Computer = createComputerNormal()
    // second will be called only when try to reach innerComputer2
    private lazy var innerComputer2: Computer = createComputerLazy()
    
    func createComputerNormal() -> Computer {
        print(#function)
        return Computer(age: 12, power: 23)
    }
    func createComputerLazy() -> Computer {
        print(#function)
        return Computer(age: 12, power: 23)
    }
    
    @IBAction func pressedComputerTests(_ sender: Any) {
        print(#function)
        
        print(innerComputer2)
    }
    
    
    // __________
    
    @IBAction func computerTests_2(_ sender: Any) {
        print(#function)
        
        print(computerCeatedWithClosure)
        print(computerCeatedWithClosure)
        print(computerCeatedWithClosure)
        
        print(lazyComputerCeatedWithClosure)
        print(lazyComputerCeatedWithClosure)
        print(lazyComputerCeatedWithClosure)
    }
    
    // this thing creates computer after initialization of instance of viewController, then
    // computerCeatedWithClosure is just a regular stored property
    var computerCeatedWithClosure: Computer = {
        print("Closure is working only once, then the value is stored in a stored-property")
        return Computer(age: 11, power: 1000)
    }()
    
    lazy var lazyComputerCeatedWithClosure: Computer = {
        print("LAZY Closure is working only once, then the value is stored in a stored-property")
        return Computer(age: 11, power: 1000)
    }()
    
    
}

