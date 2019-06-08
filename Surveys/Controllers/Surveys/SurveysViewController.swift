//
//  SurveysViewController.swift
//  Surveys
//
//  Created by Su Ho V. on 6/5/19.
//  Copyright © 2019 suho. All rights reserved.
//

import UIKit
import SwifterSwift
import SnapKit

final class SurveysViewController: ViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var pageContainer: UIView!
    @IBOutlet weak var pageControl: ISPageControl!
    @IBOutlet weak var surveyButton: UIButton!

    var numberOfItems: Int = 10

    override func setupUI() {
        super.setupUI()
        setupNavigationBar()
        setupCollectionView()
        setupPageControl()
        setupSurveyButton()
    }
}

// MARK: - Action
extension SurveysViewController {
    @objc private func onPressRefreshButton() {
        print("test")
    }

    @objc private func onPressMenuButton() {
        showAlert(title: App.String.surveysApp, message: App.String.authorSuHo)
    }

    @IBAction private func onPressSurveyButton(_ sender: Any) {
        if numberOfItems != 60 {
            numberOfItems = 60
        } else {
            numberOfItems = 10
            collectionView.setContentOffset(.zero, animated: false)
        }
        pageControl.numberOfPages = numberOfItems
        collectionView.reloadData()
    }
}

// MARK: - Setup UI
extension SurveysViewController {
    private func setupNavigationBar() {
        navigationItem.title = App.String.surveys.uppercased()
        let refresh = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(onPressRefreshButton))
        navigationItem.setLeftBarButton(refresh, animated: false)
        let menu = UIBarButtonItem(image: UIImage(named: "ic-menu"), style: .plain, target: self, action: #selector(onPressMenuButton))
        navigationItem.setRightBarButton(menu, animated: false)
    }

    private func setupCollectionView() {
        collectionView.backgroundColor = App.Color.barBackground
        collectionView.register(nibWithCellClass: SurveyItemCell.self)
        collectionView.tag = 1
        collectionView.dataSource = self
        collectionView.delegate = self
        if let bar = navigationController?.navigationBar {
            collectionView.contentInset = Configuration.contentInset(with: bar)
        }
    }

    private func setupPageControl() {
        pageControl.numberOfPages = numberOfItems
        pageContainer.snp.makeConstraints { (maker) in
            maker.trailingMargin.equalTo((App.Measure.screenSize.width - pageControl.height) / 2)
        }
        pageContainer.transform = CGAffineTransform(rotationAngle: CGFloat.pi/2)
    }

    private func setupSurveyButton() {
        surveyButton.titleLabel?.font = UIFont.systemFont(ofSize: Configuration.surveyFontSize)
        surveyButton.titleLabel?.textColor = App.Color.surveyTitle
        surveyButton.backgroundColor = App.Color.surveyButton
        surveyButton.titleLabel?.text = App.String.takeTheSurvey
    }
}

// MARK: - UICollectionViewDataSource
extension SurveysViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return numberOfItems
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withClass: SurveyItemCell.self, for: indexPath)
        return cell
    }
}

// MARK: - UICollectionViewDelegate
extension SurveysViewController: UICollectionViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offset = scrollView.height
        let index = Int((scrollView.contentOffset.y / offset).rounded())
        pageControl.currentPage = index
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension SurveysViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return App.Measure.screenSize
    }

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return .leastNormalMagnitude
    }
}

// MARK: - Configuration
extension SurveysViewController {
    private enum Configuration {
        static let surveyFontSize: CGFloat = 20
        static let controlSize: CGSize = CGSize(width: 7, height: 7)
        static func contentInset(with bar: UINavigationBar) -> UIEdgeInsets {
            let navigationBarHeight = bar.height
            let statusBarHeight = App.Measure.statusBarHeight
            return .init(top: -navigationBarHeight - statusBarHeight, left: 0, bottom: 0, right: 0)
        }
    }
}
