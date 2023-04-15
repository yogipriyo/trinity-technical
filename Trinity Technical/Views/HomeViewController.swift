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
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        setupCollectionView()
        
        setupData()
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
    
    private func setupData() {
        // these data fetching procedure should be taken out of this view controller. Put it into the view model and another independent utilities
        // then call those utilities inside the view model and trigger the changes on the UI via delegation or reactive (RXSwift/Combine/etc)
        
        if let localData = readLocalFile(forName: "data") {
            self.parse(jsonData: localData)
        }
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
        // I will create a dedicated page for search feature screen and inject all of the contact array into that page
        // I will add the text field, setup delegate to recognise when the user type in
        // get the text field value, then filter the array and display the filtered array as the contact list located below the search text field.
    }
    
    @objc private func addUserTapped() {
        // I will create a dedicated page for the add user feature screen and add content like the contact details page
        // the add user is pretty much the same like the save contact data on the contact details page
        // to do it properly, need to have some kind of data store which unfortunately, I am not able to do it within 2 hours timeframe.
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
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let contactDetailsVC: ContactDetailsViewController = ContactDetailsViewController(contactList[indexPath.row])
        navigationController?.pushViewController(contactDetailsVC, animated: true)
    }
}
