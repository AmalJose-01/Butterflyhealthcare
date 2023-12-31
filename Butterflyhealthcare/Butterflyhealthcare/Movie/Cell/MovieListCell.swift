//
//  MovieListCell.swift
//  Butterflyhealthcare
//
//  Created by Gerald George on 1/1/2024.
//

import Foundation
import UIKit
class MovieListCell: UITableViewCell {
    
    @IBOutlet weak var lbl_EmployeeName: UILabel!
    @IBOutlet weak var lbl_EmployeejobTitle: UILabel!
    @IBOutlet weak var lbl_Date: UILabel!

    @IBOutlet weak var bg_WhiteCornerView: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        DispatchQueue.main.async {
            self.viewSetObjectLayers()
        }
        
        
    }
    func viewSetObjectLayers(){
        let commoncornerradius_Swift = Commoncornerradius_Swift()
        commoncornerradius_Swift.setCornerRadiusAndBorderForObject_WithShadow_Swift(bg_WhiteCornerView , Radius: 14)
    }
}
