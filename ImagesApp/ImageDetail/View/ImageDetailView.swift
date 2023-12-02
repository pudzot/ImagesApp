//
//  DetailView.swift
//  ImagesApp
//
//  Created by Damian Piszcz on 02/12/2023.
//

import Foundation
import UIKit

final class ImageDetailView: UIView {
    
    private lazy var scrollView: UIScrollView = {
        let sv = UIScrollView()
        return sv
    }()
    
    private lazy var contentView: UIView = {
        let view = UIView()
        return view
    }()
    
    private lazy var headerImage: UIImageView = {
        let iv = UIImageView()
        iv.clipsToBounds = true
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(fullScreenTap))
        iv.isUserInteractionEnabled = true
        iv.addGestureRecognizer(tapGesture)
        return iv
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 22, weight: .medium)
        label.sizeToFit()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 18, weight: .light)
        return label
    }()
    
    private lazy var saveBtn: UIButton = {
        let button = UIButton()
        button.setTitle("Save Image", for: .normal)
        button.setTitleColor(.systemBlue, for: .normal)
        button.setTitleColor(.blue, for: .highlighted)
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(saveImage(_:)))
        button.isUserInteractionEnabled = true
        button.addGestureRecognizer(tapGesture)
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: UIScreen.main.bounds)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    private func commonInit() {
        setupScrollViewContstraints()
        setupContentViewConstraints()
        setupItemImageViewConstraints()
        setupTitleLabelConstraints()
        setupDescriptionLabelConstraints()
        setupAddLabelConstraints()
    }
    
    @objc func saveImage(_ sender: UITapGestureRecognizer) {
        guard let inputImage = headerImage.image else { return }
        
        let imageSaver = ImageSaver()
        imageSaver.writeToPhotoAlbum(image: inputImage)
    }
    
    func imageTapped(image:UIImage){
        let newImageView = UIImageView(image: image)
        newImageView.frame = UIScreen.main.bounds
        newImageView.backgroundColor = .black
        newImageView.contentMode = .scaleAspectFit
        newImageView.isUserInteractionEnabled = true
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissFullscreenImage(_:)))
        newImageView.addGestureRecognizer(tap)
        self.addSubview(newImageView)
    }
    
    @objc func dismissFullscreenImage(_ sender: UITapGestureRecognizer) {
        sender.view?.removeFromSuperview()
    }
    
    @objc func fullScreenTap() {
        imageTapped(image: headerImage.image!)
    }
    
    private func setupScrollViewContstraints() {
        addSubview(scrollView)
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: leadingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: bottomAnchor),
            scrollView.trailingAnchor.constraint(equalTo: trailingAnchor),
        ])
    }
    
    private func setupContentViewConstraints() {
        scrollView.addSubview(contentView)
        contentView.translatesAutoresizingMaskIntoConstraints = false
        let heightConstraint = contentView.heightAnchor.constraint(equalTo: scrollView.heightAnchor)
        heightConstraint.priority = UILayoutPriority(250)
        NSLayoutConstraint.activate([
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            heightConstraint,
        ])
    }
    
    private func setupItemImageViewConstraints() {
        contentView.addSubview(headerImage)
        headerImage.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            headerImage.topAnchor.constraint(equalTo: contentView.topAnchor),
            headerImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            headerImage.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            headerImage.heightAnchor.constraint(equalTo: safeAreaLayoutGuide.heightAnchor, multiplier: 0.50)
        ])
    }
    
    private func setupTitleLabelConstraints() {
        contentView.addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: headerImage.bottomAnchor, constant: 20),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20)
        ])
    }
    
    private func setupDescriptionLabelConstraints() {
        contentView.addSubview(descriptionLabel)
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10),
            descriptionLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            descriptionLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
        ])
    }
    func setupAddLabelConstraints() {
        contentView.addSubview(saveBtn)
        saveBtn.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            saveBtn.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 20),
            saveBtn.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 40),
            saveBtn.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -40),
            saveBtn.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20)
        ])
    }
    
    func bindViewWith(viewModel: ImagesDefaultViewModelCell) {
        let image = viewModel.image
        self.titleLabel.text = image.altDescription
        self.descriptionLabel.text = image.description
        ImageClient.shared.setImage(from: image.urls.regular) { [weak self] image in
            self?.headerImage.image = image
        }
    }
}
extension UIImageView {
    func setImageAndUpdateFrameHeight(image: UIImage) {
        self.image = image
        
        if image.size.width > 0 {
            self.frame.size.height = self.frame.size.width / image.size.width * image.size.height
        }
    }
}
