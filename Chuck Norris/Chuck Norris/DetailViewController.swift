//
//  DetailViewController.swift
//  Chuck Norris
//
//  Created by Maria Luiza Carvalho Sperotto on 13/11/19.
//  Copyright © 2019 Maria Luiza Carvalho Sperotto. All rights reserved.
//

import UIKit

@objc class DetailViewController: UIViewController {
    @objc public var selectedCategory = ""
    var jokes = [Joke]()
    var joke: Joke?
    
    @IBOutlet weak var jokeLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        jsonParser()
        animateImage()
    }
    
    
    @IBAction func reload(_ sender: UIButton) {
        jsonParser()
        animateImage()
        UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 6, options: [], animations: {
            sender.transform = CGAffineTransform(rotationAngle: CGFloat.pi)
            sender.transform = .identity
        
        }) { finished in
            
        }
        
}
    
    
    func animateImage() {
        UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 6, options: [], animations: {
                self.imageView.transform = CGAffineTransform(scaleX: 0.5, y: 0.5)
                self.imageView.transform = .identity
            
        }) { finished in
            
        }
        
    }
    func jsonParser() {
        let urlString = "https://api.chucknorris.io/jokes/random?category=\(selectedCategory)"
            
            guard let url = URL(string: urlString) else { return }
            URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data else { return }
            
            guard let json = try? JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] else { return }
            let joke = Joke(json: json)
            DispatchQueue.main.async {
                self.jokeLabel.text = joke.value
                    
                }
                
            }.resume()
        }
    
    
        
    }



