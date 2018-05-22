//
//  Meal.swift
//  FoodTracker
//
//  Created by snow on 2018/4/12.
//  Copyright © 2018年 skcc. All rights reserved.
//  冯剑
//

import UIKit
import os.log


class Meal:NSObject,NSCoding {
    
    
    
    //MARK:Priperties
    
    //MARK: Archiving Paths
    
    
    static let DocumentsDirectory = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!
    
    static let ArchiveURL = DocumentsDirectory.appendingPathComponent("meals")
    
    //MARK: Types
    
    struct PropertyKey {
        
        static let name = "name"
        
        static let photo = "photo"
        
        static let rating = "rating"
        
    }
    
    var name: String
    
    var photo: UIImage?
    
    var rating: Int
    
    
    //MARK: Initialization
    
    
    init?(name:String, photo: UIImage?, rating: Int) {
   
        // The name must not be empty
        
        guard !name.isEmpty else {
            
            return nil
            
        }
        
        
        
        // The rating must be between 0 and 5 inclusively
        
        guard (rating >= 0) && (rating <= 5) else {
            
            return nil
            
        }
        
        //Initialize stored properties.
        
        self.name = name
        
        self.photo = photo
        
        self.rating = rating
        
        
    }
    
    //MARK: NSCoding
    
    func encode(with aCoder: NSCoder) {
        
        aCoder.encode(name,forKey: PropertyKey.name)
        
        aCoder.encode(photo,forKey: PropertyKey.photo)
        
        aCoder.encode(rating,forKey: PropertyKey.rating)
        
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        
        //The name is required If we connot decode a name string, the initializer should fail.
        
        guard let name = aDecoder.decodeObject(forKey: PropertyKey.name) as? String else {
            
            os_log("Unable tto decode the name for a Meeal object.", log: OSLog.default, type: .debug)
            
            return nil
            
        }
        
        // Because photo is an optional property of Meal, Just use conditional cast.
        
        let photo = aDecoder.decodeObject(forKey: PropertyKey.photo) as? UIImage
        
        let rating = aDecoder.decodeInteger(forKey: PropertyKey.rating)
        
        //Must call designated initializer.
        
        self.init(name: name, photo: photo, rating: rating)
        
    }
    
}
