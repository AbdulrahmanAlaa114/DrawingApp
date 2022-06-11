//
//  SavedPhotosViewController.swift
//  DrawingApp
//
//  Created by Abdulrahman on 09/06/2022.
//

import UIKit

class SavedPhotosViewController: UIViewController, UISearchBarDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    var dataBaseService: DataBaseService!
    var cachedImageService: CachedImageService!
    var photos = [SectionedPhoto]()
    var tempPhotos = [Photo]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchBar.delegate = self
        dataBaseService = DataBaseManger.shared.dataBase
        cachedImageService = DataBaseManger.shared.cachedImages
        hideKeyboardWhenTappedAround()
        setupTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = true
        fetchPhotos()
    }
    
    func setupTableView() {
        tableView.registerNib(cell: photoTableViewCell.self)
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchBy(name: searchText)
    }
    
    func searchBy(name: String){
        let photos = name == "" ? tempPhotos : tempPhotos.filter { $0.name!.lowercased().contains(name.lowercased())}
        convertToSectionPhotoes(photos: photos)
    }
    
    func fetchPhotos(){
        
        let photosDB = dataBaseService.fetchPhotos()
        tempPhotos = photosDB
        convertToSectionPhotoes(photos: photosDB)
        
    }
    
    
    func convertToSectionPhotoes(photos: [Photo]){
        let format = DateFormatter()
        format.dateFormat = "yyyy-MM-dd"
        let dic = Dictionary(grouping: photos, by: { format.string(from: $0.creationDate!)})
        self.photos = dic.map {
            SectionedPhoto(creatingDate: $0, photos: $1.map({
                PhotoData(name: $0.name!, id: $0.id!, creatingDate: $0.creationDate!, image:
                            cachedImageService.loadImageWith(fileName: $0.id!)!
                )
            }))
        }
        tableView.reloadData()
    }
    
}


extension SavedPhotosViewController : UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return photos.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return photos[section].photos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeue() as photoTableViewCell
        cell.configerCell(with: photos[indexPath.section].photos[indexPath.row])
        
        cell.subscribeDeleteBtn = { [unowned self] in
            self.deletePhoto(indexPath: indexPath)
        }
        cell.subscribeEditBtn = { [unowned self] in
            self.redrawPhoto(indexPath: indexPath)
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return photos[section].creatingDate
    }
    
    
    func deletePhoto(indexPath: IndexPath){
        
        let okAct = UIAlertAction(title: "Yes", style: .default) { [weak self] _ in
            guard let self = self else { return }
            let id = self.photos[indexPath.section].photos[indexPath.row].id
            self.dataBaseService.deletePhotoWith(id: id)
            self.cachedImageService.removeImageWith(fileName: id)
            self.fetchPhotos()
        }
        let cancelAct = UIAlertAction(title: "No", style: .cancel, handler: nil)
        showAlert(title: "Warning", message: "Are you sure you want delete an image permanently?", actions: [okAct, cancelAct])
        
        
    }
    
    func redrawPhoto(indexPath: IndexPath){
        let photo = photos[indexPath.section].photos[indexPath.row].image
        let homeVC = (self.tabBarController?.viewControllers![0])! as! HomeViewController
        homeVC.isSetImageFromSavedPhoto = true
        homeVC.imageFromSavedPhoto = photo
        tabBarController?.selectedIndex = 0
    }
    
}
