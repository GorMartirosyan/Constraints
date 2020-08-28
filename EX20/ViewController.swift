//
//  ViewController.swift
//  EX20
//
//  Created by Gor on 4/8/20.
//  Copyright © 2020 user1. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var collectionView: UICollectionView!
    
    var landscape: [NSLayoutConstraint]?
    var portrait: [NSLayoutConstraint]?
    var isPortrait: Bool = true
    let imageArray = [#imageLiteral(resourceName: "bmw-black-f90-wallpaper-preview") , #imageLiteral(resourceName: "827062") , #imageLiteral(resourceName: "951233") , #imageLiteral(resourceName: "827062") , #imageLiteral(resourceName: "109-1091031_competition-wallpaper")]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        constraints()
    }
    override func didReceiveMemoryWarning() {
            super.didReceiveMemoryWarning()
        }
    
    
    func constraints() {
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        portrait = [
        imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        collectionView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        imageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
        collectionView.topAnchor.constraint(equalTo: imageView.bottomAnchor),
        imageView.widthAnchor.constraint(equalToConstant: 400),
        imageView.heightAnchor.constraint(equalToConstant: 500),
        collectionView.widthAnchor.constraint(equalToConstant: 400),
        collectionView.heightAnchor.constraint(equalToConstant: 300),
        ]
        
        landscape = [
        imageView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
        imageView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
        collectionView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
        collectionView.leadingAnchor.constraint(equalTo: imageView.trailingAnchor),
        imageView.widthAnchor.constraint(equalToConstant: 500),
        imageView.heightAnchor.constraint(equalToConstant: 400),
        collectionView.widthAnchor.constraint(equalToConstant: 300),
        collectionView.heightAnchor.constraint(equalToConstant: 400),
        ]
        
    }

    override func viewDidLayoutSubviews() {
        isPortrait = UIDevice.current.orientation.isPortrait
        if isPortrait {
            if let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
                layout.scrollDirection = .horizontal
            }
            NSLayoutConstraint.deactivate(landscape!)
            NSLayoutConstraint.activate(portrait!)
            reloadInputViews()
        }else{
            if let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
                layout.scrollDirection = .vertical
            }
            NSLayoutConstraint.deactivate(portrait!)
            NSLayoutConstraint.activate(landscape!)
            reloadInputViews()
        }
    }
}

extension ViewController: UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imageArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? CollectionViewCell

        cell?.cellImageView.image = imageArray[indexPath.row]
        return cell!
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let cell = collectionView.cellForItem(at: indexPath) as? CollectionViewCell {
            imageView.image = cell.cellImageView.image
        }
    }
}
