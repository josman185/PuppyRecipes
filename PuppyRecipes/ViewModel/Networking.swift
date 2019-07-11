//
//  Utils.swift
//  PuppyRecipes
//
//  Created by jos on 7/8/19.
//  Copyright © 2019 My Organization. All rights reserved.
//

import Foundation

protocol RecipesProtocol: class {
    func recipesDownloaded(recipes: NSArray)
}

class Networking: NSObject  {
    let receiveData = NSMutableData()
    weak var delegate: RecipesProtocol!
    
    func downloadRecipes(ingredientsArray:[String]) {
        var stringIngredients = " "
        // 1
        for ingredient in ingredientsArray {
            if stringIngredients != " " {
                stringIngredients = "\(stringIngredients),\(ingredient)"
            } else {
                stringIngredients = "\(ingredient)"
            }
        }
        // 2
        let strURL = "http://www.recipepuppy.com/api/?i=\(stringIngredients)&q=omelet&p=3"
        // 3
        let config = URLSessionConfiguration.default
        let urlSession = URLSession(configuration: config)
        let url = URL(string: strURL)!
        let task = urlSession.dataTask(with: url) { (data, response, error) in
            guard error == nil else {
                print("error \(String(describing: error))")
                return
            }
            guard let content = data else {
                print("No data")
                return
            }
            // 4
            self.parsingJson(content)
        }
        task.resume()
    }
    /*
     1. Obtenemos los ingredientes tecleados por el usuario y armamos el string con ellos.
     2. Creamos la url con los ingredientes.
     3. Configuramos la sesion y hacemos el request de los datos con la url creada.
     4. Pasamos los datos a una funcion para parsearlos.
     */
    
    
    func parsingJson(_ data: Data) {
        var jsonResult = NSDictionary()
        var jsonElement = NSDictionary()
        let recipesArray = NSMutableArray()
        
        // 4.1
        do {
            jsonResult = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.allowFragments) as! NSDictionary
            print(" - - - Server Result - - - ")
            print(jsonResult)
        } catch let error as NSError {
            print(error)
        }
        // 4.2
        if let recipes = jsonResult["results"] as? [Dictionary<String, AnyObject>] {
            for i in 0 ..< recipes.count {
                jsonElement = recipes[i] as NSDictionary
                
                let recipe = RecipeItem()
                if let href = jsonElement["href"] as? String,
                    let ingredients = jsonElement["ingredients"] as? String,
                    let thumbnail = jsonElement["thumbnail"] as? String,
                    let title = jsonElement["title"] as? String
                {
                    recipe.href = href
                    recipe.ingredients = ingredients
                    recipe.thumbnail = thumbnail
                    recipe.title = title
                }
                recipesArray.add(recipe)
            }
            print("Recipes Array Count: \(recipesArray.count)")
            // 4.3
            DispatchQueue.main.async(execute: {
                self.delegate.recipesDownloaded(recipes: recipesArray)
            })
        }
    }
    
    /*
     4.1 Serializamos los datos dentro de un Diccionario.
     4.2 Recorremos el diccionario para llenar el objeto array con las Recipes.
     
     */
    
    class func imageFromUrl(urlString: String) -> Data {
        var imgDat: Data?
        if let url = URL(string: urlString) {
            let urlSession = URLSession(configuration: URLSessionConfiguration.default)
            let task = urlSession.dataTask(with: url, completionHandler: { (data, response, error) in
                guard error == nil else {
                    print("error \(String(describing: error))")
                    return
                }
                guard let imageData = data else {
                    print("No image data")
                    return
                }
            imgDat = imageData
            })
            task.resume()
        }
        return imgDat!
    }
    
}

