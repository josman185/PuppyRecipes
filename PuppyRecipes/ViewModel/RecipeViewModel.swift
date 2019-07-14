//
//  RecipeViewModel.swift
//  PuppyRecipes
//
//  Created by jos on 7/13/19.
//  Copyright © 2019 My Organization. All rights reserved.
//

import Foundation
import UIKit

public class RecipeViewModel {
    private let recipe: RecipeItem
    
    init(recipe: RecipeItem){
        self.recipe = recipe
    }
    
    public var title: String {
        return recipe.title
    }
    
    public var ingredients: String {
        return recipe.ingredients
    }
    
    public var image: UIImage {
        return recipe.image
    }
}
