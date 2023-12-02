//
//  ImageDetailController.swift
//  ImagesApp
//
//  Created by Damian Piszcz on 01/12/2023.
//

import UIKit

class ImageDetailController: UIViewController {
    
    private let viewModel: ImageDetailViewModel
    private let detailView = ImageDetailView()
    
    init(viewModel: ImageDetailViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        self.fetchImage(id: viewModel.image!.id)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(detailView)
        view.backgroundColor = .systemBackground
        self.title = "Info"
        navigationController?.navigationBar.prefersLargeTitles = false
        
        bindViewModelEvent()
    }
  
    func fetchImage(id: String) {
        viewModel.fetchImage(id: id)
    }
    
    private func bindViewModelEvent() {
        viewModel.onFetchImageSucceed = { [weak self] in
            DispatchQueue.main.async {
                guard let image = self?.viewModel.image else {return}
                self?.detailView.bindViewWith(viewModel: ImagesDefaultViewModelCell(image: image))
            }
        }
        viewModel.onFetchImageFailure = { error in
            print(error)
        }
    }
}
