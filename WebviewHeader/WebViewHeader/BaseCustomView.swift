//
//  BaseCustomView.swift
//  WebviewHeader
//
//  Created by Vy Nguyen on 9/21/19.
//  Copyright © 2019 VVLab. All rights reserved.
//

import Foundation
import UIKit

// Don't forget set file owner in xib file

class BaseCustomView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        load()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        load()
    }

    func getNibName() -> String {
        return classIdentifier()
    }

    func load() {
        self.backgroundColor = UIColor.clear
        let bundle = Bundle.init(for:BaseCustomView.self)
        let nib = UINib(nibName: getNibName(), bundle: bundle)
        let views = nib.instantiate(withOwner: self, options: nil)
        if let childView = views[0] as? UIView {
            addViewOverlay(childView: childView, toView: self)
            loadingViewComplete(childView: childView)
        }
    }

    func loadingViewComplete(childView: UIView) {

    }
    func addViewOverlay(childView: UIView, toView parentView: UIView) {
        parentView.addSubview(childView)
        // Use bounds not frame or it'll be offset
        if frame == CGRect.zero {
            frame = childView.frame
        } else {
            childView.frame = bounds
        }
        BaseCustomView.addConstrainOverlay(childView: childView, toView: parentView)
    }
    static func addConstrainOverlay(childView: UIView, toView parentView: UIView) {
        childView.bounds = parentView.bounds // use for non auto layout project.
        childView.translatesAutoresizingMaskIntoConstraints = false
        let centerXConstraint = childView.centerXAnchor.constraint(equalTo: parentView.centerXAnchor)
        let centerYConstraint = childView.centerYAnchor.constraint(equalTo: parentView.centerYAnchor)
        let heightConstraint = childView.heightAnchor.constraint(equalTo: parentView.heightAnchor)
        let widthConstraint = childView.widthAnchor.constraint(equalTo: parentView.widthAnchor)
        parentView.addConstraints([centerXConstraint, centerYConstraint, heightConstraint, widthConstraint])
    }
}

extension UIView {
    // Object using only
    func classIdentifier() -> String {
        return getClassName()
    }
    func getClassName() -> String {
        return type(of: self).description().components(separatedBy: ".").last!
    }
}

