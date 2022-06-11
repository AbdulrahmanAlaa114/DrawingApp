//
//  LinesViewController.swift
//  DrawingApp
//
//  Created by Abdulrahman on 11/06/2022.
//

import UIKit

class LinesViewController: UIViewController {

    @IBOutlet weak var warningLbl: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    
    var lines: [Line]!
    weak var delegate: DeleteLines?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
        showWarningLable()
    }
    
    func showWarningLable(){
        guard lines.count == 0 else { return }
        warningLbl.isHidden = false
    }
    
    func setupCollectionView() {
        collectionView.registerNib(cell: LineCollectionViewCell.self)
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    

}


extension LinesViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return lines.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeue(indexPath: indexPath) as LineCollectionViewCell
        cell.setup(line: lines[indexPath.row])
        cell.deleteBtn.tag = indexPath.row
        cell.deleteBtn.addTarget(self, action: #selector(deleteLine(sender:)), for: .touchUpInside)
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.bounds.width, height: collectionView.frame.height - 50)
    }
    
    @objc func deleteLine(sender:UIButton) {
        
        let okAct = UIAlertAction(title: "OK", style: .default) { [weak self] _ in
            guard let self = self else { return }
            self.lines.remove(at: sender.tag)
            self.collectionView.reloadData()
            self.delegate?.deleteAt(index: sender.tag)
            self.showWarningLable()
        }
        let cancelAct = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        showAlert(title: "Warning", message: "You want to delete this draw", actions: [okAct, cancelAct])
       
    }

}
