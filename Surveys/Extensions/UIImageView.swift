//
//  UIImageView.swift
//  Surveys
//
//  Created by Su Ho V. on 6/9/19.
//  Copyright © 2019 suho. All rights reserved.
//

import UIKit
import Kingfisher

extension UIImageView {
    func cancelDownload() {
        kf.cancelDownloadTask()
    }

    func setImage(with path: String) {
        kf.setImage(with: URL(string: path))
    }
}
