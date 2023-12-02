//
//  ImagesViewController.swift
//  ImagesApp
//
//  Created by Damian Piszcz on 30/11/2023.
//

import UIKit

class ImagesViewController: UIViewController {
    
    private let viewModel: ImagesViewModel
    private let imagesView = ImagesCollectionView()
    
    init(viewModel: ImagesViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Gallery"
        view.backgroundColor = .systemBackground
        self.view = imagesView
        NotificationCenter.default.addObserver(self, selector: #selector(showOfflineDeviceUI(notification:)), name: NSNotification.Name.connectivityStatus, object: nil)
        
        configureView()
        fetchImages()
        bindViewModelEvent()
    }
    
    private func configureView() {
        imagesView.collectionView.delegate = self
        imagesView.collectionView.dataSource = self
        imagesView.searchBar.searchResultsUpdater = self
        navigationItem.searchController = imagesView.searchBar
        
    }
    
    func fetchImages() {
        viewModel.fetchImages()
    }
    
    private func bindViewModelEvent() {
        viewModel.onFetchImagesSucceed = { [weak self] in
            DispatchQueue.main.async {
                self?.imagesView.collectionView.reloadData()
            }
        }
        viewModel.onFetchImagesFailure = { error in
            print(error)
        }
    }
    
    @objc func showOfflineDeviceUI(notification: Notification) {
        if NetworkMonitor.shared.isConnected {
            print("Connected")
        } else {
            print("Not connected")
            DispatchQueue.main.async {
                self.showAlertMessage(title: "Alert", message: "Please check your internet connection")
            }
        }
    }
    
}
extension ImagesViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.images.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! ImagesCollectionCell
        cell.backgroundColor = .systemBackground
        
        let image = viewModel.images[indexPath.row]
        cell.bindViewWith(viewModel: ImagesDefaultViewModelCell(image: image))
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        let image = viewModel.images[indexPath.row]
        let service = ImagesDataService()
        let vm = ImageDetailViewModel(service: service)
        vm.image = image
        let vc = ImageDetailController(viewModel: vm)
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        var widthCell: CGFloat = collectionView.frame.width/2 - 1
        
        if UIDevice.current.orientation.isLandscape {
            widthCell = collectionView.frame.width/3 - 1
        }
        
        return CGSize(width: widthCell, height: widthCell)
    }
}
extension ImagesViewController: UISearchResultsUpdating{
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        print(searchText)
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5, execute: {
            guard let query = searchController.searchBar.text else{return}
            self.viewModel.fetchImages(for: query)
        })
    }
}
