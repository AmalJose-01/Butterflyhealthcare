//
//  MovieListCell.swift
//  Butterflyhealthcare
//
//  Created by Gerald George on 1/1/2024.
//

import Foundation
import UIKit
class MovieListCell: UITableViewCell {
    
    @IBOutlet weak var ImageLoader: UIImageView!
    @IBOutlet weak var lbl_ReleaseDate: UILabel!
    @IBOutlet weak var lbl_MovieTitle: UILabel!
    @IBOutlet weak var lbl_overview: UILabel!

    @IBOutlet weak var ImageRStar1: UIImageView!
    @IBOutlet weak var ImageRStar2: UIImageView!
    @IBOutlet weak var ImageRStar3: UIImageView!
    @IBOutlet weak var ImageRStar4: UIImageView!
    @IBOutlet weak var ImageRStar5: UIImageView!
    
    @IBOutlet weak var bg_WhiteCornerView: UIView!
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
        commoncornerradius_Swift.setCornerRadiusAndBorderForObject_WithOutBorder(ImageLoader, Radius: 10)
    }
    
    func setFontForView(){
        let commonFontClass = CommonFontClass()
        self.lbl_MovieTitle.font=commonFontClass.MulishBoldForProfileName_Small()
        self.lbl_ReleaseDate.font=commonFontClass.MulishRegularForProfileDate()
        self.lbl_overview.font=commonFontClass.MulishItalicForLabel()
    }
    
    
    
    
    public func configure_Search(with MovieResult:SearchMovieViewModel.SearchMovieResultViewModelStruct? , indexpath:NSIndexPath, isfirstObject:Bool,isLastObject:Bool){
        self.setFontForView()
        lbl_MovieTitle.text = MovieResult?.originalTitle
        lbl_ReleaseDate.text = MovieResult?.releaseDate
        lbl_overview.text = MovieResult?.overview
        let commonUrlsAndConstants = CommonUrlsAndConstants()
        let urls_BaseUpi : String = commonUrlsAndConstants.getPosterImageBaseUrl()
        let urls_endPoint = MovieResult?.posterPath ?? "/tlcuhdNMKNGEVpGqBZrAaOOf1A6.jpg"
        let urlFull = urls_BaseUpi + urls_endPoint
        guard let url = URL(string: urlFull) else {
            return
        }
        
        ImageLoader.downloaded(from: url)
        
        self.setRating(vote_average: MovieResult?.voteAverage ?? 0)
    }
    
    
    
    
    public func configure(with MovieResult:MovieViewModel.MovieResultViewModelStruct? , indexpath:NSIndexPath, isfirstObject:Bool,isLastObject:Bool){
        self.setFontForView()
        lbl_MovieTitle.text = MovieResult?.originalTitle
        lbl_ReleaseDate.text = MovieResult?.releaseDate
        lbl_overview.text = MovieResult?.overview
        let commonUrlsAndConstants = CommonUrlsAndConstants()
        let urls_BaseUpi : String = commonUrlsAndConstants.getPosterImageBaseUrl()
        let urls_endPoint = MovieResult?.posterPath ?? "/tlcuhdNMKNGEVpGqBZrAaOOf1A6.jpg"
        let urlFull = urls_BaseUpi + urls_endPoint
        guard let url = URL(string: urlFull) else {
            return
        }
        
        ImageLoader.downloaded(from: url)
        
        self.setRating(vote_average: MovieResult?.voteAverage ?? 0)
    }
   
    func setRating(vote_average: Double)  {
    
         if vote_average > 8.1 {
            ImageRStar1.isHidden = false
            ImageRStar2.isHidden = false
            ImageRStar3.isHidden = false
            ImageRStar4.isHidden = false
            ImageRStar5.isHidden = false
        }else  if vote_average > 6.1 {
            ImageRStar1.isHidden = false
            ImageRStar2.isHidden = false
            ImageRStar3.isHidden = false
            ImageRStar4.isHidden = false
            ImageRStar5.isHidden = true
        }else  if vote_average > 4.1 {
            ImageRStar1.isHidden = false
            ImageRStar2.isHidden = false
            ImageRStar3.isHidden = false
            ImageRStar4.isHidden = true
            ImageRStar5.isHidden = true
        }else  if vote_average > 2.1 {
            ImageRStar1.isHidden = false
            ImageRStar2.isHidden = false
            ImageRStar3.isHidden = true
            ImageRStar4.isHidden = true
            ImageRStar5.isHidden = true
        } else{
            ImageRStar1.isHidden = false
            ImageRStar2.isHidden = true
            ImageRStar3.isHidden = true
            ImageRStar4.isHidden = true
            ImageRStar5.isHidden = true
        }
        
    }

}
