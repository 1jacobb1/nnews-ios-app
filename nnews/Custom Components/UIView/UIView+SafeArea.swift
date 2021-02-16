//
//  UIView+SafeArea.swift
//  nnews
//
//  Created by Jacob on 1/23/21.
//

import UIKit
import SnapKit

// https://github.com/SnapKit/SnapKit/issues/448#issuecomment-342513599
extension UIView {
    var safeArea: ConstraintBasicAttributesDSL {
        #if swift(>=3.2)
        if #available(iOS 11.0, *) {
            return self.safeAreaLayoutGuide.snp
        }
        #endif
        return self.snp
    }
}
