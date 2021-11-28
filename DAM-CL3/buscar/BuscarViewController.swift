//
//  BuscarViewController.swift
//  DAM-CL3
//
//  Created by kamaly on 27/11/21.
//

import UIKit

class BuscarViewController: UIViewController, UISearchBarDelegate, UITableViewDataSource, UITableViewDelegate {

    
    @IBOutlet weak var noticiasSearchBar: UISearchBar!
    @IBOutlet weak var noticiaTable: UITableView!
    
    var articlesList: [Articles] = []
   
    override func viewDidLoad() {
        super.viewDidLoad()
        self.noticiasSearchBar.delegate = self
        self.noticiaTable.delegate = self
        self.noticiaTable.dataSource = self
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let value = searchBar.text else {return}
        searchBar.resignFirstResponder()
        noticiasSearchBar.resignFirstResponder()
        buscarNotiticias(value: value)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        noticiasSearchBar.text = nil
        noticiasSearchBar.resignFirstResponder()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return articlesList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "itemArticle", for: indexPath) as! ArticleTableViewCell
        let itemArticle = articlesList[indexPath.row]
        cell.tituloLabel.text = String(format: "%@ %@", "Titulo: ", itemArticle.title)
        cell.autorLabel.text = String(format: "%@ %@", "Autor: ", itemArticle.author ?? "")
        cell.fechaLabel.text = String(format: "%@ %@", "Fecha: ", itemArticle.published_date)
        return cell
    }
    
     func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let itemArticle =  articlesList[indexPath.row]
        print(itemArticle.title)
        // aqui debemos abrir la nueva pantalla
    }
 
     
    private func buscarNotiticias(value: String) {
    
        let urlBuscar = String(format:"%@%@", "https://free-news.p.rapidapi.com/v1/search?q=", value)
        
        
        let url = URL(string: urlBuscar)!
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = [
            "X-RapidAPI-Host" : "free-news.p.rapidapi.com",
            "X-RapidAPI-Key":"ea909e6739msh72d84e99c0c6e3bp142d3ejsn1c35e0afe88d"
        ]
        
        let task = URLSession.shared.dataTask(with: request) {data, response, error in
            
            guard let data = data, let response = response as? HTTPURLResponse, error == nil else {
                return
            }
            
            let status = response.statusCode // 200
            guard (200...299).contains(status) else {
                print("Response code =  \(status)")
                return
            }
            
            if let articles = try? JSONDecoder().decode(NoticiaResponse.self, from: data) {
                
                self.articlesList = articles.articles
                print("success 200")
               
                DispatchQueue.main.async {
                    self.noticiaTable.reloadData()
                }
                
            } else {
                print("Respuesta invalida")
            }
            
        }
        
        task.resume()
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
