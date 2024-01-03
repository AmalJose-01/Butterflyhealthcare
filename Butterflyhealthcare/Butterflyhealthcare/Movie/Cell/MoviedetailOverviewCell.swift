//
//  MoviedetailOverviewCell.swift
//  Butterflyhealthcare
//
//  Created by Gerald George on 1/1/2024.
//

import Foundation
import UIKit
class MoviedetailOverviewCell: UITableViewCell {
    
    @IBOutlet weak var lbl_OverviewHeader: UILabel!
    @IBOutlet weak var lbl_OverViewValue: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        DispatchQueue.main.async {
        }
        
        self.setFontForView()

    }
    
    func setFontForView(){
        let commonFontClass = CommonFontClass()
        self.lbl_OverviewHeader.font=commonFontClass.MulishItalicForLabelHeader()
        self.lbl_OverViewValue.font=commonFontClass.MulishItalicForLabel()
    }
    
    public func configure(with MovieResult:MovieViewModel.MovieResultViewModelStruct? , indexpath:NSIndexPath, isfirstObject:Bool,isLastObject:Bool){
        lbl_OverViewValue.text = MovieResult?.overview
        
        
    }
    
    public func configureOffline(with MovieResult:Movie , indexpath:NSIndexPath, isfirstObject:Bool,isLastObject:Bool){
        lbl_OverViewValue.text = MovieResult.overview
        
        
    }
    
    public func configureSearch(with MovieResult:SearchMovieViewModel.SearchMovieResultViewModelStruct? , indexpath:NSIndexPath, isfirstObject:Bool,isLastObject:Bool){
        lbl_OverViewValue.text = MovieResult?.overview
        
        
    }
    
}
