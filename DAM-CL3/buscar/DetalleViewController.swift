//
//  DetalleViewController.swift
//  DAM-CL3
//
//  Created by kamaly on 28/11/21.
//

import UIKit

class DetalleViewController: UIViewController {
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var autorlabel: UILabel!
    
    @IBOutlet weak var descriptionLabel: UILabel!
    
    @IBOutlet weak var topicLabel: UILabel!
    
    @IBOutlet weak var twitterLabel: UILabel!
    
    @IBOutlet weak var logoImage: UIImageView!
    var article: Articles?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.titleLabel.text = article?.title
        
        self.autorlabel.text = article?.author
        
        self.descriptionLabel.text = article?.summary
        self.descriptionLabel.sizeToFit()
        
        self.topicLabel.text = article?.topic
        
        self.twitterLabel.text = article?.twitter_account
  
      
        let url = URL(string: article?.media ?? "https://cdni.rt.com/actualidad/public_images/2021.11/article/619b5b2a59bf5b3c930fa9ee.jpg")
        let data = try? Data(contentsOf: url!)
        self.logoImage.image = UIImage(data: data!)
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
