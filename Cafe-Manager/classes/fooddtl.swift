//
//  fooddtl.swift
//  Cafe-Manager
//
//  Created by Bhanuka Nishen on 2021-04-17.
//

import Foundation
import UIKit

class fooddtl {
    var category : String
    var food : [foodonce]
   
    
    init(category : String,food : [foodonce] ) {
        
        
        self.category = category
        self.food = food
        
    }
}

