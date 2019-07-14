//
//  Item.swift
//  PuppyRecipes
//
//  Created by Jose Manuel Vargas Flores on 10/07/19.
//  Copyright © 2019 My Organization. All rights reserved.
//  Modelado de los datos.

import Foundation
import UIKit

class RecipeItem : NSObject {
    
    public let href: String
    public let ingredients: String
    public let thumbnail: String
    public let title: String
    public let image: UIImage

    
    init(href: String, ingredients: String, thumbnail: String, title: String, image: UIImage) {
        self.href = href
        self.ingredients = ingredients
        self.thumbnail = thumbnail
        self.title = title
        self.image = image
    }
}
