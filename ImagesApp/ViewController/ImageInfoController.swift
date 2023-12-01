//
//  ImageInfoController.swift
//  ImagesApp
//
//  Created by Damian Piszcz on 01/12/2023.
//

import UIKit

class ImageInfoController: UIViewController {
    
    private let viewModel: ImageInfoViewModel
    
    init(viewModel: ImageInfoViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .yellow
        print(viewModel.image?.id)
    }
}
