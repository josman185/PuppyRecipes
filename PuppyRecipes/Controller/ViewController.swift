//
//  ViewController.swift
//  PuppyRecipes
//
//  Created by jos on 7/8/19.
//  Copyright © 2019 My Organization. All rights reserved.
//

import UIKit

class ViewController: UIViewController, RecipesProtocol {

    @IBOutlet weak var recipesTV: UITableView!
    var textField = CustomView.customTextField()
    var s = String()
    var networking = Networking()
    var recipesListArr: NSArray = NSArray()
    let rowcolors = [UIColor.red, UIColor.blue, UIColor.brown, UIColor.cyan]

    override func viewDidLoad() {
        super.viewDidLoad()
        self.recipesTV.delegate = self
        self.recipesTV.dataSource = self
        
        // 1
        let searchBtn = CustomView.searchButton()
        searchBtn.addTarget(self, action: #selector(btnBuscarPressed(sender:)), for: .touchUpInside)
        self.view.addSubview(textField)
        self.view.addSubview(searchBtn)
    }
    
    
    @objc func btnBuscarPressed(sender: UIButton!) {
        // 2
        let str = textField.text ?? "None"
        let ingredientsArray = str.split(separator: " ").map({ (substring) in
            return String(substring)
        })
        // 3
        if (self.recipesListArr.count == 0) {
            let net = Networking()
            net.delegate = self
            net.downloadRecipes(ingredientsArray: ingredientsArray)
        }
    }
    // 4
    func recipesDownloaded(recipes: NSArray) {
        recipesListArr = recipes
        self.recipesTV.reloadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // 5
        if segue.identifier == "segueToDetailVC" {
            if let indexpath = recipesTV.indexPathForSelectedRow {
                //6
                let recipe: RecipeItem
                recipe = recipesListArr[indexpath.row] as! RecipeItem
                let destination = segue.destination as! DetailVC
                destination.recipeInfo = recipe
            }
        }
    }
    
    /*
     1. Creamos la instancia de un Boton y agregamos un target para que al dar clic en este se invoque la funcion: btnBuscarPressed
     2. Obtenemos el valor del textField y separamos cada uno en un Array.
     3. Aseguramos que el array que llenará la tabla este vacio enviamos los ingredientes como parámetros.
     4. Implementamos el método que recibe el Array con las Recetas y hacemos un Update a la Tabla.
     5. Validamos el id del Segue y aseguramos que se haya seleccionado un row de la tabla.
     6. Creamos y cargamos un objeto de tipo RecipeItem para enviarlo a la vista Detalle.
     */
}


extension ViewController: UITableViewDataSource, UITableViewDelegate {
    // 1
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return recipesListArr.count
    }
    
    // 2
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier: String = "BasicCell"
        let cell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier)!
        let recipe: RecipeItem = recipesListArr[indexPath.row] as! RecipeItem
        cell.backgroundColor = self.rowcolors[indexPath.row % self.rowcolors.count]
        cell.textLabel!.text = recipe.title
        return cell
    }
    
    // 3
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "segueToDetailVC", sender: indexPath)
    }
    
    /* Table View DataSource
        1. Número de Rows en la tabla, varia de acuerdo al tamaño del array que llenará la misma.
        2. Vaciamos la informacion del array en la tabla.
        3. Método que se invoca cuando el usuario presiona un Row de la tabla.
     */
}

