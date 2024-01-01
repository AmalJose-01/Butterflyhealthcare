
import UIKit

enum NibID: String, CaseIterable {
    // MARK: - Enum
    
    // MARK: Common
    
    // MARK:  eMar Facility List
    case MovieListCell = "MovieListCell"
    case MovieDetailBanner = "MovieDetailBanner"
    case MoviedetailOverviewCell = "MoviedetailOverviewCell"


    
   
    
    // MARK: - Nib Loading
    
    private var bundle: Bundle {
        let bundle = Bundle(for: ViewController.self)
        return bundle
    }
    
    var name: String {
        return rawValue
    }
    
    var nib: UINib {
        print ("name :")
        print(name)
        let nib = UINib(nibName: name, bundle: bundle)
        return nib
    }
    // MARK: - Initialisation
    
    init?(name: String) {
        guard let nib = NibID.allCases.first(where: { $0.rawValue == name }) else {
            return nil
        }
        self = nib
    }
    
    init?(type: Any) {
        let typeName = String(describing: type)
        self.init(name: typeName)
    }
}
