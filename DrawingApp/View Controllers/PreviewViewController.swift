//
//  PreviewViewController.swift
//  DrawingApp
//
//  Created by Abdulrahman on 09/06/2022.
//

import UIKit

class PreviewViewController: UIViewController {
    
    @IBOutlet weak var viewForScreenShot: UIView!
    @IBOutlet weak var previewImage: UIImageView!
    
    var dataBaseService: DataBaseService!
    var cachedImageService: CachedImageService!
    var image: UIImage!
    var pi: CGFloat = 0
    var scale: CGFloat = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isHidden = false
        previewImage.image = image
        dataBaseService = DataBaseManger.shared.dataBase
        cachedImageService = DataBaseManger.shared.cachedImages

    }
    
    func applyTransform() {
        var tranform = CGAffineTransform.identity
        tranform = tranform.scaledBy(x: scale, y: scale)
        tranform = tranform.rotated(by: pi)
        previewImage.transform = tranform
    }
    
    func savePhoto(name: String) {
        let image = self.viewForScreenShot.takeScreenshot()
        let id = UUID().uuidString
        let photo = PhotoData(name: name, id: id, creatingDate: Date(), image: image)
        dataBaseService.savePhotoWith(data: photo)
        cachedImageService.saveImageWith(fileName: photo.id, image: photo.image)
        UIImageWriteToSavedPhotosAlbum(photo.image, self, #selector(imageSavedOnAlbums(_:didFinishSavingWithError:contextType:)), nil)
        
    }
    
    @objc func imageSavedOnAlbums(_ image: UIImage, didFinishSavingWithError error: Error?, contextType: UnsafeRawPointer) {
        if let error = error {
            showAlert(title: "Save error", message: error.localizedDescription, actions: [UIAlertAction(title: "OK", style: .default)])
        } else {
            showAlert(title: "Saved!", message: "Your altered image has been saved to your photos.", actions: [UIAlertAction(title: "OK", style: .default)])
        }
    }
    
    @IBAction func onClickScale(_ sender: UIButton) {
        if sender.tag == 0 {
            guard scale < 5 else { return }
            scale += 0.25
        }else{
            guard scale > 0.25 else { return }
            scale -= 0.25
        }
        applyTransform()
    }
    
    @IBAction func onClickRotation(_ sender: Any) {
        pi += (CGFloat.pi / 2)
        applyTransform()
    }
    
    @IBAction func onClickSave(_ sender: Any) {
        
        let alert = UIAlertController(title: "Save", message: "Enter name of photo", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default) { [weak self] _ in
            guard let self = self else { return }
            if let name = alert.textFields![0].text{
                if name != ""{
                    
                    self.savePhoto(name: name)
                    
                }else{
                    self.showAlert(title: "Error", message: "You must Enter name of photo",
                              actions: [UIAlertAction(title: "Try again", style: .default, handler: nil)])
                }
            }
        }
        
        alert.addTextField { $0.placeholder = "Name" }
        alert.addAction(okAction)
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        present(alert, animated: true, completion: nil)
        
    }
}
