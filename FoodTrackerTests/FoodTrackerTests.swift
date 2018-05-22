//
//  FoodTrackerTests.swift
//  FoodTrackerTests
//
//  Created by snow on 2018/4/10.
//  Copyright © 2018年 skcc. All rights reserved.
//

import XCTest
@testable import FoodTracker

class FoodTrackerTests: XCTestCase {
    
   //MARKL Meal Class Tests
    
    
    // Confirm that the Neal initializer returns a Meal object when passed valid parameters
    
    func testMealInitializationSucceeds(){
        
        // Zero rating
        
        let zeroRatingMeal = Meal.init(name: "Zero", photo: nil, rating: 0)
        
        XCTAssertNotNil(zeroRatingMeal)
        
        
        // Highest positive rating
        
        let positiveRatingMeal = Meal.init(name:"Positive", photo: nil, rating: 0)
        
        XCTAssertNotNil(positiveRatingMeal)
        
        
    }
    
    func testException(){
        // rating exceeds maximum
        
        let largeRatingMeal = Meal.init(name: "Large", photo: nil, rating: 1)
        
        XCTAssertNotNil(largeRatingMeal)
        
    }
    
}
