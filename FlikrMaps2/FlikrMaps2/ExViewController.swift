//
//  ExViewController.swift
//  FlikrMaps2
//
//  Created by Rashed Shrahili on 15/02/1444 AH.
//

import UIKit

extension ViewController : UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return photoData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "photoCell", for: indexPath) as! PhotoCell
        
        let stringurl2 = "https://live.staticflickr.com/\(photoData[indexPath.item].server)/\(photoData[indexPath.item].id)_\(photoData[indexPath.item].secret).jpg"
        
        guard let url10 = URL(string: stringurl2) else {
            
            print("Url Crash")
            return UICollectionViewCell()
            
            
        }
        DispatchQueue.global().sync {
            guard let data1 = try? Data(contentsOf: url10) else {
                //self.photosCollectionView.reloadData()
                print("Data Crash")

            return
               }
            DispatchQueue.main.async {


    //                photos = [photo]
    //                print(photo)

                cell.photoCell.image = UIImage(data: data1)

            }
        }
//
//        guard let data1 = try? Data(contentsOf: url10) else {
//
//            print("Data Crash")
//            return UICollectionViewCell()
//        }
        
        //this Updata 
//        DispatchQueue.main.async {
//
//
////                photos = [photo]
////                print(photo)
//
//            cell.photoCell.image = UIImage(data: data1)
//
//        }
        
//     cell.photoCell.image = UIImage(data: data1)
        let photosData = photoData[indexPath.row]
        cell.photoCell.loadImageUsingCache("\(photosData)")
        
        
        
        return cell
    }
    
 
    
    
    
}

extension ViewController : UICollectionViewDelegate {
    
    
}
