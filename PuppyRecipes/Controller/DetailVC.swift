//
//  DetailVC.swift
//  PuppyRecipes
//
//  Created by jos on 7/10/19.
//  Copyright © 2019 My Organization. All rights reserved.
//

import UIKit

class DetailVC: UIViewController {
    
    @IBOutlet weak var ingredientsLbl: UILabel!
    @IBOutlet weak var thumbImageView: UIImageView!
    var recipeInfo: RecipeItem?

    override func viewDidLoad() {
        super.viewDidLoad()
        // 1
        self.title = recipeInfo?.title
        // 2
        if let ingredients = recipeInfo?.ingredients {
            self.ingredientsLbl.text = "Ingredients: \(ingredients)"
        } else {
            self.ingredientsLbl.text = "No ingredients"
        }
    }
    
    // 3
    override func viewWillAppear(_ animated: Bool) {
        if let thumbnail = recipeInfo?.thumbnail {
             imageFromurl(urlString: (thumbnail))
        }
    }
    
    // 4
    func imageFromurl(urlString: String) {
        if let url = URL(string: urlString) {
            let urlSession = URLSession(configuration: URLSessionConfiguration.default)
            // 4.1
            let task = urlSession.dataTask(with: url, completionHandler: { (data, response, error) in
                guard error == nil else {
                    print("error \(String(describing: error))")
                    return
                }
                if let imageData = data as Data? {
                    // 4.2
                    DispatchQueue.main.async {
                            self.thumbImageView.image = UIImage(data: imageData)
                        }
                }
            })
            task.resume()
        }
    }
    
    /*
     1. Seteamos el titulo de la vista con el titulo de la Recipe.
     2. Hacemos el unwrap de los ingredientes y los mostramos en la vista.
     3. Comenzamos a cargar la imagen con la url cuando la vista esta a punto de mostrarse.
     4. funcion para descargar la imagen en miniatura.
     4.1 hacemos el request de la imagen con la url.
     4.2 actualizamos la vista con la imagen descargada.
     */
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // segueToWebView
        if segue.identifier == "segueToWebView" {
            let destination = segue.destination as! WebviewVC
            destination.href = recipeInfo?.href
        }
    }
}
