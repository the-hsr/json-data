//
//  HeroViewController.swift
//  Json-onclick-expand-tableView
//
//  Created by Himanshu Singh on 09/03/22.
//

import UIKit

class HeroViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var nameLbl: UILabel!
    
    @IBOutlet weak var attributeLbl: UILabel!
    
    @IBOutlet weak var attackLbl: UILabel!
    
    @IBOutlet weak var legsLbl: UILabel!
    
    var hero: HeroStats?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        nameLbl.text = hero?.localized_name
        attributeLbl.text = hero?.primary_attr
        attackLbl.text = hero?.attack_type
        legsLbl.text = "\((hero?.legs)!)"
        
        let urlString = "https://api.opendota.com"+(hero?.img)!
        let url = URL(string: urlString)
        imageView.downloaded(from: url!)
        // Do any additional setup after loading the view.
    }

}

// MARK: To download the image from URL

extension UIImageView {
    func downloaded(from url: URL, contentMode mode: ContentMode = .scaleAspectFit) {
        contentMode = mode
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
                else { return }
            DispatchQueue.main.async() { [weak self] in
                self?.image = image
            }
        }.resume()
    }
    func downloaded(from link: String, contentMode mode: ContentMode = .scaleAspectFit) {
        guard let url = URL(string: link) else { return }
        downloaded(from: url, contentMode: mode)
    }
}
