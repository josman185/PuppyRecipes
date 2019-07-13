//
//  DetailVC.swift
//  PuppyRecipes
//
//  Created by jos on 7/10/19.
//  Copyright © 2019 My Organization. All rights reserved.
//

import UIKit

class DetailVC: UIViewController {
    
    @IBOutlet weak var ingredientsTV: UITableView!
    @IBOutlet weak var thumbImageView: UIImageView!
    @IBOutlet weak var ingredientsLbl: UILabel!
    var recipeInfo: RecipeItem?
    var ingredientsArr: [String] = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.ingredientsTV.delegate = self
        self.ingredientsTV.dataSource = self
        // 1
        self.title = recipeInfo?.title
        // 2
        if let ingredientsList = recipeInfo?.ingredients {
            ingredientsArr = ingredientsList.split(separator: ",").map({ (substring) in
                return String(substring)
            })
        } else {
            print("No ingredients")
            self.ingredientsLbl.text = "No ingredients in this Recipe"
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

extension DetailVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ingredientsArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier: String = "ingredinetsCell_id"
        let cell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier)!
        let ingredient = ingredientsArr[indexPath.row]
        cell.textLabel?.text = ingredient
        return cell
    }
    
}
