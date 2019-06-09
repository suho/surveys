//
//  SurveyItemCell.swift
//  Surveys
//
//  Created by Su Ho V. on 6/5/19.
//  Copyright © 2019 suho. All rights reserved.
//

import UIKit

final class SurveyItemCell: UICollectionViewCell {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    private var didAwake = false

    override func awakeFromNib() {
        super.awakeFromNib()
        didAwake = true
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        guard didAwake else { return }
        imageView.cancelDownload()
        imageView.image = nil
    }

    func bind(_ viewModel: SurveyItemViewModel) {
        titleLabel.text = viewModel.title
        descriptionLabel.text = viewModel.description
        imageView.setImage(with: viewModel.imagePath)
    }
}
