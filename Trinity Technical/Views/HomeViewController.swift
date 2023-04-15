//
//  HomeViewController.swift
//  Trinity Technical
//
//  Created by Yogi Priyo Prayogo on 15/04/23.
//

import UIKit

class HomeViewController: UIViewController {
    
    @IBOutlet weak var contactListCollectionView: UICollectionView!
    
    let screenSize: CGRect = UIScreen.main.bounds
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        setupNavbar()
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        setupCollectionView()
    }
    
    private func setupNavbar() {
        navigationItem.title = "Contacts"
        
        let search = UIBarButtonItem(barButtonSystemItem: .search, target: self, action: #selector(searchUserTapped))
        let add = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addUserTapped))
        
        navigationItem.leftBarButtonItems = [search]
        navigationItem.rightBarButtonItems = [add]
    }
    
    private func setupCollectionView() {
        contactListCollectionView.delegate = self
        contactListCollectionView.dataSource = self
        contactListCollectionView.register(UINib(nibName: CollectionViewCellIdentifier.contactListCellId, bundle: nil), forCellWithReuseIdentifier: CollectionViewCellIdentifier.contactListCellId)
    }
    
    @objc private func searchUserTapped() {
        
    }
    
    @objc private func addUserTapped() {
        
    }
}

extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: CollectionViewCellIdentifier.contactListCellId,
            for: indexPath
        ) as? ContactCollectionViewCell
        
        return cell ?? UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: screenSize.width/2-16, height: screenSize.width/2-16)
    }
}
