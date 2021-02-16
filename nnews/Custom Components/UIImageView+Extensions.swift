//
//  UIImageView+Extensions.swift
//  nnews
//
//  Created by Jacob on 1/23/21.
//

import UIKit
import CocoaLumberjack

extension UIImageView {
    func setImageWith(url: URL?) {
        let placeholderImage = UIImage(systemName: "n.square")
        self.sd_setImage(with: url,
                         placeholderImage: placeholderImage,
                         options: [.avoidAutoSetImage,
                                   .scaleDownLargeImages]) { image, err, cacheType, url in
            if let error = err {
                DDLogInfo("[SD_SET_IMAGE] error: \(error)")
            }
            DDLogInfo("[SD_SET_IMAGE] cache type: \(cacheType)")
            DDLogInfo("[SD_SET_IMAGE] url: \(url?.absoluteString ?? "")")
            if let img = image {
                self.image = img
            }
        }
    }
}
