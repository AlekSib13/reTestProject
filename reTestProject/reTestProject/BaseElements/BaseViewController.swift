//
//  BaseViewController.swift
//  reTestProject
//
//  Created by Aleksandr Malinin on 25.10.2022.
//

import Foundation
import UIKit
import SnapKit

enum DataExceptionalSituation {
    case noData
    case noDataToEvaluate
    case errorOccured
}

class BaseViewController: UIViewController {
    
    let noDataView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()
    
    lazy var noDataImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        setConstraints()
    }
    
    private func configure() {
        view.backgroundColor = UIColor.BaseColours.turquoiseBlueKrayola
        view.addSubview(noDataView)
        noDataView.isHidden = true
    }
    
    private func setConstraints() {
        noDataView.snp.makeConstraints {make in
            make.edges.equalToSuperview()
        }
    }
    
    func showExceptionalSituationView(situation: DataExceptionalSituation) {
        noDataView.addSubview(noDataImageView)
        noDataImageView.snp.makeConstraints {make in
            make.centerY.centerX.equalToSuperview()
            make.height.width.equalTo(GeneralConstants.Size.sizeOf300)
        }
        
        switch situation {
        case .noDataToEvaluate:
            noDataImageView.image = UIImage.Cover.nothingToEvaluate
        default:
            break
        }
        noDataView.isHidden = false
    }
    
    func hideExceptionalSituationView() {
        noDataView.isHidden = true
        noDataView.subviews.forEach {view in
            view.removeFromSuperview()
        }
    }
}
