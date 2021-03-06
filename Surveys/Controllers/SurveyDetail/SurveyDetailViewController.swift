//
//  SurveyDetailViewController.swift
//  Surveys
//
//  Created by Su Ho V. on 6/9/19.
//  Copyright © 2019 suho. All rights reserved.
//

import UIKit

final class SurveyDetailViewController: UIViewController {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    var viewModel: SurveyItemViewModel!

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }

    private func setupUI() {
        navigationItem.title = viewModel.title
        titleLabel.text = viewModel.title
        descriptionLabel.text = viewModel.description
        imageView.setImage(with: viewModel.imagePath)
    }
}
