//
//  ShimmerEffect.swift
//  Blue Ray Project
//
//  Created by AhmadSulaiman on 16/12/2023.
//

import Foundation
import UIKit
import ShimmerSwift

class ShimmerEffect: UIView {
    @IBOutlet private weak var viewOne: ShimmeringView!
    @IBOutlet private weak var viewTwo: ShimmeringView!
    @IBOutlet private weak var viewThree: ShimmeringView!
    @IBOutlet private weak var viewFour: ShimmeringView!
    @IBOutlet private weak var viewFive: ShimmeringView!
    @IBOutlet private weak var viewSix: ShimmeringView!
    override init(frame: CGRect) {
           super.init(frame: frame)
           commonInit()
        setupShimmeringViews()
       }
       
       required init?(coder aDecoder: NSCoder) {
           super.init(coder: aDecoder)
           commonInit()
           setupShimmeringViews()
       }
    private func commonInit() {
          // Assuming the name of the xib file is "MyCustomView"
          // and it's located in the main bundle
        let viewFromXib = Bundle.main.loadNibNamed("ShimmerEffect", owner: self, options: nil)![0] as! UIView
          viewFromXib.frame = self.bounds
          addSubview(viewFromXib)
      }
    private func setupShimmeringViews() {
             let shimmerViews = [viewOne, viewTwo, viewThree, viewFour, viewFive, viewSix]
             for shimmerView in shimmerViews {
                 let contentView = UIView() // Replace with your content view
                 contentView.backgroundColor = .lightGray // Set to your desired color or content
                 shimmerView?.contentView = contentView
                 shimmerView?.isShimmering = true
             }
         }
}
