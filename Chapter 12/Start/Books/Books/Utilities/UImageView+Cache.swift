//
//  UImageView+Cache.swift
//  Books
//
//  Created by Hassaan El-Garem on 6/7/21.
//

import UIKit

extension UIImageView {
    
    typealias ImageLoadedCallback = () -> Void
    
    // MARK:- Variables
    static var dictionaryImageCache = [String:UIImage]()
    static let queue: DispatchQueue = DispatchQueue.init(label: "com.Image.Cache")

    // MARK:- Functions
    func load(url: URL, callBack: ImageLoadedCallback? = nil) {
        UIImageView.queue.async { [weak self] in
            if (Self.dictionaryImageCache[url.path] != nil) {
                DispatchQueue.main.async {
                    self?.image = Self.dictionaryImageCache[url.path]
                    callBack?()
                }
                return
            }
            
            if let data = try? Data(contentsOf: url, options: .uncached) {
                if let image = UIImage(data: data) {
                    Self.dictionaryImageCache[url.path] = image
                    DispatchQueue.main.async {
                        self?.image = image
                        callBack?()
                    }
                }
            }
        }
    }
}
