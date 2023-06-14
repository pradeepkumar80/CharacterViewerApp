//
//  CharacterDetailVC.swift
//  CharacterViewer
//
//  Created by Pradeep on 6/13/23.
//

import UIKit

class CharacterDetailVC: UIViewController {
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var imgIcon: UIImageView!
    @IBOutlet weak var txtDescription: UITextView!
    
    var character: RelatedTopic?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        refreshUI()
    }
    
    func refreshUI() {
        if let character = character {
            lblTitle.text = character.name
            txtDescription.text = character.details
            if !character.iconURL.isEmpty {
                downloadImage(character.iconURL)
            } else {
                self.imgIcon.image = UIImage(named: "noImage")
            }
        }
    }
    
    func downloadImage(_ iconURL:String) {
        let session = URLSession(configuration: .default)
        session.dataTask(with: URL(string: iconURL)!) { (data, response, error) in
            if let e = error {
                print("Error downloading picture: \(e)")
            } else {
                // No errors found.
                if let res = response as? HTTPURLResponse {
                    print("Downloaded cat picture with response code \(res.statusCode)")
                    if let imageData = data {
                        DispatchQueue.main.sync {
                            self.imgIcon.image = UIImage(data: imageData)
                        }
                    } else {
                        print("Couldn't get image: Image is nil")
                    }
                } else {
                    print("Couldn't get response code for some reason")
                }
            }
        }.resume()
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

extension CharacterDetailVC: CharacterSelectionDelegate {
    func characterSelected(_ character: RelatedTopic) {
        self.character = character
        if self.lblTitle != nil {
            self.refreshUI()
        }
    }
}
