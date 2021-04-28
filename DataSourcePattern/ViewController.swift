//
//  ViewController.swift
//  DataSourcePattern
//
//  Created by Alley Pereira on 28/04/21.
//

import UIKit

class ViewController: UIViewController, ImageInfoViewDataSource {

    private let infoView = ImageInfoView()

    private var model: ImageInfo?

    override func viewDidLoad() {
        super.viewDidLoad()
        infoView.backgroundColor = .blue
        view.addSubview(infoView)
        infoView.datasource = self
        fetchData()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

        infoView.frame = CGRect(x: 0, y: 0, width: view.frame.width-20, height: view.frame.size.width-20)
        infoView.center = view.center
    }

    func fetchData() {
        guard let url = URL(string: "http://jsonplaceholder.typicode.com/photos/1") else { return }

        let task = URLSession.shared.dataTask(with: url) { [weak self] (data, _, error) in
            guard let data = data, error == nil else {
                return
            }
            do {
                let json = try JSONSerialization.jsonObject(with: data, options: .allowFragments)
                print(json)
                let result = try JSONDecoder().decode(ImageInfo.self, from: data)
                self?.model = result
                DispatchQueue.main.async {
                    self?.infoView.reloadData()
                }
            }
            catch {
                print(error.localizedDescription)
            }
        }
        task.resume()
    }

    //Mark: DataSource

    func imageInfoViewTitleForImage(_ infoView: ImageInfoView) -> String? {
        return model?.title
    }

    func imageInfoViewURLForImage(_ infoView: ImageInfoView) -> URL? {
        return URL(string: model?.thumbnailUrl ?? "")
    }

}

