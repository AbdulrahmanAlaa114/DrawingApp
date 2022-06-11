//
//  HomeViewController.swift
//  DrawingApp
//
//  Created by Abdulrahman on 09/06/2022.
//

import UIKit

class HomeViewController: UIViewController {

    @IBOutlet weak var viewForScreenShot: UIView!
    @IBOutlet weak var canvasView: CanvasView!
    @IBOutlet weak var backgroundImage: UIImageView!
    @IBOutlet weak var colorPickerView: ColorPickerView!
    @IBOutlet weak var colorPicker: UIView!
    @IBOutlet weak var backgroundView: UIView!
    @IBOutlet weak var strokeWidthView: UIView!
    @IBOutlet weak var strokeWidthLbl: UILabel!
    
    var strokeWidth: CGFloat = 1
    var imageFromSavedPhoto: UIImage!
    var isSetImageFromSavedPhoto = false
  
    override func viewDidLoad() {
        super.viewDidLoad()
       
        colorPicker.backgroundColor = canvasView.strokeColor
        addGesture()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = true
        if isSetImageFromSavedPhoto {
           showPhotoFromSavedPhotos()
        }
    }
    
    func showPhotoFromSavedPhotos(){
        canvasView.clearCanvasView()
        backgroundImage.image = imageFromSavedPhoto
        isSetImageFromSavedPhoto = false
    }
    
    func addGesture() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(didTapped))
        backgroundView.isUserInteractionEnabled = true
        backgroundView.addGestureRecognizer(tapGesture)
    }
    
    @objc private func didTapped(){
        backgroundView.isHidden = true
        colorPickerView.isHidden = true
        colorPicker.isHidden = true
        strokeWidthView.isHidden = true
    }
    
    func uploadImage(){
        let picker = UIImagePickerController()
        picker.sourceType = .photoLibrary
        picker.delegate = self
        self.present(picker, animated: true, completion: nil)
    }
    
    @IBAction func onClickStrokeWidth(_ sender: UIButton) {
        if sender.tag == 0{
            guard strokeWidth > 1 else { return }
            strokeWidth -= 1
        }else {
            guard strokeWidth < 10 else { return }
            strokeWidth += 1
        }
        canvasView.strokeWidth = strokeWidth * 2
        strokeWidthLbl.text = "\(Int(strokeWidth))"
        
    }
    
    @IBAction func onClickShowStrokeWidth(_ sender: Any) {
        
        if strokeWidthView.isHidden {
            colorPickerView.isHidden = true
            colorPicker.isHidden = true
            backgroundView.isHidden = false
            strokeWidthView.isHidden = false
        }else {
            backgroundView.isHidden = true
            strokeWidthView.isHidden = true
        }
        
    }
    
    @IBAction func onClickShowColorPicker(_ sender: Any) {

        if colorPickerView.isHidden{
            strokeWidthView.isHidden = true
            backgroundView.isHidden = false
            colorPickerView.isHidden = false
            colorPicker.isHidden = false
            
            colorPickerView.onColorDidChange = { [weak self] color in
                DispatchQueue.main.async {
                    
                    self?.canvasView.strokeColor = color
                    self?.colorPicker.backgroundColor = color
                }
                
            }
        }else{
            colorPickerView.isHidden = true
            colorPicker.isHidden = true
            backgroundView.isHidden = true
            return
        }
       
    
    }
    
    @IBAction func onClickClear(_ sender: Any) {
        didTapped()
        canvasView.clearCanvasView()
        backgroundImage.image = UIImage()
    }
    
    @IBAction func onClickUndo(_ sender: Any) {
        didTapped()
        canvasView.undoDraw()
    }
    
    @IBAction func onClickUploadImage(_ sender: Any) {
        didTapped()
        uploadImage()
    }
       
    @IBAction func onClickRedo(_ sender: Any) {
        didTapped()
        canvasView.redoDraw()
    }
    
    @IBAction func onClickPreview(_ sender: Any) {
        didTapped()
        let previewVC = storyboard?.instantiateViewController(withIdentifier: "PreviewViewController") as! PreviewViewController
        previewVC.image = viewForScreenShot.takeScreenshot()
        navigationController?.pushViewController(previewVC, animated: true)
    }
    
    @IBAction func onClickDeleteLines(_ sender: Any) {
        didTapped()
        let linesVC = storyboard?.instantiateViewController(withIdentifier: "LinesViewController") as! LinesViewController
        linesVC.delegate = self
        linesVC.lines = canvasView.lines
        present(linesVC, animated: true, completion: nil)
    }
    
}

extension HomeViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            backgroundImage.image = image
        }
        picker.dismiss(animated: true, completion: nil)
    }
}

extension HomeViewController: DeleteLines {
    
    func deleteAt(index: Int) {
        canvasView.deleteSpecifiedLineWith(index: index)
    }
    
}
