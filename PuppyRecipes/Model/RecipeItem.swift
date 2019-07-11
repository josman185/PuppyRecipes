//
//  Item.swift
//  PuppyRecipes
//
//  Created by Jose Manuel Vargas Flores on 10/07/19.
//  Copyright © 2019 My Organization. All rights reserved.
//  Modelado de los datos.

import Foundation

class RecipeItem : NSObject {
    
    var href: String?
    var ingredients: String?
    var thumbnail: String?
    var title: String?
    
    override init() {
    }
    
    init(href:String, ingredients: String, thumbnail: String, title: String) {
        self.href = href
        self.ingredients = ingredients
        self.thumbnail = thumbnail
        self.title = title
    }
    
}
