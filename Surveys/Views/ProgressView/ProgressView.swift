//
//  ProgressView.swift
//  Surveys
//
//  Created by Su Ho V. on 7/28/19.
//  Copyright © 2019 suho. All rights reserved.
//

import UIKit

final class ProgressView: UIView {
    @IBOutlet var contentView: UIView!

    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }

    private func commonInit() {
        Bundle.main.loadNibNamed("ProgressView", owner: self, options: nil)
        addSubview(contentView)
        contentView.frame = bounds
        contentView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
    }
}

// MARK: - Public Actions
extension ProgressView {
    private static var current: ProgressView?

    static func show() {
        if ProgressView.current != nil { return }
        guard let window = Application.current.window else { return }
        ProgressView.current = ProgressView(frame: window.bounds)
        guard let progressView = ProgressView.current else { return }
        window.addSubview(progressView)
    }

    static func hide() {
        guard let progressView = ProgressView.current else { return }
        progressView.removeFromSuperview()
        ProgressView.current = nil
    }
}
