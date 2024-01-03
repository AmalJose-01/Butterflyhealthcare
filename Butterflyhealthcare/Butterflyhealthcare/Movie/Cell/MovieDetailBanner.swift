//
//  MovieDetailBanner.swift
//  Butterflyhealthcare
//
//  Created by Gerald George on 1/1/2024.
//

import Foundation
import UIKit
class MovieDetailBanner: UITableViewCell {
    @IBOutlet weak var ImageLoader: UIImageView!
    @IBOutlet weak var lbl_ReleaseDate: UILabel!
    @IBOutlet weak var lbl_MovieTitle: UILabel!
    @IBOutlet weak var bg_WhiteCornerView: UIView!
    @IBOutlet weak var gradientView: UIView!

    

    override func awakeFromNib() {
        super.awakeFromNib()
        DispatchQueue.main.async {
            self.viewSetObjectLayers()
        }
        self.setFontForView()
    }
    func viewSetObjectLayers(){
        let commoncornerradius_Swift = Commoncornerradius_Swift()
        commoncornerradius_Swift.setCornerRadiusAndBorderForObject_WithShadow_Swift(bg_WhiteCornerView , Radius: 14)
    }
    
    func setFontForView(){
        let commonFontClass = CommonFontClass()
        self.lbl_MovieTitle.font=commonFontClass.MulishBoldForProfileName_Small()
        self.lbl_ReleaseDate.font=commonFontClass.MulishRegularForProfileDate()
    }
    
    public func configure(with MovieResult:MovieViewModel.MovieResultViewModelStruct? , indexpath:NSIndexPath, isfirstObject:Bool,isLastObject:Bool){
        lbl_MovieTitle.text = MovieResult?.originalTitle
        lbl_ReleaseDate.text = "Release Date: " + (MovieResult?.releaseDate ?? "")
        
        let commonUrlsAndConstants = CommonUrlsAndConstants()
        let urls_BaseUpi : String = commonUrlsAndConstants.getPosterImageBaseUrl()
        let urls_endPoint = MovieResult?.posterPath ?? "/tlcuhdNMKNGEVpGqBZrAaOOf1A6.jpg"
        let urlFull = urls_BaseUpi + urls_endPoint
        guard let url = URL(string: urlFull) else {
            return
        }
        
        ImageLoader.downloaded(from: url)
        
        let gradientLayerGray:CAGradientLayer = CAGradientLayer()
        gradientLayerGray.frame.size = self.gradientView.frame.size
        gradientLayerGray.colors =
        [UIColor.white.cgColor,UIColor.green .withAlphaComponent(1).cgColor ]
        gradientView.layer.addSublayer(gradientLayerGray)
       
    }

    
    public func configureSearch(with MovieResult:SearchMovieViewModel.SearchMovieResultViewModelStruct? , indexpath:NSIndexPath, isfirstObject:Bool,isLastObject:Bool){
        lbl_MovieTitle.text = MovieResult?.originalTitle
        lbl_ReleaseDate.text = "Release Date: " + (MovieResult?.releaseDate ?? "")
        
        let commonUrlsAndConstants = CommonUrlsAndConstants()
        let urls_BaseUpi : String = commonUrlsAndConstants.getPosterImageBaseUrl()
        let urls_endPoint = MovieResult?.posterPath ?? "/tlcuhdNMKNGEVpGqBZrAaOOf1A6.jpg"
        let urlFull = urls_BaseUpi + urls_endPoint
        guard let url = URL(string: urlFull) else {
            return
        }
        
        ImageLoader.downloaded(from: url)
        
        let gradientLayerGray:CAGradientLayer = CAGradientLayer()
        gradientLayerGray.frame.size = self.gradientView.frame.size
        gradientLayerGray.colors =
        [UIColor.white.cgColor,UIColor.green .withAlphaComponent(1).cgColor ]
        gradientView.layer.addSublayer(gradientLayerGray)
       
    }
    
}
