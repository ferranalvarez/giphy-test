import UIKit

final class GiphyPhotosViewController: UICollectionViewController {
    
    // MARK: - Properties
    fileprivate let reuseIdentifier = "GiphyCell"
    fileprivate let sectionInsets = UIEdgeInsets(top: 50.0, left: 10.0, bottom: 50.0, right: 10.0)
    
    fileprivate var gifs = [GiphyPhoto]()
    fileprivate let giphy = Giphy()
    fileprivate let itemsPerRow: CGFloat = 2
    
    override func viewDidLoad() {
        giphy.searchGiphyForTerm() {
            results, error in
            
            
            if let error = error {
                // 2
                print("Error searching : \(error)")
                return
            }
            
            if let results = results {
                // 3
                
                print("Found \(results.count)")
                self.gifs = results
                
                // 4
                self.collectionView?.reloadData()
            }
        }
    }
}

// MARK: - Private
private extension GiphyPhotosViewController {
    
    func photoForIndexPath(_ indexPath: IndexPath) -> GiphyPhoto {
        return gifs[(indexPath as NSIndexPath).row]
    }
}

extension GiphyPhotosViewController : UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        // 1
        let activityIndicator = UIActivityIndicatorView(activityIndicatorStyle: .gray)
        textField.addSubview(activityIndicator)
        activityIndicator.frame = textField.bounds
        activityIndicator.startAnimating()
        
        giphy.searchGiphyForTerm() {
            results, error in
            
            
            activityIndicator.removeFromSuperview()
            
            
            if let error = error {
                // 2
                print("Error searching : \(error)")
                return
            }
            
            if let results = results {
                // 3
                print("Found \(results.count)")
                self.gifs = results
                
                // 4
                self.collectionView?.reloadData()
            }
        }
        
        textField.text = nil
        textField.resignFirstResponder()
        return true
    }
}

// MARK: - UICollectionViewDataSource
extension GiphyPhotosViewController {
    //1
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    //2
    override func collectionView(_ collectionView: UICollectionView,
                                 numberOfItemsInSection section: Int) -> Int {
        return gifs.count
    }
    
    //3
    override func collectionView(_ collectionView: UICollectionView,
                                 cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        //1
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier,
                                                      for: indexPath) as! GiphyPhotoCell
        //2
        let giphyPhoto = photoForIndexPath(indexPath)
        cell.backgroundColor = UIColor.white
        //3
        
        
        // TODO - Integrate lazy loading GIF's
        if (giphyPhoto.thumbnail == nil) {
            giphyPhoto.thumbnail = UIImage.gifImageWithURL(gifUrl: giphyPhoto.embedUrl)
            cell.imageView.image = giphyPhoto.thumbnail
        }
        
        // this line is necessary due a bug that sometimes the gif image is not shown on scroll.
        cell.imageView.image = nil
        cell.imageView.image = giphyPhoto.thumbnail
        
       
        
        return cell
    }
}

extension GiphyPhotosViewController : UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let paddingSpace = sectionInsets.left * (itemsPerRow + 1)
        let availableWidth = view.frame.width - paddingSpace
        let widthPerItem = availableWidth / itemsPerRow
        
        return CGSize(width: widthPerItem, height: widthPerItem)
    }
    
    //3
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        return sectionInsets
    }
    
    // 4
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return sectionInsets.left
    }
}
