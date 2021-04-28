//
//  File.swift
//  DataSourcePattern
//
//  Created by Alley Pereira on 28/04/21.
//

import Foundation

protocol ImageInfoViewDataSource: AnyObject {
    func imageInfoViewTitleForImage(_ infoView: ImageInfoView) -> String?
    func imageInfoViewURLForImage(_ infoView: ImageInfoView) -> URL?
}
