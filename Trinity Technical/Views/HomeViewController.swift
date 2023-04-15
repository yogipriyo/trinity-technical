//
//  HomeViewController.swift
//  Trinity Technical
//
//  Created by Yogi Priyo Prayogo on 15/04/23.
//

import UIKit

class HomeViewController: UIViewController {
    
    @IBOutlet weak var contactListCollectionView: UICollectionView!
    
    private let screenSize: CGRect = UIScreen.main.bounds
    private var contactList: [Contact] = []
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        setupNavbar()
        
        if let localData = readLocalFile(forName: "data") {
            self.parse(jsonData: localData)
        }
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
    
    private func readLocalFile(forName name: String) -> Data? {
        do {
            if let bundlePath = Bundle.main.path(forResource: name, ofType: "json"),
                let jsonData = try String(contentsOfFile: bundlePath).data(using: .utf8) {
                return jsonData
            }
        } catch {
            displayErrorAlert(title: "Sorry!", message: "Please close the app and try again")
        }
        
        return nil
    }
    
    private func parse(jsonData: Data) {
        do {
            let decodedData = try JSONDecoder().decode([Contact].self,from: jsonData)
            contactList = decodedData
        } catch {
            displayErrorAlert(title: "Sorry!", message: "Please close the app and try again")
        }
    }
    
    @objc private func searchUserTapped() {
        
    }
    
    @objc private func addUserTapped() {
        
    }
}

extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return contactList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: CollectionViewCellIdentifier.contactListCellId,
            for: indexPath
        ) as? ContactCollectionViewCell
        cell?.setupContent(contact: contactList[indexPath.row])
        
        return cell ?? UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: screenSize.width/2-16, height: screenSize.width/2-16)
    }
}
