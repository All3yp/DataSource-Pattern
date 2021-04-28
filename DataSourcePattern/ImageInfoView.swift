//
//  ImageInfoView.swift
//  DataSourcePattern
//
//  Created by Alley Pereira on 28/04/21.
//

import UIKit

class ImageInfoView: UIView {

    weak var datasource: ImageInfoViewDataSource?

    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.backgroundColor = .black
        return imageView
    }()

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 22)
        label.text = ""
        label.numberOfLines = 0
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(imageView)
        addSubview(titleLabel)
        configure()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        imageView.frame = CGRect(x: (frame.size.width-250)/2,
                                 y: 0,
                                 width: 250,
                                 height: 250)

        titleLabel.frame = CGRect(x: 0,
                                 y: 260,
                                 width: frame.size.width,
                                 height: 70)
    }

    private func configure() {
        guard let dataSource = datasource else { return }
        guard let imageURL = dataSource.imageInfoViewURLForImage(self) else { return }
        titleLabel.text = dataSource.imageInfoViewTitleForImage(self)

        let task = URLSession.shared.dataTask(with: imageURL) { [weak self] (data, _, _) in
            guard let data = data else { return }
            DispatchQueue.main.async {
                self?.imageView.image = UIImage(data: data)
            }
        }
        task.resume()
    }

    public func reloadData() {
        configure()
    }
}
